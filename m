Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB0573B89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiGMQrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiGMQrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:47:19 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD82F66F;
        Wed, 13 Jul 2022 09:47:17 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BADFE1DDC;
        Wed, 13 Jul 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730767;
        bh=LbmuPQY5mP/niQQZAD6y/cHTHk3ho0WyMWitsZ6l2sw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=TOZYl6/ThTMJz7JwIkTVUWK4o+ZWAmhYP1JAJnXGdPbQ6bdibDR9SEhPofDnWqby0
         TOthxDsEwqoRuyM4U3nDHec1dhBck3TrhEQNtgT2mg4dqKyZU4DESELlyXHhnYi3K2
         z53sS9DZocFTYcI9bN6lTjs37QgRoQr8D75tdIHQ=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:47:15 +0300
Message-ID: <1282d35f-ed0d-e020-a4e5-8700744e2c3b@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:47:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 5/6] fs/ntfs3: Create MFT zone only if length is large enough
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
In-Reply-To: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also removed uninformative print

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 11 +++--------
  1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index e6f5bf684da4..d09213ae9755 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -806,12 +806,6 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
  
  	/* Try to allocate clusters after last MFT run. */
  	zlen = wnd_find(wnd, sbi->zone_max, lcn_s, 0, &lcn_s);
-	if (!zlen) {
-		ntfs_notice(sbi->sb, "MftZone: unavailable");
-		return 0;
-	}
-
-	/* Truncate too large zone. */
  	wnd_zone_set(wnd, lcn_s, zlen);
  
  	return 0;
@@ -2473,8 +2467,9 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
  	if (zlen == zone_len) {
  		/* MFT zone already has maximum size. */
  	} else if (!zone_len) {
-		/* Create MFT zone. */
-		wnd_zone_set(wnd, lcn, zlen);
+		/* Create MFT zone only if 'zlen' is large enough. */
+		if (zlen == sbi->zone_max)
+			wnd_zone_set(wnd, lcn, zlen);
  	} else {
  		CLST zone_lcn = wnd_zone_bit(wnd);
  
-- 
2.37.0


