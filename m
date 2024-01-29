Return-Path: <linux-fsdevel+bounces-9324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538D83FFB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89CDB232C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E1524CE;
	Mon, 29 Jan 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="S74i0XWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC452F68;
	Mon, 29 Jan 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515726; cv=none; b=gdPIwPe3alltsMWueEij+nyqBmg86gzpfAcgNrrnYEKaALmWIy0FESGrdzv99b9bl9b1OmbnLrBISehfVfkauLIH2DuAiVzU3XcYUtfX//I+y8rE0HQkAOahnQwWryrOzeSGyVB+0u+pvXk3rKueSrVubVBSITV/qY95z2E1OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515726; c=relaxed/simple;
	bh=eLCjjqfccU7QtD9Z/zPxtm6zfiWJea3+n+pEq5WYGg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=f0ypxJX1eSNWf6drQxwrc2DM7LJvGe8hMpqRgr3lakiyezuPxcSeYsZV6XP6MtjlN8T9rZ+1a/DNXjHNs4dITaMITWz+U1xAzUrputk6OwyGAcM0EkSRw0X7m47gUGTi2+w1bfx+8s94O3DWBFjxXmgEn74rmBVWSXdr1HwIoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=S74i0XWS; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 91AA2211A;
	Mon, 29 Jan 2024 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515311;
	bh=xeznt+Dol1rUDewd0bVWo6D8uEqRIEtOxRwa5jeQ4+4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=S74i0XWSIfRF+JVBnt337iayJpkT1ksrZPWaVFe8U6idhyTol/XtAFED7eKiihHXx
	 3bnLehRD7HFMSud7BGLytgQenaWmN2Y9n9bDKednKjAyM5gX0pt5omodk9cUoNasEt
	 qNxW3Y+4Lu/jmzh69HgjeYCgWx04Bp7HsulTZ7aU=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:08:41 +0300
Message-ID: <1b1c7be1-0af8-4a2b-a37f-9eedf45cbf1a@paragon-software.com>
Date: Mon, 29 Jan 2024 11:08:41 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/5] fs/ntfs3: Correct function is_rst_area_valid
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fslog.c | 14 ++++++++------
  1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 7dbb000fc691..855519713bf7 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -465,7 +465,7 @@ static inline bool is_rst_area_valid(const struct 
RESTART_HDR *rhdr)
  {
      const struct RESTART_AREA *ra;
      u16 cl, fl, ul;
-    u32 off, l_size, file_dat_bits, file_size_round;
+    u32 off, l_size, seq_bits;
      u16 ro = le16_to_cpu(rhdr->ra_off);
      u32 sys_page = le32_to_cpu(rhdr->sys_page_size);

@@ -511,13 +511,15 @@ static inline bool is_rst_area_valid(const struct 
RESTART_HDR *rhdr)
      /* Make sure the sequence number bits match the log file size. */
      l_size = le64_to_cpu(ra->l_size);

-    file_dat_bits = sizeof(u64) * 8 - le32_to_cpu(ra->seq_num_bits);
-    file_size_round = 1u << (file_dat_bits + 3);
-    if (file_size_round != l_size &&
-        (file_size_round < l_size || (file_size_round / 2) > l_size)) {
-        return false;
+    seq_bits = sizeof(u64) * 8 + 3;
+    while (l_size) {
+        l_size >>= 1;
+        seq_bits -= 1;
      }

+    if (seq_bits != ra->seq_num_bits)
+        return false;
+
      /* The log page data offset and record header length must be 
quad-aligned. */
      if (!IS_ALIGNED(le16_to_cpu(ra->data_off), 8) ||
          !IS_ALIGNED(le16_to_cpu(ra->rec_hdr_len), 8))
-- 
2.34.1


