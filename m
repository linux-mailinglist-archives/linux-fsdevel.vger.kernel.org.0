Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E75EAB02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiIZP2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiIZP0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:26:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E812AAD;
        Mon, 26 Sep 2022 07:10:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A7551F8AA;
        Mon, 26 Sep 2022 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664201456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlFGu5xf/L1Qiw7ID2qQl3vNpuCcb+T6b07/3KaOKVs=;
        b=lt5eQhEU21zFImCJ4p/J8li9f1EZU/75GeyWieUdU6emksZtc9Zl1k88t8VPtIJiyc/5HV
        4e8+zJXOF1YBQED1MK5S5WCfVob1wt0CDP4a8X5baitR+bF15Qo0DyUM+LTzkbeiV9PPws
        Xvdkx6k5Rm4yUMxxEO1n4L8xQE2Qo88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664201456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TlFGu5xf/L1Qiw7ID2qQl3vNpuCcb+T6b07/3KaOKVs=;
        b=FGPMP4E/xZWSlHk+Onq6+WTUzUu2EHdw1V6ZNYZgyh9msW4LsknhLYCiDOkp1Md4evkYio
        Yrwi0Myuo4O1HeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E206139BD;
        Mon, 26 Sep 2022 14:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9k1XF/CyMWPAAgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 14:10:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAEB9A0685; Mon, 26 Sep 2022 16:10:55 +0200 (CEST)
Date:   Mon, 26 Sep 2022 16:10:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20220926141055.sdlm3hkfepa7azf2@quack3>
References: <632894c4738d8_2a6ded294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20220919212959.GL3600936@dread.disaster.area>
 <6329ee04c9272_2a6ded294bf@dwillia2-xfh.jf.intel.com.notmuch>
 <20220921221416.GT3600936@dread.disaster.area>
 <YyuQI08LManypG6u@nvidia.com>
 <20220923001846.GX3600936@dread.disaster.area>
 <632d00a491d0d_4a67429488@dwillia2-xfh.jf.intel.com.notmuch>
 <20220923021012.GZ3600936@dread.disaster.area>
 <20220923093803.nroajmvn7twuptez@quack3>
 <20220925235407.GA3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925235407.GA3600936@dread.disaster.area>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-09-22 09:54:07, Dave Chinner wrote:
> On Fri, Sep 23, 2022 at 11:38:03AM +0200, Jan Kara wrote:
> > On Fri 23-09-22 12:10:12, Dave Chinner wrote:
> > > On Thu, Sep 22, 2022 at 05:41:08PM -0700, Dan Williams wrote:
> > > > Dave Chinner wrote:
> > > > > On Wed, Sep 21, 2022 at 07:28:51PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, Sep 22, 2022 at 08:14:16AM +1000, Dave Chinner wrote:
> > > > > > 
> > > > > > > Where are these DAX page pins that don't require the pin holder to
> > > > > > > also hold active references to the filesystem objects coming from?
> > > > > > 
> > > > > > O_DIRECT and things like it.
> > > > > 
> > > > > O_DIRECT IO to a file holds a reference to a struct file which holds
> > > > > an active reference to the struct inode. Hence you can't reclaim an
> > > > > inode while an O_DIRECT IO is in progress to it. 
> > > > > 
> > > > > Similarly, file-backed pages pinned from user vmas have the inode
> > > > > pinned by the VMA having a reference to the struct file passed to
> > > > > them when they are instantiated. Hence anything using mmap() to pin
> > > > > file-backed pages (i.e. applications using FSDAX access from
> > > > > userspace) should also have a reference to the inode that prevents
> > > > > the inode from being reclaimed.
> > > > > 
> > > > > So I'm at a loss to understand what "things like it" might actually
> > > > > mean. Can you actually describe a situation where we actually permit
> > > > > (even temporarily) these use-after-free scenarios?
> > > > 
> > > > Jason mentioned a scenario here:
> > > > 
> > > > https://lore.kernel.org/all/YyuoE8BgImRXVkkO@nvidia.com/
> > > > 
> > > > Multi-thread process where thread1 does open(O_DIRECT)+mmap()+read() and
> > > > thread2 does memunmap()+close() while the read() is inflight.
> > > 
> > > And, ah, what production application does this and expects to be
> > > able to process the result of the read() operation without getting a
> > > SEGV?
> > > 
> > > There's a huge difference between an unlikely scenario which we need
> > > to work (such as O_DIRECT IO to/from a mmap() buffer at a different
> > > offset on the same file) and this sort of scenario where even if we
> > > handle it correctly, the application can't do anything with the
> > > result and will crash immediately....
> > 
> > I'm not sure I fully follow what we are concerned about here. As you've
> > written above direct IO holds reference to the inode until it is completed
> > (through kiocb->file->inode chain). So direct IO should be safe?
> 
> AFAICT, it's the user buffer allocated by mmap() that the direct IO
> is DMAing into/out of that is the issue here. i.e. mmap() a file
> that is DAX enabled, pass the mmap region to DIO on a non-dax file,
> GUP in the DIO path takes a page pin on user pages that are DAX
> mapped, the userspace application then unmaps the file pages and
> unlinks the FSDAX file.
> 
> At this point the FSDAX mapped inode has no active references, so
> the filesystem frees the inode and it's allocated storage space, and
> now the DIO or whatever is holding the GUP reference is
> now a moving storage UAF violation. What ever is holding the GUP
> reference doesn't even have a reference to the FSDAX filesystem -
> the DIO fd could point to a file in a different filesystem
> altogether - and so the fsdax filesytem could be unmounted at this
> point whilst the application is still actively using the storage
> underlying the filesystem.
> 
> That's just .... broken.

