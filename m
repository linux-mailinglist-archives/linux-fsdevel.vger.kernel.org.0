Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FEB737017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjFTPPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjFTPOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:14:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217F1989
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 08:14:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-543ae674f37so2626572a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687274044; x=1689866044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppeagV3dNvGBs5uOwHPj/yNTFpUx3d1G45VnXlncaYU=;
        b=D2L1KmqNoXZJPq6HVKSi5pdK+8tDdkQ+kzrfoahOQuTG05P1VjhC+j9kjjGROjvFcF
         61q96uQMMZjvbkUiZUCIpV+Lrk7ZckOeQuwnOANgw6dGtMr/9Hfs5YtZ/+Y1d4GbNQd+
         3QGwCRfySrq4tSrRx8JUtX5czk7VhZdJ5Jvvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274044; x=1689866044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppeagV3dNvGBs5uOwHPj/yNTFpUx3d1G45VnXlncaYU=;
        b=X+yzA2VcQRv9Nz/1pAA2xQLyg6BPDqla9zHTzeVpx20hLR3Dvw+rOtV9I5NEXCAclH
         WUWjatc3wcBeEI1/+ND30h6HdRFc8YhZtnfv6J8GfcEIfzno7in0uvoy1Q+sWHuLuO0j
         P7jFzftXde7szI35rSpP284UYijl3BfAkaJjiDTaOeAKtZY9B76M6Qgu176puc9OaV/e
         cTobFU96mhf51RvwJJEIGLUxYLp0vESRBrTdvQvqsELIPSRmyALyYnEjMbH0nhqj4II/
         p0hrENVs19aifKHjPZq9ZKhixRISU9/MTH6hVE39kHLrb2w5+Bft5j1uRx8QpKcsrH82
         CUZA==
X-Gm-Message-State: AC+VfDxfBd1bwsq0IdJnz0JQ1Hg/WK5w3c8V+iA14DDKT6zVxMVfcl5e
        cUV0/bytI5Ry17olP4NuoIZcNA==
X-Google-Smtp-Source: ACHHUZ472Lh9kVZoNfWFhDKNBtH5Zr9VanhcaUoOkG9ECCzmzQe/bcTVtQiaub20jl/H6Nd4WRfGdg==
X-Received: by 2002:a17:902:dac9:b0:1b6:822e:2bd4 with SMTP id q9-20020a170902dac900b001b6822e2bd4mr1697133plx.60.1687274044292;
        Tue, 20 Jun 2023 08:14:04 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:8f:203:e87e:41e3:d762:f8a8])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b001aaf370b1c7sm1731872plg.278.2023.06.20.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:14:03 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mhiramat@google.com, takayas@chromium.org, drosen@google.com,
        sarthakkukreti@google.com, uekawa@chromium.org,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fuse: Add negative_dentry_timeout option
Date:   Wed, 21 Jun 2023 00:13:15 +0900
Message-ID: <20230620151328.1637569-3-keiichiw@chromium.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230620151328.1637569-1-keiichiw@chromium.org>
References: <20230620151328.1637569-1-keiichiw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add `negative_dentry_timeout` mount option for FUSE to cache negative
dentries for the specified duration.
With this option enabled, second and subsequent lookups to non-existent
files can be omitted.

A user needs to specify how often each negative_dentry cache should be
refreshed. This is because the kernel has no idea when a FUSE server
creates or deletes files, unlike normal filesystems such as ext4 where
all of file operations are managed by the kernel.
The appropriate timeout duration should be determined by considering how
often a FUSE server update file paths and the amount of memory the
kernel can use the cache.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---

 Documentation/filesystems/fuse.rst |  6 ++++++
 fs/fuse/dir.c                      |  3 ++-
 fs/fuse/fuse_i.h                   |  4 ++++
 fs/fuse/inode.c                    | 12 +++++++++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index 1e31e87aee68..6d3b55476504 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -103,6 +103,12 @@ blksize=N
   Set the block size for the filesystem.  The default is 512.  This
   option is only valid for 'fuseblk' type mounts.
 
+negative_dentry_timeout=N
+  Set the time in seconds to keep negative dentry cache. If a lookup for
+  a path fails, the kernel won't do another lookup for this period of
+  time. The default value is 0, which means that negative dentries are not
+  cached.
+
 Control filesystem
 ==================
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..21ff395467ab 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -453,7 +453,8 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	if (outarg_valid)
 		fuse_change_entry_timeout(entry, &outarg);
 	else
-		fuse_invalidate_entry_cache(entry);
+		fuse_dentry_settime(entry,
+		time_to_jiffies(get_fuse_mount(dir)->negative_dentry_timeout, 0));
 
 	if (inode)
 		fuse_advise_use_readdirplus(dir);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..bbfe53635329 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -516,6 +516,7 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
+	unsigned int negative_dentry_timeout;
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
@@ -860,6 +861,9 @@ struct fuse_mount {
 	 */
 	struct super_block *sb;
 
+	/* Timeout on negative denty caches in seconds */
+	u32 negative_dentry_timeout;
+
 	/* Entry on fc->mounts */
 	struct list_head fc_entry;
 };
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d66070af145d..45ed0c52f8a6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -654,7 +654,8 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
-	OPT_ERR
+	OPT_ERR,
+	OPT_NEGATIVE_DENTRY_TIMEOUT
 };
 
 static const struct fs_parameter_spec fuse_fs_parameters[] = {
@@ -668,6 +669,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("negative_dentry_timeout", OPT_NEGATIVE_DENTRY_TIMEOUT),
 	{}
 };
 
@@ -751,6 +753,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_NEGATIVE_DENTRY_TIMEOUT:
+		ctx->negative_dentry_timeout = result.uint_32;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1482,6 +1488,10 @@ static int fuse_get_tree_submount(struct fs_context *fsc)
 		return -ENOMEM;
 
 	fm->fc = fuse_conn_get(fc);
+	fm->negative_dentry_timeout =
+		((struct fuse_fs_context *)fsc->fs_private)
+			->negative_dentry_timeout;
+
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, NULL, set_anon_super_fc);
 	if (fsc->s_fs_info)
-- 
2.41.0.185.g7c58973941-goog

