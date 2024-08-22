Return-Path: <linux-fsdevel+bounces-26794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C893695BB07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DFB1F24CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C91CCEDE;
	Thu, 22 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="EAgwSO1L";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YgFzirG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583D1CCEC7;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341951; cv=none; b=SehtsQP+aRECM4RUux1sb0uafQMb1n9LbZbq7okeeyrDe7y7u0wFGN6o23RpzBeNgsfnyiE1SkX7GK0NCUfs8Be8WoFGOr23w7bL755RjPWmei/eVYXkHKf4yCu468DWyIU3DySO3we6WaB8PeXaJtqrKQ3xJZ9sOHgUS9ixAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341951; c=relaxed/simple;
	bh=QvCHcl/SSOPW36MN1J92+S5deZwIvzodh4p8wNVpnKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plFTNuAln84G1AoHgggYvNNeJI4BKxRpuABbxuvIp8nZ8aaeADTPYRSUOYofVq0SVJz38ycodtSSIMBBFtFXq2Wwmnc5y1FXCSgBpCYu1M4WKKq11z0NRLWESqNHrNAw3s/XyRZZDPDjt48dnFgITDfuU1WMFssnx0yrBCli05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=EAgwSO1L; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=YgFzirG3; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3900021DF;
	Thu, 22 Aug 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341467;
	bh=FP5NbU3L+cA8ftMj6oxKd/JNZXBmnwx+Bf9E83KyMUQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EAgwSO1L+dJbNFazHjWihIGbvcYCtjLw4VJKIDACGnMA39w8iET+472eio+M4Y5Qq
	 nZNCN9ytenuuHQPtQ+QmWAPuasQVzVCKivbwqDwH3pxICLXDg+3Er/OgSk6KsW67Zg
	 VjvUOal3EfpO/+0RNk5rtOQqZIbdgBqpiIOh37dA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 58DF82215;
	Thu, 22 Aug 2024 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341943;
	bh=FP5NbU3L+cA8ftMj6oxKd/JNZXBmnwx+Bf9E83KyMUQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YgFzirG3gge+FeSfZeKNxEC9TwNrWC+piM/haaThielAPrEOFwZHOHmXJ7ijKq1Tx
	 tJwdEuboa6aW6+vImwPEFx1COBqyEcx/My361Zr7/umbOIjqcRPJ5we+dvTLooGC7o
	 jBx+DMGLRO1+iLhGh9j7gfFb6aVOuNePytHlbK/w=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 11/14] fs/ntfs3: Implement fallocate for compressed files
Date: Thu, 22 Aug 2024 18:52:04 +0300
Message-ID: <20240822155207.600355-12-almaz.alexandrovich@paragon-software.com>
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
 fs/ntfs3/attrib.c | 25 +++++++++++++++----------
 fs/ntfs3/inode.c  |  3 ++-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 6ede3e924dec..d2a9cd963429 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -976,15 +976,17 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 
 	/* Check for compressed frame. */
-	err = attr_is_frame_compressed(ni, attr, vcn >> NTFS_LZNT_CUNIT, &hint);
+	err = attr_is_frame_compressed(ni, attr_b, vcn >> NTFS_LZNT_CUNIT,
+				       &hint);
 	if (err)
 		goto out;
 
 	if (hint) {
 		/* if frame is compressed - don't touch it. */
 		*lcn = COMPRESSED_LCN;
-		*len = hint;
-		err = -EOPNOTSUPP;
+		/* length to the end of frame. */
+		*len = NTFS_LZNT_CLUSTERS - (vcn & (NTFS_LZNT_CLUSTERS - 1));
+		err = 0;
 		goto out;
 	}
 
@@ -1027,16 +1029,16 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
 		if (vcn < svcn || evcn1 <= vcn) {
-			/* Load attribute for truncated vcn. */
-			attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0,
-					    &vcn, &mi);
-			if (!attr) {
+			struct ATTRIB *attr2;
+			/* Load runs for truncated vcn. */
+			attr2 = ni_find_attr(ni, attr_b, &le_b, ATTR_DATA, NULL,
+					     0, &vcn, &mi);
+			if (!attr2) {
 				err = -EINVAL;
 				goto out;
 			}
-			svcn = le64_to_cpu(attr->nres.svcn);
-			evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
-			err = attr_load_runs(attr, ni, run, NULL);
+			evcn1 = le64_to_cpu(attr2->nres.evcn) + 1;
+			err = attr_load_runs(attr2, ni, run, NULL);
 			if (err)
 				goto out;
 		}
@@ -1517,6 +1519,9 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 /*
  * attr_is_frame_compressed - Used to detect compressed frame.
+ *
+ * attr - base (primary) attribute segment.
+ * Only base segments contains valid 'attr->nres.c_unit'
  */
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 			     CLST frame, CLST *clst_data)
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d8fcd4882b18..d142f15b24e7 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -609,7 +609,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 
 	bytes = ((u64)len << cluster_bits) - off;
 
-	if (lcn == SPARSE_LCN) {
+	if (lcn >= sbi->used.bitmap.nbits) {
+		/* This case includes resident/compressed/sparse. */
 		if (!create) {
 			if (bh->b_size > bytes)
 				bh->b_size = bytes;
-- 
2.34.1


