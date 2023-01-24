Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3F679797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjAXMSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjAXMSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3513E44BCB
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 746711FE4E;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZVUeTNLEEUx0443mgR5K2SttDqpFw0ZKjkku6TP0Wo=;
        b=FTU7W/NPycRyOqmbgumlwFRN/Iye3TaSmEULaPd4eVJv0VNy00WkBIwwdYO//b39uO7pqK
        XZUWphe+5rAZBWgG4mvR3+3ezB6DuVloqbOtLp/R0ZZMySKSGsVuFZ0rItxbmhFvLYRYpv
        RkIGu+ziCZ8vk6cIeAun4Z2XLoKgJIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZVUeTNLEEUx0443mgR5K2SttDqpFw0ZKjkku6TP0Wo=;
        b=nAOC7Yev8SVK14RHjieC8R1SYMfMttds0axM0RR4IcvcYy5QJh/CbrpeviD313X07t2xLj
        grdXdOH4xXNscfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68567139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IGB4GYfMz2P6NwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E528A06FD; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 16/22] udf: Push i_data_sem locking into udf_extend_file()
Date:   Tue, 24 Jan 2023 13:18:02 +0100
Message-Id: <20230124121814.25951-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=jack@suse.cz; h=from:subject; bh=YKApF8RYDN9TvkwYm3OzvSY4/kL0/650RvrVTrDWQvw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x6LI9JOYK2v0mUqcAJQMh2kou2Tw7VrgmDtWo+ 499fQBSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MegAKCRCcnaoHP2RA2UIuB/ 9JXVL9CfLKy6knsB5sB5yyn6jbzueomUsmTURyofmPbX3AtI5+EtmDt19L7JbUUWUfk589Emr2sbvp JTXsA05HjVeRFedf3HdrxvR01RaDQzTHGyi2/DXBBIldOgRv9M5UjhfnJG0ILH7d2RK+KArgyfMS/U 3pByj6NfFuxuVq16ZutBE3CGkOT937kOA8BDQYP0lpRRqMFnh6DO/sFZUacFMjeDpnNGqFx7M2UI5/ FuxwGUPSvXX43L4RCD7RQrlGYFref4UnYOWpHX/sM/B1NQekiYITSAWHMy4H9sp6N2iktYC5YMM6Bm Z0gOC9qQOrIvOR8dU3AnIvVnT0T6ar
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Push i_data_sem locking into udf_extend_file(). It somewhat simplifies
the code around it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index b13c35335dd1..3ffeb5651689 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -555,6 +555,7 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	else
 		BUG();
 
+	down_write(&iinfo->i_data_sem);
 	/*
 	 * When creating hole in file, just don't bother with preserving
 	 * preallocation. It likely won't be very useful anyway.
@@ -599,6 +600,7 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	err = 0;
 out:
 	brelse(epos.bh);
+	up_write(&iinfo->i_data_sem);
 	return err;
 }
 
@@ -1160,20 +1162,17 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 			    (udf_file_entry_alloc_offset(inode) + newsize)) {
 				down_write(&iinfo->i_data_sem);
 				iinfo->i_lenAlloc = newsize;
+				up_write(&iinfo->i_data_sem);
 				goto set_size;
 			}
 			err = udf_expand_file_adinicb(inode);
 			if (err)
 				return err;
 		}
-		down_write(&iinfo->i_data_sem);
 		err = udf_extend_file(inode, newsize);
-		if (err) {
-			up_write(&iinfo->i_data_sem);
+		if (err)
 			return err;
-		}
 set_size:
-		up_write(&iinfo->i_data_sem);
 		truncate_setsize(inode, newsize);
 	} else {
 		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-- 
2.35.3

