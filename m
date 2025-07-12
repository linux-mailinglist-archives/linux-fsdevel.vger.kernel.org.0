Return-Path: <linux-fsdevel+bounces-54759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D9B02C01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F1A3B2196
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED26288C02;
	Sat, 12 Jul 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IqfAvXTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8119D07A;
	Sat, 12 Jul 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339169; cv=none; b=GbgNVkPdFFx/v5NVbJMTiFyeGphv6GbDZtHnmP/AFBwN+ArhcnM1fHC2auX2M3f1p1lK1rS8SbZKsBgv/34V+UQl0d8crte6XeOoIINY3K4EV1nWv4bf/OL5c6Rf5xBi2ZjS3gjgmqOPjM80x6QDkE9GCwltFFb1DfRZE4Z9wAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339169; c=relaxed/simple;
	bh=KVHxuI7ffAY55mkbgINGTapD6ubc8SGXGyWhllQxqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dRzUju799F56wrdpje6K677zSUlVewfl+cT5As7hvchnD7YjQKMutm4gy5W8/tcTvAVpeBKeoz8rJuXV7Ygjbfe5EN+AnSUqSqZjXGT0v4e8stSa2EU0VXLKOGkGLKO9mYCqxyzhja6UcnAuZlilXXz7P64kTPpA24oO13Q2Usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IqfAvXTV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=H4d/LgvvkNNliAOaQdh90NNwmSgmMcJA3DAuQ3okDg0=; b=IqfAvXTVTyVl1yL8WMclNilzt2
	78cB8L11AcNBMuQULmKJCXmeQiwbTDIy0VvNHu0vs+24G9zDcgoCuc29hzPpH17Ko7y9y2jzrtwhq
	x8Nvjm2KVYJ2aPzo4GNjOgjdGL5WzrC7jzMidI4mGIw4EoYH8imKGQn6XQs2Il1OfPPDTBhO01b6E
	RsR9R8d0qermdGumn2oFoliaDJDmX7zfu1HXTXT2+jnOYUgZmCfJmoF73mCFon6Vx4/+LzhY2/335
	GyNzfUwLb40IR2cc3acBRxQjX5ICYAJQMU0TtkSiHUwK/cadAmC1sf7jPttW5/8+G5GDLaD/V9DuX
	qre1W2/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uadSu-00000008tFH-46tS;
	Sat, 12 Jul 2025 16:52:45 +0000
Date: Sat, 12 Jul 2025 17:52:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Subject: [PATCH] mshv_eventfd: convert to CLASS(fd)
Message-ID: <20250712165244.GA1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in viro/vfs.git #work.fd; if nobody objects, into #for-next it goes...]

similar to 66635b077624 ("assorted variants of irqfd setup: convert
to CLASS(fd)") a year ago...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 8dd22be2ca0b..48c514da34eb 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -377,10 +377,11 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
 	struct mshv_irqfd *irqfd, *tmp;
 	unsigned int events;
-	struct fd f;
 	int ret;
 	int idx;
 
+	CLASS(fd, f)(args->fd);
+
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
 		return -ENOMEM;
@@ -390,8 +391,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	INIT_WORK(&irqfd->irqfd_shutdown, mshv_irqfd_shutdown);
 	seqcount_spinlock_init(&irqfd->irqfd_irqe_sc, &pt->pt_irqfds_lock);
 
-	f = fdget(args->fd);
-	if (!fd_file(f)) {
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -496,12 +496,6 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 		mshv_assert_irq_slow(irqfd);
 
 	srcu_read_unlock(&pt->pt_irq_srcu, idx);
-	/*
-	 * do not drop the file until the irqfd is fully initialized, otherwise
-	 * we might race against the POLLHUP
-	 */
-	fdput(f);
-
 	return 0;
 
 fail:
@@ -514,8 +508,6 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	if (eventfd && !IS_ERR(eventfd))
 		eventfd_ctx_put(eventfd);
 
-	fdput(f);
-
 out:
 	kfree(irqfd);
 	return ret;

