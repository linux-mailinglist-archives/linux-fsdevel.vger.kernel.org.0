Return-Path: <linux-fsdevel+bounces-31077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D49919DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E1A1C214FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD3153BF6;
	Sat,  5 Oct 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dghZQ0HH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B1231C90
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155846; cv=none; b=gdqfjQkUxwFXuGGmDv4USnnzXQrMGBSFeLEdf8F9gAiXgcuBoJPuezG2wBb8QeN8kUcdIerg4PAAnzaYFIsfeiKJKu6QJ+VZVHqkrHavHcBhVVG0QFn+sCBN8lQrsq3joMHzVRd7ggw5I6cL71uUyEZ/BD2SG2uEk77opy9K9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155846; c=relaxed/simple;
	bh=KtXd08KaoieUizwd0zwbc1+3U6h+44ZsMRtxU+18vGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cn7CSYC4yFixuS9SSJlqsj4dwzoHIvkTFa7bXa+tFksd5j51qFtn1LPAhShigtY4tsBDbUGenGSsrBwKZ3FwhWjgsmQupDrflty5LNJ8Z7AVu2QNxkr+CQwYyq+r0vgHMyTA1RBZHBJcoabO1FzjiFy71QhL7lUH1qG2XMpJan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dghZQ0HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF68C4CECF;
	Sat,  5 Oct 2024 19:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728155846;
	bh=KtXd08KaoieUizwd0zwbc1+3U6h+44ZsMRtxU+18vGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dghZQ0HHQIq+UKLQLw/JVrNmAM/hTUOmUZl+13syFkL2up3EZPdIbYYgSm118ixbx
	 OVjsCNjllhjHZRARK1qe9YoHAgL78RBf2nYMJFQ9lKPx6MOGYcasOMHU3q4HmiqBUs
	 PbIDZMDy19xOfP6HvicalCUjW0tlhKj0CEA2SwRtarpLpVGGnN4HQmaoykZxrSHw3y
	 lA6ogGa+bfkIxEKhAnnc8M23TGNOPbIZG9U7fOp2IxLqRYKZMgMcNRKQCBaqzBzz2T
	 Idufia6LN0opzK2cLabeIn9TYxbwPhz0b4pglFW2gUxjGzgG2m+21GLO/SYBeuCSIX
	 hV/uRlAdhjiuA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 05 Oct 2024 21:16:44 +0200
Subject: [PATCH RFC 1/4] fs: protect backing files with rcu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-brauner-file-rcuref-v1-1-725d5e713c86@kernel.org>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
In-Reply-To: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KtXd08KaoieUizwd0zwbc1+3U6h+44ZsMRtxU+18vGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzTjgkuMgtZaHZn+01l56s1llzNF7tVKTeIok3MXcm+
 Ey25u/b1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRpe8YGRaeM7k8R3CHzrfW
 5K2vVLgs7j92fZfM8Vr699Fjm7+LZxszMqye8PZNjd22yM8GL5q2HTqikCRXdjI/e3q2N/vsNNm
 sThYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently backing files are not under any form of rcu protection.
Switching to rcuref requires rcu protection and so does the speculative
vma lookup. Switch them to the same rcu slab as regular files. There
should be no additional magic required as the lifetime of backing files
are always tied to a regular file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997c24e533f88285deb537ddf9429ed..9fc9048145ca023ef8af8769d5f1234a69f10df1 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -40,6 +40,7 @@ static struct files_stat_struct files_stat = {
 
 /* SLAB cache for file structures */
 static struct kmem_cache *filp_cachep __ro_after_init;
+static struct kmem_cache *bfilp_cachep __ro_after_init;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
@@ -68,7 +69,7 @@ static inline void file_free(struct file *f)
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
 		path_put(backing_file_user_path(f));
-		kfree(backing_file(f));
+		kmem_cache_free(bfilp_cachep, backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -267,13 +268,13 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
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
 
@@ -529,6 +530,10 @@ void __init files_init(void)
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
 				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+
+	bfilp_cachep = kmem_cache_create("bfilp", sizeof(struct backing_file),
+				NULL, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 

-- 
2.45.2


