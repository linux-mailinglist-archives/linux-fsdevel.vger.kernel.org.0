Return-Path: <linux-fsdevel+bounces-21151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DB8FF9D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04682284B4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76929CE1;
	Fri,  7 Jun 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vMN5eIhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A44A39
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725604; cv=none; b=EO/Etegu0fI+1CbcVLguaxRkK4vHdZs0ZErnCEZahiesYeG3xsMuBX/vP9Bu/Ke7gjTkmCMsMZCf3X9HY4LU1RcgHIw5xP8T3H/c1qrECZElH7tF3MeWvHsWTpTYnJ2Ichy8satBCdvD3Dwvq/uj0J2ZrVab80DUWY8274ErNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725604; c=relaxed/simple;
	bh=gz+a6GZyT64kQv3ZsHJLsAUNPyP8y8MfwvZAjtV9A4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDccKuVdyvhSVy+ZPDGUQ0YI5ZPktVqXr42Lh6gJiAPtbtnFm6Fwc56rRdrvPHHjP+m/QTpIg4iESDcHhR1RD+1BN/KSIQmCsxREAZZ5iTW6tkavBt2AaWo7sRmKYmmhf5E8PyrYiWcglHT8KTZBZI0uk4QEC2UExx2gXN8K9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vMN5eIhP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=upudUIfOhHvlU9n7S9zs9CWE7XB8TwwtGBna33IDgbM=; b=vMN5eIhP29ZiS14m/Kbr7qShk3
	p64WdCyww4rphvHkaMNu/VK3Cbfi217ACzQgYH4JFKKPpa9RBfBc1PZdOUsZS61m/w8FgU0k1aspW
	dpyscr0CUhcY/bHVKpkpALHEui48zS6T+VdvPMu3rNraeX4ER356TRsAujL4DD3aJGTNGz8I9sJut
	r9ikOXDVRdm3gAbbwTXYsgVwEbyjnALoXgo1lKiKk2WzxlpYUmGy5St4lfV8eugCUAlMHnUeEl2jz
	3KaQOslGZ0zYN5Hd5xfbPuwHhAGU36dv7dzlxjwzoInc3YmE9+3wdldYOZKArm8Rq3SNHH/zrFEX7
	vpAGoQRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtc-009xCi-1O;
	Fri, 07 Jun 2024 02:00:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 16/19] do_mq_notify(): switch to CLASS(fd, ...)
Date: Fri,  7 Jun 2024 02:59:54 +0100
Message-Id: <20240607015957.2372428-16-viro@zeniv.linux.org.uk>
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

a minor twist is the reuse of struct fd instance in there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ipc/mqueue.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c72ef725e845..d798a43fe981 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1290,7 +1290,6 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 {
 	int ret;
-	struct fd f;
 	struct sock *sock;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
@@ -1328,13 +1327,14 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 			skb_put(nc, NOTIFY_COOKIE_LEN);
 			/* and attach it to the socket */
 retry:
-			f = fdget(notification->sigev_signo);
-			if (!fd_file(f)) {
-				ret = -EBADF;
-				goto out;
+			{
+				CLASS(fd, f)(notification->sigev_signo);
+				if (fd_empty(f)) {
+					ret = -EBADF;
+					goto out;
+				}
+				sock = netlink_getsockbyfilp(fd_file(f));
 			}
-			sock = netlink_getsockbyfilp(fd_file(f));
-			fdput(f);
 			if (IS_ERR(sock)) {
 				ret = PTR_ERR(sock);
 				goto free_skb;
@@ -1351,8 +1351,8 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		}
 	}
 
-	f = fdget(mqdes);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -1360,7 +1360,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	inode = file_inode(fd_file(f));
 	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
-		goto out_fput;
+		goto out;
 	}
 	info = MQUEUE_I(inode);
 
@@ -1399,8 +1399,6 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	spin_unlock(&info->lock);
-out_fput:
-	fdput(f);
 out:
 	if (sock)
 		netlink_detachskb(sock, nc);
-- 
2.39.2


