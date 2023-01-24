Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A567973E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjAXMGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95242333A
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 999B62186F;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAHsfO1gYoBTfHFesFHiNYZ3kre+lrECI+1qGMOWBHM=;
        b=e68FUPzYnb+AxA2dL0clX/nnuVAp+MCiPqiIeuOB+g5ENH05H92VOaW11pPWglb8gWs3iM
        Jr3iSsOB8ycyg98eVF28dZlEU9df3huxzPA8OAp1cAO7VyNa6mr2WjXzWozCDRsjhshJ4x
        UJaDCMM1Kp1A6b+TVtoSmAv6Iej8JIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAHsfO1gYoBTfHFesFHiNYZ3kre+lrECI+1qGMOWBHM=;
        b=e9z6tJkNgkgt7dOfq2Ob0HeJxcS9hpgCA0Rz0b4vaAsZLGKiqwpPhiW5snx7SiiSP3+65e
        wByxx+tjv4hWjxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A819139FB;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gjCEIcfJz2MBMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2D693A06B9; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/10] udf: Convert in-ICB files to use udf_direct_IO()
Date:   Tue, 24 Jan 2023 13:06:14 +0100
Message-Id: <20230124120628.24449-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=jack@suse.cz; h=from:subject; bh=/f6STiVQgXZ4Dt84TDbNEkU4dxgsNG3+TkjM5fQLNso=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m2rqrcEMQTobRuwAM64+dQk7GN2KNp2KUApZDg zam3h/mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JtgAKCRCcnaoHP2RA2QX5CA Ccyxb5bFpCn87BlFCTDpzT6sz30DQx2CSI188uHtf6oXfOKrix36k6hoyS0BgByMrlhedKo8l4LYfu 7yk/XIiW3vi4XfdbWG/XhalOVrrfu5pwNfXhIhxxIczpJPvxrVsS05gbVpWSI7ADV7dX6wRfYBKZ9n LRIEcLB7nAuofE7STvzXf3I4Fa+9e0Csj0yXf9yvh9ufcg0RV7N+d3/DAVSABLztAk/qYAZ11p3sw4 UsSD6juc1ZcVjq7uaxE6rXWvJV+QndEnPvkqQceXbueS9w8L9oF0TM57GZiNWwqkH6DxMN3uDju+kd 56goDGmy4fYvJIK9JYjgKX6wJUmZPU
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

Switching address_space_operations while a file is used is difficult to
do in a race-free way. To be able to use single address_space_operations
in UDF, make in-ICB files use udf_direct_IO().

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
index 54e6127ebf55..52016c942f68 100644
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

