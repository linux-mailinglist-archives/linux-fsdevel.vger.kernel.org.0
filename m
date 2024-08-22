Return-Path: <linux-fsdevel+bounces-26791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C027395BB02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5191C22CCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246711CDA28;
	Thu, 22 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="j3DSaZDC";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="cg1AEGCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED51CCB56;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341950; cv=none; b=ZwoUmRWJZik6bxeYSviqnOk4WB7mUuhAVek12DmYcUJuKf8euU9tu7J5ZNKS9kqqtjjAVgy/kkvos+AjtFcm5bNIEup3ZcO6DUOpr8ELQbKRjUak7vYq8+y49FAK129GSf8j8OsH5iOYfrrNqVwCUHSeuCCDF+4zYlOtLazvMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341950; c=relaxed/simple;
	bh=Mn1ftOxGaFNs409llO/zdqoLSMKHOxWTUSVYOj2GmuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3jq9DyCn/FhHmEloVIAGV5TSDPSRbWM1mPGwsq1s+RnhPp6B0teMvOJfnV6dyVJ2GbijLI9lqGP8yxRQDAGomNByc055ysJHXITtUy4k71HtlI+h6uNJxO4+IItB1Hza1010gYVlZCAmjb9RWgeXjig4Qiif4IhPA3QOO68In4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=j3DSaZDC; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=cg1AEGCd; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id EF8D421DC;
	Thu, 22 Aug 2024 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341466;
	bh=dvmmrstlBLX4YWAtfUAvlH/1hCcoqmaZ0Gf2SfYUBn0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=j3DSaZDCmnuWIEnR+WLIIyO97yyZjxRN0pdNLDVqaKf+9U9OuAiPcqGXvf9En4K7+
	 ym4ZU6/4Sf0lq76wBSjymm6KR+KI/YPr2gJUchyY2n02bFP4xhsh3VX3HfuOoO4XT7
	 X+TeVqU7K0pySZxjT2/3vZQw7SH2lEgP//pJ+xDA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 26E322215;
	Thu, 22 Aug 2024 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341942;
	bh=dvmmrstlBLX4YWAtfUAvlH/1hCcoqmaZ0Gf2SfYUBn0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cg1AEGCdF1qx84mORrdEo+WMMecDvvz/MghO3knhqnDrdtU+kgwQYoNAc+tlw5tzY
	 T35kgDMdqsxECUJV4S6tJ7KQSrS6D5czp+hrxPmI+0svAaNtYV6teyS1w5Xo5Y39rc
	 p1y1bm2NxEqO4OV8jfC/l8NTLz5S92RtW/PxTVqc=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 08/14] fs/ntfs3: Stale inode instead of bad
Date: Thu, 22 Aug 2024 18:52:01 +0300
Message-ID: <20240822155207.600355-9-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Fixed the logic of processing inode with wrong sequence number.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 8eaaf9e465d4..d8fcd4882b18 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -536,11 +536,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
-- 
2.34.1


