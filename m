Return-Path: <linux-fsdevel+bounces-40986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3CA29BED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12E43A7956
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A1215070;
	Wed,  5 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iy8P3z0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A18214A96
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791614; cv=none; b=nyynitEt9JPRt9bi/TF8CLI07u86ti4cZIT1XDK/lzOhAoXgmqsL0tfM+9Av43e0vZ1MA9I5T6jAP5DhKcm5vvZ9aLF19j52ipm05GVMsRFs8rXF9JVyt8XKoRs3yjs5BkZ6ZUTm0IPKY12hmpvLUUxFZrZo0e8mghD7+Q+Vue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791614; c=relaxed/simple;
	bh=owTMDRvMIl6CR2bRpwY5/l81nLg7mc8/bjZWhYhz7z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5K6JBGRBl1mt3E6165tnrqtxEMt0v6WuWwR/egYfr+zoHcCL6EJTmg5o4Rm7aRRI0HbHpW2CpoiwZCb0o9Yu9rVtL9A+WtWxSKxk10toro0NrY7bnzB7fv8bYWOXIaTIxkU4eRs3TZ3LGoyjbjHzkg78rOvpTuI1DqYfirfQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iy8P3z0b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738791611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI3k8bcq+m+N+I5b1C39QGxRc+84aBKvh/0h/4r8Fxg=;
	b=iy8P3z0bFhjYMpI4ofJ4I6+i2PpfflGtenPvkTHXEpLfVMsV5SUGpQpka7DuCuFOhHOuF/
	pthqmmM/21FM5YEBrgpHExharPNqfnSvx+2IPCIUWBV0fzFFAJ2gENimbcYv+GgI+ErCQ3
	cZfmzhgMOPTKcctj2nIrdP2ohSvuKhQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-IML2EKifMyaB_Rsp_fZgqQ-1; Wed, 05 Feb 2025 16:40:10 -0500
X-MC-Unique: IML2EKifMyaB_Rsp_fZgqQ-1
X-Mimecast-MFC-AGG-ID: IML2EKifMyaB_Rsp_fZgqQ
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844e619a122so20695739f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 13:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791609; x=1739396409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI3k8bcq+m+N+I5b1C39QGxRc+84aBKvh/0h/4r8Fxg=;
        b=W3HS6myBnDvKqC0uHOKaF5x40udNGkXJJG99swgwit8XlW/LvSV0lpjyztP3ue0xW2
         /9Gxxt1Z8hWCObsUcNFK6Gc7pxj6C+6aMYSw0oOef3Yb48E836b4OuIYOzFLRQYcMQGL
         hrsPB9MCFdZPD0JqrmsPhicUZ7B+gGchEG5/5V1UJMeVQVOQBqJbTK2bbORoSWUpJlog
         wX7BrUZVEGeu6eKuOl+sN2a+exqRpf3zY2cri+kscYAWwlDdgo75UhlFdx/sbtY+P67s
         2a2O56WJu9jkp7+CTIELWQuXLKPQBXxE+DTJdAWESoD9t+bf6NJnhlzSrvJszUZj5CHd
         wOpQ==
X-Gm-Message-State: AOJu0YzTd27qp+uW6Ahw0QBxFjaR3x4gb2xuMykm5Ft632m37yO243x0
	Z/QkB5h3TUgoox5oTv546/lpcNW6Ozje1hyX/t3dHeayrEx3vw7qdQlIh2Xz3RObVlOx9sxzz0m
	xc0vvTMapTg+WGrUDu4D6lSXsqwhcN8c1RXyLOQLxyhw/Dp4XlzvfnQGiRTQT7+68uh7i0kzTTf
	TqPXOtZ+NYx4By/beqRgWqw/o39EA7ayY0D6EgZVQPJzW8pGIq
X-Gm-Gg: ASbGncs+IcxPqOu3r5I1G7SZ6CkQRkM73ZIi1Zoswa+bmAHWrHj4yOwrXhKEt3hvMKw
	zOE9TEfgquG9IgOYdhcDxugkVl/7HB9SN90YvMEFzQpg6E+wIQNh/BBuNBuk2yt4iif3i/7dEY6
	U4+z7P5FDee6KwFs1InLZljqklM2GNn2DJxx13S+K7vjMbGVA3S9ZOrEisETtq6PhXAVmEl+qMP
	OXk+DEL6FNWhorn975iDxVGWPi1CGn52oUXAUNlIJc/qblqfA+bmp/noQnFx5/JUzjeuSn2vsQb
	LcaSHdewds1RwgO22MJYmu8s+A4GQXABt4VklcuqqGtorRZDhmqPJA==
X-Received: by 2002:a05:6602:7508:b0:844:c9b1:f08f with SMTP id ca18e2360f4ac-854ea41b7d0mr503095939f.3.1738791609026;
        Wed, 05 Feb 2025 13:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs5EGBWtKkTqAqB86JsHbPoGmrEMriXtkg5ui5VlfDiJspKWjCaUnChoJ44zGQVO1YgQ0YEg==
