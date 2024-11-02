Return-Path: <linux-fsdevel+bounces-33512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349969B9CD9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90011282BF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2631537CE;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cvUJCh5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0914831C;
	Sat,  2 Nov 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524111; cv=none; b=dYHdtE7j5yh0zLjwrjTnYtfm/5ljs4R4ms7paF08nlY6h/JBKsvZUqJ9FYyA72wcVvDgy+Zys1bRFYxiF4R4dO+OPU5D39h4t1t+9zXqcTb2HQYV95KPwgGP/O04O1vFyupScq74j39m3HPCCJPBeFMj4qaTlxjdXUK6D40nMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524111; c=relaxed/simple;
	bh=ekmyQzoU1BKlanMG0cN3EVm6pNJn+h0ka3WKg7Nql7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvmP9m7fvIAuFCTyc8zdFYoDcpUcz93mN6uYOJ0OUCs3LmCkFTW5df3ch7pSbu/a5vnFVSBEfSZG/z/ExO7quAB0aP7i13E+Jl/TS1xa8TWIh8x+wzRXBTnwNDQ20Tj9g6sPFxFKDWM9GjJxxjzzHTzfzPV9CjR6Tpx+p5+eag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cvUJCh5q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DGLJxTIbvWrNXmEE+I4ltRrz0P0fdEjG8R5Y9QwgEm4=; b=cvUJCh5qlrX4+/9xLM6xlBaY/M
	Kza777JqXV4SUht1Z0aW3Jh4l2Rbg9kad+v957IrsVlI7+eCHTteNleyOM2AtexrIA6Ijhb62qsk0
	O361JX3ATByDxMQLTGkI311mDgKtcj/BZqa6eOgvSolfLXAY0YcR83DvozpDRQOjgVAY+v5dlCmy6
	t0EsGjDTQygQxxzxLe5IEICF+sKHNisjPVW+6eEbzGD4gJ1KnVJV07rTbrn2onQKG9JwUSX7fgHm+
	bzLv4XaZRP590EBLiXTLiS0gX8pWbT1+hVWtguLsJzaXMR/n10LBH/JmnkmNUKgORq4V4DiGfPCJM
	RLngXe4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHmE-426L;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 07/28] do_mq_notify(): switch to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:05 +0000
Message-ID: <20241102050827.2451599-7-viro@zeniv.linux.org.uk>
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

The only failure exit before fdget() is a return, the only thing done
after fdput() is transposable with it.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ipc/mqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 48640a362637..4f1dec518fae 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1317,7 +1317,6 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 {
 	int ret;
-	struct fd f;
 	struct sock *sock;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
@@ -1370,8 +1369,8 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		}
 	}
 
-	f = fdget(mqdes);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -1379,7 +1378,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	inode = file_inode(fd_file(f));
 	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
-		goto out_fput;
+		goto out;
 	}
 	info = MQUEUE_I(inode);
 
@@ -1418,8 +1417,6 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	spin_unlock(&info->lock);
-out_fput:
-	fdput(f);
 out:
 	if (sock)
 		netlink_detachskb(sock, nc);
-- 
2.39.5


