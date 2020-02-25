Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6A16C274
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 14:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgBYNhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 08:37:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729206AbgBYNhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582637820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VbB7+QADsI1EK8eonSCcKnzGBIFtu6wHTsOjHf0RC78=;
        b=aQxBfh4vZZ9uKS8MphNB5+D0yQHkPg4IQjQt4ny//NGW2FIpuKf4ZNPcv48hOL08H9o2Ns
        VzkNTrGTomG2VZL5NyzHxC0NnVnOgOtV+4ll8AfIHRLvSfovUGtEmxjTXlbUb2G+gxbGLA
        iuZjXKtK8FKohMplgM8jLsxRh28EDC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-ACVQtKhEOeGgmNJNlb4jcw-1; Tue, 25 Feb 2020 08:36:58 -0500
X-MC-Unique: ACVQtKhEOeGgmNJNlb4jcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F43800D53;
        Tue, 25 Feb 2020 13:36:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70A185C548;
        Tue, 25 Feb 2020 13:36:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E8AB92257D2; Tue, 25 Feb 2020 08:36:53 -0500 (EST)
Date:   Tue, 25 Feb 2020 08:36:53 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200225133653.GA7488@redhat.com>
References: <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224201346.GC14651@redhat.com>
 <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
 <20200224211553.GD14651@redhat.com>
 <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:32:58PM -0800, Dan Williams wrote:

[..]
> > > > Ok, how about if I add one more patch to the series which will check
> > > > if unwritten portion of the page has known poison. If it has, then
> > > > -EIO is returned.
> > > >
> > > >
> > > > Subject: pmem: zero page range return error if poisoned memory in unwritten area
> > > >
> > > > Filesystems call into pmem_dax_zero_page_range() to zero partial page upon
> > > > truncate. If partial page is being zeroed, then at the end of operation
> > > > file systems expect that there is no poison in the whole page (atleast
> > > > known poison).
> > > >
> > > > So make sure part of the partial page which is not being written, does not
> > > > have poison. If it does, return error. If there is poison in area of page
> > > > being written, it will be cleared.
> > >
> > > No, I don't like that the zero operation is special cased compared to
> > > the write case. I'd say let's make them identical for now. I.e. fail
> > > the I/O at dax_direct_access() time.
> >
> > So basically __dax_zero_page_range() will only write zeros (and not
> > try to clear any poison). Right?
> 
> Yes, the zero operation would have already failed at the
> dax_direct_access() step if there was present poison.
> 
> > > I think the error clearing
> > > interface should be an explicit / separate op rather than a
> > > side-effect. What about an explicit interface for initializing newly
> > > allocated blocks, and the only reliable way to destroy poison through
> > > the filesystem is to free the block?
> >
> > Effectively pmem_make_request() is already that interface filesystems
> > use to initialize blocks and clear poison. So we don't really have to
> > introduce a new interface?
> 
> pmem_make_request() is shared with the I/O path and is too low in the
> stack to understand intent. DAX intercepts the I/O path closer to the
> filesystem and can understand zeroing vs writing today. I'm proposing
> we go a step further and make DAX understand free-to-allocated-block
> initialization instead of just zeroing. Inject the error clearing into
> that initialization interface.
> 
> > Or you are suggesting separate dax_zero_page_range() interface which will
> > always call into firmware to clear poison. And that will make sure latent
> > poison is cleared as well and filesystem should use that for block
> > initialization instead?
> 
> Yes, except latent poison would not be cleared until the zeroing is
> implemented with movdir64b instead of callouts to firmware. It's
> otherwise too slow to call out to firmware unconditionally.
> 
> > I do like the idea of not having to differentiate
> > between known poison and latent poison. Once a block has been initialized
> > all poison should be cleared (known/latent). I am worried though that
> > on large devices this might slowdown filesystem initialization a lot
> > if they are zeroing large range of blocks.
> >
> > If yes, this sounds like two different patch series. First patch series
> > takes care of removing blkdev_issue_zeroout() from
> > __dax_zero_page_range() and couple of iomap related cleans christoph
> > wanted.
> >
> > And second patch series for adding new dax operation to zero a range
> > and always call info firmware to clear poison and modify filesystems
> > accordingly.
> 
> Yes, but they may need to be merged together. I don't want to regress
> the ability of a block-aligned hole-punch to clear errors.

Hi Dan,

IIUC, block aligned hole punch don't go through __dax_zero_page_range()
path. Instead they call blkdev_issue_zeroout() at later point of time.

Only partial block zeroing path is taking __dax_zero_page_range(). So
even if we remove poison clearing code from __dax_zero_page_range(),
there should not be a regression w.r.t full block zeroing. Only possible
regression will be if somebody was doing partial block zeroing on sector
boundary, then poison will not be cleared.

We now seem to be discussing too many issues w.r.t poison clearing
and dax. Atleast 3 issues are mentioned in this thread.

A. Get rid of dependency on block device in dax zeroing path.
   (__dax_zero_page_range)

B. Provide a way to clear latent poison. And possibly use movdir64b to
   do that and make filesystems use that interface for initialization
   of blocks.

C. Dax zero operation is clearing known poison while copy_from_iter() is
   not. I guess this ship has already sailed. If we change it now,
   somebody will complain of some regression.

For issue A, there are two possible ways to deal with it.

1. Implement a dax method to zero page. And this method will also clear
   known poison. This is what my patch series is doing.

2. Just get rid of blkdev_issue_zeroout() from __dax_zero_page_range()
   so that no poison will be cleared in __dax_zero_page_range() path. This
   path is currently used in partial page zeroing path and full filesystem
   block zeroing happens with blkdev_issue_zeroout(). There is a small
   chance of regression here in case of sector aligned partial block
   zeroing.

My patch series takes care of issue A without any regressions. In fact it
improves current interface. For example, currently "truncate -s 512
foo.txt" will succeed even if first sector in the block is poisoned. My
patch series fixes it. Current implementation will return error on if any
non sector aligned truncate is done and any of the sector is poisoned. My
implementation will not return error if poisoned can be cleared as part
of zeroing. It will return only if poison is present in non-zeoring part.

Why don't we solve one issue A now and deal with issue B and C later in
a sepaprate patch series. This patch series gets rid of dependency on 
block device in dax path and also makes current zeroing interface better.

Thanks
Vivek

