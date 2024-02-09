Return-Path: <linux-fsdevel+bounces-10953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97984F577
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714C828733E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71E374DD;
	Fri,  9 Feb 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="On3jiWPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF20374DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483486; cv=none; b=lU8jLoh/NxQEJLwDrd1T7ax95m0MGgy1tnbAMRtRT+FCpURPhuUAjdGD488JCRhV92877Vn9nyoOlsjOq4enCmzPWSrgzeOO0aQ/JO9ZDbZWLJ9OZX/0g7NMBkBxdqJb4s9WCrDn7upk5T11TS50FlidCmOrKkkn1vTcU6g0MjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483486; c=relaxed/simple;
	bh=zgL4PZ1+Kzv9qhprgOf8WbzPMIyS0sRjP61DqMeF32E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYdQw6OSB06fkk5pRkAGaJ2ij4mkIlMvaxJ5uflEanZkp416g/8FIXjHui9kKtClB6poaeSundHrXtlnFQHRcPSgUle5FEy2PTP2r39BFOXiPD8Csx+cgoS+2+w4MB7u96Htwd7mA+9ZM3JqujSBKz9BShHJ/3yYXEh76pOa7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=On3jiWPM; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:53a9:0:640:8a1f:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id 218186090E;
	Fri,  9 Feb 2024 15:57:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pviJflBUpCg0-SHmVizU8;
	Fri, 09 Feb 2024 15:57:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707483473; bh=j7i24/YR35paK3Dvy9qaqErGYsf0br25TuhZ+LRQkpg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=On3jiWPMiu/SAbJjzvcUUbsv9OIfVjn0c2Wb9WcVxfwMlIwXVTDGzjlW8ECN32Mwo
	 023ko5QalErFJXW2+ZfvCCkMy658Up48cUN/Odx9k/uKGgVmNfLRRwyLQ+OVmjtxou
	 aBsqPuEjJzmoaWgZfCoT7Yoh9KV61kez9auVvQp8=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>
Cc: linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Date: Fri,  9 Feb 2024 15:52:19 +0300
Message-ID: <20240209125220.330383-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
as well. Comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/fcntl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..c3e342eb74af 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -846,12 +846,6 @@ int send_sigurg(struct fown_struct *fown)
 static DEFINE_SPINLOCK(fasync_lock);
 static struct kmem_cache *fasync_cache __ro_after_init;
 
-static void fasync_free_rcu(struct rcu_head *head)
-{
-	kmem_cache_free(fasync_cache,
-			container_of(head, struct fasync_struct, fa_rcu));
-}
-
 /*
  * Remove a fasync entry. If successfully removed, return
  * positive and clear the FASYNC flag. If no entry exists,
@@ -877,7 +871,7 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
 		write_unlock_irq(&fa->fa_lock);
 
 		*fp = fa->fa_next;
-		call_rcu(&fa->fa_rcu, fasync_free_rcu);
+		kfree_rcu(fa, fa_rcu);
 		filp->f_flags &= ~FASYNC;
 		result = 1;
 		break;
-- 
2.43.0


