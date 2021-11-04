Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48D5445A3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 20:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhKDTHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 15:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233947AbhKDTHW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 15:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B349D61051;
        Thu,  4 Nov 2021 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636052683;
        bh=6QPcBULZTXdCSGAGAHS0TvJSZvMO/KqkGnLb73dsPBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bv7jKp3Yw1Rdie9XZDWNK3pIPqQoPNhud+EqCebVCSNFnXX1tJKRugwxgw+L+OWGR
         2MLp/jTRGzvo1NoqGoAE4h9SET6WwR2eC6KxGEbcMshVRiJ3shOzD+v3fRuOlCDV9R
         9G84hJuxDUt0jNPNpbLWG5OuhVHMx1EBgq9VUuR/29TPkJQ2u2B/sSSO0SotyKedJk
         vIVOo9i23NlZDiCmEUONOL1Ve83kSVqtxk9oDKbsfMth7fdhjwVmAa4V9JJhr/fdzN
         4WL/W9RmR5LhAyY6JcVhB45zjOxTxwGLojZm72rrw52Ey6bohVc7ZaZCNnE2bWDg9r
         QNnReKci3yYEQ==
Date:   Thu, 4 Nov 2021 12:04:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Sandeen <sandeen@sandeen.net>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104190443.GK24333@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de>
 <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:10:19AM -0700, Dan Williams wrote:
> On Thu, Nov 4, 2021 at 10:36 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Nov 04, 2021 at 10:34:17AM -0700, Darrick J. Wong wrote:
> > > /me wonders, are block devices going away?  Will mkfs.xfs have to learn
> > > how to talk to certain chardevs?  I guess jffs2 and others already do
> > > that kind of thing... but I suppose I can wait for the real draft to
> > > show up to ramble further. ;)
> >
> > Right now I've mostly been looking into the kernel side.  An no, I
> > do not expect /dev/pmem* to go away as you'll still need it for a
> > not DAX aware file system and/or application (such as mkfs initially).
> >
> > But yes, just pointing mkfs to the chardev should be doable with very
> > little work.  We can point it to a regular file after all.
> 
> Note that I've avoided implementing read/write fops for dax devices
> partly out of concern for not wanting to figure out shared-mmap vs
> write coherence issues, but also because of a bet with Dave Hansen
> that device-dax not grow features like what happened to hugetlbfs. So
> it would seem mkfs would need to switch to mmap I/O, or bite the
> bullet and implement read/write fops in the driver.

That ... would require a fair amount of userspace changes, though at
least e2fsprogs has pluggable io drivers, which would make mmapping a
character device not too awful.

xfsprogs would be another story -- porting the buffer cache mignt not be
too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
Note that xfsprogs explicitly screens out chardevs.

--D
