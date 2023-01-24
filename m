Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4116679746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjAXMGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjAXMGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639FE2330C
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 064F721875;
        Tue, 24 Jan 2023 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+h/2r0MBY6/nWcqg4A6fS6cmUGg6a993gy6cT2d0wc=;
        b=cBc4ftfEvIUDLr/1Fkcj2CH8wexd+bZhEpsmlTAstsSosIuAtmKIGrjQO/i5PJgYxujbnZ
        H9x2JQjAb35mSz5V+PmZ7A6FrKbnVRs/4kqGuZ9LzjSkvpk37AM4QE69mZ5jJyKcc6+5US
        +72PYV0WRGWcybFrbJE3dM1HASXXCoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+h/2r0MBY6/nWcqg4A6fS6cmUGg6a993gy6cT2d0wc=;
        b=6nTjKBxq/Se9heEHttJaxEY9/f1JITZcxrD5w9JC7pG4z6CmV7Xk/4Ig30KSu+CWA1pB42
        9fmW/vXsOc1jsbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDA09139FF;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pq7/OcfJz2MSMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 588C0A06D5; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/10] udf: Switch udf_adinicb_readpage() to kmap_local_page()
Date:   Tue, 24 Jan 2023 13:06:21 +0100
Message-Id: <20230124120628.24449-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=jack@suse.cz; h=from:subject; bh=pDb9KRYtDEV08u1/RrB4YmM3BhqEkGDJ3enLU3mrb6w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m85ajbUgngXWNvxIdI270EfDosY1P4zi/39DtM mwEAqFmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JvAAKCRCcnaoHP2RA2WlwCA DNf4pzzwU28gcHVf+fEWZ19asS5EBsJ3hCPqXYdpEU40Kf+eRzGvvko+TYLmhI/apT1FD71y3sRSkh sM1NDDH1YjRVjbEBIDF2wFz4uloIC/3C8hEn1BhCn5nU7PNgN9SGDn80ENBy764ZGxBcD2KOZbbOW7 YPqXN4JaCEMYctPJ7KJk1Cc7zYa5eXjrrWwS83NnrgZyoOBLWa4GHzExN/JcHgFl4R1vTJ6fJDQaXF /H5oDunabW5lyp56yXA4GIqeCGZvF/NYy+7qhKdey8eGSriZ9LHdFnmJR4dqQ7t8lEMTKa0MECwVZJ zFvJaYEgDZFsOxZDiTY6XIlfru9j+8
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

Instead of using kmap_atomic() use kmap_local_page() in
udf_adinicb_readpage().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index dcd3f1dac227..5ae29f89869b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -222,12 +222,12 @@ static void udf_adinicb_readpage(struct page *page)
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	loff_t isize = i_size_read(inode);
 
-	kaddr = kmap_atomic(page);
+	kaddr = kmap_local_page(page);
 	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
 	memset(kaddr + isize, 0, PAGE_SIZE - isize);
 	flush_dcache_page(page);
 	SetPageUptodate(page);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 static int udf_read_folio(struct file *file, struct folio *folio)
-- 
2.35.3

