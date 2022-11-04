Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6F619B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiKDP12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiKDP1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:27:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E532716E;
        Fri,  4 Nov 2022 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NRigLoVbg9iNMuo2V8dujDupHLGv4656kHqtcy7GZD8=; b=cC/8pOU9guMXpHbLROmQ2jJkPP
        fLIJJBoVaFImQSaJFL0EWP8TTGFmm1Fq/sTBJJzHOEsig/P1SI1UBIbnctYsc4kfBpEtbkTVb2mcZ
        Ox1PTbpiMUHAhUcDFiGqO5ffa8RLcaU4htW4J7D1+QIRrp5YcZ701l+dtCKa0/v+wq867Rzs2qjn5
        m+hDXZshw76/eeJ25GEvs/oa2Dpn7Gb7+4FfiG7RrZMv4cn4ae/Eyjl07Dbl+O73y7VDkBQtEk8h0
        f9z379l8811dl922VVtAq9pc8KIqwTp7lj2fnWcgj+lzkCFo5nZGbwWtuSpe8hnrjhN+krL6P+YDR
        WpFHYXzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqybA-007SeM-OG; Fri, 04 Nov 2022 15:27:12 +0000
Date:   Fri, 4 Nov 2022 15:27:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y2UvUOn6hmnqbrA7@casper.infradead.org>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018210152.GH2703033@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:01:52AM +1100, Dave Chinner wrote:
> On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> > @@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
> >  	while (!done && (index <= end)) {
> >  		int i;
> >  
> > -		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> > -				tag);
> > -		if (nr_pages == 0)
> > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > +				tag, &fbatch);
> 
> This can find and return dirty multi-page folios if the filesystem
> enables them in the mapping at instantiation time, right?

Correct.  Just like before the patch.  pagevec_lookup_range_tag() has
only ever returned head pages, never tail pages.  This is probably
because shmem (which was our only fs that supported compound pages)
never supported writeback, so never looked up pages by tag.

> >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > -			error = (*writepage)(page, wbc, data);
> > +			error = writepage(&folio->page, wbc, data);
> 
> Yet, IIUC, this treats all folios as if they are single page folios.
> i.e. it passes the head page of a multi-page folio to a callback
> that will treat it as a single PAGE_SIZE page, because that's all
> the writepage callbacks are currently expected to be passed...
> 
> So won't this break writeback of dirty multipage folios?

No.  A filesystem only sets the flag to create multipage folios once its
writeback callback handles multipage folios correctly (amongst many other
things that have to be fixed and tested).  I haven't written down all
the things that a filesystem maintainer needs to check at least partly
because I don't know how representative XFS/iomap are of all filesystems.

