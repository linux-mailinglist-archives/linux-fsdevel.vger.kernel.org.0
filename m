Return-Path: <linux-fsdevel+bounces-33539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37339B9D45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778922857C6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960031B0F2E;
	Sat,  2 Nov 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a4xaumWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2A1AC8AE;
	Sat,  2 Nov 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524129; cv=none; b=Sjn1mflHgxrifsPZ06j0PVB/2ekH5pwyIqJCHp+abE/QzAosF7JhjhVkghgArVCKlGOEPOwaOOckIHdakYfzj9CeV7z9BC0qxWxCyaXvqI4lqn2TwPZ9Yg6LrO04+n6Q6Ao87glHUqS4HX8YTC+DvrwyebgBhCjQn/IljctHwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524129; c=relaxed/simple;
	bh=sIsbHOCdc77aqOwzZ9NdzfWbaJOX5esYl6OGr+8g17w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs65So6NS46gMA01gAFBbNAmaIiEJ3BbahXTfGEA7FG4G+po29VYXZKA3bGZRPHuF7ld5cyrMgiXYMKivoXpYV3PVhTYQjMpNAz5LY6nOPsXJhF25r+MJLgwNOLiOjnGiQDgvCFE7ORIf40znZSytPxii1/n9jVtPqXmckyMjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a4xaumWi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EYGEzTbzCwoX59fmg/fy+A0M2cH27/fC1+I1UrCmDZc=; b=a4xaumWihzxkWK0sSVMGC09NKL
	/EsiX3Dv1qIhCPhGLJUqveSVG6gtBNZ1U93ayc7VzB9EgmgXdfbFST0I3zU+9qpSPpj/EUeuXlqIx
	Fnyp/bs4rZTmQ47+xzgW7rRAjr5j8FEseJlNADJiY/fv/BDNRH88f6gSL6KPdvBBzDlVBBsLyjzkk
	fP/fibZTx0A/vhFAcheY5lQxujutQNbon/Mm236ocUpZruF+bKXt0TmhNhrHVYo7eVv/SeGQ8KH+4
	g+uQWinRficKJPYDWd7Q4JFj+CvmXIztzmdlGYHSgtOgVi4dL5DA4p08buP+34xGVLU0PPh/KaS/U
	hXCzdZ5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76N9-0000000AHmC-3giW;
	Sat, 02 Nov 2024 05:08:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 06/28] do_mq_notify(): saner skb freeing on failures
Date: Sat,  2 Nov 2024 05:08:04 +0000
Message-ID: <20241102050827.2451599-6-viro@zeniv.linux.org.uk>
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

cleanup is convoluted enough as it is; it's easier to have early
failure outs do explicit kfree_skb(nc), rather than going to
contortions needed to reuse the cleanup from late failures.

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
2.39.5


