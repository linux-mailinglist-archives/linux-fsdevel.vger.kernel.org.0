Return-Path: <linux-fsdevel+bounces-33533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03979B9D28
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A436F28427B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1C1AB6FF;
	Sat,  2 Nov 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LKniih2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C315852E;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524116; cv=none; b=bQliGXqBnWT6E+OLUx+jS/ipubcohMUCtvxo65zfGrgFGnTPKoXCrWnVC4sZ6SjPYGbl2gEAqXTNo9zI/3Oo5dLTzaF2n1EOaRwaHT4zadrJfPp2gT8g8WnbxsSQajjVXvVQsiKg02RfJgGBL8kZ+ni32HR1UHjqWQzsSvpsXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524116; c=relaxed/simple;
	bh=gbkcLZ2oi9ZTyoWuRq/Wa/jw5/HxFtKeEWqYhZZiKXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZnGJISP2N1jV1L/LuKcvV7PvqEJTTOe6HnlcMHp3vJcMq+h3DPTLzSMUQDhB2flbwAZL5Be7ZgKc3Rt3pTDR9ufFvlw4apzsjM8+QDaGNYiKCO8uoQww+gMOXtElF3objqHGif0riBFKbGte9rypYjvpyZbFtudIeUjo9ZXCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LKniih2X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6hy/KqwBlFpcuKN8QvzGZavlerwPpGSpN7JrWMUa+QA=; b=LKniih2XOmlR2zkZ5FYnf38UVW
	JPG5uBofVuxVZvqdAi8nPWCvrFDzIues0n2b/4rCb2bjja15GKag5XBh4nw6xFeihxnZ59tml+BN6
	a47v+Cf/n/MXBJSHV/eJvdmHWyB/4QORULnDdxf/ElQYuEzovuVjAfh4W4Izr4hqMNd7kr8AYWRLs
	3dzQF3YxqeWqTwi0wm3eDQhqjyiXxv1l5F3AV6e1FtQn+1LrYzx6x/FnHzDPON/LNInEjW2lJxaoP
	a0Ns30Ktn0Eqf/UokaKDIDmwFeFPoAaB4kkuPxSWJaRfeaHRMly8bbyK98gF/jhBmLANYny6cTgLh
	q4GvcM5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76ND-0000000AHoZ-0Rqz;
	Sat, 02 Nov 2024 05:08:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 27/28] css_set_fork(): switch to CLASS(fd_raw, ...)
Date: Sat,  2 Nov 2024 05:08:25 +0000
Message-ID: <20241102050827.2451599-27-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

reference acquired there by fget_raw() is not stashed anywhere -
we could as well borrow instead.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/cgroup/cgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8305a67ea8d9..02acc2540c46 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6476,7 +6476,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct cgroup *dst_cgrp = NULL;
 	struct css_set *cset;
 	struct super_block *sb;
-	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
 		cgroup_lock();
@@ -6493,14 +6492,14 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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
@@ -6548,15 +6547,12 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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
2.39.5


