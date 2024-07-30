Return-Path: <linux-fsdevel+bounces-24543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C349406FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E931F22C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD16192B71;
	Tue, 30 Jul 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwFM7FXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6E1922E1;
	Tue, 30 Jul 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316497; cv=none; b=ao1vm7mHlyscJhHP6/6FBztPZs+wNrPW/08ARgLTUHdbKf601xRi2NtTpysjwCBD4PONmMfDejkYcp8eIqFiRbeokISsRr9IgqQyNf0GPqiJ8sw2ETTMfxyDDmVL8hVXBJ1/57/pSzWqOCWzG5in6/czYHh1Rabbte4am3k9DBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316497; c=relaxed/simple;
	bh=nsP5fCdu1d1453OnOXOtXraSy508jAD7L0TWBTzmIE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKmq6eePzTX0h4PAp+FdWGbwG44dwnn0KbQ9mZVWb1b4CwZDnyJXwK2UpVGIexvfREf0WxP1HFvEFurymQ2LUCxhh3Zxv26AAflxuVivznN59oXGEJO0sqo+yOXAuF6k7eZdCSeKQYbBM0MjRK2cpRgzqaq5cvqAqpGu4g5jf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwFM7FXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DE6C4AF0A;
	Tue, 30 Jul 2024 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316497;
	bh=nsP5fCdu1d1453OnOXOtXraSy508jAD7L0TWBTzmIE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwFM7FXVXYxCg1IOYXk/3YQoOIRFVN1nWDfxuETBiBcZNdH3Rg0QWRjJ5m+nqQwx/
	 oKB2yMiO9VoSaPeLOqVkHci7lzZ2MGAFMZXFCFtlba5P9N54JtbqGl1ZnBr0+yblEH
	 UvudrbKr3AlAIDoRbVDRH4x4KjPeyaPj9Azk382RPRBZ8SnPqc9M/GdTfk3YJL7djK
	 6bZQ5lccv5SLW1RDPULhsph7Al/WBljhyj0Qhjm0vWszdtWCEsjK0sixiGZ5OAGNYX
	 T2LLSlmw1igRkzCoEoTmazU4PuqaFsekJVJpMRIn+IABYows8LGb28RaFICFKX9kY2
	 mQVkcehFPn7Ag==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 11/39] switch netlink_getsockbyfilp() to taking descriptor
Date: Tue, 30 Jul 2024 01:15:57 -0400
Message-Id: <20240730051625.14349-11-viro@kernel.org>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/netlink.h  | 2 +-
 ipc/mqueue.c             | 8 +-------
 net/netlink/af_netlink.c | 9 +++++++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index b332c2048c75..a48a30842d84 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -239,7 +239,7 @@ int netlink_register_notifier(struct notifier_block *nb);
 int netlink_unregister_notifier(struct notifier_block *nb);
 
 /* finegrained unicast helpers: */
-struct sock *netlink_getsockbyfilp(struct file *filp);
+struct sock *netlink_getsockbyfd(int fd);
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk);
 void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 34fa0bd8bb11..fd05e3d4f7b6 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1355,13 +1355,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 			skb_put(nc, NOTIFY_COOKIE_LEN);
 			/* and attach it to the socket */
 retry:
-			f = fdget(notification->sigev_signo);
-			if (!fd_file(f)) {
-				ret = -EBADF;
-				goto out;
-			}
-			sock = netlink_getsockbyfilp(fd_file(f));
-			fdput(f);
+			sock = netlink_getsockbyfd(notification->sigev_signo);
 			if (IS_ERR(sock)) {
 				ret = PTR_ERR(sock);
 				goto free_skb;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0b7a89db3ab7..42451ac355d0 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1180,11 +1180,16 @@ static struct sock *netlink_getsockbyportid(struct sock *ssk, u32 portid)
 	return sock;
 }
 
-struct sock *netlink_getsockbyfilp(struct file *filp)
+struct sock *netlink_getsockbyfd(int fd)
 {
-	struct inode *inode = file_inode(filp);
+	CLASS(fd, f)(fd);
+	struct inode *inode;
 	struct sock *sock;
 
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+
+	inode = file_inode(fd_file(f));
 	if (!S_ISSOCK(inode->i_mode))
 		return ERR_PTR(-ENOTSOCK);
 
-- 
2.39.2


