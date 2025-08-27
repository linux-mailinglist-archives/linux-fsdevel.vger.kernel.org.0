Return-Path: <linux-fsdevel+bounces-59334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA979B3775C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 03:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DFB2A862F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA1E51EC;
	Wed, 27 Aug 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qZbAadV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B730CDB5;
	Wed, 27 Aug 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259191; cv=none; b=JYgEiba1k3EhLXXGYf6LiDlWDc+U6ShFSsiFiGSf6FyuIwi1YlfWaBiR/oCjhtTBfWprEOnwKQozbQZkwiH4ai29EC2dxQcLSRNFhy9yJMKC0PzVf1e0XeItDzvNnL3B9fmOw98iOWYdnkNlQfmlR2oTS6bPS86D6dYkIKiSAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259191; c=relaxed/simple;
	bh=xfCiDSQkn5ReCbwQtvM5qpPPvCdd/ql37hTgXQ5PgiA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M5LQpFLwfQIMyuUimbpl45xNma+7tVXSgdtwD0P6nWJGb0ojKK85PZk5+yQ0Q5Hqmb/oRiFqsh5Hzvfo5NxUpYFzLCyrn2QaYF65EGYVXpj0k7ZEY/Fs5/1xchUiia+TOeYH1NcXME8R5/sIeXuGaANi4sbKyCDjoNo8uk9yunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qZbAadV3; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756259158; bh=D6pHWg2ab5DPdVesfZp2MiqJOFW5W3h939+1veckb5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qZbAadV367hJw9sHJF/jKmRy1mqDQheh+9FzTqDUYbKnll+E/3suwqTlcJFvcPpre
	 Rx/7Sz6oXulZHv7dQYDBIFy9zPz1p72aiunbD8Jg4aZRJibgwhrwNOE55aOIQ7stM5
	 4IoJSGFuEx6zEDp8MOo9W1zWwUn42OEBYdts7HDI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id B773F6E1; Wed, 27 Aug 2025 09:45:55 +0800
X-QQ-mid: xmsmtpt1756259155tkgey9lvc
Message-ID: <tencent_35D325E7BA1BBB7B33559EE41B034B1A1B08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5ViZ8acEhdmjnBMCJOxEoOpAI/e2JaxFK5tQ9cUnG1F9Jvi9slK
	 0NEMAuo2vbnVpYm+nuTcYqcU5LazFSJ1jjZPfwONXqv2SAwRfH/LwLjCKWPXLUeRsEogpNl3yYNS
	 o63pqDs89cWgGJ5b9dOOlovWsrOoupxZNGVg2Ke1NPOx7ourbOHDYy5VwEgtEdEULTpj9lZT9c79
	 JHqS/wdvmwHuS9n870+q9tzajbN/+JX9wW8bC+PBSpy9u5zk9bmMdKy57LZi19kmicdluDruvZFh
	 unvtadYfP7iWzSLi4cRlP+JS6s5zzAuCMnVyEXdUxMfZiLVHvoIZVC3fBUWHtSlGf3+9k/UZTE9K
	 BcFNKKpZJSNqSB4lHBVkviCRLWxSc24B1P8fi5MiNN6ODjRjDbkvAAIvWC7OtR9TtAdQQ65qjQZJ
	 Bz0jdBq0SIlLLxusJaP+u3QqrlhFTaXx6c2iCzT+DW3PNFVyZqaIcDBbTkRnaV0TUbGv9JmNTtRk
	 2mzpLFOJX+Gf0wjykxGepX4h/nibteO+PYm2z51tpREwr+Cpv1KkJ7E9NhvR1tqdGgfCqm6g0xRN
	 iZKEt8lB1+a9umLcbtSxB2Lt/NfwGm1mn7Gqa9PI/QSNMKmvTsMpl61vsYYy4ua0CdNE5uVa2J1T
	 9CmF3q/XhtX/p1BF/DZIhmEO3H/B41FUpl/XIA7dorQob+Wjq9UZRG3YbkRpo2hAFWJa3unGRdzB
	 0nfrOXd1yYanOwesm3/ZR5TA55qsh+yM6UFMLOY42sNmHbVossJflV83kw8z7Z2uYEsALL18Xpb4
	 KxJTTJiFTzfLA6lEV0FwyGCwfCM7c4e8AuX2cST/FHlvt9dc80nHcHjyahkvVtNPTRvMK8aYuciT
	 qUyTQzWw/PVGksRLWljFbozOPq8YBrDuDiphN1lFG01DO+BvCrerqFu1ldrjecAF+bA+LEkM033z
	 fGf8KNScAOpNV13X7vpTAFVmQIwfloDoBe1QF0Gf9Z5KzekxMi4Vkno/1jtNJw/FBdbfW7B/zwhl
	 wABrxDxA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: joannelkoong@gmail.com
Cc: eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] fuse: Block access to folio overlimit
Date: Wed, 27 Aug 2025 09:45:55 +0800
X-OQ-MSGID: <20250827014554.316703-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAJnrk1acbc80OLZe9Pf7a-8HPRmkJhz=bZVRPOnJQWB78neVVg@mail.gmail.com>
References: <CAJnrk1acbc80OLZe9Pf7a-8HPRmkJhz=bZVRPOnJQWB78neVVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz reported a slab-out-of-bounds Write in fuse_dev_do_write.

When the number of bytes to be retrieved is truncated to the upper limit
by fc->max_pages and there is an offset, the oob is triggered.

Add a loop termination condition to prevent overruns.

Fixes: 3568a9569326 ("fuse: support large folios for retrieves")
Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
Tested-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
V1 -> V2: update root cause

 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..5150aa25e64b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num) {
+	while (num && ap->num_folios < num_pages) {
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;
-- 
2.43.0


