Return-Path: <linux-fsdevel+bounces-18571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C58BA5FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA81F24251
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C533E479;
	Fri,  3 May 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eGMHKCEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312C22F00
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709865; cv=none; b=Mwq/HlKFlapdlj1UqX30rgmXM2mEHKGYvo7A8L0D1dLiaybrjphj+HAJx88qvYkPmsPWzpCusI43CsJ1rgakaNpVjVoNeMwYHYGojoYm6XPfmcNcRCGwVkdfRCZTXGnhLHpQ6BORda4uO0/oPkVP40wqfFZMcpPNrYP/XciJDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709865; c=relaxed/simple;
	bh=T22JrpafRjR0cPiRd37OY+3r5BzgSapXYKLtL7I1f1g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5BEBLAcS7eWmv1OtuzvAi5E60QdcWXe40Xwyeil1lZ7Lude4Jr0I4BY3ix8vWGiOnuQJJx5Neep6SQdWc+J1Vv5YEvTsqZ9wesxW2XWBDqvfLVOKNC8prMwmt0A1VZ0UmkEWuo6jPK+Tl8d7/eyKOSiiwd7NIYvudDyBeTkBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eGMHKCEM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zwCOMy2NEj3BPtx134SFdJYS70Xwr8CQmU8M48tauxc=; b=eGMHKCEMOJDF/XvbCBpsQwX7ey
	csla19ABCZl0aO5E+TcMkTy4LlbgxU5BtEgiDJdBm3b0C90IL8jyNq3lT+C/UihLmiu3kRpFxWA7j
	Blp67+4m0bA+XsgxitFBPMQVtRiU+AFgcovEJe3pJICK4P1VL0G16jKjTDkE/Nqmy/Q5DMANusDe1
	yZ6NDwg1J7dx+5iBzvfzhx86DkERGw9Ir7hzusZsQfvlkyCuiFJNbczmv/RhvVpsrxVy4joppuftL
	q4Jbes+R8eShnhVW4c+p3IoK/OIHfogNT6TNii+7pVJkV8rCrl1tCmSCkhxnb8QZLquonlOzHeo3G
	BaGJyHlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMf-00A5Vb-2f
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 9/9] make set_blocksize() fail unless block device is opened exclusive
Date: Fri,  3 May 2024 05:17:40 +0100
Message-Id: <20240503041740.2404425-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 block/bdev.c                          | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1be76ef117b3..5503d5c614a7 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1134,3 +1134,10 @@ superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
 device freezing now works for any block device owned by a given superblock, not
 just the main block device. The get_active_super() helper and bd_fsfreeze_sb
 pointer are gone.
+
+---
+
+**mandatory**
+
+set_blocksize() takes opened struct file instead of struct block_device now
+and it *must* be opened exclusive.
diff --git a/block/bdev.c b/block/bdev.c
index a329ff9be11d..a89bce368b64 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -157,6 +157,9 @@ int set_blocksize(struct file *file, int size)
 	if (size < bdev_logical_block_size(bdev))
 		return -EINVAL;
 
+	if (!file->private_data)
+		return -EINVAL;
+
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-- 
2.39.2


