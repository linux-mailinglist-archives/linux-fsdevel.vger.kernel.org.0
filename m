Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942E512B53A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfL0Oam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 09:30:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52332 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfL0Oal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:30:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so8194469wmc.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SJEn2F+yVgSIpuW6AxSyC1Con0NqfXAdj1dTyYrxtwU=;
        b=xZYHH0GVRFPE5Xvgz7fK234vm3vk3rQc8DTqOtKdWIn7kQoGBWIIbTOLhXXkKc7yEN
         Yk5DSAe3Pp6L0PQT5sq945v0FgOoBOm3zdvsx2p7JSbGTC+QkuhUnV92jd+VuNmOuWI/
         D3Q51xWm8NlH/DBAa9OTcewuMZhcKw+4272B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJEn2F+yVgSIpuW6AxSyC1Con0NqfXAdj1dTyYrxtwU=;
        b=auCGhvo28/ZO/KVxnzTDGwpI6uUpyNeVkTqeO3400YPl4jNdmN8ZbLqOmyCU7NJJC/
         WogeHbmvL8cCLNiR9jW7W6za9CP3s3VV1KcX0v6hbRc+3oXvh0L293zr8a7QBF0HUbl9
         9XZPbZTTkjIgSwCM3raimsng2QH/1ulrfpkJWC4UpA3rKpYhzSJ60uMaAIENshBof0dP
         Ij6SMQclkePIw0wLO7pI97KZMybBTt1t27ri+R2HM9jSxcpH6Qgx19ZqfJm1kEGlrSEv
         oqCKppKqqpARMSxXH7zd267n14uBmoqBDHben7kT5xsRixgIt3Fg+blfDnEVUCBcJfMl
         yMPQ==
X-Gm-Message-State: APjAAAXiFundbpwI3oKKUzwkqim8CVZ6n4YWcDWYTxtve0d3wBRYRinO
        j2LK+kF46cdR/O9qBje0Nq/BBtk8MkA=
X-Google-Smtp-Source: APXvYqz98n6QGyZmDlnlF5P6PChY+i7dRIpWtnYeFHbhKeGZkzz6da1DQ6U43qg/Kv2QxrV6JUnl0w==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr19201944wmb.160.1577457039217;
        Fri, 27 Dec 2019 06:30:39 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id h2sm37587902wrt.45.2019.12.27.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 06:30:38 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:30:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/3] shmem: Add support for using full width of ino_t
Message-ID: <533d188802d292fa9f7c9e66f26068000346d6c1.1577456898.git.chris@chrisdown.name>
References: <cover.1577456898.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577456898.git.chris@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new inode64 option now uses get_next_ino_full, which always uses the
full width of ino_t (as opposed to get_next_ino, which always uses
unsigned int).

Using inode64 makes inode number wraparound significantly less likely,
at the cost of making some features that rely on the underlying
filesystem not setting any of the highest 32 bits (eg. overlayfs' xino)
not usable.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reported-by: Phyllipe Medeiros <phyllipe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index de8e4b71e3ba..d7727d0d687f 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -35,6 +35,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	bool small_inums;	    /* i_ino width unsigned int or ino_t */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
diff --git a/mm/shmem.c b/mm/shmem.c
index ff041cb15550..56cf581ec66d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -115,11 +115,13 @@ struct shmem_options {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	bool small_inums;
 	int huge;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
+#define SHMEM_SEEN_INUMS 8
 };
 
 #ifdef CONFIG_TMPFS
@@ -2248,8 +2250,12 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	inode = new_inode(sb);
 	if (inode) {
 		/* Recycle to avoid 32-bit wraparound where possible */
-		if (!inode->i_ino)
-			inode->i_ino = get_next_ino();
+		if (!inode->i_ino) {
+			if (sbinfo->small_inums)
+				inode->i_ino = get_next_ino();
+			else
+				inode->i_ino = get_next_ino_full();
+		}
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -3380,6 +3386,8 @@ enum shmem_param {
 	Opt_nr_inodes,
 	Opt_size,
 	Opt_uid,
+	Opt_inode32,
+	Opt_inode64,
 };
 
 static const struct fs_parameter_spec shmem_param_specs[] = {
@@ -3391,6 +3399,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_flag  ("inode32",	Opt_inode32),
+	fsparam_flag  ("inode64",	Opt_inode64),
 	{}
 };
 
@@ -3415,6 +3425,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	const char *err;
 
 	opt = fs_parse(fc, &shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3476,6 +3487,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 		goto unsupported_parameter;
+	case Opt_inode32:
+		ctx->small_inums = true;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
+	case Opt_inode64:
+		if (sizeof(ino_t) < 8) {
+			err = "Cannot use inode64 with <64bit inums in kernel";
+			goto err_msg;
+		}
+		ctx->small_inums = false;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
 	}
 	return 0;
 
@@ -3483,6 +3506,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	return invalf(fc, "tmpfs: Unsupported parameter '%s'", param->key);
 bad_value:
 	return invalf(fc, "tmpfs: Bad value for '%s'", param->key);
+err_msg:
+	return invalf(fc, "tmpfs: %s", err);
 }
 
 static int shmem_parse_options(struct fs_context *fc, void *data)
@@ -3567,6 +3592,15 @@ static int shmem_reconfigure(struct fs_context *fc)
 		}
 	}
 
+	/*
+	 * get_next_ino and get_next_ino_full have different static counters, so
+	 * it's not safe to change once we started or we could get duplicates
+	 */
+	if (ctx->seen & SHMEM_SEEN_INUMS) {
+		err = "Cannot retroactively change inode number size";
+		goto out;
+	}
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
 	if (ctx->seen & SHMEM_SEEN_BLOCKS)
@@ -3608,6 +3642,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u",
 				from_kgid_munged(&init_user_ns, sbinfo->gid));
+	seq_printf(seq, ",inode%d", (sbinfo->small_inums ? 32 : 64));
 #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
 	/* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
 	if (sbinfo->huge)
@@ -3667,6 +3702,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
 	sbinfo->uid = ctx->uid;
 	sbinfo->gid = ctx->gid;
+	sbinfo->small_inums = ctx->small_inums;
 	sbinfo->mode = ctx->mode;
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
@@ -3879,6 +3915,7 @@ int shmem_init_fs_context(struct fs_context *fc)
 	ctx->mode = 0777 | S_ISVTX;
 	ctx->uid = current_fsuid();
 	ctx->gid = current_fsgid();
+	ctx->small_inums = true;
 
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
-- 
2.24.1

