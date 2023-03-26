Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043516C9235
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 05:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCZDZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCZDZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:25:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FAB45D;
        Sat, 25 Mar 2023 20:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HUFJfcz3xhLN7wytQypTHSI/i8bh/OrYAC1kWnV5Y98=; b=v0FVk+pvfjX0D/NhLrBVtifHQS
        OrmcleZDfibPRbuCfWWp7e9dotdxw5pH5eQQS1daAibLhAAntZKuzJAxRz7DJpyHX5V+KxdiEOKGN
        +YMJUFmXa2xd5L1O2JpErwhjZ2pWti2WsVSaV/3ifPN/EFh6GjdU/31AUgPjtWWBRu8XG09pq+SwO
        ick0Kwr+899P3UUzpDgULjvL9EGIgUnx5izmc3WDF5BASFB08+O655Lvf2TPF4oh0mW9srBya9lfE
        /TCVt90CmVUlLYdgEsX3BxpYPkabFt7Jy9IsrjVT3B3r40fJ0bQjGsK8aKKanAWvzYW0+VX2qjClW
        xUoiRX/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgH0T-006FXO-Kb; Sun, 26 Mar 2023 03:25:21 +0000
Date:   Sun, 26 Mar 2023 04:25:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 23/29] ext4: Convert ext4_mpage_readpages() to work on
 folios
Message-ID: <ZB+7IUGRryHSdd2y@casper.infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
 <20230324180129.1220691-24-willy@infradead.org>
 <20230324222951.GA5083@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324222951.GA5083@sol.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:29:51PM -0700, Eric Biggers wrote:
> On Fri, Mar 24, 2023 at 06:01:23PM +0000, Matthew Wilcox (Oracle) wrote:
> >  		if (first_hole != blocks_per_page) {
> > -			zero_user_segment(page, first_hole << blkbits,
> > -					  PAGE_SIZE);
> > +			folio_zero_segment(folio, first_hole << blkbits,
> > +					  folio_size(folio));
> >  			if (first_hole == 0) {
> > -				if (ext4_need_verity(inode, page->index) &&
> > -				    !fsverity_verify_page(page))
> > +				if (ext4_need_verity(inode, folio->index) &&
> > +				    !fsverity_verify_page(&folio->page))
> >  					goto set_error_page;
> 
> This can use fsverity_verify_folio().

Thanks!  Ted, let me know if you want a resend with this fixed, or
if you'll do it yourself.
