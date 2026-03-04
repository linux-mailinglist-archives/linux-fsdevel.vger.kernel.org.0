Return-Path: <linux-fsdevel+bounces-79299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEORDi15p2kshwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:13:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9961F8C4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7293066BEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D415B1EB;
	Wed,  4 Mar 2026 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqU1HAh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB311643B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583036; cv=none; b=R1/vqsbFieSnOoEvEnnpWetO7fedWuUTELgfpv09fm1y6OJstwfvAEHSRO4UDmEJ48l+2At0tde32XuGP6KLHPAhbBcOZdaQUBT4J8B8bdrpPqXPXD/Z+1fy1JtwE8h/aTNNuQLErP0IRwUtMkvkKsNQ+hPHnAXw8AM2qpyLUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583036; c=relaxed/simple;
	bh=fTKKoLNMyP1LnYIpGjnJ5YMLrL8M5nLQ5w0OC3j9WJ4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAyXHBbG4gBXVQHXTDXTfbsYehMfx8FR161MoKUJGmsjD03zyygp2iKg+aZbkZEnd8TwNrLHW0w/Uxgvimf9oCf+F/Cd9IglupiKfQBXdnzpwhOXfucqZTuYzrDBUXUDH6x8TxHZ0Ma5O+IYO3s6AiY60juxkvimrraWa72LDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqU1HAh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42615C116C6;
	Wed,  4 Mar 2026 00:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772583036;
	bh=fTKKoLNMyP1LnYIpGjnJ5YMLrL8M5nLQ5w0OC3j9WJ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iqU1HAh1qOwrFTSAcUlzlUmmTAL2IkrXEejvjX7UsDWN/yd2OGQxIq4sLwatL5/aH
	 sQho+mBR0+nr9+Oa+8pKHXNTOCHEAxcB+1wRHiSsBXIuBvs6MKdf+5KQpqt+Kp8cWD
	 Iem1LF/n2S9fyMYIJeNs3jiA6POo59zy+acKyqABaEN1hhKyrdXNlWt2rYYMUvDTfp
	 bHspFfsk2HyDKGHaVyX52XWEwsdQSkIYC0ArZsWrRU1TW6/n43W5mZdplKAYBPG6m6
	 roq/Q/3uPAzx0m68ckptJUDkByS9eewBMaJJ0LJPaW/GGBC0HeAX7OV2lnd/bW2cuQ
	 HMx3LB3feEB8w==
Date: Tue, 03 Mar 2026 16:10:35 -0800
Subject: [PATCH 2/3] libfuse: integrate fuse services into mount.fuse3
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: miklos@szeredi.hu, neal@gompa.dev, joannelkoong@gmail.com,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com
Message-ID: <177258266087.1161627.15882939941749159980.stgit@frogsfrogsfrogs>
In-Reply-To: <177258266040.1161627.14968799557253463876.stgit@frogsfrogsfrogs>
References: <177258266040.1161627.14968799557253463876.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB9961F8C4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gompa.dev,gmail.com,vger.kernel.org,bsbernd.com];
	TAGGED_FROM(0.00)[bounces-79299-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
index 16e120da10765e..b211c7ede4e034 100644
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
index 860c512a34e30f..13b80b3150e3bf 100644
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
index 4bee10bba2b18b..02901443553f89 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1036,3 +1036,21 @@ int mount_service_main(int argc, char *argv[])
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


