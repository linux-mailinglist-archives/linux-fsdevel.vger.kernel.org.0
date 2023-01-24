Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F4679786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjAXMSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39205442ED
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA8202188C;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsEyo1qnv9h4UWXO9UUhyxv8nz/caMYUDMPuiBK/Vi8=;
        b=BuUPziHiVGNmvNU7fgpMa3DVLNStubmm7+fUg/ckreHhMFpEnEWuHKDMb3aWRfi0ZSEvXn
        QvtNRrT0oFRtcOd2NYe1NcWnpE9ecgRYrlHBAv4htv9Ery58oIyjRtRbjsB0H3LPzsf5HI
        pmK333VdGLEml+Vr8ulsfap8TeYz1kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsEyo1qnv9h4UWXO9UUhyxv8nz/caMYUDMPuiBK/Vi8=;
        b=LOHFshjAT6By0enDc2VG1KsAmunpySh3nWXdSLuAh5FWnab4P7xMIKYJrI+Mhd0XbyytcG
        9Ltp0vQ50031MWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC2E5139FF;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ve9NYbMz2PcNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23249A06D1; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 06/22] udf: Use udf_bread() in udf_load_vat()
Date:   Tue, 24 Jan 2023 13:17:52 +0100
Message-Id: <20230124121814.25951-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=jack@suse.cz; h=from:subject; bh=n6xJxrlYEz8GHt8c6ZVR7iV2PHp3WFV1VftbBpZofNc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xxcF2x49xaajEXOl8aFdc/GG40QQLuw8vE6s9K kVIqEu2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/McQAKCRCcnaoHP2RA2S5DB/ kBFHtDanT2x1kINsF2cMNWrWrWywBvcLZS7XdDMoCucHFQmyKfTH8WOLM4zjl7A6giTAiGzTXqKan2 qJLjoJUlkjOKV/0H7oAyriKbcS8FUIoy49tb0a2MkQtL5hqccCbNz9dXv+aKvn0RxCumueYPNreBWX NH9ZSZRMFpzAjMGxry0CsHfHoGaxkiB7hIvHcl0d3rOYep+NJOAaTIsfNKhBZLF2yVus8Fzn31SAzo qFoV7Tf0dvT8RaX1ciuWTpMuVMB2tD6NTkgifT/pUAKO+nb7tamfCfwFyLYzzJoZmIA9gvPWAU5fPZ pWIIyyRchpXS9hlVf+FhFD7hDQ/iBh
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

Use udf_bread() instead of mapping and loadign buffer head manually in
udf_load_vat().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 58a3148173ac..df5287c5d659 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1176,7 +1176,6 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 	struct udf_part_map *map = &sbi->s_partmaps[p_index];
 	struct buffer_head *bh = NULL;
 	struct udf_inode_info *vati;
-	uint32_t pos;
 	struct virtualAllocationTable20 *vat20;
 	sector_t blocks = sb_bdev_nr_blocks(sb);
 
@@ -1198,10 +1197,14 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
 		vati = UDF_I(sbi->s_vat_inode);
 		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-			pos = udf_block_map(sbi->s_vat_inode, 0);
-			bh = sb_bread(sb, pos);
-			if (!bh)
-				return -EIO;
+			int err = 0;
+
+			bh = udf_bread(sbi->s_vat_inode, 0, 0, &err);
+			if (!bh) {
+				if (!err)
+					err = -EFSCORRUPTED;
+				return err;
+			}
 			vat20 = (struct virtualAllocationTable20 *)bh->b_data;
 		} else {
 			vat20 = (struct virtualAllocationTable20 *)
-- 
2.35.3

