Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2272CB7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjFLQ1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjFLQ1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:27:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1CE4A;
        Mon, 12 Jun 2023 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/pPSReBtB0BjBo4cv14OqoRMUj2m3fwzDCLAIzJHsg=; b=PtH5tIhLJg12K5ZtTxqU2Qw3qE
        uvcwXUAMpVm7BxX2WWbl3X1K/MbRyD/KEXTz7M1thm2EqDcTuzarSrvhs0jSw4AyIjxTE4unYcXVv
        mG/1z8LpGg9QE1YXBtfvg5UvSgqIroX5rXXx8+DC7l8NXNU4Q4+EquX/dIkiRiAuT+ZGToo7zpSL3
        tDPQ1+0RcLeSOd//GuGvlVLzxCuizkECUtluoqnfcCXvAW+WF+hA7CRPKFv+aR4UhrrXwXXRazley
        moAMMFuCIP0xdvJFWpgKUFxiRpdrlY+D6PEJLtrAL0LTXDYeqCc0QczBgmNy4JPd0Um23eMeV3IJ0
        N158oKpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8kO2-002pWC-73; Mon, 12 Jun 2023 16:27:22 +0000
Date:   Mon, 12 Jun 2023 17:27:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv9 6/6] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZIdHap4ZvwG+aN4U@casper.infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <954d2e61dedbada996653c9d780be70a48dc66ae.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954d2e61dedbada996653c9d780be70a48dc66ae.1686395560.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 10, 2023 at 05:09:07PM +0530, Ritesh Harjani (IBM) wrote:
> +static void iomap_ifs_calc_range(struct folio *folio, size_t off, size_t len,
> +		enum iomap_block_state state, unsigned int *first_blkp,
> +		unsigned int *nr_blksp)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +
> +	*first_blkp = first_blk + (state * blks_per_folio);

This _isn't_ first_blk.  It's first_bit.  You could just rename it to
'first', but misnaming it as first_blkp is going to confuse.