X-Received: by 2002:a05:6602:7508:b0:844:c9b1:f08f with SMTP id ca18e2360f4ac-854ea41b7d0mr503092839f.3.1738791608638;
        Wed, 05 Feb 2025 13:40:08 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717863sm368050839f.36.2025.02.05.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:40:07 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/4] pstore: convert to the new mount API
Date: Wed,  5 Feb 2025 15:34:29 -0600
Message-ID: <20250205213931.74614-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205213931.74614-1-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the pstore filesystem to the new mount API.

Cc: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/pstore/inode.c | 111 +++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 36 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce79..3a4582b79c75 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -14,10 +14,10 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/string.h>
-#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/ramfs.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include <linux/sched.h>
 #include <linux/magic.h>
 #include <linux/pstore.h>
@@ -226,37 +226,38 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 }
 
 enum {
-	Opt_kmsg_bytes, Opt_err
+	Opt_kmsg_bytes
 };
 
-static const match_table_t tokens = {
-	{Opt_kmsg_bytes, "kmsg_bytes=%u"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec pstore_param_spec[] = {
+	fsparam_u32	("kmsg_bytes",	Opt_kmsg_bytes),
+	{}
 };
 
-static void parse_options(char *options)
-{
-	char		*p;
-	substring_t	args[MAX_OPT_ARGS];
-	int		option;
-
-	if (!options)
-		return;
+struct pstore_context {
+	unsigned int kmsg_bytes;
+};
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
+static int pstore_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct pstore_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
 
-		if (!*p)
-			continue;
+	opt = fs_parse(fc, pstore_param_spec, param, &result);
+	/* pstore has historically ignored invalid kmsg_bytes param */
+	if (opt < 0)
+		return 0;
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_kmsg_bytes:
-			if (!match_int(&args[0], &option))
-				pstore_set_kmsg_bytes(option);
-			break;
-		}
+	switch (opt) {
+	case Opt_kmsg_bytes:
+		ctx->kmsg_bytes = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 /*
@@ -269,10 +270,12 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int pstore_remount(struct super_block *sb, int *flags, char *data)
+static int pstore_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	parse_options(data);
+	struct pstore_context *ctx = fc->fs_private;
+
+	sync_filesystem(fc->root->d_sb);
+	pstore_set_kmsg_bytes(ctx->kmsg_bytes);
 
 	return 0;
 }
@@ -281,7 +284,6 @@ static const struct super_operations pstore_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= pstore_evict_inode,
-	.remount_fs	= pstore_remount,
 	.show_options	= pstore_show_options,
 };
 
@@ -406,8 +408,9 @@ void pstore_get_records(int quiet)
 	inode_unlock(d_inode(root));
 }
 
-static int pstore_fill_super(struct super_block *sb, void *data, int silent)
+static int pstore_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct pstore_context *ctx = fc->fs_private;
 	struct inode *inode;
 
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
@@ -417,7 +420,7 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op		= &pstore_ops;
 	sb->s_time_gran		= 1;
 
-	parse_options(data);
+	pstore_set_kmsg_bytes(ctx->kmsg_bytes);
 
 	inode = pstore_get_inode(sb);
 	if (inode) {
@@ -431,19 +434,33 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	scoped_guard(mutex, &pstore_sb_lock)
-		pstore_sb = sb;
+	pstore_sb = sb;
 
 	pstore_get_records(0);
 
 	return 0;
 }
 
-static struct dentry *pstore_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int pstore_get_tree(struct fs_context *fc)
+{
+	if (fc->root)
+		return pstore_reconfigure(fc);
+
+	return get_tree_single(fc, pstore_fill_super);
+}
+
+static void pstore_free_fc(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, pstore_fill_super);
+	kfree(fc->fs_private);
 }
 
+static const struct fs_context_operations pstore_context_ops = {
+	.parse_param	= pstore_parse_param,
+	.get_tree	= pstore_get_tree,
+	.reconfigure	= pstore_reconfigure,
+	.free		= pstore_free_fc,
+};
+
 static void pstore_kill_sb(struct super_block *sb)
 {
 	guard(mutex)(&pstore_sb_lock);
@@ -456,11 +473,33 @@ static void pstore_kill_sb(struct super_block *sb)
 	INIT_LIST_HEAD(&records_list);
 }
 
+static int pstore_init_fs_context(struct fs_context *fc)
+{
+	struct pstore_context *ctx;
+
+	ctx = kzalloc(sizeof(struct pstore_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/*
+	 * Global kmsg_bytes is initialized to default, and updated
+	 * every time we (re)mount the single-sb filesystem with the
+	 * option specified.
+	 */
+	ctx->kmsg_bytes = kmsg_bytes;
+
+	fc->fs_private = ctx;
+	fc->ops = &pstore_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type pstore_fs_type = {
 	.owner          = THIS_MODULE,
 	.name		= "pstore",
-	.mount		= pstore_mount,
 	.kill_sb	= pstore_kill_sb,
+	.init_fs_context = pstore_init_fs_context,
+	.parameters	= pstore_param_spec,
 };
 
 int __init pstore_init_fs(void)
-- 
2.48.0


