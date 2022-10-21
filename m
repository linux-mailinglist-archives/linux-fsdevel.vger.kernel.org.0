Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28F607CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJUQxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJUQxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:12 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A228C31E;
        Fri, 21 Oct 2022 09:53:08 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 734F32201;
        Fri, 21 Oct 2022 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666371028;
        bh=d0P/O+Kp+C+ez1qFGFR5y9BK+bKwVlzJw6ae9PLolSM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=AYfjMIA9L2KLwAun2Hkba60Oxx3kY9AoQZHIVEE56wUtfe7sM0KRRd6pr11wUCluk
         /+7UAeTeQQX0SJWuDlDvgTuHFhYAm26ykejFtbm5eu5X5VE6eqSOwGiBKSUZIxDVcZ
         1NxDhZxhZ2AE+UcowsS6lWhn9rJxCOB5MdpByo4c=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 19:53:01 +0300
Message-ID: <118f7c57-2b66-6ac6-f2e8-f1eccff97ea5@paragon-software.com>
Date:   Fri, 21 Oct 2022 19:53:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 4/4] fs/ntfs3: Simplify ntfs_update_mftmirr function
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
In-Reply-To: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make err assignment in one place.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 4 +---
  1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 99dc2a287eab..3fe2de74eeaf 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -801,7 +801,6 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
  	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
  		return;
  
-	err = 0;
  	bytes = sbi->mft.recs_mirr << sbi->record_bits;
  	block1 = sbi->mft.lbo >> sb->s_blocksize_bits;
  	block2 = sbi->mft.lbo2 >> sb->s_blocksize_bits;
@@ -831,8 +830,7 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
  		put_bh(bh1);
  		bh1 = NULL;
  
-		if (wait)
-			err = sync_dirty_buffer(bh2);
+		err = wait ? sync_dirty_buffer(bh2) : 0;
  
  		put_bh(bh2);
  		if (err)
-- 
2.37.0


