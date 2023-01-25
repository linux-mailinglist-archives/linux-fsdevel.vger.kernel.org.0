Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C667AE51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjAYJmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjAYJmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19433EC46
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 705B81FEDA;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqD9uKDnI3HPWvas6RtM9zNOgMIU0VQV5ATdQusFkWI=;
        b=1O9y8xOHNS6hvR6DKaOh/3qJahXJNZF8ndtjDMGkfgD3XuK3+hbNLWnxiULYEse00+Cl3x
        IF0pYli0PYOxifpOcgdgjySw4ExrP4l/dw0WCqPOXS2/s403hoQ11t6RXg2DA9k9KCF9ro
        NQVkEdMnIwHDoN+M24bKPQ/j2O9jhjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqD9uKDnI3HPWvas6RtM9zNOgMIU0VQV5ATdQusFkWI=;
        b=p6SO1a/jnjghWvNWEJgDhj8L88/7s481Hd80tKNslX+Rv2mf/VbwMbCCCx8SLRJ4B2TK0e
        AHH1OPN94NQfgsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AEAC13A0F;
        Wed, 25 Jan 2023 09:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IR4rFmn50GMxIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 782C0A06D8; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 11/12] udf: Convert udf_adinicb_writepage() to memcpy_to_page()
Date:   Wed, 25 Jan 2023 10:41:53 +0100
Message-Id: <20230125094159.10877-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=jack@suse.cz; h=from:subject; bh=dhFeQH5IiopDQxnKUKJGGcbwk9AWq9rK5bsPaj/RUos=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlgMQ7Wy6ITz+YbzVzICd0WNE8+cUmgLHB48E/N R3c8SdWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5YAAKCRCcnaoHP2RA2WqGB/ 9j5XinJ2NN4JJYGmsniVbnkci/wNgc7809A4TrTdmtNRv+22JusundJiLyWaIDVKUEL3mzkDjjQl0k 3Ew4BhdtLNB1t8m4GdHfkp9jWGHZu54ox3iITkw8qLePQ+JoeGCcUiOphZW8h9fXwF0tTkz7JPeNez woIkHUZiHlJCeU3juJBp11NrLYKhMFjkiOnstZ5h/nKmeC0BbX5fthyvO0v/PKN1ijDITyOTHraQRf SJgOjZr5qye+ltMSIBpujmAEmvSzgVTAjwiq96oOyvVjEWZsihbFbGSqi67a2/ll8yjBDFrkiU71Q+ 7Mi8LGjlTgyCLJd1y/qNH5DeB+XUtj
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

Instead of mapping the page manually with kmap() atomic, use helper
memcpy_to_page(). Also delete the pointless SetPageUptodate() call.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7e3aca596bcf..66e491626d74 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -189,16 +189,11 @@ static int udf_adinicb_writepage(struct page *page,
 				 struct writeback_control *wbc, void *data)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
 	BUG_ON(!PageLocked(page));
-
-	kaddr = kmap_atomic(page);
-	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
-	SetPageUptodate(page);
-	kunmap_atomic(kaddr);
-	unlock_page(page);
+	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
+		       i_size_read(inode));
 	mark_inode_dirty(inode);
 
 	return 0;
-- 
2.35.3

