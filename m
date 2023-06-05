Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16230721C92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 05:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFEDdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 23:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:33:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE27A4;
        Sun,  4 Jun 2023 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ki9H5mCcnub6qNTf2YjCHw/MK/nflERfZb0YZh+FWCA=; b=KdMelgmh+JDu7W+uwSRCGQi+nE
        plHcRod38WOdWKQSKEufrMfsB3vTceprtdq9jPlNb9ly2i4MOkDLYeTplfd+e6U/wUQ/MNkG9Sbwa
        OJOIZ/v02pzbIxqhNFmarW7QD5giRUso5sXdXmwgSYdH7VcwaZKrsXjQuWHIAbsCCzFSftnOyuFIM
        i77nDxJaFvZ14ZgrymPkwVekTHvUWMuqIyOCJwx1PVkuK2NZx+W74qGLGJAVstadtyazU6xovo9Ex
        7rfVgtKSpMeTZz4lgZ8eWA51KY3drBn8UG8u9II5cKfaeYhtf/EQ/L+p8+NLVEJYm496I13mL3HIp
        UNQZXzlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q60xs-00Bc7E-HU; Mon, 05 Jun 2023 03:33:04 +0000
Date:   Mon, 5 Jun 2023 04:33:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv6 3/5] iomap: Refactor some iop related accessor functions
Message-ID: <ZH1XcNIe+qIt/H6Z@casper.infradead.org>
References: <cover.1685900733.git.ritesh.list@gmail.com>
 <0d52baa3865f4c8fe49b8389f8e8070ed01144f8.1685900733.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d52baa3865f4c8fe49b8389f8e8070ed01144f8.1685900733.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:01:50AM +0530, Ritesh Harjani (IBM) wrote:
> @@ -214,7 +231,7 @@ struct iomap_readpage_ctx {
>  static int iomap_read_inline_data(const struct iomap_iter *iter,
>  		struct folio *folio)
>  {
> -	struct iomap_page *iop;
> +	struct iomap_page __maybe_unused *iop;

Ummm ... definitely unused, right?

>  	const struct iomap *iomap = iomap_iter_srcmap(iter);
>  	size_t size = i_size_read(iter->inode) - iomap->offset;
>  	size_t poff = offset_in_page(iomap->offset);
> @@ -240,7 +257,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	memcpy(addr, iomap->inline_data, size);
>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_local(addr);
> -	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
> +	iomap_iop_set_range_uptodate(iter->inode, folio, offset,
> +				     PAGE_SIZE - poff);

Once you make this change, iop is set in this function, but never used.
So you still want to call iomap_page_create() if offset > 0, but you
can ignore the return value.  And you don't need to call to_iomap_page().

Or did I miss something elsewhere in this patch series?
