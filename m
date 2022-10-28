Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10A16118F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiJ1RKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiJ1RJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:09:53 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0C23AB70;
        Fri, 28 Oct 2022 10:07:24 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 470E5218D;
        Fri, 28 Oct 2022 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976683;
        bh=U5rbfGUDH6ccvvDNl8615tsqE6RiTSqFhdpj1nt8ic0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=hwSGfoen1bMnhsSlVk8x6dEwrUSpuNPsLhvXJnARtw5MNCA1r1KWx5dao/d9v3eoK
         3Vu0+WppGF6nw8xAtqoIFmKwUeTp4O6J0hWqj4kSYi6HnXd+awtcyeNNgCn3tlbZKA
         1t3QcY0SwItky4YG4Lokvq28mmbaDSV/EgRIpuxc=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 43FAADD;
        Fri, 28 Oct 2022 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976842;
        bh=U5rbfGUDH6ccvvDNl8615tsqE6RiTSqFhdpj1nt8ic0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=YE23VZEzseXPeW66Goh/t49OwxklhqLY0j5wtbGtZJlmHCCVtuQILU9sJbZDgZGhe
         V/SolDCexSsbF+eOmm2OHKN394ShVLf+z5SdQP1IImgkDMogC/9hLKgi6dk6LjIZ2F
         hkSWbWe2tNdvhcDZnm+36N8X+jIZs0VEiOD0EAyM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:07:21 +0300
Message-ID: <ffaff797-0424-5aef-6ad7-d7e999f83198@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:07:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 12/14] fs/ntfs3: Fix wrong if in hdr_first_de
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to check used bytes instead of total.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/ntfs.h | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9f764bf4ed0a..86ea1826d099 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -714,12 +714,13 @@ static inline struct NTFS_DE *hdr_first_de(const struct INDEX_HDR *hdr)
  {
  	u32 de_off = le32_to_cpu(hdr->de_off);
  	u32 used = le32_to_cpu(hdr->used);
-	struct NTFS_DE *e = Add2Ptr(hdr, de_off);
+	struct NTFS_DE *e;
  	u16 esize;
  
-	if (de_off >= used || de_off >= le32_to_cpu(hdr->total))
+	if (de_off >= used || de_off + sizeof(struct NTFS_DE) > used )
  		return NULL;
  
+	e = Add2Ptr(hdr, de_off);
  	esize = le16_to_cpu(e->size);
  	if (esize < sizeof(struct NTFS_DE) || de_off + esize > used)
  		return NULL;
-- 
2.37.0


