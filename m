Return-Path: <linux-fsdevel+bounces-31192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D96D992F05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BB81F24232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D171D6DA8;
	Mon,  7 Oct 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXAQ4K3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B41D1F76
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311076; cv=none; b=IWJh4Xp4I483tvyrxjcc0oY52GyIHUsa//GOnSmZ5IdrYiuN/dXAFudl9eJdSc21ZlHsnOJuvqZmqc7koPZclkFus+wB0WCIt4/X3npeO1U7lUzHlQnyR+PjdMBy/P80GasNduw7aVJXmrfGxAOFCs4aosuJFPG+hf8Hf1vl3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311076; c=relaxed/simple;
	bh=Wv255iQMQcFXzIhKM5T7QpG8TwX1ScnW6TVpLYYyUqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE4PeXk5sjFgPtuG2E9/mzMIugLik3upJ7oAwtDjWHLjQRF6H9Dns4sP6tiVkHvE7ZoX6eiY7NtyXqNgh2RJ4xcKY+g6CPWMqeY28GyO+r8a6A6knlrfRPgsAChLN4xA99CFyZLUqN0PNPpfLV3CfozUV4gK6YW9AKK43yXHZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXAQ4K3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BCCC4CECF;
	Mon,  7 Oct 2024 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311076;
	bh=Wv255iQMQcFXzIhKM5T7QpG8TwX1ScnW6TVpLYYyUqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXAQ4K3+Nj9bEa4wEagoykGYNQI1Dv4nnuZO7sWwtSgm1jOn2KqqFUpBuF0JudN5w
	 KYKFVvl4c1VAUo1Mac0VlyeKzYYcKPZ6iOOwTDPj/yvFukOtyFza6AarGWPqCy1EE2
	 hynjQMB6u8UEiF3QymkELBDmVaot1lhYhSzpEE8khxFUl83tJb09Ot41gFBtMbJWFo
	 PSj9OlTTDk32pzMu9fs2bKqkd9l1/DAMPsQLW2lNvOxZVweQUM2nMH5jXLUM7/R089
	 xtgb+tY98eap5x5Kn30sqq4/juJg8doKHrw3C14xPj+Wn6fbYdivu/tUSjygOPAZIm
	 ngYsXeeP429oA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Oct 2024 16:23:57 +0200
Subject: [PATCH v2 1/3] fs: protect backing files with rcu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-brauner-file-rcuref-v2-1-387e24dc9163@kernel.org>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
In-Reply-To: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Wv255iQMQcFXzIhKM5T7QpG8TwX1ScnW6TVpLYYyUqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzv1eYxhu0YN7a7v3qMyPj7dU544Nn7+JZd/2r5clDS
 4LmbPn9tqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAisq8ZGZ7PcheoffBTe5bK
 0Vnz18sssftufzKYST3oRDnj26QVsu8Z/meIpkjuPLc15+fLqTypq+0EnFUe/Hyw6OjP1/uV3fK
 Z9rIAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently backing files are not under any form of rcu protection.
Switching to file_ref requires rcu protection and so does the
speculative vma lookup. Switch backing files to the same rcu slab type
as regular files. There should be no additional magic required as the
lifetime of a backing file is always tied to a regular file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997c24e533f88285deb537ddf9429ed..4b23eb7b79dd9d4ec779f4c01ba2e902988895dc 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -40,13 +40,17 @@ static struct files_stat_struct files_stat = {
 
 /* SLAB cache for file structures */
 static struct kmem_cache *filp_cachep __ro_after_init;
+static struct kmem_cache *bfilp_cachep __ro_after_init;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
 /* Container for backing file with optional user path */
 struct backing_file {
 	struct file file;
-	struct path user_path;
+	union {
+		struct path user_path;
+		freeptr_t bf_freeptr;
+	};
 };
 
 static inline struct backing_file *backing_file(struct file *f)
@@ -68,7 +72,7 @@ static inline void file_free(struct file *f)
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
 		path_put(backing_file_user_path(f));
-		kfree(backing_file(f));
+		kmem_cache_free(bfilp_cachep, backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -267,13 +271,13 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	struct backing_file *ff;
 	int error;
 
-	ff = kzalloc(sizeof(struct backing_file), GFP_KERNEL);
+	ff = kmem_cache_zalloc(bfilp_cachep, GFP_KERNEL);
 	if (unlikely(!ff))
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(&ff->file, flags, cred);
 	if (unlikely(error)) {
-		kfree(ff);
+		kmem_cache_free(bfilp_cachep, ff);
 		return ERR_PTR(error);
 	}
 
@@ -529,6 +533,11 @@ void __init files_init(void)
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
 				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+
+	args.freeptr_offset = offsetof(struct backing_file, bf_freeptr);
+	bfilp_cachep = kmem_cache_create("bfilp", sizeof(struct backing_file),
+				&args, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 

-- 
2.45.2


