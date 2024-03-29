Return-Path: <linux-fsdevel+bounces-15625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156708910A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C092428C35A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2536364C4;
	Fri, 29 Mar 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohkuFqn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C222C19F
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677250; cv=none; b=kITzbPrkkf36YL9aABiarRQiAaeFN7usL4KWFYTv/rya1BAkZS314PbBtMaNq1jyK+t6dExRhya87SiV6mUkfIc0Ormu4jntGCpwPB9sy3lTjmlUNXiRzXS0HotV6Ii5GqFN+GAPntzys2oCaKeN8awjVphNSdA/8kjjcz0OWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677250; c=relaxed/simple;
	bh=WHF1cQ6wftLpEUkLh/arn81XtKeZBIuOooiwZcqzz24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r7Sh4JA8og2GuIBJNci0xQyhntmMxl33LhLqbdVWrosOYqn2j9aA326ol+ywpLsVUyvgvCFbZqVa4xmkTyAEPccBjNW9U3UW/IIDKq/8uKi5ZBEq7+nlfYGJxEOXIE6+b7EBj6t9DRJasVz2igZ0eFKhaFus+7zNL/9TfFhBIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohkuFqn0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2789117276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677246; x=1712282046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TWHZ6CjfZzMP0P6lR3s6R//pEvlviDj7MeL1JlKB90=;
        b=ohkuFqn0UVk+BjOZ6e/RSq+48ILEeFYpINfxRwudlqaBWyFbnkpPawUTBv2CuqMfD1
         nKkruG6I9j8NGgSA9NVtg7HFFnTUqmFC29sod1XHXTCBRYdW3S2Ir/T+QbLZT3239gae
         E3pKZvFzV7WBF8aL/cfmUln6QiwAysATkK9SOwcL7Y/LT4r3vpzE+dtbvj3ImOHvxzcO
         p5GdAoDK2j2Pj/oOVRZ4bHmUl77HwudnBv7cMP6VYmH3vegQkSeCFVq3Buqg+0w5BDAN
         bBklfy6rYVEQEw1nKMN8V3/ButYEI+bfHgut2Ye4IsUsZ1OlhTZKMBSPur38HYhTtAv9
         vutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677246; x=1712282046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TWHZ6CjfZzMP0P6lR3s6R//pEvlviDj7MeL1JlKB90=;
        b=RfyYLjAUf5EKHDpL9UmpThMTyKOFP6A3NgmaFq+4hgaMeEMV8KsGec5rdpQu604gSC
         l0SAoQYb9sUT3Zb/gOZsHtNaMjzJM1adJ6Fq+bXLkQm3HM5JnqNW4uXcOO/yO/BSTSnT
         CDBFwZMrKDfk8QNW59Tbh6udvIdK5fEHpeYJVX1vNaFa9XpsUJ79XuABy1w04RbSwNmL
         pZPCEF8uHs7P3SPtXaA5Zl2ym8ZlrF+lFbrX+F2UhaB4p/tHQ17sbAFHTtkNpIbT6e0s
         38iacn9nqcM3zHE+z4JjZ+FWjj+4/t+Dtg17DSMexMM7emfnj+H3tI7i20Jsr2kl+d1p
         VQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCWP79Lp1qU0rpVT67RnWlCIzsKRmODA2ZGlXjPpVMI3hQ0QLBTL47yQMEtMfMNYwfkh3x2gOTCyajd/RuOEdxgL/g4uCM+th0SbQ5li0A==
X-Gm-Message-State: AOJu0Yw/ZchS27YS7X1W6ISej/BqxYKDVNpDFUPWsTT8l/ONbKWOfKb+
	QoSjqTBC34p1Rch+nV67Zvc8nph5X8pXq4TJzZb3cfeYXZLoJKKoP+Pq2fjKVYhHTLmEjfrc5Q+
	DZg==
X-Google-Smtp-Source: AGHT+IEi4wBl0taMuZM199uicOLSQKEshdiXi8Hiat+CV3OzSJuBGo9P6id8BJm2lQgMqafkSWILsniPSE4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:72c:b0:dc2:3441:897f with SMTP id
 l12-20020a056902072c00b00dc23441897fmr300435ybt.6.1711677246590; Thu, 28 Mar
 2024 18:54:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:18 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-4-drosen@google.com>
Subject: [RFC PATCH v4 03/36] fuse-bpf: Prepare for fuse-bpf patch
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This moves some functions and structs around to make the following patch
easier to read.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/dir.c    |  4 ----
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  | 52 ++++++++++++++++++++++++------------------------
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..cd8d6b2f6d78 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -46,10 +46,6 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 }
 
 #else
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
-};
 
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bcbe34488862..797bcfd6fa06 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -76,6 +76,14 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+/** FUSE specific dentry data */
+#if BITS_PER_LONG < 64
+union fuse_dentry {
+	u64 time;
+	struct rcu_head rcu;
+};
+#endif
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 516ea2979a90..8eff618ac47b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -197,6 +197,32 @@ static ino_t fuse_squash_ino(u64 ino64)
 	return ino;
 }
 
+static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
+				      const struct fuse_inode *fi)
+{
+	struct timespec64 atime = inode_get_atime(&fi->inode);
+	struct timespec64 mtime = inode_get_mtime(&fi->inode);
+	struct timespec64 ctime = inode_get_ctime(&fi->inode);
+
+	*attr = (struct fuse_attr){
+		.ino		= fi->inode.i_ino,
+		.size		= fi->inode.i_size,
+		.blocks		= fi->inode.i_blocks,
+		.atime		= atime.tv_sec,
+		.mtime		= mtime.tv_sec,
+		.ctime		= ctime.tv_sec,
+		.atimensec	= atime.tv_nsec,
+		.mtimensec	= mtime.tv_nsec,
+		.ctimensec	= ctime.tv_nsec,
+		.mode		= fi->inode.i_mode,
+		.nlink		= fi->inode.i_nlink,
+		.uid		= fi->inode.i_uid.val,
+		.gid		= fi->inode.i_gid.val,
+		.rdev		= fi->inode.i_rdev,
+		.blksize	= 1u << fi->inode.i_blkbits,
+	};
+}
+
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   struct fuse_statx *sx,
 				   u64 attr_valid, u32 cache_mask)
@@ -1477,32 +1503,6 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
-				      const struct fuse_inode *fi)
-{
-	struct timespec64 atime = inode_get_atime(&fi->inode);
-	struct timespec64 mtime = inode_get_mtime(&fi->inode);
-	struct timespec64 ctime = inode_get_ctime(&fi->inode);
-
-	*attr = (struct fuse_attr){
-		.ino		= fi->inode.i_ino,
-		.size		= fi->inode.i_size,
-		.blocks		= fi->inode.i_blocks,
-		.atime		= atime.tv_sec,
-		.mtime		= mtime.tv_sec,
-		.ctime		= ctime.tv_sec,
-		.atimensec	= atime.tv_nsec,
-		.mtimensec	= mtime.tv_nsec,
-		.ctimensec	= ctime.tv_nsec,
-		.mode		= fi->inode.i_mode,
-		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
-		.rdev		= fi->inode.i_rdev,
-		.blksize	= 1u << fi->inode.i_blkbits,
-	};
-}
-
 static void fuse_sb_defaults(struct super_block *sb)
 {
 	sb->s_magic = FUSE_SUPER_MAGIC;
-- 
2.44.0.478.gd926399ef9-goog


