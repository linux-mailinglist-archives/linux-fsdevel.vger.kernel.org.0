Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4864EDDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiLPP1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLPP1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD462EA7
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F7C45D118;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za3+4oEmABIe6QRozLecwR0MZnI52ujPUK/sFQnM7/M=;
        b=DUbgb9vgBrGDHrL3uahhn8bpkJ/OjPjbYm0s2qUPomOHxW6RAmjAE2UmWAgiByp/UaDsef
        r9ykzDGUgeOpsjcqajYbdEnKvovwy9Z2IAcoo0xjzEV1rAoI2FsV+U1OcYGaWu7iujWeuu
        VoG5zCynRzzybf+oMaSSyHSQMEWx260=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za3+4oEmABIe6QRozLecwR0MZnI52ujPUK/sFQnM7/M=;
        b=gJcs2NbYXYVuIqJF+iXL4Ouvk1G+nGW/R9oiJX7PPR4EBTtTkDpUv9CcTC4YyarW7GnqX1
        6ihx39qTT/lqqPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 356131390A;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SYYIDUaOnGPWCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AEDF4A076D; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 11/20] udf: Convert udf_rmdir() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:15 +0100
Message-Id: <20221216152656.6236-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=jack@suse.cz; h=from:subject; bh=XDI1tTIaCQ3IB4Ewh4iCUFKqk+P1N3hGkp6tPs1Vm0o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2foV3W+iW/ppyqc9SuKnFwlv+zHPp1c+IGZF36 XyGwx22JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNnwAKCRCcnaoHP2RA2RMACA CYmi+FnPkhIb1c5nSdcotKHlBf5hIvCFKaEmKvvuy5gXCWrjqiYGbMF2eAQpX3YvKFiTrE0yD52oao biM79WAlOm5iefOcxJvLR9c4lq8/p5LkRK9tWqkMkN4V/lZhQZTUEqYUaUERn8k1qlKda0L85bMdrM RUBAnZ/jZb00engQhxcrnVgZ/syIRUNlj686f0SMCkUdZyNecEewo4fVSJBN3S3U9uY9+eawCr13De PKK6+oK5q90GujkIk5OOYVJKzOAi96LwbRhzT7cKgGBuh7SKS0EbBQu8sy+z5wh6FQ32eGic6mol/i 2S/FnGiqaoGvmmkguUfMT8Kg3TGERb
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

Convert udf_rmdir() to use new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index f38ed9c1b54d..703303562778 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -898,30 +898,23 @@ static int empty_dir(struct inode *dir)
 
 static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi, cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_rmdir;
-	retval = -ENOTEMPTY;
+	ret = -ENOTEMPTY;
 	if (!empty_dir(inode))
 		goto end_rmdir;
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_rmdir;
+	udf_fiiter_delete_entry(&iter);
 	if (inode->i_nlink != 2)
 		udf_warn(inode->i_sb, "empty directory has nlink != 2 (%u)\n",
 			 inode->i_nlink);
@@ -931,14 +924,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = dir->i_ctime = dir->i_mtime =
 						current_time(inode);
 	mark_inode_dirty(dir);
-
+	ret = 0;
 end_rmdir:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.35.3

