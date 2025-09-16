Return-Path: <linux-fsdevel+bounces-61588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F74B58A07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314D87A322A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090A14B950;
	Tue, 16 Sep 2025 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9rSB/B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A715C96
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983745; cv=none; b=crlFB1MRcyLUdvLaWrrx9UDQYq2l/NrYCkSHfzx3fr/tbyIyHBaHB4eTf/iS7FChaymgUoIICZKpWxBANz/UwfarOvf/13Ijb2FgmBHWCLg/JHxC2eTyd25OG++URkjLwa4tyOEUKRqG5yWhxd2YGFCO5yMbxUmU5tWFL7ZG/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983745; c=relaxed/simple;
	bh=DIdvZHZiYNiGiAZRlYkDq5CCmh5SKy7mvQdKZmY+G5Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkySr09JYauSvlhSu1NQyFrZD1E6g/lEFOCUBv40NoghGkmLAiWfvTW3eMj7BIeRa6Bqpg6DlpNpdkL16HUzrPqg4gHlKztH4f6ECDOMrGwlwMw0Hi4/REHedR5eUmto8SAldBt2HPg6l2AoLWmaPmW5xm6WY+kKCtR2O3amm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9rSB/B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A0C4CEF1;
	Tue, 16 Sep 2025 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983745;
	bh=DIdvZHZiYNiGiAZRlYkDq5CCmh5SKy7mvQdKZmY+G5Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l9rSB/B1+qCwsO5WjEEfMeIciHKM2T4J82aIGohNU9yqfx/ClsJ1pAs5cZZ6fcsDq
	 75NrrtIxi4calBxevT1dvRxHPmHGM5ai6eBlfs2SyuJ/vrxqLE1mCuQ2bjlVjzeh6F
	 Tv3YrJBYaSSiKvnQz36WxFox06kcbZSV2smgKHJaMzwi1DS8xum1k6vJeJATUD6LM+
	 pJWDZE92LzqXfMyy2oLPR6QYK9aUc/311Zq6KM9RIsriPuN01r/9QTBaWndKHjxr0q
	 EiuZQTpddSQBzlXYAcXNmRvrrkdy1opeBQbVpfFJbVUqkEOGUmdmoovA9NXLRj/Kir
	 GIurMACRXxfwA==
Date: Mon, 15 Sep 2025 17:49:04 -0700
Subject: [PATCH 2/4] libfuse: integrate fuse services into mount.fuse3
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155806.388120.7949378678028347135.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
References: <175798155756.388120.4267843355083714610.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach mount.fuse3 how to start fuse via service, if present.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/mount_service.h  |    9 ++++++++
 doc/fuservicemount3.8 |   10 ++++++++
 util/fuservicemount.c |   48 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build      |    4 +++
 util/mount.fuse.c     |   58 +++++++++++++++++++++++++++++++------------------
 util/mount_service.c  |   18 +++++++++++++++
 6 files changed, 124 insertions(+), 23 deletions(-)


diff --git a/util/mount_service.h b/util/mount_service.h
index 986a785bed3e74..b3e449ef005231 100644
--- a/util/mount_service.h
+++ b/util/mount_service.h
@@ -29,4 +29,13 @@ int mount_service_main(int argc, char *argv[]);
  */
 const char *mount_service_subtype(const char *fstype);
 
+/**
+ * Discover if there is a fuse service socket for the given fuse subtype.
+ *
+ * @param subtype subtype of a fuse filesystem type (e.g. Y from
+ *                mount_service_subtype)
+ * @return true if available, false if not
+ */
+bool mount_service_present(const char *subtype);
+
 #endif /* MOUNT_SERVICE_H_ */
diff --git a/doc/fuservicemount3.8 b/doc/fuservicemount3.8
index e45d6a89c8b81a..aa2167cb4872c6 100644
--- a/doc/fuservicemount3.8
+++ b/doc/fuservicemount3.8
@@ -7,12 +7,20 @@ .SH SYNOPSIS
 .B mountpoint
 .BI -t " fstype"
 [
-.I options
+.BI -o " options"
 ]
+
+.B fuservicemount3
+.BI -t " fstype"
+.B --check
+
 .SH DESCRIPTION
 Mount a filesystem using a FUSE server that runs as a socket service.
 These servers can be contained using the platform's service management
 framework.
+
+The second form checks if there is a FUSE service available for the given
+filesystem type.
 .SH "AUTHORS"
 .LP
 The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
diff --git a/util/fuservicemount.c b/util/fuservicemount.c
index c54d5b0767f760..edff2ed08ac23b 100644
--- a/util/fuservicemount.c
+++ b/util/fuservicemount.c
@@ -9,10 +9,58 @@
 /* This program does the mounting of FUSE filesystems that run in systemd */
 
 #define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
 #include "fuse_config.h"
 #include "mount_service.h"
 
