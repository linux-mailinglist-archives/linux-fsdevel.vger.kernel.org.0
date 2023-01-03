Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8265C878
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 21:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbjACUxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 15:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjACUxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:53:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61112D35;
        Tue,  3 Jan 2023 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/BxhApXGBQSkvwGPdUVtQvXgrRE60w5clbCXLT5mVE=; b=IjNwZnDcV41tbThJhvL9M6k8BE
        lfROA+iOMY+Sq/4Nn+VhiuY81mClUBXyYAFUTDrji8HX8c5kKFLwdEjX1h2bAC5mx5eVCmQJeXWy3
        Hq3ywXOCBRxCTFSx2Q1sBNqBrfPn7CQvCaJaLOKfcs4sSIJHZJFx3oMIylb39cfL3t+yx5UqGDMOr
        d47/+lED0aXpBIfLPar2Mqy4W2BHZNuWr8v3EeLNvs5myTtf2Sb95Z3Q62onzgALwxyGqP7jdEyBk
        ItAQvCiw0IVprLsCfhymyzbffRAnCprWiL5WD2+giHP3fQ9fSlPKZKBq6VV0qccyvJbjWA0JFx9l0
        /GkwhozQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCoI7-00EP1J-Vk; Tue, 03 Jan 2023 20:53:48 +0000
Date:   Tue, 3 Jan 2023 20:53:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, chao@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y7SV23/k39ygIj8/@casper.infradead.org>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com>
 <Y5tvQKT8HWxngEnc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5tvQKT8HWxngEnc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:02:24AM -0800, Jaegeuk Kim wrote:
> On 12/12, Vishal Moola (Oracle) wrote:
> > @@ -2994,13 +2998,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
> >  		tag_pages_for_writeback(mapping, index, end);
> >  	done_index = index;
> >  	while (!done && !retry && (index <= end)) {
> > -		nr_pages = find_get_pages_range_tag(mapping, &index, end,
> > -				tag, F2FS_ONSTACK_PAGES, pages);
> > -		if (nr_pages == 0)
> > +		nr_pages = 0;
> > +again:
> > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > +				tag, &fbatch);
> 
> Can't folio handle this internally with F2FS_ONSTACK_PAGES and pages?

I really want to discourage filesystems from doing this kind of thing.
The folio_batch is the natural size for doing batches of work, and
having the consistency across all these APIs of passing in a folio_batch
is quite valuable.  I understand f2fs wants to get more memory in a
single batch, but the right way to do that is to use larger folios.

