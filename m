Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCE27CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfEWMXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 08:23:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32965 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMXE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 08:23:04 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 16E9B6CF7216F6A5AE3C;
        Thu, 23 May 2019 13:23:02 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.46) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 23 May 2019 13:22:53 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 3/3] gen_init_cpio: add support for file metadata
Date:   Thu, 23 May 2019 14:18:03 +0200
Message-ID: <20190523121803.21638-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523121803.21638-1-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds support for file metadata (only TYPE_XATTR metadata type).
gen_init_cpio has been modified to read xattrs from files that will be
added to the image and to include file metadata as separate files with the
special name 'METADATA!!!'.

This behavior can be selected by setting the desired file metadata type as
value for CONFIG_INITRAMFS_FILE_METADATA.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 usr/Kconfig               |   8 +++
 usr/Makefile              |   4 +-
 usr/gen_init_cpio.c       | 137 ++++++++++++++++++++++++++++++++++++--
 usr/gen_initramfs_list.sh |  10 ++-
 4 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..8d9f54a16440 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -233,3 +233,11 @@ config INITRAMFS_COMPRESSION
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
 	default ""
+
+config INITRAMFS_FILE_METADATA
+	string "File metadata type"
+	default ""
+	help
+	  Specify xattr to include xattrs in the image.
+
+	  If you are not sure, leave it blank.
diff --git a/usr/Makefile b/usr/Makefile
index 4a70ae43c9cb..7d5eb3c7b713 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -29,7 +29,9 @@ ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
 			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
-        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+        $(if $(filter-out "",$(CONFIG_INITRAMFS_FILE_METADATA)), \
+         -e $(CONFIG_INITRAMFS_FILE_METADATA))
 
 # $(datafile_d_y) is used to identify all files included
 # in initramfs and to detect if any files are added/removed.
diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 03b21189d58b..e93cb1093e77 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/xattr.h>
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
@@ -10,6 +11,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <limits.h>
+#include "../include/linux/initramfs.h"
 
 /*
  * Original work by Jeff Garzik
@@ -24,6 +26,115 @@
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
+static char metadata_path[] = "/tmp/cpio-metadata-XXXXXX";
+static int metadata_fd = -1;
+
+static enum metadata_types parse_metadata_type(char *arg)
+{
+	static char *metadata_type_str[TYPE__LAST] = {
+		[TYPE_NONE] = "none",
+		[TYPE_XATTR] = "xattr",
+	};
+	int i;
+
+	for (i = 0; i < TYPE__LAST; i++)
+		if (!strcmp(metadata_type_str[i], arg))
+			return i;
+
+	return TYPE_NONE;
+}
+
+static int cpio_mkfile(const char *name, const char *location,
+		       unsigned int mode, uid_t uid, gid_t gid,
+		       unsigned int nlinks);
+
+static int write_xattrs(const char *path)
+{
+	struct metadata_hdr hdr = { .c_version = 1, .c_type = TYPE_XATTR };
+	char str[sizeof(hdr.c_size) + 1];
+	char *xattr_list, *list_ptr, *xattr_value;
+	ssize_t list_len, name_len, value_len, len;
+	int ret = -EINVAL;
+
+	if (metadata_fd < 0)
+		return 0;
+
+	if (path == metadata_path)
+		return 0;
+
+	list_len = listxattr(path, NULL, 0);
+	if (list_len <= 0)
+		return 0;
+
+	list_ptr = xattr_list = malloc(list_len);
+	if (!list_ptr) {
+		fprintf(stderr, "out of memory\n");
+		return ret;
+	}
+
+	len = listxattr(path, xattr_list, list_len);
+	if (len != list_len)
+		goto out;
+
+	if (ftruncate(metadata_fd, 0))
+		goto out;
+
+	lseek(metadata_fd, 0, SEEK_SET);
+
+	while (list_ptr < xattr_list + list_len) {
+		name_len = strlen(list_ptr);
+
+		value_len = getxattr(path, list_ptr, NULL, 0);
+		if (value_len < 0) {
+			fprintf(stderr, "cannot get xattrs\n");
+			break;
+		}
+
+		if (value_len) {
+			xattr_value = malloc(value_len);
+			if (!xattr_value) {
+				fprintf(stderr, "out of memory\n");
+				break;
+			}
+		} else {
+			xattr_value = NULL;
+		}
+
+		len = getxattr(path, list_ptr, xattr_value, value_len);
+		if (len != value_len)
+			break;
+
+		snprintf(str, sizeof(str), "%.8lx",
+			 sizeof(hdr) + name_len + 1 + value_len);
+
+		memcpy(hdr.c_size, str, sizeof(hdr.c_size));
+
+		if (write(metadata_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+			break;
+
+		if (write(metadata_fd, list_ptr, name_len + 1) != name_len + 1)
+			break;
+
+		if (write(metadata_fd, xattr_value, value_len) != value_len)
+			break;
+
+		if (fsync(metadata_fd))
+			break;
+
+		list_ptr += name_len + 1;
+		free(xattr_value);
+		xattr_value = NULL;
+	}
+
+	free(xattr_value);
+out:
+	free(xattr_list);
+
+	if (list_ptr != xattr_list + list_len)
+		return ret;
+
+	return cpio_mkfile(METADATA_FILENAME, metadata_path, S_IFREG, 0, 0, 1);
+}
 
 struct file_handler {
 	const char *type;
@@ -128,7 +239,7 @@ static int cpio_mkslink(const char *name, const char *target,
 	push_pad();
 	push_string(target);
 	push_pad();
-	return 0;
+	return write_xattrs(name);
 }
 
 static int cpio_mkslink_line(const char *line)
@@ -174,7 +285,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
-	return 0;
+	return write_xattrs(name);
 }
 
 enum generic_types {
@@ -268,7 +379,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
-	return 0;
+	return write_xattrs(name);
 }
 
 static int cpio_mknod_line(const char *line)
@@ -372,8 +483,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		name += namesize;
 	}
 	ino++;
-	rc = 0;
-	
+	rc = write_xattrs(location);
 error:
 	if (filebuf) free(filebuf);
 	if (file >= 0) close(file);
@@ -526,10 +636,11 @@ int main (int argc, char *argv[])
 	int ec = 0;
 	int line_nr = 0;
 	const char *filename;
+	enum metadata_types metadata_type = TYPE_NONE;
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:h");
+		int opt = getopt(argc, argv, "t:e:h");
 		char *invalid;
 
 		if (opt == -1)
@@ -544,6 +655,9 @@ int main (int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case 'e':
+			metadata_type = parse_metadata_type(optarg);
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
@@ -565,6 +679,14 @@ int main (int argc, char *argv[])
 		exit(1);
 	}
 
+	if (metadata_type != TYPE_NONE) {
+		metadata_fd = mkstemp(metadata_path);
+		if (metadata_fd < 0) {
+			fprintf(stderr, "cannot create temporary file\n");
+			exit(1);
+		}
+	}
+
 	while (fgets(line, LINE_SIZE, cpio_list)) {
 		int type_idx;
 		size_t slen = strlen(line);
@@ -620,5 +742,8 @@ int main (int argc, char *argv[])
 	if (ec == 0)
 		cpio_trailer();
 
+	if (metadata_type != TYPE_NONE)
+		close(metadata_fd);
+
 	exit(ec);
 }
diff --git a/usr/gen_initramfs_list.sh b/usr/gen_initramfs_list.sh
index 0aad760fcd8c..0907a4043da9 100755
--- a/usr/gen_initramfs_list.sh
+++ b/usr/gen_initramfs_list.sh
@@ -15,7 +15,7 @@ set -e
 usage() {
 cat << EOF
 Usage:
-$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
+$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} [-e <type>] ...
 	-o <file>      Create compressed initramfs file named <file> using
 		       gen_init_cpio and compressor depending on the extension
 	-u <uid>       User ID to map to user ID 0 (root).
@@ -28,6 +28,7 @@ $0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
 		       If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
 	-d             Output the default cpio list.
+	-e <type>      File metadata type to include in the cpio archive.
 
 All options except -o and -l may be repeated and are interpreted
 sequentially and immediately.  -u and -g states are preserved across
@@ -283,6 +284,10 @@ while [ $# -gt 0 ]; do
 			default_list="$arg"
 			${dep_list}default_initramfs
 			;;
+		"-e")   # file metadata type
+			metadata_arg="-e $1"
+			shift
+			;;
 		"-h")
 			usage
 			exit 0
@@ -312,7 +317,8 @@ if [ ! -z ${output_file} ]; then
 			fi
 		fi
 		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
-		usr/gen_init_cpio $timestamp ${cpio_list} > ${cpio_tfile}
+		usr/gen_init_cpio $metadata_arg $timestamp \
+			${cpio_list} > ${cpio_tfile}
 	else
 		cpio_tfile=${cpio_file}
 	fi
-- 
2.17.1