Hum, so I'm confused (and my last email probably was as well). So let me
spell out the details here so that I can get on the same page about what we
are trying to solve:

For FSDAX, backing storage for a page must not be freed (i.e., filesystem
must to free corresponding block) while there are some references to the
page. This is achieved by calls to dax_layout_busy_page() from the
filesystem before truncating file / punching hole into a file. So AFAICT
this is working correctly and I don't think the patch series under
discussion aims to change this besides the change in how page without
references is detected.

Now there is a separate question that while someone holds a reference to
FSDAX page, the inode this page belongs to can get evicted from memory. For
FSDAX nothing prevents that AFAICT. If this happens, we loose track of the
page<->inode association so if somebody later comes and truncates the
inode, we will not detect the page belonging to the inode is still in use
(dax_layout_busy_page() does not find the page) and we have a problem.
Correct?

> > I'd be more worried about stuff like vmsplice() that can add file pages
> > into pipe without holding inode alive in any way and keeping them there for
> > arbitrarily long time. Didn't we want to add FOLL_LONGTERM to gup executed
> > from vmsplice() to avoid issues like this?
> 
> Yes, ISTR that was part of the plan - use FOLL_LONGTERM to ensure
> FSDAX can't run operations that pin pages but don't take fs
> references. I think that's how we prevented RDMA users from pinning
> FSDAX direct mapped storage media in this way. It does not, however,
> prevent the above "short term" GUP UAF situation from occurring.

If what I wrote above is correct, then I understand and agree.

> > I agree that freeing VMA while there are pinned pages is ... inconvenient.
> > But that is just how gup works since the beginning - the moment you have
> > struct page reference, you completely forget about the mapping you've used
> > to get to the page. So anything can happen with the mapping after that
> > moment. And in case of pages mapped by multiple processes I can easily see
> > that one of the processes decides to unmap the page (and it may well be
> > that was the initial process that acquired page references) while others
> > still keep accessing the page using page references stored in some internal
> > structure (RDMA anyone?).
> 
> Yup, and this is why RDMA on FSDAX using this method of pinning pages
> will end up corrupting data and filesystems, hence FOLL_LONGTERM
> protecting against most of these situations from even arising. But
> that's that workaround, not a long term solution that allows RDMA to
> be run on FSDAX managed storage media.
> 
> I said on #xfs a few days ago:
> 
> [23/9/22 10:23] * dchinner is getting deja vu over this latest round
> of "dax mappings don't pin the filesystem objects that own the
> storage media being mapped"
> 
> And I'm getting that feeling again right now...
> 
> > I think it will be rather difficult to come up
> > with some scheme keeping VMA alive while there are pages pinned without
> > regressing userspace which over the years became very much tailored to the
> > peculiar gup behavior.
> 
> Perhaps all we should do is add a page flag for fsdax mapped pages
> that says GUP must pin the VMA, so only mapped pages that fall into
> this category take the perf penalty of VMA management.

Possibly. But my concern with VMA pinning was not only about performance
but also about applications relying on being able to unmap pages that are
currently pinned. At least from some processes one of which may be the one
doing the original pinning. But yeah, the fact that FOLL_LONGTERM is
forbidden with DAX somewhat restricts the insanity we have to deal with. So
maybe pinning the VMA for DAX mappings might actually be a workable
solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
