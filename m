Return-Path: <linux-fsdevel+bounces-66704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8581C299B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996E84E92E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D8239E60;
	Sun,  2 Nov 2025 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0bkXgNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45B24A079;
	Sun,  2 Nov 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125188; cv=none; b=thdRnEwbXYvn7L71oYr2YobwX61ATBktEuZJfl63Hx1kQUbmserFBuJvbtPZhADolJKSzAmqdy2nuXfGR6vZpUONa4rDnLK+RO99X+jeS9/Ls55YXZxv02RFS1gIEyV+6Vvg1ohdcmAJGukrKM/oNoyHHdUHqhyFEjVGqx0KE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125188; c=relaxed/simple;
	bh=j9FwyOzlyRQK7/TmHkKGcHga/tQ4GGfYIgop1w8fQlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4igmcBPploD5CpHwhQFjJs6sHehoqnnA8HAw0obK/6Efv5S84OYB/tUeGM0Geg+M6vVNzNVdRVtUAsnx+NFYWYa3/yf3P1jnLLpELvry9LPx7SRSzqIiMMUNI6DNzkvYZlaFR64THMMIkfltbudAzJBJSXU6wlDGpyofKcoaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0bkXgNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1715AC4CEFD;
	Sun,  2 Nov 2025 23:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125185;
	bh=j9FwyOzlyRQK7/TmHkKGcHga/tQ4GGfYIgop1w8fQlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H0bkXgNOnUYPmw/iZl8jGISQ6KTId6tTDImMtzBl1HF0R3z4s6VotXE4ky7oZjoaA
	 RezHz0foOjg4QgDqJG+scpMhdVg6SMZGvasE8hfvHgDyAT97T5tZ7tX0cTh7qJmMP2
	 t8YW1HpjoszzZUSFS8K/VewGoYD7T2K7KBYeZLAgCfoaUHF4CGec9YDFlGgRFKzGam
	 3XrCpkvTgawmrYv3PNuDetzShjMBf4fpqnpFlP7zorbmCFTIGbqcK4vRhXrqLlCIz8
	 VddLeUL3+qWveNQboanO/ri2UNBUyVfx8Iv2KcrhTVObq6gaikX8CKHhTvHyLeOqgg
	 ChRJhIhCsHBcw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:45 +0100
Subject: [PATCH 6/8] nbd: don't copy kernel creds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-6-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j9FwyOzlyRQK7/TmHkKGcHga/tQ4GGfYIgop1w8fQlo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy19eoZZ/8nZL5sX+u2qPXn3hJQuR+LSzX+2K8/Vb
 LQSk74U2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR20KMDKfs7J/8rk168Hva
 s003Nnqt95Daz7Krd8mb1BunMt5elH3K8Ffu95sOc7tnMaWbuzffdN8yucZo1tpzYk38wSuntS2
 K8uEEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-4-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/nbd.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a853c65ac65d..1f0d89e21ec8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,7 +52,6 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
-static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -555,7 +554,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
-	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -564,10 +562,10 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
-	old_cred = override_creds(nbd_cred);
-
 	msg.msg_iter = *iter;
 
+	with_kernel_creds();
+
 	noreclaim_flag = memalloc_noreclaim_save();
 	do {
 		sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
@@ -590,8 +588,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-	revert_creds(old_cred);
-
 	return result;
 }
 
@@ -2683,15 +2679,7 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
-	nbd_cred = prepare_kernel_cred(&init_task);
-	if (!nbd_cred) {
-		destroy_workqueue(nbd_del_wq);
-		unregister_blkdev(NBD_MAJOR, "nbd");
-		return -ENOMEM;
-	}
-
 	if (genl_register_family(&nbd_genl_family)) {
-		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2746,7 +2734,6 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
 
-	put_cred(nbd_cred);
 	idr_destroy(&nbd_index_idr);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }

-- 
2.47.3


