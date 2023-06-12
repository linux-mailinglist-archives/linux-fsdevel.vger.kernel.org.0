Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733972B817
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjFLGdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFLGdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:33:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676901981;
        Sun, 11 Jun 2023 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVYzREkSZaqgr8GO6Wu2I+uNE0VjM5SWo3AfQ7iWDlU=; b=1rF1+yzTwtUMRGyDemzphisEbq
        5iC9GHoc+P++UGkL/pxWRLm4p5D89xwrdFkVUJ8w8VB3LiblGLrqLUJ2Zz5Q3fLwPQkso/LBa8vbO
        rhyqyjzo4HABVApf6dU6x+vSEMGPVdohkS5GKdNAp9N32U/K18L/nfC7R5LHThJPL7TnVmWrJCDXh
        9POgd8d+VPL+EzGoQTRqpq9QuF4nX3iiqeRiLwl4wutld2BQDjbP5BabyAhPrG5zot+giU2W7k5EZ
        VrGd8y1uv4t02QRIpkN8FCzD25cJfCtWzEVzQhh/ST0gGw+e971HxRIyf2Nht0LTJKa+lZfyncFs5
        DZpeJ+lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8azY-002l7u-25;
        Mon, 12 Jun 2023 06:25:28 +0000
Date:   Sun, 11 Jun 2023 23:25:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers
 for ifs state bitmap
Message-ID: <ZIa6WLknzuxoDDT8@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 10, 2023 at 05:09:04PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
> and iomap_ifs_is_block_uptodate() for managing uptodate state of
> ifs state bitmap.
> 
> In later patches ifs state bitmap array will also handle dirty state of all
> blocks of a folio. Hence this patch adds some helper routines for handling
> uptodate state of the ifs state bitmap.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e237f2b786bc..206808f6e818 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
>  
>  static struct bio_set iomap_ioend_bioset;
>  
> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
> +					       struct iomap_folio_state *ifs)
> +{
> +	struct inode *inode = folio->mapping->host;
> +
> +	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> +}
> +
> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
> +					       unsigned int block)
> +{
> +	return test_bit(block, ifs->state);
> +}

A little nitpicky, but do the _ifs_ name compenents here really add
value?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
