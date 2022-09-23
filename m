Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365D95E7760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiIWJkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiIWJir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:38:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30FF1873;
        Fri, 23 Sep 2022 02:38:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA09F21A63;
        Fri, 23 Sep 2022 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663925883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bndYC5R0I4YgJGO4guaGwuqL0KUo/BZ7Mi4kZdQckaE=;
        b=YUEiD3qlDTE6kfrELEyA6DtKQfZ0Z+lFXfep2GktpftEQDVLbnyfS1R5/SSne35rBzcs3l
        GoY7lcn3f9+optdT8RUNJrmlCwSXqZ/AklzJklYsKLNIXPhDSGAO0D1dUVoFhOG77ru9JY
        i8AOqEBC5HoQzGRwksUlYLvNaCJ0ONQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663925883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bndYC5R0I4YgJGO4guaGwuqL0KUo/BZ7Mi4kZdQckaE=;
        b=1cq16cCNLVPsPcsJejQybf10gm0fZ/HKzz/EgMTKikDllXQPpuy4rYG0qwnsQ8tfTxR+w6
        egBrBNbiBpwcP+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8E3A13A00;
        Fri, 23 Sep 2022 09:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMoWLXt+LWMvKQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 09:38:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57D2AA0685; Fri, 23 Sep 2022 11:38:03 +0200 (CEST)
Date:   Fri, 23 Sep 2022 11:38:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/18] xfs: Add xfs_break_layouts() to the inode
 eviction path
Message-ID: <20220923093803.nroajmvn7twuptez@quack3>
References: <166329933874.2786261.18236541386474985669.stgit@dwillia2-xfh.jf.intel.com>
 <20220918225731.GG3600936@dread.disaster.area>
 <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923021012.GZ3600936@dread.disaster.area>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-09-22 12:10:12, Dave Chinner wrote:
> On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> > Dave Chinner wrote:
> > > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > > 
> > > > > Where are these DAX page pins that don't require the pin holder to
> > > > > also hold active references to the filesystem objects coming from?
> > > > 
> > > > O_DIRECT and things like it.
> > > 
> > > O_DIRECT IO to a file holds a reference to a struct file which holds
> > > an active reference to the struct inode. Hence you can't reclaim an
> > > inode while an O_DIRECT IO is in progress to it. 
> > > 
> > > Similarly, file-backed pages pinned from user vmas have the inode
> > > pinned by the VMA having a reference to the struct file passed to
> > > them when they are instantiated. Hence anything using mmap() to pin
> > > file-backed pages (i.e. applications using FSDAX access from
> > > userspace) should also have a reference to the inode that prevents
> > > the inode from being reclaimed.
> > > 
> > > So I'm at a loss to understand what "things like it" might actually
> > > mean. Can you actually describe a situation where we actually permit
> > > (even temporarily) these use-after-free scenarios?
> > 
> > Jason mentioned a scenario here:
> > 
> > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > 
> > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > thread2 does memunmap()+close() while the read() is inflight.
> 
> And, ah, what production application does this and expects to be
> able to process the result of the read() operation without getting a
> SEGV?
> 
> There's a huge difference between an unlikely scenario which we need
> to work (such as O_DIRECT IO to/from a mmap() buffer at a different
> offset on the same file) and this sort of scenario where even if we
> handle it correctly, the application can't do anything with the
> result and will crash immediately....

I'm not sure I fully follow what we are concerned about here. As you've
written above direct IO holds reference to the inode until it is completed
(through kiocb->file->inode chain). So direct IO should be safe?

I'd be more worried about stuff like vmsplice() that can add file pages
into pipe without holding inode alive in any way and keeping them there for
arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
from vmsplice() to avoid issues like this?

> > Sounds plausible to me, but I have not tried to trigger it with a focus
> > test.
> 
> If there really are applications this .... broken, then it's not the
> responsibility of the filesystem to paper over the low level page
> reference tracking issues that cause it.
> 
> i.e. The underlying problem here is that memunmap() frees the VMA
> while there are still active task-based references to the pages in
> that VMA. IOWs, the VMA should not be torn down until the O_DIRECT
> read has released all the references to the pages mapped into the
> task address space.
> 
> This just doesn't seem like an issue that we should be trying to fix
> by adding band-aids to the inode life-cycle management.

I agree that freeing VMA while there are pinned pages is ... inconvenient.
But that is just how gup works since the beginning - the moment you have
struct page reference, you completely forget about the mapping you've used
to get to the page. So anything can happen with the mapping after that
moment. And in case of pages mapped by multiple processes I can easily see
that one of the processes decides to unmap the page (and it may well be
that was the initial process that acquired page references) while others
still keep accessing the page using page references stored in some internal
structure (RDMA anyone?). I think it will be rather difficult to come up
with some scheme keeping VMA alive while there are pages pinned without
regressing userspace which over the years became very much tailored to the
peculiar gup behavior.

I can imagine we would keep *inode* referenced while there are its pages
pinned. That should not be that difficult but at least in naive
implementation that would put rather heavy stress on inode refcount under
some loads so I don't think that's useful either.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
