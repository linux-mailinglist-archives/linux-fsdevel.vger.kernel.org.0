Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC727E5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfEWNlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 09:41:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729698AbfEWNlt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 09:41:49 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6F7EF4F3DADC617547CA;
        Thu, 23 May 2019 14:41:46 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.46) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 23 May 2019 14:41:34 +0100
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
Subject: [USER][PATCH] cpio: add option to add file metadata in copy-out mode
Date:   Thu, 23 May 2019 15:38:24 +0200
Message-ID: <20190523133824.710-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the -e <type> option to include file metadata in the image.
At the moment, only the xattr type is supported.

If the xattr type is selected, the patch includes an additional file for
each file passed to stdin, with special name 'METADATA!!!'. The additional
file might contain multiple metadata records. The format of each record is:

<metadata len (ASCII, 8 chars)><version><type><metadata>

The format of metadata for the xattr type is:

<xattr name>\0<xattr value>

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 doc/cpio.texi   |   3 ++
 src/copyout.c   | 136 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/dstring.c   |  26 +++++++--
 src/dstring.h   |   1 +
 src/extern.h    |   2 +
 src/global.c    |   2 +
 src/initramfs.h |  21 ++++++++
 src/main.c      |  22 ++++++++
 8 files changed, 206 insertions(+), 7 deletions(-)
 create mode 100644 src/initramfs.h

diff --git a/doc/cpio.texi b/doc/cpio.texi
index e667b48..d7b311f 100644
--- a/doc/cpio.texi
+++ b/doc/cpio.texi
@@ -275,6 +275,9 @@ Set the I/O block size to the given @var{number} of bytes.
 @item -D @var{dir}
 @itemx --directory=@var{dir}
 Change to directory @var{dir}
+@item -e @var{type}
+@itemx --file-metadata=@var{type}
+Include in the image file metadata with the specified type.
 @item --force-local
 Treat the archive file as local, even if its name contains colons.
 @item -F [[@var{user}@@]@var{host}:]@var{archive-file}
diff --git a/src/copyout.c b/src/copyout.c
index 7532dac..f0e512a 100644
--- a/src/copyout.c
+++ b/src/copyout.c
@@ -22,6 +22,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/xattr.h>
 #include "filetypes.h"
 #include "cpiohdr.h"
 #include "dstring.h"
@@ -578,6 +579,92 @@ assign_string (char **pvar, char *value)
   *pvar = p;
 }
 
+static int
+write_xattrs (int metadata_fd, char *path)
+{
+  struct metadata_hdr hdr = { .c_version = 1, .c_type = TYPE_XATTR };
+  char str[sizeof(hdr.c_size) + 1];
+  char *xattr_list, *list_ptr, *xattr_value;
+  ssize_t list_len, name_len, value_len, len;
+  int ret = -EINVAL;
+
+  if (metadata_fd < 0)
+    return 0;
+
+  list_len = llistxattr(path, NULL, 0);
+  if (list_len <= 0)
+    return -ENOENT;
+
+  list_ptr = xattr_list = malloc(list_len);
+  if (!list_ptr) {
+    error (0, 0, _("out of memory"));
+    return ret;
+  }
+
+  len = llistxattr(path, xattr_list, list_len);
+  if (len != list_len)
+    goto out;
+
+  if (ftruncate(metadata_fd, 0))
+    goto out;
+
+  lseek(metadata_fd, 0, SEEK_SET);
+
+  while (list_ptr < xattr_list + list_len) {
+    name_len = strlen(list_ptr);
+
+    value_len = lgetxattr(path, list_ptr, NULL, 0);
+    if (value_len < 0) {
+      error (0, 0, _("cannot get xattrs"));
+      break;
+    }
+
+    if (value_len) {
+      xattr_value = malloc(value_len);
+      if (!xattr_value) {
+	error (0, 0, _("out of memory"));
+	break;
+      }
+    } else {
+      xattr_value = NULL;
+    }
+
+    len = lgetxattr(path, list_ptr, xattr_value, value_len);
+    if (len != value_len)
+      break;
+
+    snprintf(str, sizeof(str), "%.8lx",
+	     sizeof(hdr) + name_len + 1 + value_len);
+
+    memcpy(hdr.c_size, str, sizeof(hdr.c_size));
+
+    if (write(metadata_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+      break;
+
+    if (write(metadata_fd, list_ptr, name_len + 1) != name_len + 1)
+      break;
+
+    if (write(metadata_fd, xattr_value, value_len) != value_len)
+      break;
+
+    if (fsync(metadata_fd))
+      break;
+
+    list_ptr += name_len + 1;
+    free(xattr_value);
+    xattr_value = NULL;
+  }
+
+  free(xattr_value);
+out:
+  free(xattr_list);
+
+  if (list_ptr != xattr_list + list_len)
+    return ret;
+
+  return 0;
+}
+
 /* Read a list of file names from the standard input
    and write a cpio collection on the standard output.
    The format of the header depends on the compatibility (-c) flag.  */
@@ -591,6 +678,8 @@ process_copy_out ()
   int in_file_des;		/* Source file descriptor.  */
   int out_file_des;		/* Output file descriptor.  */
   char *orig_file_name = NULL;
+  char template[] = "/tmp/cpio-metadata-XXXXXX";
+  int ret, metadata_fd, metadata = 0, old_metadata;
 
   /* Initialize the copy out.  */
   ds_init (&input_name, 128);
@@ -623,9 +712,36 @@ process_copy_out ()
       prepare_append (out_file_des);
     }
 
+  /* Create a temporary file to store file metadata */
+  if (metadata_type != TYPE_NONE) {
+    metadata_fd = mkstemp(template);
+    if (metadata_fd < 0) {
+      error (0, 0, _("cannot create temporary file"));
+      return;
+    }
+  }
+
   /* Copy files with names read from stdin.  */
-  while (ds_fgetstr (stdin, &input_name, name_end) != NULL)
+  while ((metadata_type != TYPE_NONE && metadata) ||
+	 ds_fgetstr (stdin, &input_name, name_end) != NULL)
     {
+      old_metadata = metadata;
+
+      if (metadata) {
+	metadata = 0;
+
+        if (metadata_type != TYPE_XATTR) {
+	  error (0, 0, _("metadata type not supported"));
+	  continue;
+	}
+
+	ret = write_xattrs(metadata_fd, orig_file_name);
+	if (ret < 0)
+	  continue;
+
+	ds_sgetstr (template, &input_name, name_end);
+      }
+
       /* Check for blank line.  */
       if (input_name.ds_string[0] == 0)
 	{
@@ -655,8 +771,15 @@ process_copy_out ()
 		    }
 		}
 	    }
