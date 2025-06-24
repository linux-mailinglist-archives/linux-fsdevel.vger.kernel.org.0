Return-Path: <linux-fsdevel+bounces-52687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBEEAE5D46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EFC188829D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C4248895;
	Tue, 24 Jun 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mDGukU2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BA42065
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748270; cv=none; b=UK+qc/O7JPfaopMUuGJ2VE7XCSd/s6txKZjWEVMOEy5WfoVMxhdBVdfQ8iNsotn4PLJzIwrOaj2ztDC4dFfsA20P1vkbSjLP/GDD8/PLYe/gzIO/oQPVSb2GhU5znWZCNMeldjKVYIl6H/GwKIfNDxHwB4xn1/0Wo4F4G7W6VTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748270; c=relaxed/simple;
	bh=WS7B+wO0qg49cplymA8qVkLe//ezHXIUCYhoeLeH0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j4niw5oFfn7iE7lob8EqNnoJnHK7QpzPlHe6rUh35eQPV/oSBZVm60voYMWsxPVf3Bc6L5lCBhk8HsvKt3Kj6/EcE+4HgFw7tQKh8yT93Zj0HRba8XqrrlU3FFbqQsfsvIdwE75HOjjbjO+EEuf49NtS2JdfNRgr7LhukkrkT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mDGukU2t; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8tzdEms/KsGdI0vGD+49Yjq/VwL0U0MDymqFfADwnM8=; b=mDGukU2tKN6bUZw2HP2y5Kk9rE
	dHFJXPEInl7RdESCkzMYeGxgHVhdFXu8WJpsvT4ZAlDSGrQd1Vl/98FrWgLkWFblPQoaoVSIXnTaP
	4qHX0ZKVXOPjr59nH8CEnhdZRequ6mAjRB0I0/xdCrv9ruKck37U1CxrZXa0MNVhjGLnV75F8+6O/
	ewzkQcQtMBocUCI/EslJ8XjcPJtJQulE8cgBQ8h0utr3JMoaA0gtyIZOU3xVjpCESs5d77Rf6A7by
	D/us0bs871swY1MRHOqSUlxu7CjuQuQMPDj73WxIapIY/kgCaDolhqUx+gfIdjdw8EIC2MBpKZkAH
	ahACj9kQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTxbG-00000008SWG-0cPx;
	Tue, 24 Jun 2025 06:57:46 +0000
Date: Tue, 24 Jun 2025 07:57:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH][RFC] userns and mnt_idmap leak in open_tree_attr(2)
Message-ID: <20250624065746.GM1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[if nobody objects, I'm going to throw that into #fixes and send to Linus
in a couple of days]

Once want_mount_setattr() has returned a positive, it does require
finish_mount_kattr() to release ->mnt_userns.  Failing do_mount_setattr()
does not change that.

As the result, we can end up leaking userns and possibly mnt_idmap as
well.

Fixes: c4a16820d901 ("fs: add open_tree_attr()")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index eed83254492f..54c59e091919 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5307,16 +5307,12 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 			kattr.kflags |= MOUNT_KATTR_RECURSE;
 
 		ret = wants_mount_setattr(uattr, usize, &kattr);
-		if (ret < 0)
-			return ret;
-
-		if (ret) {
+		if (ret > 0) {
 			ret = do_mount_setattr(&file->f_path, &kattr);
-			if (ret)
-				return ret;
-
 			finish_mount_kattr(&kattr);
 		}
+		if (ret)
+			return ret;
 	}
 
 	fd = get_unused_fd_flags(flags & O_CLOEXEC);

