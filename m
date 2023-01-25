Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F367AE52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjAYJmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjAYJmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBC3EC48
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 739771FED6;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXDtyCUNu5VoYwlS7xsHDzk4XKyktknG43RJia0BStM=;
        b=rNPWudjkbfa4dXeGjnfeQdxVYpUN+yk1O1BSzkSgjUJQs8r/+wXQVIv177xZEidY58ct2K
        4esPnoPm/VyXX0TaPAJbjAPfJQmXm0plkK2SHG1aAsqgH5Zok3FInennzNxke5C/+3x/5q
        RGK81F0WQrWs8tG4MNA18eeL5zyBuu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXDtyCUNu5VoYwlS7xsHDzk4XKyktknG43RJia0BStM=;
        b=lKj9yxk5hmtm5x82CrAQNsCptMpPE3KgbLTl+wqaptfbwPpVJexxbv9ZhXF3c62Lmh45h2
        IUWiAi5lX8l50fDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57C7513A0A;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hwUOFWn50GMwIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E0CFA06E1; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 12/12] udf: Convert udf_expand_file_adinicb() to avoid kmap_atomic()
Date:   Wed, 25 Jan 2023 10:41:54 +0100
Message-Id: <20230125094159.10877-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=jack@suse.cz; h=from:subject; bh=rA0hx6VLz0r/esxyZcHhWvmu94EpK1SGsJn5IxzPb/M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlhLYB2c3wQGjoioYt03PmJOrLrEaahb5zMLcZ5 /Q65GvKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5YQAKCRCcnaoHP2RA2VENCA CgsWjjHye7W2BwSqoPHtPH32I87/reHlv3GY0QD2SGwPuUR9kqK/nd/ipTbhT+0xUD4/s594gVtmkn TxLygKozp/56DL8mMFNFRB0xTqJldbHu4h354KNjOmMpM15KWhCAXdZYjWfLR3a4qyh1/dlO5oxONt KX/xJyuTNqdjeaH3QMz6cnPwo2lEFmgqF+xLW4YCGdUbH1Mitl6dujlNjUqa/kz3JmlVQj8XBajFVc wfHQv7xnV8GYGjJVew15SRyTwNYlo4ssPEPdco5lGVwrCrEWh0V3NFKq3lUAyJgnkwGR+a1lMFmwer Qx6EMFgf1xios9g/FYyGDbDKuvX1wP
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

Remove the last two remaining kmap_atomic() uses in UDF in
udf_expand_file_adinicb(). The first use can be actually conveniently
replaced with udf_adinicb_readpage(), the second with memcpy_to_page().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 66e491626d74..0ef2f8e5d301 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -335,7 +335,6 @@ const struct address_space_operations udf_aops = {
 int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct page *page;
-	char *kaddr;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int err;
 
@@ -357,16 +356,8 @@ int udf_expand_file_adinicb(struct inode *inode)
 	if (!page)
 		return -ENOMEM;
 
-	if (!PageUptodate(page)) {
-		kaddr = kmap_atomic(page);
-		memset(kaddr + iinfo->i_lenAlloc, 0x00,
-		       PAGE_SIZE - iinfo->i_lenAlloc);
-		memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr,
-			iinfo->i_lenAlloc);
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-		kunmap_atomic(kaddr);
-	}
+	if (!PageUptodate(page))
+		udf_adinicb_readpage(page);
 	down_write(&iinfo->i_data_sem);
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
@@ -383,9 +374,8 @@ int udf_expand_file_adinicb(struct inode *inode)
 		/* Restore everything back so that we don't lose data... */
 		lock_page(page);
 		down_write(&iinfo->i_data_sem);
-		kaddr = kmap_atomic(page);
-		memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, inode->i_size);
-		kunmap_atomic(kaddr);
+		memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
+			       inode->i_size);
 		unlock_page(page);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
-- 
2.35.3

