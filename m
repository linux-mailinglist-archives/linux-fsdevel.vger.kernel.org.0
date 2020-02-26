Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4C17006F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBZNwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:52:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726388AbgBZNwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582725118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qS+zeTxWycgVFIYDEZjy4nCOnkZdH/4Sp0bqijNqhww=;
        b=aWjv3JaSKmgzRud0qQ97OFqa5dZT4jlmtwEWLTG+Ey/Y8MOy5VH9MbZFM6utdkIhJJ1VIB
        QIh059Ymwf2l52lzWH7LPDMZRAVJIKCjH6Eqpd9NBIC6u/ZsrjIUJT4ctdr5PxVu8HtvvL
        ZcjItT4QRzB6Doo0chrgbagvX3bb3sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cJauPauOMlK1pAIo-9Oeew-1; Wed, 26 Feb 2020 08:51:54 -0500
X-MC-Unique: cJauPauOMlK1pAIo-9Oeew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70A4B13E2;
        Wed, 26 Feb 2020 13:51:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7E6560BE1;
        Wed, 26 Feb 2020 13:51:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 58E0E2257D2; Wed, 26 Feb 2020 08:51:50 -0500 (EST)
Date:   Wed, 26 Feb 2020 08:51:50 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200226135150.GA30329@redhat.com>
References: <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224201346.GC14651@redhat.com>
 <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
 <20200224211553.GD14651@redhat.com>
 <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
 <20200225133653.GA7488@redhat.com>
 <CAPcyv4h2fdo=-jqLPTqnuxYVMbBgODWPqafH35yBMBaPa5Rxcw@mail.gmail.com>
 <20200225200824.GB7488@redhat.com>
 <CAPcyv4jN7ntOO2hK4ByDcX4-Kob=aJNOr3fGR_k_8rxZ=3Sz7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jN7ntOO2hK4ByDcX4-Kob=aJNOr3fGR_k_8rxZ=3Sz7w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:49:30PM -0800, Dan Williams wrote:
[..]
> > > > Hi Dan,
> > > >
> > > > IIUC, block aligned hole punch don't go through __dax_zero_page_range()
> > > > path. Instead they call blkdev_issue_zeroout() at later point of time.
> > > >
> > > > Only partial block zeroing path is taking __dax_zero_page_range(). So
> > > > even if we remove poison clearing code from __dax_zero_page_range(),
> > > > there should not be a regression w.r.t full block zeroing. Only possible
> > > > regression will be if somebody was doing partial block zeroing on sector
> > > > boundary, then poison will not be cleared.
> > > >
> > > > We now seem to be discussing too many issues w.r.t poison clearing
> > > > and dax. Atleast 3 issues are mentioned in this thread.
> > > >
> > > > A. Get rid of dependency on block device in dax zeroing path.
> > > >    (__dax_zero_page_range)
> > > >
> > > > B. Provide a way to clear latent poison. And possibly use movdir64b to
> > > >    do that and make filesystems use that interface for initialization
> > > >    of blocks.
> > > >
> > > > C. Dax zero operation is clearing known poison while copy_from_iter() is
> > > >    not. I guess this ship has already sailed. If we change it now,
> > > >    somebody will complain of some regression.
> > > >
> > > > For issue A, there are two possible ways to deal with it.
> > > >
> > > > 1. Implement a dax method to zero page. And this method will also clear
> > > >    known poison. This is what my patch series is doing.
> > > >
> > > > 2. Just get rid of blkdev_issue_zeroout() from __dax_zero_page_range()
> > > >    so that no poison will be cleared in __dax_zero_page_range() path. This
> > > >    path is currently used in partial page zeroing path and full filesystem
> > > >    block zeroing happens with blkdev_issue_zeroout(). There is a small
> > > >    chance of regression here in case of sector aligned partial block
> > > >    zeroing.
> > > >
> > > > My patch series takes care of issue A without any regressions. In fact it
> > > > improves current interface. For example, currently "truncate -s 512
> > > > foo.txt" will succeed even if first sector in the block is poisoned. My
> > > > patch series fixes it. Current implementation will return error on if any
> > > > non sector aligned truncate is done and any of the sector is poisoned. My
> > > > implementation will not return error if poisoned can be cleared as part
> > > > of zeroing. It will return only if poison is present in non-zeoring part.
> > >
> > > That asymmetry makes the implementation too much of a special case. If
> > > the dax mapping path forces error boundaries on PAGE_SIZE blocks then
> > > so should zeroing.
> > >
> > > >
> > > > Why don't we solve one issue A now and deal with issue B and C later in
> > > > a sepaprate patch series. This patch series gets rid of dependency on
> > > > block device in dax path and also makes current zeroing interface better.
> > >
> > > I'm ok with replacing blkdev_issue_zeroout() with a dax operation
> > > callback that deals with page aligned entries. That change at least
> > > makes the error boundary symmetric across copy_from_iter() and the
> > > zeroing path.
> >
> > IIUC, you are suggesting that modify dax_zero_page_range() to take page
> > aligned start and size and call this interface from
> > __dax_zero_page_range() and get rid of blkdev_issue_zeroout() in that
> > path?
> >
> > Something like.
> >
> > __dax_zero_page_range() {
> >   if(page_aligned_io)
> >         call_dax_page_zero_range()
> >   else
> >         use_direct_access_and_memcpy;
> > }
> >
> > And other callers of blkdev_issue_zeroout() in filesystems can migrate
> > to calling dax_zero_page_range() instead.
> >
> > If yes, I am not seeing what advantage do we get by this change.
> >
> > - __dax_zero_page_range() seems to be called by only partial block
> >   zeroing code. So dax_zero_page_range() call will remain unused.
> >
> >
> > - dax_zero_page_range() will be exact replacement of
> >   blkdev_issue_zeroout() so filesystems will not gain anything. Just that
> >   it will create a dax specific hook.
> >
> > In that case it might be simpler to just get rid of blkdev_issue_zeroout()
> > call from __dax_zero_page_range() and make sure there are no callers of
> > full block zeroing from this path.
> 
> I think you're right. The path I'm concerned about not regressing is
> the error clearing on new block allocation and we get that already via
> xfs_zero_extent() and sb_issue_zeroout(). For your fs we'll want a
> dax-device equivalent  for that path, but that does mean that
> __dax_zero_page_range() stays out of the error clearing game.

In virtiofs we do not manage our own blocks. We let host filesystem
do that and we are just passthrough filesystem passing fuse messages
around. So I have not seen need of block zeroing interface yet.

I just happened to carry a patch in my patch series in this area because
we wanted to get rid of this assumption that dax always has a block
device associated. Apart from that, I don't need __dax_zero_page_range()
for virtiofs. 

I am doing this cleanup so that we dont even try to use block device
in this dax zeroing path.

Anyway, I will cleanup this patch series and get rid of
blkdev_issue_zeroout() call from __dax_zero_page_range() and post again
for review and where does it go from there.

Thanks
Vivek

