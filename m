Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2C5F0C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiI3Nl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiI3Nlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:41:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6717CCC9;
        Fri, 30 Sep 2022 06:41:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06FE61F88E;
        Fri, 30 Sep 2022 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664545305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3iEPJPd4WNALUdHRRfTjBi+oXPYskJSYk9FE5ApHVI=;
        b=c4bGmWjEcN9VYtgaWDbnSVcoO3a87aGSWoLgqHJs7Ullw8llaYGbsBG8aP3wJuZ0WNUK0e
        dyClrZQb+spR2ajvH31k0mJoGOWbURztSwchybbhwigBOPJeaJnD3ohfqPafwY1HHYZlcW
        cBj6YiTNYZsXDWSU9/v4GMQc6knQRvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664545305;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3iEPJPd4WNALUdHRRfTjBi+oXPYskJSYk9FE5ApHVI=;
        b=uIKW4D3ioWwIGLwYUWsLLXWvSLtf9wAKT6KY+LoAMLmlCeVKyhptUh66PCD+dxwXR6PIum
        Y543b8qOh6WAmFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB16813776;
        Fri, 30 Sep 2022 13:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e49fORjyNmNrRgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 30 Sep 2022 13:41:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 809A0A0668; Fri, 30 Sep 2022 15:41:44 +0200 (CEST)
Date:   Fri, 30 Sep 2022 15:41:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220930134144.pd67rbgahzcb62mf@quack3>
References: <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
 <20220926141055.sdlm3hkfepa7azf2@quack3>
 <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63362b4781294_795a6294f0@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-09-22 16:33:27, Dan Williams wrote:
> Jan Kara wrote:
> > On Mon 26-09-22 09:54:07, Dave Chinner wrote:
> > > > I'd be more worried about stuff like vmsplice() that can add file pages
> > > > into pipe without holding inode alive in any way and keeping them there for
> > > > arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
> > > > from vmsplice() to avoid issues like this?
> > > 
> > > Yes, ISTR that was part of the plan - use FOLL_LONGTERM to ensure
> > > FSDAX can't run operations that pin pages but don't take fs
> > > references. I think that's how we prevented RDMA users from pinning
> > > FSDAX direct mapped storage media in this way. It does not, however,
> > > prevent the above "short term" GUP UAF situation from occurring.
> > 
> > If what I wrote above is correct, then I understand and agree.
> > 
> > > > I agree that freeing VMA while there are pinned pages is ... inconvenient.
> > > > But that is just how gup works since the beginning - the moment you have
> > > > struct page reference, you completely forget about the mapping you've used
> > > > to get to the page. So anything can happen with the mapping after that
> > > > moment. And in case of pages mapped by multiple processes I can easily see
> > > > that one of the processes decides to unmap the page (and it may well be
> > > > that was the initial process that acquired page references) while others
> > > > still keep accessing the page using page references stored in some internal
> > > > structure (RDMA anyone?).
> > > 
> > > Yup, and this is why RDMA on FSDAX using this method of pinning pages
> > > will end up corrupting data and filesystems, hence FOLL_LONGTERM
> > > protecting against most of these situations from even arising. But
> > > that's that workaround, not a long term solution that allows RDMA to
> > > be run on FSDAX managed storage media.
> > > 
> > > I said on #xfs a few days ago:
> > > 
> > > [23/9/22 10:23] * dchinner is getting deja vu over this latest round
> > > of "dax mappings don't pin the filesystem objects that own the
> > > storage media being mapped"
> > > 
> > > And I'm getting that feeling again right now...
> > > 
> > > > I think it will be rather difficult to come up
> > > > with some scheme keeping VMA alive while there are pages pinned without
> > > > regressing userspace which over the years became very much tailored to the
> > > > peculiar gup behavior.
> > > 
> > > Perhaps all we should do is add a page flag for fsdax mapped pages
> > > that says GUP must pin the VMA, so only mapped pages that fall into
> > > this category take the perf penalty of VMA management.
> > 
> > Possibly. But my concern with VMA pinning was not only about performance
> > but also about applications relying on being able to unmap pages that are
> > currently pinned. At least from some processes one of which may be the one
> > doing the original pinning. But yeah, the fact that FOLL_LONGTERM is
> > forbidden with DAX somewhat restricts the insanity we have to deal with. So
> > maybe pinning the VMA for DAX mappings might actually be a workable
> > solution.
> 
> As far as I can see, VMAs are not currently reference counted they are
> just added / deleted from an mm_struct, and nothing guarantees
> mapping_mapped() stays true while a page is pinned.

I agree this solution requires quite some work. But I wanted to say that
in principle it would be a logically consistent and technically not that
difficult solution.
 
> I like Dave's mental model that the inode is the arbiter for the page,
> and the arbiter is not allowed to go out of scope before asserting that
> everything it granted previously has been returned.
> 
> write_inode_now() unconditionally invokes dax_writeback_mapping_range()
> when the inode is committed to going out of scope. write_inode_now() is
> allowed to sleep until all dirty mapping entries are written back. I see
> nothing wrong with additionally checking for entries with elevated page
> reference counts and doing a:
> 
>     __wait_var_event(page, dax_page_idle(page));
> 
> Since the inode is out of scope there should be no concerns with racing
> new 0 -> 1 page->_refcount transitions. Just wait for transient page
> pins to finally drain to zero which should already be on the order of
> the wait time to complete synchrounous writeback in the dirty inode
> case.

I agree this is doable but there's the nasty sideeffect that inode reclaim
may block for abitrary time waiting for page pinning. If the application
that has pinned the page requires __GFP_FS memory allocation to get to a
point where it releases the page, we even have a deadlock possibility.
So it's better than the UAF issue but still not ideal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
