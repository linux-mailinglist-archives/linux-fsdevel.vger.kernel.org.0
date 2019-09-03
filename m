Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6258EA677E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfICLgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfICLgv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:51 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DC4E757C0
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:50 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c11so4226687wml.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3ITaB+F8loZbcEn4YrJIgIB7m3BqeKZtOyPY/Ayk1w=;
        b=PiR7c36cfHi1bZfbG+XO2a/kOdHlX4Z07+jYAToKx3QrOnx9LgL8k8cxNTJKJ2qtG7
         fcDE2ipuutvTjC8mBGa3CtdlOC1J9WzFQw+JyXDbyrslcFVBAx3m9q1zrbIn0Bkf6vYS
         87tHuEhYO2j7HUn9PRldD3A2xf3418jrHp+gZUYXBdOSg4bD7j27MgckPIfhgtpWkHO6
         XOuRqS+rtmtyfOiNwZYLYFBUcsyWxaMuuuYKCCweyPgcSZD7E6xoJwdtgtpmLJ4PyW2l
         t3R1nXCxdgbzMnXdFrNZgCuaCoZZB5uKarPMbBTOhwe9dGo4LRU9ckXDeqVLwKzJLuQn
         cJlA==
X-Gm-Message-State: APjAAAX/ntOSfU3t7RnSc25PcB0mSLrWnEg9uF17Odc1AKkS04+TyrnL
        Uj9brS28P/2nsHxxuQNRUDABEujvhjiBPOuFqmpZp5uxSgy0b17uQCAc5ni4En17QXDhI7IBgvH
        PJ53PqV7yj0faoH2DDhJ3OI7oCQ==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr38940115wrw.53.1567510608782;
        Tue, 03 Sep 2019 04:36:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwu8OC/y6yanKYsj1cT00XOuOjwHESvhNUhBsPBTa/oAejpHDFyTDxNuNmfoqJGHtub3HzQeg==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr38940087wrw.53.1567510608580;
        Tue, 03 Sep 2019 04:36:48 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:47 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 03/16] vfs: subtype handling moved to fuse
Date:   Tue,  3 Sep 2019 13:36:27 +0200
Message-Id: <20190903113640.7984-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The unused vfs code can be removed.  Don't pass empty subtype (same as if
->parse callback isn't called).

The bits that are left involve determining whether it's permitted to split the
filesystem type string passed in to mount(2).  Consequently, this means that we
cannot get rid of the FS_HAS_SUBTYPE flag unless we define that a type string
with a dot in it always indicates a subtype specification.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c            | 14 --------------
 fs/fuse/inode.c            |  3 +--
 fs/namespace.c             |  2 --
 fs/proc_namespace.c        |  2 +-
 fs/super.c                 |  5 -----
 include/linux/fs_context.h |  1 -
 6 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 270ecae32216..f6dee3b2b7de 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -508,7 +508,6 @@ void put_fs_context(struct fs_context *fc)
 	put_net(fc->net_ns);
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
-	kfree(fc->subtype);
 	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
@@ -575,17 +574,6 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 	}
 
-	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
-	    strcmp(param->key, "subtype") == 0) {
-		if (param->type != fs_value_is_string)
-			return invalf(fc, "VFS: Legacy: Non-string subtype");
-		if (fc->subtype)
-			return invalf(fc, "VFS: Legacy: Multiple subtype");
-		fc->subtype = param->string;
-		param->string = NULL;
-		return 0;
-	}
-
 	if (ctx->param_type == LEGACY_FS_MONOLITHIC_PARAMS)
 		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
 
@@ -742,8 +730,6 @@ void vfs_clean_context(struct fs_context *fc)
 	fc->s_fs_info = NULL;
 	fc->sb_flags = 0;
 	security_free_mnt_opts(&fc->security);
-	kfree(fc->subtype);
-	fc->subtype = NULL;
 	kfree(fc->source);
 	fc->source = NULL;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2597ed237ada..e3375ce8e97f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -473,8 +473,7 @@ static const struct fs_parameter_spec fuse_param_specs[] = {
 	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
-	__fsparam(fs_param_is_string, "subtype", OPT_SUBTYPE,
-		  fs_param_v_optional),
+	fsparam_string	("subtype",		OPT_SUBTYPE),
 	{}
 };
 
diff --git a/fs/namespace.c b/fs/namespace.c
index d28d30b13043..105f995543f6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2768,8 +2768,6 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 				put_filesystem(type);
 				return -EINVAL;
 			}
-		} else {
-			subtype = "";
 		}
 	}
 
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e16fb8f2049e..273ee82d8aa9 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -88,7 +88,7 @@ static inline void mangle(struct seq_file *m, const char *s)
 static void show_type(struct seq_file *m, struct super_block *sb)
 {
 	mangle(m, sb->s_type->name);
-	if (sb->s_subtype && sb->s_subtype[0]) {
+	if (sb->s_subtype) {
 		seq_putc(m, '.');
 		mangle(m, sb->s_subtype);
 	}
diff --git a/fs/super.c b/fs/super.c
index 80b56bc7d2db..e30a4279784c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1535,11 +1535,6 @@ int vfs_get_tree(struct fs_context *fc)
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
 
-	if (fc->subtype && !sb->s_subtype) {
-		sb->s_subtype = fc->subtype;
-		fc->subtype = NULL;
-	}
-
 	/*
 	 * Write barrier is for super_cache_count(). We place it before setting
 	 * SB_BORN as the data dependency between the two functions is the
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ed5b4349671e..461d37912bed 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -97,7 +97,6 @@ struct fs_context {
 	const struct cred	*cred;		/* The mounter's credentials */
 	struct fc_log		*log;		/* Logging buffer */
 	const char		*source;	/* The source name (eg. dev path) */
-	const char		*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* Linux S&M options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
 	fmode_t			bdev_mode;	/* File open mode for bdev */
-- 
2.21.0

