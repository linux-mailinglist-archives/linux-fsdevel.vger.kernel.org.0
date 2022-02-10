Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AC4B09CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiBJJpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 04:45:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiBJJpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE41B1B3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644486300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qGHq6WJL5h3ZNW1AqFzIiMK1BGfq6MuaHa+gD/xwRss=;
        b=ZtFDUmpzTq3eHA2/itai3qFksogphxcZqENTgTWjlAQLbVTDHYVG6Cv7yz3E8Pk/MVhVKP
        c0BtPi6BGcNTUrTH+dfUlp352jPPpL9XPWL9FsyREMLNhWuwz0ksiqs/lNIG8eNxw/5vqt
        gVpdAvKmz7Yx2RC0GXYkU7ncda30o+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-KvZOVrNHPniPvYFJG49HyA-1; Thu, 10 Feb 2022 04:44:57 -0500
X-MC-Unique: KvZOVrNHPniPvYFJG49HyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4CB8190B2A0;
        Thu, 10 Feb 2022 09:44:56 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.33.36.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA2F7D712;
        Thu, 10 Feb 2022 09:44:55 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] vfs: parse sloppy mount option in correct order
Date:   Thu, 10 Feb 2022 10:44:54 +0100
Message-Id: <20220210094454.826716-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/cifs/fs_context.c       |  4 ++--
 fs/cifs/fs_context.h       |  1 -
 fs/fs_context.c            | 14 ++++++++++++--
 fs/nfs/fs_context.c        |  4 ++--
 fs/nfs/internal.h          |  1 -
 include/linux/fs_context.h |  2 ++
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 7ec35f3f0a5f..5a8c074df74a 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -866,7 +866,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	if (!skip_parsing) {
 		opt = fs_parse(fc, smb3_fs_parameters, param, &result);
 		if (opt < 0)
-			return ctx->sloppy ? 1 : opt;
+			return fc->sloppy ? 1 : opt;
 	}
 
 	switch (opt) {
@@ -1412,7 +1412,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->multiuser = true;
 		break;
 	case Opt_sloppy:
-		ctx->sloppy = true;
+		fc->sloppy = true;
 		break;
 	case Opt_nosharesock:
 		ctx->nosharesock = true;
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index e54090d9ef36..52a67a96fb67 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -155,7 +155,6 @@ struct smb3_fs_context {
 	bool uid_specified;
 	bool cruid_specified;
 	bool gid_specified;
-	bool sloppy;
 	bool got_ip;
 	bool got_version;
 	bool got_rsize;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..2f9284e53589 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -155,8 +155,15 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
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
 
@@ -227,6 +234,9 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 		}
 	}
 
+	if (!fc->sloppy && fc->param_inval)
+		ret = -EINVAL;
+
 	return ret;
 }
 EXPORT_SYMBOL(generic_parse_monolithic);
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ea17fa1f31ec..c9ff68e17b68 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -482,7 +482,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 
 	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
 	if (opt < 0)
-		return ctx->sloppy ? 1 : opt;
+		return fc->sloppy ? 1 : opt;
 
 	if (fc->security)
 		ctx->has_sec_mnt_opts = 1;
@@ -837,7 +837,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		 * Special options
 		 */
 	case Opt_sloppy:
-		ctx->sloppy = true;
+		fc->sloppy = true;
 		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 		break;
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 12f6acb483bb..9febdc95b4d0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -80,7 +80,6 @@ struct nfs_fs_context {
 	bool			internal;
 	bool			skip_reconfig_option_check;
 	bool			need_mount;
-	bool			sloppy;
 	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..06a4b72a0f98 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -110,6 +110,8 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool                    sloppy:1;       /* If fs support it and was specified */
+	bool                    param_inval:1;  /* If set, check sloppy value */
 };
 
 struct fs_context_operations {
-- 
2.31.1

