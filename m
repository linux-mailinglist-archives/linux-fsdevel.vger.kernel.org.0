Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44B167AE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjAYJmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjAYJmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:42:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC030DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:42:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F09B21C7D;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674639720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbMzmf9G8WMjoORBLmai2ybFW7arGcn8bzeTN+8RUx8=;
        b=KbhqZZW5csiAwnxnkrFuvwIcnieHOH6OLHxw2QW41Yi+DH15nr9KMbmKhFCLp76DQnCByM
        Mkh1Ast2vk0RmMuNcGVSkiyd7tqwiZhPPFnEuR60vYXNKT0hiwIZnWwXUmTWHyzslO3ECw
        1o8ZsisP+sDMq2TPGpYmCqdU29LzcjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674639720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbMzmf9G8WMjoORBLmai2ybFW7arGcn8bzeTN+8RUx8=;
        b=EJ4fG5wj8K1r9pYubWTKSwz88HYWgzSpSPxNZ3cSewUmLXo/KcL5j61NRjNL/XIpDSip+0
        GKn2kn5G5kphcoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05FED1358F;
        Wed, 25 Jan 2023 09:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KttAWj50GMNIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:42:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4A11EA06C5; Wed, 25 Jan 2023 10:41:59 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/12] udf: Convert in-ICB files to use udf_direct_IO()
Date:   Wed, 25 Jan 2023 10:41:45 +0100
Message-Id: <20230125094159.10877-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125093914.24627-1-jack@suse.cz>
References: <20230125093914.24627-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=jack@suse.cz; h=from:subject; bh=OpupSpv5nOqZ+Mai/BiVUoRv28As2Dk8TvM4mIs7FIQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj0PlZLGiELpNTMVeLOuGBK2HrAXX+zSb6DilH3NZ8 BjscdTuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY9D5WQAKCRCcnaoHP2RA2YqoB/ 9IgLA2d1exN5GkJHRSqI2mEIQsnspFPdYcUWBLh2ylpqh0Sw7YlU4OT1HlymcCgr87DR825+drj/Do FLdEbjeycpWi+8savvAhXGHmaeqRkjEbcKVBDqzq9VqF+CAZLgB4FAiDYdVEGvXe1yrV9l+rnUM1Pl z6729RynT3gk4DdMvqE7xFmYAdV2JD6A4W2Lk3aCxyf1q6N4UlQVqVfafI/1b/+usuFUYpi10g2YEu cOdo8Nppet18a1STZiuKOVTaULgomXydn+GHl3k9qdUvAk7EpG7ztHBnnWKbsjZY58ONi1cSosoloj QhbOC+XXghA0yWkJop3A+wz5Lw5lEJ
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

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make in-ICB files use udf_direct_IO().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c    | 8 +-------
 fs/udf/inode.c   | 5 ++++-
 fs/udf/udfdecl.h | 1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 7a8dbad86e41..6bab6aa7770a 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -76,12 +76,6 @@ static int udf_adinicb_write_begin(struct file *file,
 	return 0;
 }
 
-static ssize_t udf_adinicb_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	/* Fallback to buffered I/O. */
-	return 0;
-}
-
 static int udf_adinicb_write_end(struct file *file, struct address_space *mapping,
 				 loff_t pos, unsigned len, unsigned copied,
 				 struct page *page, void *fsdata)
@@ -103,7 +97,7 @@ const struct address_space_operations udf_adinicb_aops = {
 	.writepages	= udf_writepages,
 	.write_begin	= udf_adinicb_write_begin,
 	.write_end	= udf_adinicb_write_end,
-	.direct_IO	= udf_adinicb_direct_IO,
+	.direct_IO	= udf_direct_IO,
 };
 
 static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 3c6a129d1ae9..dafbc99b78a3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -243,7 +243,7 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 	return ret;
 }
 
-static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -251,6 +251,9 @@ static ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	size_t count = iov_iter_count(iter);
 	ssize_t ret;
 
+	/* Fallback to buffered IO for in-ICB files */
+	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return 0;
 	ret = blockdev_direct_IO(iocb, inode, iter, udf_get_block);
 	if (unlikely(ret < 0 && iov_iter_rw(iter) == WRITE))
 		udf_write_failed(mapping, iocb->ki_pos + count);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 48647eab26a6..a851613465c6 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -161,6 +161,7 @@ extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
 int udf_read_folio(struct file *file, struct folio *folio);
 int udf_writepages(struct address_space *mapping, struct writeback_control *wbc);
+ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
 int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
-- 
2.35.3

