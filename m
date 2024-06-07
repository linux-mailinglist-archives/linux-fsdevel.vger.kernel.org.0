Return-Path: <linux-fsdevel+bounces-21152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380288FF9D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE69A284AE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF853399A;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="INyg8CAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86712B77
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725604; cv=none; b=f3wk/lWGJ1SsuXsvEfTdikUFlhmznHmBvtxMdXRbMS7kILeDjWfjGyL2r+S4aHT7hHo4MOWNXDbJSviRsJVdJOyWW60w/dYt2Xm+4IM40K37PAs226JUVEnTN3gSxo0jHtDf6JiBWeHcXpPq1RKKmhlTwBPQKmud3+KKuCkZLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725604; c=relaxed/simple;
	bh=U0O64jh9NF1/2yxYBjKjCftRqJHA29grUIpqiErjuDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqRXb+2IypmaWjbVKFmaWleeM2WaGD5ylhDT9/MFvnu8vK24BC5J16RtvCnpOFRiKiK2KiZiWN+Br3lV/Eusj4woq58wJmsGqIRjFdK2fIlpAwKBTrNgpE6pvo+F2stlltOuJZSoK4OY0TeH7nhX03QQCCBixDCvdbXZgnhJFZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=INyg8CAb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fKnGGyAs0Oseev8NEKpHBDRoTYI8fi6kVSQOKANagtw=; b=INyg8CAbSycs2xloAqG5Rp8h5p
	2f5PwzTJlSeVk4RZANTnV6im4+BswLcuGe+RA2rkj9VZIlbeNOtIPzlEaP7Q0D2i3ntqLr6BEpdfW
	2flk7DIaSV0UvLP7ZV4mcKe3O9kIChzNDq4HMnmqn483CyxGxwC95gWVWoq4fIkbdx2WTqRLSXTPi
	wlnA68Cg3Qmb7hGZRbHNlCwQSaHt6WQX3QVL8HE2QqnXqpQL+9SB4Trr7jWSV3wcncU8G1Dap+Pbw
	YSGCUTRmtIs7AMvO3vSY0j8dccP2jRjTaklWbjDL3BNln8nJAAGgNW4s3qsFlwueDPLdxMoBsAubo
	R08/B7Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtb-009xBw-0R;
	Fri, 07 Jun 2024 01:59:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 09/19] css_set_fork(): switch to CLASS(fd_raw, ...)
Date: Fri,  7 Jun 2024 02:59:47 +0100
Message-Id: <20240607015957.2372428-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/cgroup/cgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d53673ccaefc..b3a5ae2807b4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6394,7 +6394,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct cgroup *dst_cgrp = NULL;
 	struct css_set *cset;
 	struct super_block *sb;
-	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
 		cgroup_lock();
@@ -6411,14 +6410,14 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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
@@ -6466,15 +6465,12 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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