-	  
-	  assign_string (&orig_file_name, input_name.ds_string);
+
+	  if (old_metadata) {
+	    assign_string (&orig_file_name, template);
+	    ds_sgetstr (METADATA_FILENAME, &input_name, name_end);
+	    file_hdr.c_mode |= 0x10000;
+	  } else {
+	    assign_string (&orig_file_name, input_name.ds_string);
+	  }
+
 	  cpio_safer_name_suffix (input_name.ds_string, false,
 				  !no_abs_paths_flag, true);
 #ifndef HPUX_CDF
@@ -844,6 +967,8 @@ process_copy_out ()
 	    fprintf (stderr, "%s\n", orig_file_name);
 	  if (dot_flag)
 	    fputc ('.', stderr);
+	  if (metadata_type != TYPE_NONE && !old_metadata)
+	    metadata = 1;
 	}
     }
 
@@ -882,6 +1007,11 @@ process_copy_out ()
 	       ngettext ("%lu block\n", "%lu blocks\n",
 			 (unsigned long) blocks), (unsigned long) blocks);
     }
+
+  if (metadata_type != TYPE_NONE) {
+    close(metadata_fd);
+    unlink(template);
+  }
 }
 
 
diff --git a/src/dstring.c b/src/dstring.c
index ddad4c8..fe3cfaf 100644
--- a/src/dstring.c
+++ b/src/dstring.c
@@ -60,8 +60,8 @@ ds_resize (dynamic_string *string, int size)
    Return NULL if end of file is detected.  Otherwise,
    Return a pointer to the null-terminated string in S.  */
 
-char *
-ds_fgetstr (FILE *f, dynamic_string *s, char eos)
+static char *
+ds_fgetstr_common (FILE *f, char *input_string, dynamic_string *s, char eos)
 {
   int insize;			/* Amount needed for line.  */
   int strsize;			/* Amount allocated for S.  */
@@ -72,7 +72,10 @@ ds_fgetstr (FILE *f, dynamic_string *s, char eos)
   strsize = s->ds_length;
 
   /* Read the input string.  */
-  next_ch = getc (f);
+  if (input_string)
+    next_ch = *input_string++;
+  else
+    next_ch = getc (f);
   while (next_ch != eos && next_ch != EOF)
     {
       if (insize >= strsize - 1)
@@ -81,7 +84,10 @@ ds_fgetstr (FILE *f, dynamic_string *s, char eos)
 	  strsize = s->ds_length;
 	}
       s->ds_string[insize++] = next_ch;
-      next_ch = getc (f);
+      if (input_string)
+	next_ch = *input_string++;
+      else
+	next_ch = getc (f);
     }
   s->ds_string[insize++] = '\0';
 
