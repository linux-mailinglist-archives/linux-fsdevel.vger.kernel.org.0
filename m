Return-Path: <linux-fsdevel+bounces-51657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAABAD9A54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0CB17771F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96E1D618C;
	Sat, 14 Jun 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TSwnHJmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAB1DE8A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880956; cv=none; b=Uu+aBgW5ttbrKbZeMX7xjhkf+PYc3dU2BI90X5aEVM+oSOCns0/75xQQ1/hJg5VTEnMLs577zrHl7qOYFYD8FjuE+ygOu2fnU/hELARnvPY1cgUYk62Gn9RVYyhu39/MhKyJ4c/betCp7tzwtAiQHz1mlnZ2zPrF5ITUg/nuhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880956; c=relaxed/simple;
	bh=qg2O6iZIseTcAZRQtk1St6N4PV/Ld/G7Bj1cvWMy0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjucnYsvApwcL0OmM1EKWS09ISUAjcL030M3EC6HtmOMw7aOnv+++fhb9JhSGpAfxGn8TrZzgEpy3GYdiwKxa8/OlrxJPQqFNBZQH9dsSUnay+9Avsv7XYN1vKx+k1jU/DBm94SQkagPoIWzsOUDFdZmNJYUSqXDL53Fb5ZsET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TSwnHJmi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zkQbpoHYynZJKwBwIgQufFZmwj6RMGLD5+dk1wRCrvY=; b=TSwnHJmiHjXIEeoB4vAZV0b3/s
	Fe3W/60rbAo/tWgMRuBdRSD88h+XAqaeJXwLGZVhijuOVwF7TwkYTflB4u1oW1t+JLq1HxaW7nFH5
	nK5g5EaKLG5wJ8CgwadVmOP4aCAlzs+IKqSL99Wk6BjEQaCjLlLJpKrs61owdOfggqIaR4umMeWFb
	xGSs3+TRMnBoCOsbx7BKGYz8F96bFO1XoYOlF1mEqgFaatxJ/cPjEFYsGs+AT3syQeMEYJjP/EiUo
	8qsH8XMDHmJmOTZ7ye+IGqHQts7Q5wkzkMpehgHX85LqNSZUPb4LuA1odzX72TwfVgAjkoqRYwNmm
	rDxJGFdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyK-000000022qr-0Co6;
	Sat, 14 Jun 2025 06:02:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 8/8] functionfs, gadgetfs: use simple_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:30 +0100
Message-ID: <20250614060230.487463-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

usual mount leaks if something had been bound on top of disappearing
files there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 3 +--
 drivers/usb/gadget/legacy/inode.c  | 7 +------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2dea9e42a0f8..ea5f0af1e8d2 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2369,8 +2369,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
 		if (epfile->dentry) {
-			d_delete(epfile->dentry);
-			dput(epfile->dentry);
+			simple_recursive_removal(epfile->dentry, NULL);
 			epfile->dentry = NULL;
 		}
 	}
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index fcce84a726f2..b51e132b0cd2 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1561,7 +1561,6 @@ static void destroy_ep_files (struct dev_data *dev)
 	spin_lock_irq (&dev->lock);
 	while (!list_empty(&dev->epfiles)) {
 		struct ep_data	*ep;
-		struct inode	*parent;
 		struct dentry	*dentry;
 
 		/* break link to FS */
@@ -1571,7 +1570,6 @@ static void destroy_ep_files (struct dev_data *dev)
 
 		dentry = ep->dentry;
 		ep->dentry = NULL;
-		parent = d_inode(dentry->d_parent);
 
 		/* break link to controller */
 		mutex_lock(&ep->lock);
@@ -1586,10 +1584,7 @@ static void destroy_ep_files (struct dev_data *dev)
 		put_ep (ep);
 
 		/* break link to dcache */
-		inode_lock(parent);
-		d_delete (dentry);
-		dput (dentry);
-		inode_unlock(parent);
+		simple_recursive_removal(dentry, NULL);
 
 		spin_lock_irq (&dev->lock);
 	}
-- 
2.39.5


