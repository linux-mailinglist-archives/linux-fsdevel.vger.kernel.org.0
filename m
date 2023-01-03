Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E441865BE5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjACKpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 05:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbjACKoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:44:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC729592
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jan 2023 02:44:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8283855F;
        Tue,  3 Jan 2023 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672742676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6PZfa14X74RoBzPDavN3w+TqisCcRb26GNpQu8tmi2Q=;
        b=gCXyyFYkEoq1GsRkAjsn3sDVIoAvtNvtmfZTofBUyUF1K0eoNhGKz2Nj/zi49dwo6kZDRx
        mfQAwfonX77SW/a7XryJ56GkXb2mmLDxbi3koVYCCI5Ok+jKD3UMXhyPJVJhoBM/R7Cr4L
        tOxsdJSNoW4R6HutJE3GHXNsGEAAkoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672742676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6PZfa14X74RoBzPDavN3w+TqisCcRb26GNpQu8tmi2Q=;
        b=TYCs55YaqD0hcrSch8xT2NtH4DSsUbF/pEH8Nu7nm1CSXTsaM1GIo8bTaCHLj/Bte2tfV4
        fQrbhMx9TTMQeiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DED91390C;
        Tue,  3 Jan 2023 10:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z4rRGhQHtGMdTAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Jan 2023 10:44:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC38CA0742; Tue,  3 Jan 2023 11:44:35 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: don't allocate blocks beyond EOF from __mpage_writepage
Date:   Tue,  3 Jan 2023 11:44:30 +0100
Message-Id: <20230103104430.27749-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=jack@suse.cz; h=from:subject; bh=v/6sM6EENHzqzWQReoWn9B5pKtwhLRZbJueMePY1O1I=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjtAcN8ap40RQH5vExQOW0af6TRCqMWSOJQ3XEcP2g XmJw7uWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY7QHDQAKCRCcnaoHP2RA2dFLCA DIuUQDyK5U3UFStsY5eCo06MH22cqChk7P/rZ4B/rMLKfnWgpBJS7WwNt6rlm/tx4q2mKWQUs0PWCG p4+5uun7k2aPrWBxbAHpzYf+7IUvd+0SIHKTYMw/YDdxzJbxwd7V0y+b/hm0u/Y4w8G99meMQbTbhm FkYagCCLbqYCO6IlLj+87MQwkjRr2LnMQafgxLS1bbjJdHWdEa2Wu0XRhaRKkw0cwoj7cx0r9IaADt zuJWy38uobNp5WuY7oXt0I+Q0G08jYPC9ELuAVDtx9QuZj1AvLD+xxDz2LfMXUDk2o+EIMGSAki6ce hRp247m+bqTuGOGJ0FU3zzpKCuAKYv
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

When __mpage_writepage() is called for a page beyond EOF, it will go and
allocate all blocks underlying the page. This is not only unnecessary
but this way blocks can get leaked (e.g. if a page beyond EOF is marked
dirty but in the end write fails and i_size is not extended).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mpage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0f8ae954a579..9f040c1d5912 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -524,6 +524,12 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
+	/*
+	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
+	 * space.
+	 */
+	if (block_in_file >= (i_size + (1 << blkbits) - 1) >> blkbits)
+		goto page_is_mapped;
 	last_block = (i_size - 1) >> blkbits;
 	map_bh.b_page = page;
 	for (page_block = 0; page_block < blocks_per_page; ) {
-- 
2.35.3

