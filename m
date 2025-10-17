Return-Path: <linux-fsdevel+bounces-64451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B69BE8065
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B361A66381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3C30F556;
	Fri, 17 Oct 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NtoIEsTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530002E5B21;
	Fri, 17 Oct 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696340; cv=none; b=b/ED1hD/NIBwicNXir1EdnCbIj3PhoSN0YfegJJZUUOEpdXni0Wn5l/4t9thrQyNg0UsNy3GKWLM8Tn1Oc2I79tvrb/vzXIpqBIUz/+4xqCMVaByvjuw02p/CILy6dowjYW9wk8vrBZ55IV42eV7Pzxif2sThBq4ZaPJ7jwEvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696340; c=relaxed/simple;
	bh=lNASWFq9hkLr8MIHPepeg51anv+cru/E/QAApgicP0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/RvxbHP9ta0h4CBVThRgi8/oi87TPYDyRcVCrp6mlrj0jOW+vLk43KddKaSa3e6/gmHINgLaUc+guqN4pUaJVCJtPup7rQHVZ9V6O9hUQBOSox5M+GrMem895HPClCuB4mbw8id2eM6EwmY4Gc3hpBrNjQPI6HOcL315ttYIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=NtoIEsTF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3A31C1D24;
	Fri, 17 Oct 2025 10:16:03 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=NtoIEsTF;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C7FC72421;
	Fri, 17 Oct 2025 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1760696337;
	bh=7gYjnXTWlXZnRzDxdd+FF1TOLbuiSGPJK+lCoMVUybc=;
	h=From:To:CC:Subject:Date;
	b=NtoIEsTFAWVts+98/hBFuKoUYVmGYSCam4q3aHdds6fF8wlnTBC1swSWpbrridCbK
	 NJm6CdYK4iBGafQtU+DghEsrsbR2yk2CBpgfWNbR4igjTZuOIlJ5iTZYCr8bLRN/4C
	 yY7D8Ib+ho3Cy7NCYa56W/y98Q3LO4TOja2+xd74=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Oct 2025 13:18:55 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] fs/ntfs3: fix mount failure for sparse runs in run_unpack()
Date: Fri, 17 Oct 2025 12:18:47 +0200
Message-ID: <20251017101847.5874-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

Some NTFS volumes failed to mount because sparse data runs were not
handled correctly during runlist unpacking. The code performed arithmetic
on the special SPARSE_LCN64 marker, leading to invalid LCN values and
mount errors.

Add an explicit check for the case described above, marking the run as
sparse without applying arithmetic.

Fixes: 736fc7bf5f68 ("fs: ntfs3: Fix integer overflow in run_unpack()")
Cc: stable@vger.kernel.org
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/run.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 88550085f745..5df55e4adbb1 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -984,8 +984,12 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			if (!dlcn)
 				return -EINVAL;
 
-			if (check_add_overflow(prev_lcn, dlcn, &lcn))
+			/* Check special combination: 0 + SPARSE_LCN64. */
+			if (!prev_lcn && dlcn == SPARSE_LCN64) {
+				lcn = SPARSE_LCN64;
+			} else if (check_add_overflow(prev_lcn, dlcn, &lcn)) {
 				return -EINVAL;
+			}
 			prev_lcn = lcn;
 		} else {
 			/* The size of 'dlcn' can't be > 8. */
-- 
2.43.0


