Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B011666BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 08:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbjALHyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 02:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjALHyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:54:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA960D5;
        Wed, 11 Jan 2023 23:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s3TjPAFjRqnBuoET6D3Wlhqe4sSMChdk41PYCR2aI7s=; b=dA3vKN7oguxt0/A1U9XDalYfkA
        P9KPlEaYhKRV1VIc+elvxZlB5i7smggNemN5yZQ9p/d5wZQ+tvJ7gwF/9QWE3XT6C6/xvdKlRyp1s
        VdfhjAHsYJfXcieL+3bNf6VPv4ACiGisJILvRifAxfBz1uCDl4lXYFZiddg4/fytnlYk0rmYnHPfI
        dCkgusR7kMVoBXA04eh91HTOWQDbiwKPYyoxtfItoYIOUZyWDS7oZySJf+ANSFHqHLjED2Q5Kl+eP
        oIfCGPOQBtR1wYeidGOKDztvfVMLl2cLfgnE5rOEBhnzh4NMSYigDFPI5cLDiKt66h01nj5OAg1DZ
        1n88OWrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFsPn-00E37f-Ak; Thu, 12 Jan 2023 07:54:23 +0000
Date:   Wed, 11 Jan 2023 23:54:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y7+8r1IYQS3sbbVz@infradead.org>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:27:58PM +0000, David Howells wrote:
> This allows all but three of the users of iov_iter_rw() to be got rid of: a
> consistency check and a warning statement in cifs

Let's just drop these two.

> and one user in the block
> layer that has neither available.

And use the information in the request for this one (see patch below),
and then move this patch first in the series, add an explicit direction
parameter in the gup_flags to the get/pin helper and drop iov_iter_rw
and the whole confusing source/dest information in the iov_iter entirely,
which is a really nice big tree wide cleanup that remove redundant
information.

---
diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c73bb..08cbb7ff3b196d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -203,7 +203,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	/*
 	 * success
 	 */
-	if ((iov_iter_rw(iter) == WRITE &&
+	if ((op_is_write(rq->cmd_flags) &&
 	     (!map_data || !map_data->null_mapped)) ||
 	    (map_data && map_data->from_user)) {
 		ret = bio_copy_from_iter(bio, iter);
