Return-Path: <linux-fsdevel+bounces-33513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878899B9CDF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0CF282CD6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5A156F20;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cXq+9iff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBF12C54B;
	Sat,  2 Nov 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524111; cv=none; b=VC0Oy3dp1EEU+NnQ04n+FvSglgKVGuH513l1WwlzRob+36wst9c8iw6XvelGjRaBNm0dvSdmU4gAB+XlUyJdZcPYiHV9JOi4OKXM2RPBrqHQTAHqetRykD3waTTW1Vyjx+uFbttAj7AyuNa3sewafnDzQzLRRGixi9aWZiCCbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524111; c=relaxed/simple;
	bh=UqnvzOd5I7WOVm//QNX3k4MhlM20WbrTvfOuXDlE5C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7IdwUydtny/TobYKSkCJN57064PVPybWFAfhBy7cl2gHV1vR8D7PeA4af3MDwFn3BWoIJsRVpGtOAjYtbpYHGy9523r8yS4T7kQr0Y4b+aJMRfcsGp+mPGAbhN923eIJQqcYY7RG7nlGx2YXLUAbduPB5VBFtues77EOg8QFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cXq+9iff; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7lWz1glGDMtaZAgjM+sv2K64LrUeWXOaiYPOh1LexrE=; b=cXq+9iff69xH2JAUYzeykbuM24
	HLGyk5lyu/NNkih8G6f3TDdaMHThHioZjqbpAZqdCm6+R8XLby1iKEkoAGWqmBvQyAYByMbzTITS7
	qTZmtXa1jukAfJNwPxeUPqrRfR92W48gIhVix6Vc9KvnxXdF+RSwAwAbsDq/OhfAGhPP465uLHybI
	tIqeJlEUGEQfImQEc/VgtdCsKYSEakVIHnnjlxwoVx1DbMmpnhbfPZVrfWfHvTyZyNEiqFQdliH1C
	u+mnBc7XOQ5TBYyg1uldiOJm/UKaxeC5ZVSaql4sgZG36I2le5DmzABpvItpMvYJm3Rzg92GE//kG
	NiWjuhQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHmA-3F0A;
	Sat, 02 Nov 2024 05:08:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 05/28] switch netlink_getsockbyfilp() to taking descriptor
Date: Sat,  2 Nov 2024 05:08:03 +0000
Message-ID: <20241102050827.2451599-5-viro@zeniv.linux.org.uk>
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

the only call site (in do_mq_notify()) obtains the argument
from an immediately preceding fdget() and it is immediately
followed by fdput(); might as well just replace it with
a variant that would take a descriptor instead of struct file *
and have file lookups handled inside that function.

Reviewed-by: Christian Brauner <brauner@kernel.org>
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
2.39.5


