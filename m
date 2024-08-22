Return-Path: <linux-fsdevel+bounces-26792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4CD95BB03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C261F24D04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399751CDA2E;
	Thu, 22 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="DGUZOGrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D91CCEC4;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341950; cv=none; b=rAJdjTnFrSrCpceYfk2OqyQjlUngOuLY0ODvw/li6IY4fRq80PKlM/p2J5TbNtLZPdJMCJSFuln/U16D71k8cscGsGZe/Oah16lZkABdw+8CT6Ki5p7U45GbOvDZSohZ1Iig/TajQ+Uk2HU+azuZvdE6DDbFN2H2I/iW6vACIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341950; c=relaxed/simple;
	bh=7CeXT1uhtxNXOwIiPRkMV2wrqgMJm8yD+h252EmzuOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj45J5XLzfdPC4cumjIHmqqzrtZO51F2YN1CfHh//KiIrNplcX2mo9bBx7T8JWeQB23Ul7EiPkhbsW9EgO8K7RexHSSWIpC8LwYism1wnfKUoiIbykMuehshV+MrUHYn61rQCfkOgzcytnWEIja3ZyB8g6rnQLcIGA3Vk+dpog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=DGUZOGrG; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 72D2521DE;
	Thu, 22 Aug 2024 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341466;
	bh=qsBAFx7vQsf0CXdUIHO/KoScnoJRG+kIfeZFLte2GYI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DGUZOGrGCvRHDifFJSwk4en6J9v7MnY6LTKsuMlvJZGrIwGgKofVlf7vP71pCCPyG
	 7xaeV/Wq2XqYTrTyCLAHtCJceD+cM75jU+xOvQtLEvObPiP68TvtXZOdGvWuBRoMPF
	 jgPLSuA+rqxGtJirLpFnHJj9a0eIWaOEG9NOaK3A=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 10/14] fs/ntfs3: Make checks in run_unpack more clear
Date: Thu, 22 Aug 2024 18:52:03 +0300
Message-ID: <20240822155207.600355-11-almaz.alexandrovich@paragon-software.com>
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

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/run.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index cb8cf0161177..58e988cd8049 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -959,7 +959,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		 * Large positive number requires to store 5 bytes
 		 * e.g.: 05 FF 7E FF FF 00 00 00
 		 */
-		if (size_size > 8)
+		if (size_size > sizeof(len))
 			return -EINVAL;
 
 		len = run_unpack_s64(run_buf, size_size, 0);
@@ -971,7 +971,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 		if (!offset_size)
 			lcn = SPARSE_LCN64;
-		else if (offset_size <= 8) {
+		else if (offset_size <= sizeof(s64)) {
 			s64 dlcn;
 
 			/* Initial value of dlcn is -1 or 0. */
@@ -984,8 +984,10 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 				return -EINVAL;
 			lcn = prev_lcn + dlcn;
 			prev_lcn = lcn;
-		} else
+		} else {
+			/* The size of 'dlcn' can't be > 8. */
 			return -EINVAL;
+		}
 
 		next_vcn = vcn64 + len;
 		/* Check boundary. */
-- 
2.34.1


