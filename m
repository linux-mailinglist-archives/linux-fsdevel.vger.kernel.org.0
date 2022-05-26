Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C067A535474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiEZUcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiEZUcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 16:32:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FCAFAFA;
        Thu, 26 May 2022 13:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B499AB82200;
        Thu, 26 May 2022 20:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE407C385A9;
        Thu, 26 May 2022 20:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653597135;
        bh=MmNkpzD1809dhPXWWPtX7YZu9JXiJf7remfxKhtGai0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TprHn+qmZo+pQwsHUK0FDg7FQH9R3znZ+HC+bex9rn/90v+AtqF3pVx8HJnXmdfPN
         97Jgx9iTK2Q++tiWQeLPOEYtDs1hgLQb+hAprVwYHE8kN8gNBbFraCj+MsBEMysLtE
         zZENPvZbhDodKAaeUrdR2dGaGvmdZ1m5STV0pnprOgqYvtd8MYLbGjwOfXvJaiqE3X
         CVMMul9sC9pyIrJIkBIeJz8gUjh5Uc92HAHpzeRPTbQGOFxYY4y34idVVi2LnJJ+Dp
         Gd5bGH541facVbES3JfBkQbRmMXjcTVW6Klr0j2R9Ix45+NPAf2SXdK05Kyf9bCkm1
         QIkr9jK9xnqZQ==
Date:   Thu, 26 May 2022 14:32:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <Yo/jzEDENPKpD8Al@kbusch-mbp.dhcp.thefacebook.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
 <Yo8sZWNNTKM2Kwqm@sol.localdomain>
 <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com>
 <Yo/DYI17KWgXJNyB@sol.localdomain>
 <Yo/NNiGbnHw/G9Lc@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo/NNiGbnHw/G9Lc@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 12:55:50PM -0600, Keith Busch wrote:
> 
> Let me see how difficult it would be catch it early in blkdev_dio_aligned().

Something like this appears to work:

---
diff --git a/block/fops.c b/block/fops.c
index 6ecbccc552b9..20763a143991 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -47,7 +47,8 @@ static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
 {
 	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
-	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
+	if (!iov_iter_aligned(iter, bdev_dma_alignment(bdev),
+			      bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 	return 0;
 }
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..a9cbf90d8dcd 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -219,6 +219,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 #endif
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
+bool iov_iter_aligned(const struct iov_iter *i, unsigned addr_mask,
+			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..6a98bbd56408 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1268,6 +1268,89 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
+static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
+				   unsigned len_mask)
+{
+	size_t size = i->count;
+	size_t skip = i->iov_offset;
+	unsigned k;
+
+	for (k = 0; k < i->nr_segs; k++, skip = 0) {
+		size_t len = i->iov[k].iov_len - skip;
+
+		if (len > size)
+			len = size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->iov[k].iov_base + skip) & addr_mask)
+			return false;
+
+		size -= len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
+				  unsigned len_mask)
+{
+	size_t size = i->count;
+	unsigned skip = i->iov_offset;
+	unsigned k;
+
+	for (k = 0; k < i->nr_segs; k++, skip = 0) {
+		size_t len = i->bvec[k].bv_len - skip;
+
+		if (len > size)
+			len = size;
+		if (len & len_mask)
+			return false;
+		if ((unsigned long)(i->bvec[k].bv_offset + skip) & addr_mask)
+			return false;
+
+		size -= len;
+		if (!size)
+			break;
+	}
+	return true;
+}
+
+bool iov_iter_aligned(const struct iov_iter *i, unsigned addr_mask,
+		      unsigned len_mask)
+{
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_bvec(i))
+		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
+
+	if (iov_iter_is_pipe(i)) {
+		unsigned int p_mask = i->pipe->ring_size - 1;
+		size_t size = i->count;
+
+		if (size & len_mask)
+			return false;
+		if (size && allocated(&i->pipe->bufs[i->head & p_mask])) {
+			if (i->iov_offset & addr_mask)
+				return false;
+		}
+
+		return true;
+	}
+
+	if (iov_iter_is_xarray(i)) {
+		if (i->count & len_mask)
+			return false;
+		if ((i->xarray_start + i->iov_offset) & addr_mask)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(iov_iter_aligned);
+
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	unsigned long res = 0;
--
