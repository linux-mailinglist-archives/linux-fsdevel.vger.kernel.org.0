Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAF653E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiLVKQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiLVKQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0C6462
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 956648D589;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5N0xOwUSqyGUKgtFC52PIjPv/er7HVrcdK2etrPkTE=;
        b=Iym4y0NjtBYPwM1mc4WvFn3C7BPr/uTPMAffvuiJrWX8Ys/bytn+1R/b74b3BkKLD2orEY
        YbBB44gKEXD4E6i93Bf/wGOGFPiujzVf8oYDKVRVvD16eH5t70UWSaHhqB+WM4U6DIP+4l
        5UP6aCFkXBedd2at8Qngm8dsoLJfPZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5N0xOwUSqyGUKgtFC52PIjPv/er7HVrcdK2etrPkTE=;
        b=0QzNDiYw6KUtqFKbbBsL2cUmq2n4h7MIIu636+jwmXlhCcapwe9Tz3/ZzteKREIoogL5Nk
        Bhg9jVclFB+DRiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E8C91391C;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QUP5Gm4upGMxWwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0AF24A071C; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] udf: Handle error when expanding directory
Date:   Thu, 22 Dec 2022 11:15:58 +0100
Message-Id: <20221222101612.18814-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=jack@suse.cz; h=from:subject; bh=nj1dyUcvok/3ME6MbG+EF2pgGQY+QqHMVUhP5hAJirI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5eON9WLES5geU3IrZaitEZo9i+FRuTSB4yA9B/ zz7m/LaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuXgAKCRCcnaoHP2RA2a9MB/ 0RNNhEb9iMGTWmz1X+lNWYn4jWl4c8jlfWM7xNJbXX3DXAJuJl4Fbl7Id5fLvmJXfiU2+JIo8he041 fhYBuA9n1k8KJVQTUgAOOFQMb/roSHbNgoWRNb/BejHWo/dBhh35m76Kq5MjUvIC8nSpSfUpSGko/o FIY7+DHycSS0oQWidXI7ZYK6e/02MexZxboLSgtBBknz+JOBCM/jA3kD0lHyDKYUVtAYQZ74tnCnz6 Eb4bNjlsqZ2E9IEAjnupVsFt14pRqLKGljv/zpKHtcsOOqbrEv+cxS+X2QUkb3yPZV+8G4C6Qqn0wf RJWfirIvS7X/P3CEX6bgzwM/+Mtzsl
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

When there is an error when adding extent to the directory to expand it,
make sure to propagate the error up properly. This is not expected to
happen currently but let's make the code more futureproof.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 800271b00f84..de169feacce9 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -192,8 +192,13 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	epos.bh = NULL;
 	epos.block = iinfo->i_location;
 	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	ret = udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
 	brelse(epos.bh);
+	if (ret < 0) {
+		*err = ret;
+		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
+		return NULL;
+	}
 	mark_inode_dirty(inode);
 
 	/* Now fixup tags in moved directory entries */
-- 
2.35.3

