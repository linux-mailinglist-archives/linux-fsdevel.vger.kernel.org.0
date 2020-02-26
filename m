Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08DD170507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBZQ6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:58:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727141AbgBZQ6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582736284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgFRQgERnZWSeTCYUsPGjYde4JUbCe/DftIr4ctMkfU=;
        b=Z5HqPk7RJNoP+Rc30O9vQpEQuaeAj1rdu/1n/6L8WW59XCFlB2keycTqvFU+0+kZtAjl8q
        scWf6wKp8wpQDgGYX4SjjUp95d6ykSohs7guPRNv//T9lvWCiBsjEvhkQvzbsLwis/2n1I
        lRigFNMahOlR29ev/THcNuJmMTmSZLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-gR2VWTs9ONWsOjFxXq7p1A-1; Wed, 26 Feb 2020 11:58:01 -0500
X-MC-Unique: gR2VWTs9ONWsOjFxXq7p1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 869FE107ACC4;
        Wed, 26 Feb 2020 16:57:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE30660BE1;
        Wed, 26 Feb 2020 16:57:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 76F622257D2; Wed, 26 Feb 2020 11:57:56 -0500 (EST)
Date:   Wed, 26 Feb 2020 11:57:56 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200226165756.GB30329@redhat.com>
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
> xfs_zero_extent() and sb_issue_zeroout().

Well I was wrong. I found atleast one user which uses __dax_zero_page_range()
to zero full PAGE_SIZE blocks.

xfs_io -c "allocsp 32K 0" foo.txt

In that case, I will add a new dax method say dax_zero_page_range() which will
only take PAGE_SIZE aligned range will clear known poison and call that
from __dax_zero_page_range() if I/O is PAGE_SIZE aligned.

For now I will limit this interface to take only single page at a time
because otherwise implementation becomes complex in dm/md stack where
range has to be broken across multiple devices and there are no users
because current iomap API passes one page at a time.

So once we have grown users, then one can also tackle the complexity of
modifying dm/md to break a page range across multiple devices.

Will post a patch series for this.

Thanks
Vivek

