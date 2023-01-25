Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83367AE53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjAYJmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjAYJmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FED2716
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BDF921C86;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntIqIWP+u7LqYWu9VpJ1s00Imo/AG1DtfaRXmHaXZz4=;
        b=LabvqNLeuYFvY37m5rl2zhrkTDHa0cPn0pikJevYt+Sh4zrxNgDP0e9RR49GfF0FUiAiCL
        Gv3EihgJ52YAEJU+WRY0Qv2d0apnWjhY2DvM2KDcYRwlSz7V9hJY7IOma4P2fZ4dDhFf0n
        t+r/fTt+lk23livRSrTAkbRNPg/sRaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntIqIWP+u7LqYWu9VpJ1s00Imo/AG1DtfaRXmHaXZz4=;
        b=H59AhP3dUp/I1ffiXrFH/nexErXUW+B1J3JhX4QZ2MQNcOnbvZlCk5gxGaJDGcaPwgV5f3
        nfKC1BZL2ePmLsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC1D1358F;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/6TDmn50GMqIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 734E2A06D7; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/12] udf: Switch udf_adinicb_readpage() to kmap_local_page()
Date:   Wed, 25 Jan 2023 10:41:52 +0100
Message-Id: <20230125094159.10877-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=jack@suse.cz; h=from:subject; bh=HY/6cWAzv/GdBpBJvLctrA1mkb/5yrEe4/zrDB/jyRE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0Plf9uOOJ5oY2zfwiZlrHfOeQeyClOD19y7BcLV3 p3GLqGOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5XwAKCRCcnaoHP2RA2eRlB/ 9KnY+WDrnOryrvViOFRoNdauhxKXuBOf17xYegRZt4UnzK04HSL/N/IXas+ejADIR5fMC5NcOss02S e/FWhH8q/hKcnUIM8gSLs2Pvz2r2XkA+Zm+bRut3sEsFlxAfiV9nUN/yzAtFEp6qqqW/kK+gb7GUT0 aYTlp8TDw3nvxP6tWAl8N+y/LGSDNggAPxrLewOmuigFOmeJE4+5kSp24wSIBAvkS2xyEYQVsT/Qd/ tqjvyI9GdH2PiQu+rafvtGzMtB8XGr48xbRCw5af7rQ3zY/xOa6bJOE1zmSh+Nuk/FZVuQWtKcrfU5 uyTZbT5MkY8FOSWYa46jBhfG2uWEye
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

Instead of using kmap_atomic() use kmap_local_page() in
udf_adinicb_readpage().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index dc59b119d9ac..7e3aca596bcf 100644
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

