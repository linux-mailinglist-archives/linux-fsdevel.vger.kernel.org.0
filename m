Return-Path: <linux-fsdevel+bounces-72109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC6CDED9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 18:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7ED7300727A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47915236A8B;
	Fri, 26 Dec 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="AAVfjVu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166D1DE8AD;
	Fri, 26 Dec 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766770898; cv=none; b=swH457al2q0tMLCC9/3GQaLPj7J/KbsfkCu3sT3eZIDp7OBc2saM4mNzratoP/zDNo074U4fnZuC4pJDa8UKn22+k+FRsbc1+nSaFrBmedVU2Iyqs1U4hDa64nhsvbi7VObVMZsI1hXY7pVcj2cCU0A21fAjNj2awUVm9HUv90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766770898; c=relaxed/simple;
	bh=vFwQUnDdAP6uowxwBZNG+/8WNKvcOvxA70GqTlior40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtaU0Q0IfApL4b2n08i5AUWzNV2UO+WiErub8mGGc12avWc4gEs6FaoIBGTUeBS56LXtYCZIlY1wE7ACZ3AoiubGDO9xKh1YZQKWoBhZg6bnNApZgqG7w6oDlb88R34xHYPXqyf2Gxdc4krB3hNjpCiVWGyYHHz3VUpF33gHat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=AAVfjVu4; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1B3BF1D1D;
	Fri, 26 Dec 2025 17:38:27 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=AAVfjVu4;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5A5672267;
	Fri, 26 Dec 2025 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1766770895;
	bh=mQiVHYmDhcQ/IpJk769L/6T6fswpwCQ78QPsc4l0ACk=;
	h=From:To:CC:Subject:Date;
	b=AAVfjVu4WsM75BUFsX+vRX3pxFvrh85aQFrH3LWbe7oV17ZTeZQTFq2JZR4EAgDZW
	 LPi2QaF0BVKI55YbP6IFsmRRKlonM+b0LRKbDTTQOHham0uPH0XpIjAR4qAi4Pmp8h
	 BSNXglVkrO5szm24l9TrlTubs48kUKLctCIB1LQI=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Dec 2025 20:41:34 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: drop preallocated clusters for sparse and compressed files
Date: Fri, 26 Dec 2025 18:41:25 +0100
Message-ID: <20251226174125.15780-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Do not keep preallocated clusters for sparsed and compressed files.
Preserving preallocation in these cases causes fsx failures when running
with sparse files and preallocation enabled.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index c45880ab2391..0cd15a0983fe 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -448,8 +448,10 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 	is_ext = is_attr_ext(attr_b);
 	align = sbi->cluster_size;
-	if (is_ext)
+	if (is_ext) {
 		align <<= attr_b->nres.c_unit;
+		keep_prealloc = false;
+	}
 
 	old_valid = le64_to_cpu(attr_b->nres.valid_size);
 	old_size = le64_to_cpu(attr_b->nres.data_size);
-- 
2.43.0


