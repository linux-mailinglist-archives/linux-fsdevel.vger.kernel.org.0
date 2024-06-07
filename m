Return-Path: <linux-fsdevel+bounces-21199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9139900381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C65E1F26D9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2319408C;
	Fri,  7 Jun 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MhmQO+3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB2190682;
	Fri,  7 Jun 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763178; cv=none; b=nMtCrsxRQWGX3d69VBmLp/KazkfxaaYyYZjHowuwfDIvWvYKVSnPg1RVw0DRDAG6AtFywId9vXfO6K/lzQO4qbDmoZiXQDmXZ8IcSpJDLF197rEI41pZjRW/vHCIbHi6BppKhY6KwclaHO3PHzgvdmssQj0VdRv2l/LzCnV3nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763178; c=relaxed/simple;
	bh=9pfPn1DGlgCPQSm1l68MBIhjL6uK0pKgf2XzkNTt120=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAtFbqMaZhyPQKyKQ9hv/YxM8CB11aD52xzsfH/Lfx9K7FEogkK7S6BR7KUxac/O57UjMavBsWfeX6tY527yOJwytG8TC9DixvA+TT5qd9y7aGjLlPuZyUZlue4Ohc8t8NN1OfvfBGXbvxiuwrzm5fAaDZqxgwWKxMOJIFtvdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MhmQO+3w; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 123A72110;
	Fri,  7 Jun 2024 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762095;
	bh=hZDgLEF+W6zZWxUzPUdboblkLRtxbcKk/oAVZILB+e4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MhmQO+3wsHnK5Fg3xzRJt2k9tQH70q/hOnKV5CFtagm4ISB+eVWwYbFLKQiM+aYYn
	 qAswQYHDqS4nrCIYol8JFPNmukVUr4Sycyyr0DWh6tkF+JjCgx4KSneWqlseE/mh7q
	 cUOOhllUs0kF7prHBXYcMk9A0UYoJttTqsZ2G6sQ=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:08 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 04/18] fs/ntfs3: Deny getting attr data block in compressed frame
Date: Fri, 7 Jun 2024 15:15:34 +0300
Message-ID: <20240607121548.18818-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
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

Attempting to retrieve an attribute data block in a compressed frame
is ignored.

Fixes: be71b5cba2e64 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8638248d80d9..7918ab1a3f35 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -975,6 +975,19 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	if (err)
 		goto out;
 
+	/* Check for compressed frame. */
+	err = attr_is_frame_compressed(ni, attr, vcn >> NTFS_LZNT_CUNIT, &hint);
+	if (err)
+		goto out;
+
+	if (hint) {
+		/* if frame is compressed - don't touch it. */
+		*lcn = COMPRESSED_LCN;
+		*len = hint;
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!*len) {
 		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
 			if (*lcn != SPARSE_LCN || !new)
-- 
2.34.1


