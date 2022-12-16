Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EB64EDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiLPP12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLPP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61259654DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 338F9343E7;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWqDPOp0TslfJoEoQTnx0fpfTCQ6z7r275A9JmzPrHM=;
        b=e2fH/VLW31eiKjbIbcpKd1CqdvCTZJVb7eDSZtI8I2RDm6a0ZdIsh5XhiI2Z2KeXekDY/v
        0EdebxiKxo56eVW/oOMKHjGiTH9UL+/OwszWrTL9zVPuy3HrBrLp3fUuGDEFa9iFVgeqON
        HlJ/knr/+uLLiIjZYImmVwmTLr01iTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWqDPOp0TslfJoEoQTnx0fpfTCQ6z7r275A9JmzPrHM=;
        b=wWc+DnyjW7bhp2O1H4rseecZViDYpwY9LcKrB+erl+SHhulpgDjG/oFIL5bvGq0hrHrCj7
        QQMWSG9X+YzyIWBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1264B13904;
        Fri, 16 Dec 2022 15:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xip8BEeOnGPyCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CDEAAA0775; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 16/20] udf: Convert udf_link() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:20 +0100
Message-Id: <20221216152656.6236-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=jack@suse.cz; h=from:subject; bh=rXVrA0+jvApOnIJJb9ZTUXGfEd4eQk7Ev8cI4UsIFcE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2kHxhWI8UEEhir0tv3SVF3AA+/uF5X+MS/JMC/ yKptWsyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNpAAKCRCcnaoHP2RA2U2tB/ 9Xy6x2acsU1Cdp6XyCoQAihC578A6nDrKck0gvBbdYzbVi32DJyn9ABKz9Er1sQ5AmgSb54zC9TElt cWR1VJiVR13da/btc5/fziDjNvQNDv8V8tXp2fANSBfH76A7+Z+3KQdUQ7xHhnfd+E9ep/kb0DYYnR VeyBPX6LEA9xRN1R4aI3RzahcEH51lEkPIDxABtKLVyB8iqhek6sq56CSZuw/1dIKcy6ijy/B2LHWJ 4i8POSQuYIxHr296QQ1F4zYCnsfxLkJfT9FvZ6GRzoR+oNqcwShYlSinDWpLwIk1uqzZxd2TgplLew jutFDfQ6d8GirSMD/UlQy13HM+pdOq
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

Convert udf_link() to use new directory iteration code for adding entry
into the directory.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 6973f9956d32..7871f7763a9b 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1218,27 +1218,21 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err)
 		return err;
-	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
 	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+		*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 			cpu_to_le32(lvid_get_unique_id(inode->i_sb));
 	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
 	inc_nlink(inode);
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
-- 
2.35.3

