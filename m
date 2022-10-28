Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130AC6118DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJ1RHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiJ1RHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:07:35 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6089916;
        Fri, 28 Oct 2022 10:05:23 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9F7C5218D;
        Fri, 28 Oct 2022 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976561;
        bh=Z1wJrT5mwfguS7h+6tsChzRtdrFWjJ5h0upJpKVRuVk=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ap6Jd6Il508YZcM9lbiU4LL2kgEi4UhNsNWfCnwz82iAyHSOTNCS15nO6A1HsqqAh
         T3UKIuf6LKcjsfIE0WH7E/wixWbAPAbeuKLxMXFtdYEqwfG93+cA/R4a11d4NWKeeX
         edS2NmHWt3Xugulc3YadJcy5AWyWed3mdVCIp+3A=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9D6C0DD;
        Fri, 28 Oct 2022 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976720;
        bh=Z1wJrT5mwfguS7h+6tsChzRtdrFWjJ5h0upJpKVRuVk=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Od8/scn9IvuypjfeFrrovmpLjKo9xf74MXtp5mvONypWGUSwprXwoK1UXw3c3YuCk
         tNECaWd3SGEm8ey2KObVffO0Hctm1mtjqsdBqa6eM0dETSKqGRVN4qratXSr1csDmZ
         pBIOvXCGCvm2j/GxjuAdWFrVr447zC7AsIjICX5o=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:05:20 +0300
Message-ID: <c097330f-1472-1011-e5a4-53183ee108da@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:05:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 08/14] fs/ntfs3: Correct ntfs_check_for_free_space
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

zlen in some cases was bigger than correct value.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index b56ffb4951cc..e5a1f4df0397 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -432,7 +432,7 @@ bool ntfs_check_for_free_space(struct ntfs_sb_info *sbi, CLST clen, CLST mlen)
  	wnd = &sbi->used.bitmap;
  	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
  	free = wnd_zeroes(wnd);
-	zlen = wnd_zone_len(wnd);
+	zlen = min_t(size_t, NTFS_MIN_MFT_ZONE, wnd_zone_len(wnd));
  	up_read(&wnd->rw_lock);
  
  	if (free < zlen + clen)
-- 
2.37.0


