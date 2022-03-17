Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55D24DD0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 23:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiCQWxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiCQWxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:53:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 131B32B4A70;
        Thu, 17 Mar 2022 15:52:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A7519533CEA;
        Fri, 18 Mar 2022 09:52:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nUyye-006iPy-EW; Fri, 18 Mar 2022 09:52:16 +1100
Date:   Fri, 18 Mar 2022 09:52:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <20220317225216.GB1544202@dread.disaster.area>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org>
 <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjOlJL7xwktKoLFN@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6233bba4
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=7svFRl-LX0UtnufVsbMA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:16:20PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 17, 2022 at 12:26:35PM -0700, Linus Torvalds wrote:
> > On Thu, Mar 17, 2022 at 8:04 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > So how about we do something like this:
> > >
> > >  - Make folio_start_writeback() and set_page_writeback() return void,
> > >    fixing up AFS and NFS.
> > >  - Add a folio_wait_start_writeback() to use in the VFS
> > >  - Remove the calls to set_page_writeback() in the filesystems
> > 
> > That sounds lovely, but it does worry me a bit. Not just the odd
> > 'keepwrite' thing, but also the whole ordering between the folio bit
> > and the tagging bits. Does the ordering possibly matter?
> 
> I wouldn't change the ordering of setting the xarray bits and the
> writeback flag; they'd just be set a little earlier.  It'd all be done
> while the page was still locked.  But you're right, there's lots of
> subtle interactions here.
> 
> > That whole "xyz_writeback_keepwrite()" thing seems odd. It's used in
> > only one place (the folio version isn't used at all):
> > 
> >   ext4_writepage():
> > 
> >      ext4_walk_page_buffers() fails:
> >                 redirty_page_for_writepage(wbc, page);
> >                 keep_towrite = true;
> >       ext4_bio_write_page().
> > 
> > which just looks odd. Why does it even try to continue to do the
> > writepage when the page buffer thing has failed?
> > 
> > In the regular write path (ie ext4_write_begin()), a
> > ext4_walk_page_buffers() failure is fatal or causes a retry). Why is
> > ext4_writepage() any different? Particularly since it wants to keep
> > the page dirty, then trying to do the writeback just seems wrong.
> > 
> > So this code is all a bit odd, I suspect there are decades of "people
> > continued to do what they historically did" changes, and it is all
> > worrisome.
> 
> I found the commit: 1c8349a17137 ("ext4: fix data integrity sync in
> ordered mode").  Fortunately, we have a documented test for this,
> generic/127, so we'll know if we've broken it.

Looks like a footgun. ext4 needs the keepwrite stuff for block size <
page size, in the case where a page has both written and
delalloc/unwritten buffers on it. In that case ext4_writepage tries
to write just the written blocks and leave the dealloc/unwritten
buffers alone because it can't do allocation in ->writepage context.

I say footgun, because the nested ->writepage call that needs
keepwrite comes a from journal stop context in the high level
->writepages context that is doing allocation that will allow the
entire page to be written. i.e. it seems a bit silly to be
triggering partial page writeback that skips delalloc/unwritten
extents, but then needs special awareness of higher level IO that is
in progress that is currently doing the allocation that will allow
all the delalloc/unwritten extents on the page to also be written
back...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
