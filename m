Return-Path: <linux-fsdevel+bounces-43860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02DA5EA99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E25E1761AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A081494DB;
	Thu, 13 Mar 2025 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HkwK9EnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2B1386DA;
	Thu, 13 Mar 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840223; cv=none; b=hg3x6FGm1Rk9LuGLAdEFIdkLcv8dzFCq6AeQMd5hum/eVe+6Lt6CAhhjFMQP79gMGAkWyM262vU8eFg8Efq1RV3HjsJd9ToUHedIgclFZ2gmPE3c4mo5lBIbGP54mMy3vI/u4QxS0ZNy4hmVoeS5kwww0JCJpc5xthm+boJPeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840223; c=relaxed/simple;
	bh=+eIHF7nusOT6vkHRkV5HmWigcK0e1K7mHyfI6uS0j5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNlu/P/DmkxEiyC5CAVl2D9SoVbHwlIGOPq3OXa3UcevopD8swNHia6m5+Wxt4Tdt1atFsaJYeydIpD5lK0rP44F3cbq3IDmjeP9h/jtyLAITz5s4LlEVnV7b0pZJ+J6+hE588++wMZRdVquV6knUvayEutnLtsRPWP2VuYkaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HkwK9EnP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JGDZKjK6OCs68zG/tr6xM+cq3fLRGiU5AsrbLJq3hy0=; b=HkwK9EnP5vbTyY+IQ4Ts3B8yEt
	cMFsHQrQ9zON/qh8NEEuPZqS2c6Lb0iVW//HoNU/rtS7Z1mZIbRESC4btevcOK6oi6hSAt3jKf3rj
	w5wJ3KLN03oxyrtz62SPyVrDhIDWXNGoRK9YMYV5xhT1+PfT/AmBl/CPI4IHZdef72P2cqxI3Yymp
	D3evmXAi63k5BToVAZKto0VLJUz9wrJWnVmffK1+cZQ8iHTtO4gkb2Ezj+nd/BZp67Tmij5OBHXEi
	Myd+uunLSoVESuDxXeSbOEXgaEmSeWSM6I9csAHxXBt612qWT5qb+s+7zKQlr5U3zn/ZMgMPuUgMI
	B14QSTXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tsaD6-00000008uvz-2NjH;
	Thu, 13 Mar 2025 04:30:20 +0000
Date: Thu, 13 Mar 2025 04:30:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Subject: [PATCH 4/4] qibfs: fix _another_ leak
Message-ID: <20250313043020.GD2123707@ZenIV>
References: <20250313042702.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313042702.GU2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

failure to allocate inode => leaked dentry...

this one had been there since the initial merge; to be fair,
if we are that far OOM, the odds of failing at that particular
allocation are low...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/hw/qib/qib_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index b27791029fa9..b9f4a2937c3a 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -55,6 +55,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = new_inode(dir->i_sb);
 
 	if (!inode) {
+		dput(dentry);
 		error = -EPERM;
 		goto bail;
 	}
-- 
2.39.5


