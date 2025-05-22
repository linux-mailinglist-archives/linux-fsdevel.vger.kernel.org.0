Return-Path: <linux-fsdevel+bounces-49615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C65AC00F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A4D16936A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11010A3E;
	Thu, 22 May 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR54VacU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938AEAC7;
	Thu, 22 May 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872287; cv=none; b=F9jMqjxSERtNb5s4t+0ldPCh/Ug0qpTYBtRFxmIKKZbnOX0NuR5nLpMpofQtIhTCn/vIGio0JOqQYS09XSc/T2Trbx2RQa5IgBBXydaWaV/stvr9T2c0AARg0RhMBg88CztI1GXbRV2wS8++/tzUQ3Bpr3uDwFV4spTPj4GIV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872287; c=relaxed/simple;
	bh=bvvqOVzr58THUkrgXcLjI7XdxTCgUdU0E/NbbKxob4g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejhT00TrhZ1/diQVEMvFLqos6Ltgy+Hx2N02QVgJLiXe8VLOJbjadseuLW1NOBOtdq+zcm22emSaaaEvLHq/sdkQvEFPjzS8wPRIqGQAdcl72nrNnjVILJFF+53DRqdSSsJbNjr6HHT/AK9lZ6zjEi1S2okbOj5HL59xqYPUQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR54VacU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B6C4CEE4;
	Thu, 22 May 2025 00:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872287;
	bh=bvvqOVzr58THUkrgXcLjI7XdxTCgUdU0E/NbbKxob4g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lR54VacUMo5VFU88z+bpA3A8cqrCOuPsL8ylxbLMvpxlYNW+/8IHchQhRfTbu1lGr
	 zlERqLturSBFMtWuybomoAV3ndb1jLOXksVy4/EKzbAgl2/Wniv0L9QcOadmCRmtJm
	 YB5kvfJsWX4E96m97ZbgPx55yFILxD4b8jvlj1Z5MrqJLflyKYr1bohDqf6Hrhb4UU
	 eR1mgDINQ4nXNIf+kAY3P44lmnjKwFfCVI0uXxUvRb0O8wJNxLBxNkuuBD8cq0vyMl
	 BreBNykIPv1UM300s7pEHXaM6hrmvZuy0/2fQFm3SvYITyf2DdYcLQ3NREB3/I79JH
	 Gfigdu2QOtJoQ==
Date: Wed, 21 May 2025 17:04:47 -0700
Subject: [PATCH 09/11] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195758.1483178.13602094664783346780.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use large folios when we're using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 345610768edc80..c58ac812598d8f 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1070,6 +1070,7 @@ const struct address_space_operations fuse_iomap_aops = {
 void fuse_iomap_init_pagecache(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	ASSERT(fuse_has_iomap(inode));
 
@@ -1081,6 +1082,11 @@ void fuse_iomap_init_pagecache(struct inode *inode)
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
 	INIT_LIST_HEAD(&fi->ioend_list);
 	spin_lock_init(&fi->ioend_lock);
+
+	if (inode->i_blkbits > PAGE_SHIFT)
+		min_order = inode->i_blkbits - PAGE_SHIFT;
+
+	mapping_set_folio_min_order(inode->i_mapping, min_order);
 }
 
 void fuse_iomap_destroy_pagecache(struct inode *inode)


