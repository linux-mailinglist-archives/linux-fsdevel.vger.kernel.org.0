Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359E697642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 07:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBOGYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 01:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjBOGYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:24:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46F2B2B1;
        Tue, 14 Feb 2023 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SGKZr1LFtN6F69r+wq3YkG37Rjrl6skoofTy7kDFRIw=; b=3OR5JmFdY4IGkJ/l/pgp90om0J
        Ju5dZedZ3MjMwpgQOLP3xiymIiGw4D24BfsZyFalIcSrBG8lURQRyiJJKdo33Bqxn3LAUWgltMA+s
        J/Cgm5/E5nANYUbi2OJO7WzSxhwSNcp/dN3pztwvUYPxZwFuavW6NfWoVum/yi+JoVStrAbHJZKMS
        aHCfhhNeaPnocYyp5Bfy04V1HG0FEAyHgf2IaXEPnyvD5jmo5OUYdq2H+ZqlHDc1nf51EsI9zLW8L
        wAUxH4TTk1c0+PVqwch9Tp3NkIBGzGk3QVnWqPLkVFmwR8Rs00FOrC9EdRif99BYJo/4ZndQcFJqU
        4IN8xwgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSBDV-004s2l-59; Wed, 15 Feb 2023 06:24:33 +0000
Date:   Tue, 14 Feb 2023 22:24:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <Y+x6oQkLex8PbfgL@infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
 <20230215045952.GF2825702@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215045952.GF2825702@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:59:52PM +1100, Dave Chinner wrote:
> I don't think this works, especially if the COW mechanism relies on
> delayed allocation to prevent ENOSPC during writeback. That is, we
> need a write() or page fault (to run ->page_mkwrite()) after every
> call to folio_clear_dirty_for_io() in the writeback path to ensure
> that new space is reserved for the allocation that will occur
> during a future writeback of that page.
> 
> Hence we can't just leave the page dirty on COW filesystems - it has
> to go through a clean state so that the clean->dirty event can be
> gated on gaining the space reservation that allows it to be written
> back again.

Exactly.  Although if we really want we could do the redirtying without
formally moving to a clean state, but it certainly would require special
new code to the same steps as if we were redirtying.

Which is another reason why I'd prefer to avoid all that if we can.
For that we probably need an inventory of what long term pins we have
in the kernel tree that can and do operate on shared file mappings,
and what kind of I/O semantics they expect.
