Return-Path: <linux-fsdevel+bounces-24544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE053940703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D241F2182F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981C193065;
	Tue, 30 Jul 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQG71GD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70285192B87;
	Tue, 30 Jul 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316498; cv=none; b=osY7AJaUA1wC48hKTwbA5S5/qXJ/PZsVzX+BDkPjb/2nb+Sdt7Wh/j7rfGDUnaBKYrXsM+9DS1ssK/KMioSCjluJa0788ruy82/7QM3d/FA0rO3K46t1d2fxU2NbKo+5+DUs7/SqiB55ms/nHzuHFsjqyPFR0oSvFUjV9a2mj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316498; c=relaxed/simple;
	bh=EM4vCTt9vpScW5Nx9NhATMhgwRcoYbV6qMHNIe41hpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2r6kz8cjyBaPBQy4ECaXkxKEuVlcsACjsc7tAT9V//T+JLWUeDJLX8es59Eksr2KdXsEF48b0JI+A2csL8Oh+QxgRVUIZPYenFhUJxSTPChBECGgtZxa/OXD1ex+o8p98lIDuGHYlnBJyfC+xWxPeg5L4g7L8ITfASzlCKr2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQG71GD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4505FC32782;
	Tue, 30 Jul 2024 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316498;
	bh=EM4vCTt9vpScW5Nx9NhATMhgwRcoYbV6qMHNIe41hpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQG71GD1mamXBPSk0xd8mfXcI7uwnBVogi4kwrvLMzHgX9zNs790Qe1egWfPeyFV0
	 bvPnbHMW9d3bXQO8SwDHvTwDCjcYIeyvVlPnBi8PwLCGthIf40pr+eVk7RobCgrzOK
	 16nXvAYuZtTyVeHWtADcJdxbE8JdMCzDJUGSJF3mKotx8qJMOEVmmF6eqw8ttMLCTV
	 o4Oc/vFeo/e3YMrvRWL5ySAwEBG70bP8aSJyofk17wtdWZ88OzVOV/+jFkjIkTJlr2
	 svfriwT2Wll3oBntXxjavTKfyenEHlfhYrFk/hDk2Slybp3s67jvQQSd49cnIFuMKm
	 S0XNSOyBDj/4Q==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 12/39] do_mq_notify(): saner skb freeing on failures
Date: Tue, 30 Jul 2024 01:15:58 -0400
Message-Id: <20240730051625.14349-12-viro@kernel.org>
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

cleanup is convoluted enough as it is; it's easier to have early
failure outs do explicit kfree_skb(nc), rather than going to
convolutions needed to reuse the cleanup from late failures.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ipc/mqueue.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index fd05e3d4f7b6..48640a362637 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1347,8 +1347,8 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 			if (copy_from_user(nc->data,
 					notification->sigev_value.sival_ptr,
 					NOTIFY_COOKIE_LEN)) {
-				ret = -EFAULT;
-				goto free_skb;
+				kfree_skb(nc);
+				return -EFAULT;
 			}
 
 			/* TODO: add a header? */
@@ -1357,16 +1357,14 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 retry:
 			sock = netlink_getsockbyfd(notification->sigev_signo);
 			if (IS_ERR(sock)) {
-				ret = PTR_ERR(sock);
-				goto free_skb;
+				kfree_skb(nc);
+				return PTR_ERR(sock);
 			}
 
 			timeo = MAX_SCHEDULE_TIMEOUT;
 			ret = netlink_attachskb(sock, nc, &timeo, NULL);
-			if (ret == 1) {
-				sock = NULL;
+			if (ret == 1)
 				goto retry;
-			}
 			if (ret)
 				return ret;
 		}
@@ -1425,10 +1423,6 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 out:
 	if (sock)
 		netlink_detachskb(sock, nc);
-	else
-free_skb:
-		dev_kfree_skb(nc);
-
 	return ret;
 }
 
-- 
2.39.2


