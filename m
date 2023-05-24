Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7922570EE40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjEXGkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbjEXGjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:39:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D22E7C;
        Tue, 23 May 2023 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eobR5ofZ8yxLf84yh50zZqRr7gdMKJnXJJVUfhV2d0w=; b=2ZfYf4T/+f++kX0X6NMRNZXwFn
        6aJYCflJ4wEp0XLVUCdXCN0nfsQ5luRD33XEc2EqYblO0dhiYNMTUNSmJchUW/7enLAPlmHRPVTRN
        HrjFHfPzJiM/nyFHTY8ScCLT7mFVz+NtIFvc/acgUikn31hWmFmFJ4FMTJq/43ss5+MCXBqLVImmE
        A9pdpS5w9NbP2G9XPCMhi0fFgf0vvzeY/WWuMXCznPPcLFetHBcLbiKST4MtObidiE+5CIpuLwNdm
        pCu2aMfTqEU6JWZiCVS25Y7Gz/zN3AFzBMMo8MRaMCSzXHj+V3ehXBI9NdPv8q47zr966sS5g1e0P
        EcTndYAw==;
Received: from [2001:4bb8:188:23b2:cbb8:fcea:a637:5089] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1i8v-00CVjC-1x;
        Wed, 24 May 2023 06:38:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/11] fuse: update ki_pos in fuse_perform_write
Date:   Wed, 24 May 2023 08:38:09 +0200
Message-Id: <20230524063810.1595778-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524063810.1595778-1-hch@lst.de>
References: <20230524063810.1595778-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both callers of fuse_perform_write need to updated ki_pos, move it into
common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 fs/fuse/file.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 97d435874b14aa..90d587a7bdf813 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1329,7 +1329,10 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 	fuse_write_update_attr(inode, pos, res);
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
-	return res > 0 ? res : err;
+	if (!res)
+		return err;
+	iocb->ki_pos += res;
+	return res;
 }
 
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -1375,41 +1378,35 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos = iocb->ki_pos;
 		written = generic_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
 			goto out;
 
-		pos += written;
-
-		written_buffered = fuse_perform_write(iocb, mapping, from, pos);
+		written_buffered = fuse_perform_write(iocb, mapping, from,
+						      iocb->ki_pos);
 		if (written_buffered < 0) {
 			err = written_buffered;
 			goto out;
 		}
-		endbyte = pos + written_buffered - 1;
+		endbyte = iocb->ki_pos + written_buffered - 1;
 
-		err = filemap_write_and_wait_range(file->f_mapping, pos,
+		err = filemap_write_and_wait_range(file->f_mapping,
+						   iocb->ki_pos,
 						   endbyte);
 		if (err)
 			goto out;
 
 		invalidate_mapping_pages(file->f_mapping,
-					 pos >> PAGE_SHIFT,
+					 iocb->ki_pos >> PAGE_SHIFT,
 					 endbyte >> PAGE_SHIFT);
 
 		written += written_buffered;
-		iocb->ki_pos = pos + written_buffered;
+		iocb->ki_pos += written_buffered;
 	} else {
 		written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
-		if (written >= 0)
-			iocb->ki_pos += written;
 	}
 out:
 	inode_unlock(inode);
-	if (written > 0)
-		written = generic_write_sync(iocb, written);
-
 	return written ? written : err;
 }
 
-- 
2.39.2