+static int check_service(const char *fstype)
+{
+	const char *subtype;
+
+	if (!fstype) {
+		fprintf(stderr,
+			"fuservicemount: expected fs type for --check\n");
+		return EXIT_FAILURE;
+	}
+
+	subtype = mount_service_subtype(fstype);
+	return mount_service_present(subtype) ? EXIT_SUCCESS : EXIT_FAILURE;
+}
+
 int main(int argc, char *argv[])
 {
+	char *fstype = NULL;
+	bool check = false;
+	int i;
+
+	/*
+	 * If the user passes us exactly the args -t FSTYPE --check then
+	 * we'll just check if there's a service for the FSTYPE fuse server.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--check")) {
+			if (check) {
+				check = false;
+				break;
+			}
+			check = true;
+		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {
+			if (fstype) {
+				check = false;
+				break;
+			}
+			fstype = argv[i + 1];
+			i++;
+		} else {
+			check = false;
+			break;
+		}
+	}
+	if (check)
+		return check_service(fstype);
+
 	return mount_service_main(argc, argv);
 }
diff --git a/util/meson.build b/util/meson.build
index 68d8bb11f92955..3adf395bfb6386 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -6,7 +6,9 @@ executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c
            install_dir: get_option('bindir'),
            c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
 
+mount_fuse3_sources = ['mount.fuse.c']
 if private_cfg.get('HAVE_SERVICEMOUNT', false)
+  mount_fuse3_sources += ['mount_service.c']
   executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c'],
              include_directories: include_dirs,
              link_with: [ libfuse ],
@@ -15,7 +17,7 @@ if private_cfg.get('HAVE_SERVICEMOUNT', false)
              c_args: '-DFUSE_USE_VERSION=317')
 endif
 
-executable('mount.fuse3', ['mount.fuse.c'],
+executable('mount.fuse3', mount_fuse3_sources,
            include_directories: include_dirs,
            link_with: [ libfuse ],
            install: true,
diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index f1a90fe8abae7c..b6a55eebb7f88b 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -49,6 +49,9 @@
 #endif
 
 #include "fuse.h"
+#ifdef HAVE_SERVICEMOUNT
+# include "mount_service.h"
+#endif
 
 static char *progname;
 
@@ -280,9 +283,7 @@ int main(int argc, char *argv[])
 	mountpoint = argv[2];
 
 	for (i = 3; i < argc; i++) {
-		if (strcmp(argv[i], "-v") == 0) {
-			continue;
-		} else if (strcmp(argv[i], "-t") == 0) {
+		if (strcmp(argv[i], "-t") == 0) {
 			i++;
 
 			if (i == argc) {
@@ -303,6 +304,39 @@ int main(int argc, char *argv[])
 					progname);
 				exit(1);
 			}
+		}
+	}
+
+	if (!type) {
+		if (source) {
+			dup_source = xstrdup(source);
+			type = dup_source;
+			source = strchr(type, '#');
+			if (source)
+				*source++ = '\0';
+			if (!type[0]) {
+				fprintf(stderr, "%s: empty filesystem type\n",
+					progname);
+				exit(1);
+			}
+		} else {
+			fprintf(stderr, "%s: empty source\n", progname);
+			exit(1);
+		}
+	}
+
+#ifdef HAVE_SERVICEMOUNT
+	/*
+	 * Now that we know the desired filesystem type, see if we can find
+	 * a socket service implementing that.
+	 */
+	if (mount_service_present(type))
+		return mount_service_main(argc, argv);
+#endif
+
+	for (i = 3; i < argc; i++) {
+		if (strcmp(argv[i], "-v") == 0) {
+			continue;
 		} else	if (strcmp(argv[i], "-o") == 0) {
 			char *opts;
 			char *opt;
@@ -366,24 +400,6 @@ int main(int argc, char *argv[])
 	if (suid)
 		options = add_option("suid", options);
 
-	if (!type) {
-		if (source) {
-			dup_source = xstrdup(source);
-			type = dup_source;
-			source = strchr(type, '#');
-			if (source)
-				*source++ = '\0';
-			if (!type[0]) {
-				fprintf(stderr, "%s: empty filesystem type\n",
-					progname);
-				exit(1);
-			}
-		} else {
-			fprintf(stderr, "%s: empty source\n", progname);
-			exit(1);
-		}
-	}
-
 	if (setuid_name && setuid_name[0]) {
 #ifdef linux
 		if (drop_privileges) {
diff --git a/util/mount_service.c b/util/mount_service.c
index 46d368d0cba922..612fec327cedde 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -960,3 +960,21 @@ int mount_service_main(int argc, char *argv[])
 	mount_service_destroy(&mo);
 	return ret;
 }
+
+bool mount_service_present(const char *fstype)
+{
+	struct stat stbuf;
+	char path[PATH_MAX];
+	int ret;
+
+	snprintf(path, sizeof(path), FUSE_SERVICE_SOCKET_DIR "/%s", fstype);
+	ret = stat(path, &stbuf);
+	if (ret)
+		return false;
+
+	if (!S_ISSOCK(stbuf.st_mode))
+		return false;
+
+	ret = access(path, R_OK | W_OK);
+	return ret == 0;
+}


