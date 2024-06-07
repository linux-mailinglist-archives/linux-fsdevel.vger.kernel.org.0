Return-Path: <linux-fsdevel+bounces-21198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBD90037F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF892881E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68AE192B83;
	Fri,  7 Jun 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pciVf6Lh";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Rtx/WFi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5E1922F2;
	Fri,  7 Jun 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763177; cv=none; b=RqIFPx6LS2+s99y1g6ccHfcsKvBM3U1fvv9DToKeIT6soUbgfddG//S178gc80aKkTTmyRINPxxkt3l0SzqcthWhdKMFgsDPlNSv2iICKhBKXhwf9MxLssHIw9pQ23sSRAMCdi920jaLj4WXL3N7WTcLS9yyJ0HJa4PuV/HUHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763177; c=relaxed/simple;
	bh=Qftod05FG8cvV0DSzaUmUcM0W3C99UwJOo6+6K5E5Q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT1qXnBSi0xSSGz/RhI6yFgOrmiSd1+FnfxsgeWF8Ym+I1kL4IiTSV8ZZtCGArNhIIweWsbETqWzY0J+IjTOKRyYgnPYRY+u8K6K0qEe3iQTwkCf8THAjEu86XHhsY6NlVE11B0w6xfEAT29L6S3Be2CN1dOBN/LXihgMQxkpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=pciVf6Lh; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Rtx/WFi/; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A986C210F;
	Fri,  7 Jun 2024 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762093;
	bh=C0FGKScgnT35/rhseY+g8+MwboIiYrT4rJr94CiH6dY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pciVf6LhJPjNSSemFdaR0dyVndK7+XIl3Ol5Urwi736uGXEw+YMn1LLC29agSpdgQ
	 HiW2zgOEyemCnAwE2iT3bXnnhUS8Cc4gGkMIVWcUv3pcZRLrGzusnOwnNya84ZwvKN
	 QmnJYKv+QmHVLNthp3kd83AOvQhY2D/nKDCZfKQQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8D3D7195;
	Fri,  7 Jun 2024 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762567;
	bh=C0FGKScgnT35/rhseY+g8+MwboIiYrT4rJr94CiH6dY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Rtx/WFi/ykZJaXFGm3HBVjNjkCEEWUQyaucxmFbLNNcTSc+eptRAUchT1VcRMLI4e
	 49jCBSnBbKXDXQEl/0LoSgDEFTbsYyM+dYNeyMbmwoJavnF82PLaVj9JcZa3hmX5pz
	 Ss2o6UJfeOQllTIonhl3DU54Tu0ZRN/yrKtY/NWc=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 03/18] fs/ntfs3: Fix transform resident to nonresident for compressed files
Date: Fri, 7 Jun 2024 15:15:33 +0300
Message-ID: <20240607121548.18818-4-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Сorrected calculation of required space len (in clusters)
for attribute data storage in case of compression.

Fixes: be71b5cba2e64 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8e6bcdf99770..8638248d80d9 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -231,7 +231,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	struct ntfs_sb_info *sbi;
 	struct ATTRIB *attr_s;
 	struct MFT_REC *rec;
-	u32 used, asize, rsize, aoff, align;
+	u32 used, asize, rsize, aoff;
 	bool is_data;
 	CLST len, alen;
 	char *next;
@@ -252,10 +252,13 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	rsize = le32_to_cpu(attr->res.data_size);
 	is_data = attr->type == ATTR_DATA && !attr->name_len;
 
-	align = sbi->cluster_size;
-	if (is_attr_compressed(attr))
-		align <<= COMPRESSION_UNIT;
-	len = (rsize + align - 1) >> sbi->cluster_bits;
+	/* len - how many clusters required to store 'rsize' bytes */
+	if (is_attr_compressed(attr)) {
+		u8 shift = sbi->cluster_bits + NTFS_LZNT_CUNIT;
+		len = ((rsize + (1u << shift) - 1) >> shift) << NTFS_LZNT_CUNIT;
+	} else {
+		len = bytes_to_cluster(sbi, rsize);
+	}
 
 	run_init(run);
 
-- 
2.34.1