@@ -91,6 +97,12 @@ ds_fgetstr (FILE *f, dynamic_string *s, char eos)
     return s->ds_string;
 }
 
+char *
+ds_fgetstr (FILE *f, dynamic_string *s, char eos)
+{
+  return ds_fgetstr_common (f, NULL, s, eos);
+}
+
 char *
 ds_fgets (FILE *f, dynamic_string *s)
 {
@@ -102,3 +114,9 @@ ds_fgetname (FILE *f, dynamic_string *s)
 {
   return ds_fgetstr (f, s, '\0');
 }
+
+char *
+ds_sgetstr (char *input_string, dynamic_string *s, char eos)
+{
+  return ds_fgetstr_common (NULL, input_string, s, eos);
+}
diff --git a/src/dstring.h b/src/dstring.h
index b5135fe..f5f95ec 100644
--- a/src/dstring.h
+++ b/src/dstring.h
@@ -49,3 +49,4 @@ void ds_resize (dynamic_string *string, int size);
 char *ds_fgetname (FILE *f, dynamic_string *s);
 char *ds_fgets (FILE *f, dynamic_string *s);
 char *ds_fgetstr (FILE *f, dynamic_string *s, char eos);
+char *ds_sgetstr (char *input_string, dynamic_string *s, char eos);
diff --git a/src/extern.h b/src/extern.h
index 6fa2089..4c34404 100644
--- a/src/extern.h
+++ b/src/extern.h
@@ -19,6 +19,7 @@
 
 #include "paxlib.h"
 #include "quotearg.h"
+#include "initramfs.h"
 #include "quote.h"
 
 enum archive_format
@@ -99,6 +100,7 @@ extern char output_is_seekable;
 extern int (*xstat) ();
 extern void (*copy_function) ();
 extern char *change_directory_option;
+extern enum metadata_types metadata_type;
 
 
 /* copyin.c */
diff --git a/src/global.c b/src/global.c
index fb3abe9..0c40be0 100644
--- a/src/global.c
+++ b/src/global.c
@@ -199,3 +199,5 @@ char *change_directory_option;
 int renumber_inodes_option;
 int ignore_devno_option;
 
+/* include file metadata into the image */
+enum metadata_types metadata_type = TYPE_NONE;
diff --git a/src/initramfs.h b/src/initramfs.h
new file mode 100644
index 0000000..d13fc39
--- /dev/null
+++ b/src/initramfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * include/linux/initramfs.h
+ *
+ * Include file for file metadata in the initial ram disk.
+ */
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+#define METADATA_FILENAME "METADATA!!!"
+
+enum metadata_types { TYPE_NONE, TYPE_XATTR, TYPE__LAST };
+
+struct metadata_hdr {
+	char c_size[8];     /* total size including c_size field */
+	char c_version;     /* header version */
+	char c_type;        /* metadata type */
+	char c_metadata[];  /* metadata */
+} __attribute__((packed));
+
+#endif /*_LINUX_INITRAMFS_H*/
diff --git a/src/main.c b/src/main.c
index c68aba9..af1fa52 100644
--- a/src/main.c
+++ b/src/main.c
@@ -200,6 +200,8 @@ static struct argp_option options[] = {
   {"device-independent", DEVICE_INDEPENDENT_OPTION, NULL, 0,
    N_("Create device-independent (reproducible) archives") },
   {"reproducible", 0, NULL, OPTION_ALIAS },
+  {"file-metadata", 'e', N_("TYPE"), 0,
+   N_("Include file metadata"), GRID+1 },
 #undef GRID
   
   /* ********** */
@@ -293,6 +295,22 @@ warn_control (char *arg)
   return 1;
 }
 
+static enum metadata_types
+parse_metadata_type(char *arg)
+{
+  static char *metadata_type_str[TYPE__LAST] = {
+    [TYPE_NONE] = "none",
+    [TYPE_XATTR] = "xattr",
+  };
+  int i;
+
+  for (i = 0; i < TYPE__LAST; i++)
+    if (!strcmp (metadata_type_str[i], arg))
+      return i;
+
+  return TYPE_NONE;
+}
+
 static error_t
 parse_opt (int key, char *arg, struct argp_state *state)
 {
@@ -354,6 +372,10 @@ parse_opt (int key, char *arg, struct argp_state *state)
       copy_matching_files = false;
       break;
 
+    case 'e':		/* Metadata type.  */
+      metadata_type = parse_metadata_type(arg);
+      break;
+
     case 'E':		/* Pattern file name.  */
       pattern_file_name = arg;
       break;
-- 
2.17.1

