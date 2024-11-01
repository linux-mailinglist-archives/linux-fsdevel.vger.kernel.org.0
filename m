Return-Path: <linux-fsdevel+bounces-33445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354039B8CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DB21C2198B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83232157476;
	Fri,  1 Nov 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="V0jT6IDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB06156644;
	Fri,  1 Nov 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449097; cv=none; b=Sawx8G2O/g1PR+lbVurqTDAAzouj7RDJ8BIh9fGfM3Ey8Dkwt4KFmAgV/TO5NhOuX1KKgtyrlxc3o8fjaeq7O0KVslYs8xLFBX/MfflhTbFESfj0kUWwfAvaga1YFA5bAahgGZj72Buv9odQeqFZIXPACtGLaU8mCmfoo6n40GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449097; c=relaxed/simple;
	bh=ip10q0afRCPufQl5vblhJgoIxGZLNRQ5cA/HQPEMSgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6PvQIWJyxpcSZXyzRN5t9jxMoK2L3jK3sahkec1Z5dYVjHp+HIyg5++8uFFvL2bSuKrNuc6IpDALv7+D8e5gNjcHXylnQwXJZBUojp9IqY1vCrl/96we32hPPPYi9X6Uxdv86MMVeJXMRFdLLcHtkuYV99gxnjA3QRDzjZuezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=V0jT6IDN; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B926A2195;
	Fri,  1 Nov 2024 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448624;
	bh=5KkQ+m9GyL5KPsZkuY61BI+zMKTicmhs5y2zpcYau+4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V0jT6IDNJXH4dHMMTKvwLiYxBP+N/KDda0GjyCby6eP6hkEYal45lVUKtV/ul3h7X
	 b3+XMHWSgcJgOXCmty79amTXktMUlFySx4tgGiPHd8fodSAvOaVfqchFiC1MEryhi4
	 3ufXL3H2ZnikOznaWk9Imc/VU1KO3Q6GPw6elv1w=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6/7] fs/ntfs3: Switch to folio to release resources
Date: Fri, 1 Nov 2024 11:17:52 +0300
Message-ID: <20241101081753.10585-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
References: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
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

As part of the process of switching from page to folio.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 0063e2351aa9..3f96a11804c9 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -989,6 +989,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	u64 frame_vbo;
 	pgoff_t index;
 	bool frame_uptodate;
+	struct folio *folio;
 
 	if (frame_size < PAGE_SIZE) {
 		/*
@@ -1043,8 +1044,9 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 			if (err) {
 				for (ip = 0; ip < pages_per_frame; ip++) {
 					page = pages[ip];
-					unlock_page(page);
-					put_page(page);
+					folio = page_folio(page);
+					folio_unlock(folio);
+					folio_put(folio);
 				}
 				goto out;
 			}
@@ -1054,9 +1056,10 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		off = offset_in_page(valid);
 		for (; ip < pages_per_frame; ip++, off = 0) {
 			page = pages[ip];
+			folio = page_folio(page);
 			zero_user_segment(page, off, PAGE_SIZE);
 			flush_dcache_page(page);
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 		}
 
 		ni_lock(ni);
@@ -1065,9 +1068,10 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 
 		for (ip = 0; ip < pages_per_frame; ip++) {
 			page = pages[ip];
-			SetPageUptodate(page);
-			unlock_page(page);
-			put_page(page);
+			folio = page_folio(page);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (err)
@@ -1109,8 +1113,9 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 					for (ip = 0; ip < pages_per_frame;
 					     ip++) {
 						page = pages[ip];
-						unlock_page(page);
-						put_page(page);
+						folio = page_folio(page);
+						folio_unlock(folio);
+						folio_put(folio);
 					}
 					goto out;
 				}
@@ -1151,9 +1156,10 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		for (ip = 0; ip < pages_per_frame; ip++) {
 			page = pages[ip];
 			ClearPageDirty(page);
-			SetPageUptodate(page);
-			unlock_page(page);
-			put_page(page);
+			folio = page_folio(page);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (err)
-- 
2.34.1


