Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F21653E20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiLVKQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiLVKQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01D656A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A31E450A;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsty5jhjCjY1hQnFIQVKu4GMgQFq8mfuqTz0AWhEuhM=;
        b=AKo2kdSwAnoBI/ycyXlRfXWxELXW7tWQnDDElnHEJnpa2fRoHKnc0G7ylnHcW+8PgEnh27
        lqOV0BT7FYCaRBLpNML4PjEgRAuHmsHLH3F8FPHmM9uPJ4NPejB2ii8Oh5bSt9NsAfcoPA
        +esK6wuf8PHjUS608xeC4o/qBWK/qvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsty5jhjCjY1hQnFIQVKu4GMgQFq8mfuqTz0AWhEuhM=;
        b=dTJ/O6peN5oeuVgdI4CqIcZjjB9PEZqqu5BqOdkIuHoVS/HW7WjyfBU9hvGeDE/nPcw3TR
        2O0RJ2qnSYf7sYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19DB913919;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kYBJBnAupGM7WwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 22B27A0742; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] udf: Move setting of i_lenExtents into udf_do_extend_file()
Date:   Thu, 22 Dec 2022 11:16:02 +0100
Message-Id: <20221222101612.18814-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=jack@suse.cz; h=from:subject; bh=xyoN7AngrBdg2o4OYF4YB/kbkvIdNNJU9naNQV32cso=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5iaFxznBF1Fhc7j198rjTuKbouaYKaMpbXBeTt l/+/gbSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuYgAKCRCcnaoHP2RA2abJCA CmikLnKio4gB196NJ2DfY3XaaNFhczNtiFQOcpLLTae+jF84S92mD/YnDPj/H3V3GKrZq21AHo/bz2 48Rb43BfkAxpA/9WXirwpZ0gswM8zdzm3Tu6wV0WUrWFQ/WensGSmSqg26lpKIkPf6Ed+c8Qn69i+4 M2RX17WBx+DYctyKPRhWAPPxh8+fsXBpix6/3c+YrkfrVZIvEhqEEZt1F4er0dhiKEqJdt3AszeeQW tECQMu+A+HnS1GLb/T5nmohIEji1uDPjkH+mQsTV16b5bAd9k3rTvTYPk+KFQi5YVx0ub3i/RTZP4L 3bkRZGPTNqvE4pNFXTCy7oGG3d9+wE
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

When expanding file for a write into a hole, we were not updating total
length of inode's extents properly. Move the update of i_lenExtents into
udf_do_extend_file() so that both expanding of file by truncate and
expanding of file by writing beyond EOF properly update the length of
extents. As a bonus, we also correctly update the length of extents when
only part of extents can be written.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 15b3e529854b..fe5b0ba600fa 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -419,6 +419,7 @@ static int udf_do_extend_file(struct inode *inode,
 			~(sb->s_blocksize - 1);
 	}
 
+	add = 0;
 	/* Can we merge with the previous extent? */
 	if ((last_ext->extLength & UDF_EXTENT_FLAG_MASK) ==
 					EXT_NOT_RECORDED_NOT_ALLOCATED) {
@@ -451,6 +452,7 @@ static int udf_do_extend_file(struct inode *inode,
 		if (new_block_bytes)
 			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
 	}
+	iinfo->i_lenExtents += add;
 
 	/* Managed to do everything necessary? */
 	if (!new_block_bytes)
@@ -469,6 +471,7 @@ static int udf_do_extend_file(struct inode *inode,
 				   last_ext->extLength, 1);
 		if (err)
 			goto out_err;
+		iinfo->i_lenExtents += add;
 		count++;
 	}
 	if (new_block_bytes) {
@@ -478,6 +481,7 @@ static int udf_do_extend_file(struct inode *inode,
 				   last_ext->extLength, 1);
 		if (err)
 			goto out_err;
+		iinfo->i_lenExtents += new_block_bytes;
 		count++;
 	}
 
@@ -585,7 +589,6 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	if (err < 0)
 		goto out;
 	err = 0;
-	iinfo->i_lenExtents = newsize;
 out:
 	brelse(epos.bh);
 	return err;
-- 
2.35.3

