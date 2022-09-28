Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474DE5ED28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 03:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiI1BPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 21:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiI1BPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:15:11 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 18:15:03 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D31C433;
        Tue, 27 Sep 2022 18:15:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9D1A81002E8;
        Wed, 28 Sep 2022 11:09:50 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pQx7apNrMsWf; Wed, 28 Sep 2022 11:09:50 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 9653210030B; Wed, 28 Sep 2022 11:09:50 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 2560D1002E7;
        Wed, 28 Sep 2022 11:09:48 +1000 (AEST)
Subject: [PATCH] vfs: parse sloppy mount option in correct order
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs-list <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Wed, 28 Sep 2022 09:09:47 +0800
Message-ID: <166432738753.7008.13932358518650344215.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Bergantinos Corpas <rbergant@redhat.com>

With addition of fs_context support, options string is parsed
sequentially, if 'sloppy' option is not leftmost one, we may
return ENOPARAM to userland if a non-valid option preceeds sloopy
and mount will fail :

host# mount -o quota,sloppy 172.23.1.225:/share /mnt
mount.nfs: an incorrect mount option was specified
host# mount -o sloppy,quota 172.23.1.225:/share /mnt
host#

This patch correct that behaviour so that sloppy takes precedence
if specified anywhere on the string

changes since v1:
- add a boolean to fs context and postpone error reporting until
  parsing is done.

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/cifs/fs_context.c       |    4 ++--
 fs/cifs/fs_context.h       |    1 -
 fs/fs_context.c            |   14 ++++++++++++--
 fs/nfs/fs_context.c        |    5 +++--
 fs/nfs/internal.h          |    1 -
 include/linux/fs_context.h |    2 ++
 6 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 0e13dec86b25..32c3fdd7d27a 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -864,7 +864,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	if (!skip_parsing) {
 		opt = fs_parse(fc, smb3_fs_parameters, param, &result);
 		if (opt < 0)
-			return ctx->sloppy ? 1 : opt;
+			return fc->sloppy ? 1 : opt;
 	}
 
 	switch (opt) {
@@ -1420,7 +1420,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->multiuser = true;
 		break;
 	case Opt_sloppy:
-		ctx->sloppy = true;
+		fc->sloppy = true;
 		break;
 	case Opt_nosharesock:
 		ctx->nosharesock = true;
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index bbaee4c2281f..75e4c41466fa 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -157,7 +157,6 @@ struct smb3_fs_context {
 	bool uid_specified;
 	bool cruid_specified;
 	bool gid_specified;
-	bool sloppy;
 	bool got_ip;
 	bool got_version;
 	bool got_rsize;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index df04e5fc6d66..911a36bf2226 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -157,8 +157,15 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
-	return invalf(fc, "%s: Unknown parameter '%s'",
-		      fc->fs_type->name, param->key);
+	/* We got an invalid parameter, but sloppy may have been specified
+	 * later on param string.
+	 * Let's wait to process whole params to return EINVAL.
+	 */
+
+	fc->param_inval = true;
+	errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
+
+	return 0;
 }
 EXPORT_SYMBOL(vfs_parse_fs_param);
 
@@ -234,6 +241,9 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 		}
 	}
 
+	if (!fc->sloppy && fc->param_inval)
+		ret = -EINVAL;
+
 	return ret;
 }
 EXPORT_SYMBOL(generic_parse_monolithic);
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 4da701fd1424..09da63cc84f7 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -485,7 +485,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
 	if (opt < 0)
-		return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;
+		return (opt == -ENOPARAM && fc->sloppy) ? 1 : opt;
 
 	if (fc->security)
 		ctx->has_sec_mnt_opts = 1;
@@ -853,7 +853,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		 * Special options
 		 */
 	case Opt_sloppy:
-		ctx->sloppy = true;
+		fc->sloppy = true;
+		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 		break;
 	}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 898dd95bc7a7..83552def96f1 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -90,7 +90,6 @@ struct nfs_fs_context {
 	bool			internal;
 	bool			skip_reconfig_option_check;
 	bool			need_mount;
-	bool			sloppy;
 	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff1375a16c8c..d91d42bc06ce 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -111,6 +111,8 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool                    sloppy:1;       /* If fs support it and was specified */
+	bool                    param_inval:1;  /* If set, check sloppy value */
 };
 
 struct fs_context_operations {


