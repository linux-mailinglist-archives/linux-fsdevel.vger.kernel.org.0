Return-Path: <linux-fsdevel+bounces-24570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F2E940786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCE8B21B42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537961A071C;
	Tue, 30 Jul 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpbuiIoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234A1A01CC;
	Tue, 30 Jul 2024 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316522; cv=none; b=tDhyAZBiUaSGzSjT15O/N494avdCkgFil8TNJCzfD8Lo3sZTFJSwHM5ibP+WMjXXGsiKyrpbVQATs8mzCMuo2Lh2Zu7MjU7OPvcn+xmMBJ9G0bM82trYVrOCCwt9CjPFgcGtq7qR+M1R2V2xDycIbXcQKgVQu4gLpUQbpjbJzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316522; c=relaxed/simple;
	bh=1RWeJteantwQiubozWOdpGDte2QyE8hvi2k4mk8eOfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUtcBetHBIaGLFWPpY5PeZTEQ7DEGgK1Nua4BKvr9gjC+FZhl4H7S9yrosgbARhbeRJO9JRKD8/LBte8BF4TDiumwOSDwfpa47LFLllhMr8yJKLxl93+HkftpSXkDNO27Y78jB7qMH7TdNCaN4A7L4qn+7VcRIuscscuPhl+iRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpbuiIoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0AFC32782;
	Tue, 30 Jul 2024 05:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316522;
	bh=1RWeJteantwQiubozWOdpGDte2QyE8hvi2k4mk8eOfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpbuiIoCPzLkspqm75UTrx1qkTgTMSk7+Z2eWLzL0FmQxrS5uXLLvCVYhmVh3hcNM
	 VxLXkHwZ/Ed8/gZQUYuBZMGuQFO9i0bmWvlpMV/mK6Ljg6JxZ1vBG30lvHsi4AS2TC
	 Q95BZNtyZajK7DZFeJ4twaULCT6GQL3pq0xHi+uxQX4qdIxuNYNLd27YG9tQvkID5w
	 wZedR+wqhOI1V0S8RHkrb81czoj1x9oC+GulTBDYoOagUVRfYi4qAmjd4pd/hk1kRC
	 GG2OW+MG6HQRixSZeJnOTcpFDjI88IxrlU+J79voPz1CjYX+d4cUF0IPPYx35GaNrh
	 OFGCQrKf6uANQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 38/39] css_set_fork(): switch to CLASS(fd_raw, ...)
Date: Tue, 30 Jul 2024 01:16:24 -0400
Message-Id: <20240730051625.14349-38-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

reference acquired there by fget_raw() is not stashed anywhere -
we could as well borrow instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/cgroup/cgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1244a8c8878e..0838301e4f65 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6409,7 +6409,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct cgroup *dst_cgrp = NULL;
 	struct css_set *cset;
 	struct super_block *sb;
-	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
 		cgroup_lock();
@@ -6426,14 +6425,14 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 		return 0;
 	}
 
-	f = fget_raw(kargs->cgroup);
-	if (!f) {
+	CLASS(fd_raw, f)(kargs->cgroup);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto err;
 	}
-	sb = f->f_path.dentry->d_sb;
+	sb = fd_file(f)->f_path.dentry->d_sb;
 
-	dst_cgrp = cgroup_get_from_file(f);
+	dst_cgrp = cgroup_get_from_file(fd_file(f));
 	if (IS_ERR(dst_cgrp)) {
 		ret = PTR_ERR(dst_cgrp);
 		dst_cgrp = NULL;
@@ -6481,15 +6480,12 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	}
 
 	put_css_set(cset);
-	fput(f);
 	kargs->cgrp = dst_cgrp;
 	return ret;
 
 err:
 	cgroup_threadgroup_change_end(current);
 	cgroup_unlock();
-	if (f)
-		fput(f);
 	if (dst_cgrp)
 		cgroup_put(dst_cgrp);
 	put_css_set(cset);
-- 
2.39.2


