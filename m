Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1B67DC18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjA0CFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 21:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjA0CFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:05:40 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D5AD3D;
        Thu, 26 Jan 2023 18:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PK9c5BIZ/2zl/kbi/P3CFpqoz5RNvD3sK2pvPPas0Ak=; b=RylZnR9uWIvzX4rWuBzjZyKE88
        p7IhXapBv2ZuJ8A5mNdHQ/M4MSSpH2DhYndse8MHfUKjUVpOimHisD8sYwAXacgUuraHI26wQLGfA
        ZTOuH9+ysl18EC/pf4TBjGlgbm/+l4BAfxy/B3Dqxb1oCo3ERvTttDRm4VN8M+WXYsbtFZD0QYRXK
        EZ54JgXXmPhXCsE3YKPxtOFagSMtMtW57bXiCDmHrYqa6qm4cGZXRgfODjLrfV/nI2Omrl3u8hbAc
        7Uu9Szo5UwLkvwyZhqqXASLKT5SrFZM9KyoOlQ52YNg9Yg48+zdsWK21Jwik8hMSF/bAvz1SCSDR3
        eesAwG3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLE4V-004MLo-24;
        Fri, 27 Jan 2023 02:02:31 +0000
Date:   Fri, 27 Jan 2023 02:02:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y9Mwt1EMm8InCHvA@ZenIV>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com>
 <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
 <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:44:08AM +0100, David Hildenbrand wrote:
> On 26.01.23 23:36, Al Viro wrote:
> > On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
> > > On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
> > > 
> > > > +/**
> > > > + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
> > > > + * @iter: The iterator
> > > > + *
> > > > + * Examine the iterator and indicate by returning true or false as to how, if
> > > > + * at all, pages extracted from the iterator will be retained by the extraction
> > > > + * function.
> > > > + *
> > > > + * %true indicates that the pages will have a pin placed in them that the
> > > > + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
> > > > + * to forcibly copy a page for the child (the parent must retain the original
> > > > + * page).
> > > > + *
> > > > + * %false indicates that no measures are taken and that it's up to the caller
> > > > + * to retain the pages.
> > > > + */
> > > > +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
> > > > +{
> > > > +	return user_backed_iter(iter);
> > > > +}
> > > > +
> > > 
> > > Wait a sec; why would we want a pin for pages we won't be modifying?
> > > A reference - sure, but...
> > 
> > After having looked through the earlier iterations of the patchset -
> > sorry, but that won't fly for (at least) vmsplice().  There we can't
> > pin those suckers;
> 
> We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to handle
> such long-term pinning as vmsplice() needs. But the release path (unpin)
> will be the same.

Umm...  Are you saying that if the source area contains DAX mmaps, vmsplice()
from it will fail?
