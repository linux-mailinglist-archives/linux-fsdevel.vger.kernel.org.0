Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EAE6C7779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCXFpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXFpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:45:04 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 22:45:03 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE0DBE8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:45:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9202F1003F6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 16:39:18 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6YTt4G13xs_j for <linux-fsdevel@vger.kernel.org>;
        Fri, 24 Mar 2023 16:39:18 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 7BD9A1003E5; Fri, 24 Mar 2023 16:39:18 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E62881003CD;
        Fri, 24 Mar 2023 16:39:16 +1100 (AEDT)
Subject: [RFC PATCH] vfs: handle sloppy option in fs context monolithic parser
From:   Ian Kent <raven@themaw.net>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>, Karel Zak <kzak@redhat.com>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>
Date:   Fri, 24 Mar 2023 13:39:16 +0800
Message-ID: <167963635629.253682.12145104262169969353.stgit@donald.themaw.net>
In-Reply-To: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sloppy option doesn't make sense for fsconfig() and knowedge of how
to handle this case needs to be present in the caller. It does make
sense in the legacy options parser, generic_parse_monolithic(), so it
should allow for it.

The sloppy option needs to be independent of the order in which it's
given.

The simplest way to do this in generic_parse_monolithic() is to check
for it's presence, check if the file system supports it, then skip
occurrances of it when walking the options string.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/cifs/fs_context.c |    2 +-
 fs/fs_context.c      |   31 ++++++++++++++++++++++++++++++-
 fs/nfs/fs_context.c  |    2 +-
 include/linux/fs.h   |    1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 6d13f8207e96..d7e9356797ab 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -866,7 +866,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	if (!skip_parsing) {
 		opt = fs_parse(fc, smb3_fs_parameters, param, &result);
 		if (opt < 0)
-			return ctx->sloppy ? 1 : opt;
+			return opt;
 	}
 
 	switch (opt) {
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..fa179e1b8061 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -187,6 +187,28 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 }
 EXPORT_SYMBOL(vfs_parse_fs_string);
 
+
+static bool check_for_sloppy_option(void *options)
+{
+	char *sloppy;
+	char last;
+
+	sloppy = strstr(options, "sloppy");
+	if (!sloppy)
+		return false;
+
+	last = sloppy[6];
+
+	if (sloppy == options) {
+		if (last == 0 || last == ',')
+			return true;
+	} else if (*(--sloppy) == ',') {
+		if (last == 0 || last == ',')
+			return true;
+	}
+	return false;
+}
+
 /**
  * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
  * @ctx: The superblock configuration to fill in.
@@ -201,6 +223,7 @@ EXPORT_SYMBOL(vfs_parse_fs_string);
 int generic_parse_monolithic(struct fs_context *fc, void *data)
 {
 	char *options = data, *key;
+	bool sloppy = false;
 	int ret = 0;
 
 	if (!options)
@@ -210,11 +233,17 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 	if (ret)
 		return ret;
 
+	if (fc->fs_type->fs_flags & FS_ALLOW_LEGACY_SLOPPY)
+		sloppy = check_for_sloppy_option(options);
+
 	while ((key = strsep(&options, ",")) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
 			char *value = strchr(key, '=');
 
+			if (sloppy && !strcmp(key, "sloppy"))
+				continue;
+
 			if (value) {
 				if (value == key)
 					continue;
@@ -222,7 +251,7 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 				v_len = strlen(value);
 			}
 			ret = vfs_parse_fs_string(fc, key, value, v_len);
-			if (ret < 0)
+			if (!sloppy && ret < 0)
 				break;
 		}
 	}
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9bcd53d5c7d4..e8818b68ce3f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -485,7 +485,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
 	if (opt < 0)
-		return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;
+		return opt;
 
 	if (fc->security)
 		ctx->has_sec_mnt_opts = 1;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..ca05111767cb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2533,6 +2533,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALLOW_LEGACY_SLOPPY	64	/* FS allows "sloppy" option handling behaviour */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;


