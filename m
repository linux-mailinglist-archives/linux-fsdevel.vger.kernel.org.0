Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F5679785
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjAXMST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E23525E
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 777081FE1C;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRI4qWEv0uFDa3q6P9RZRAilZAK3cVMS+OYZbEt17mg=;
        b=lAAZaW/nzU1h4hJ38awEwy0UO1/Mw6IGXo7EivqBbgjFcTtOSCBDM77U6pT1GuQajEUWF7
        spwNEu5lHVCakzahomYNkKKPDJgx6ly0M95H1jA4j3zOPlmQ9NnniFgMsFAuoujoz/bqsy
        n0sBegeMXb/TKKDKu1TS69eEfRy7JU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRI4qWEv0uFDa3q6P9RZRAilZAK3cVMS+OYZbEt17mg=;
        b=0kSrJCUgmEMyL+slFj15pqCSciW5ZpVUf5LjSkJzuNZ8rP6ncK1EFfAhPb6SrQ8y842VeP
        n0uLDL58wYJQdWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E6C139FB;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FyfgGIbMz2PINwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07E59A06B6; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 01/22] udf: Unify types in anchor block detection
Date:   Tue, 24 Jan 2023 13:17:47 +0100
Message-Id: <20230124121814.25951-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; i=jack@suse.cz; h=from:subject; bh=bE8hHAl123golhXRKX5pttpZsk9gLScyiYZp9PnIOkg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xtxW4zE1ierehLJXHdRbE6z36DcBOnDA9ThX3F u3RJr/yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MbQAKCRCcnaoHP2RA2fi2CA DUFfS71rbZkj2p741h4tYv01C0QywkhQEMFRVG4+uSt60++yNcRJFEIQATTSZI48AbyelNnuhTuL9j kJRymu5OsDdRa+zHzuo0yeUspFlAq6P+hesLa/bwLjmbBdsaQJneCqyAPe4G4IXJtiO8jDQKBXCK0M lnnZFdcOYhLEPX2leydy1Tie7/Ewo0Ee7iTLOCFZfBUCl7BxQ/9GM9us2WxL9gBgiB+uiKnvEhG6QW d06GcBUAjW/O84/MC0qNzQytgXfX6dR5SzzGBAdsBLR7fW/u2YkuT3kaKgNheJD5/rwCnHzYzbfwoc YIz4iAG6UEw4mm3Gx56A4arb+CLK0f
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When detecting last recorded block and from it derived anchor block
position, we were mixing unsigned long, u32, and sector_t types. Since
udf supports only 32-bit block numbers this is harmless but sometimes
makes things awkward. Convert everything to udf_pblk_t and also handle
the situation when block device size would not fit into udf_pblk_t.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/lowlevel.c | 7 +++++--
 fs/udf/super.c    | 4 ++--
 fs/udf/udfdecl.h  | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index 46d697172197..c87ed942d076 100644
--- a/fs/udf/lowlevel.c
+++ b/fs/udf/lowlevel.c
@@ -45,7 +45,7 @@ unsigned int udf_get_last_session(struct super_block *sb)
 	return 0;
 }
 
-unsigned long udf_get_last_block(struct super_block *sb)
+udf_pblk_t udf_get_last_block(struct super_block *sb)
 {
 	struct cdrom_device_info *cdi = disk_to_cdi(sb->s_bdev->bd_disk);
 	unsigned long lblock = 0;
@@ -54,8 +54,11 @@ unsigned long udf_get_last_block(struct super_block *sb)
 	 * The cdrom layer call failed or returned obviously bogus value?
 	 * Try using the device size...
 	 */
-	if (!cdi || cdrom_get_last_written(cdi, &lblock) || lblock == 0)
+	if (!cdi || cdrom_get_last_written(cdi, &lblock) || lblock == 0) {
+		if (sb_bdev_nr_blocks(sb) > ~(udf_pblk_t)0)
+			return 0;
 		lblock = sb_bdev_nr_blocks(sb);
+	}
 
 	if (lblock)
 		return lblock - 1;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 241b40e886b3..c756d903a862 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1861,10 +1861,10 @@ static int udf_check_anchor_block(struct super_block *sb, sector_t block,
  * Returns < 0 on error, 0 on success. -EAGAIN is special - try next set
  * of anchors.
  */
-static int udf_scan_anchors(struct super_block *sb, sector_t *lastblock,
+static int udf_scan_anchors(struct super_block *sb, udf_pblk_t *lastblock,
 			    struct kernel_lb_addr *fileset)
 {
-	sector_t last[6];
+	udf_pblk_t last[6];
 	int i;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	int last_count = 0;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d35aa42bb577..eaf9e6fd201e 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -196,7 +196,7 @@ extern void udf_new_tag(char *, uint16_t, uint16_t, uint16_t, uint32_t, int);
 
 /* lowlevel.c */
 extern unsigned int udf_get_last_session(struct super_block *);
-extern unsigned long udf_get_last_block(struct super_block *);
+udf_pblk_t udf_get_last_block(struct super_block *);
 
 /* partition.c */
 extern uint32_t udf_get_pblock(struct super_block *, uint32_t, uint16_t,
-- 
2.35.3

