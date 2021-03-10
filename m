Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EC333FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 14:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhCJNzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 08:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhCJNzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:55:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C50C061760;
        Wed, 10 Mar 2021 05:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASkeCYNO3dhrSyJuXDJUBfebpEQzrlHM2DpTFAkPLVI=; b=Tt7ayNXNWXK2bTVKrYTcEgnkh+
        f1XcrJPHapkQa44CIKSbezQvxwWp57snh9ZQwPdTMAk8AB48/hoKyAYsV3ZU4LGI3DP+I6nECBWbe
        mY8h829FSnSMNv/PCAsrzVymOeG/qWx13tFKzswafFltkt9XHyX7vptRhmgxV+4sHHs8TT+u96GSL
        4nlKgrcNvpOFZWyOF3okP7Uk5+XNkqMtBb7NgFccqDeLTOWWgoQL+VFa7b1Ix9secQvnL/Gs/rzb7
        Aq26qRzbQFKc31DbCj6H7qdLZAgtko2Pd9+6RYYvXLu4N3eSeb9hz4Wf+6HZD9JmGcZZiCUZ26U0N
        zLJxPIow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJzJD-003a9C-NN; Wed, 10 Mar 2021 13:55:32 +0000
Date:   Wed, 10 Mar 2021 13:55:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com, jack@suse.cz,
        viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310135531.GP3479805@casper.infradead.org>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <CAEg-Je-F6ybPPV22-hq9=cuUCA7cw2xAA7Y-97tKhYUX1+fDwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-F6ybPPV22-hq9=cuUCA7cw2xAA7Y-97tKhYUX1+fDwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:36:06AM -0500, Neal Gompa wrote:
> On Wed, Mar 10, 2021 at 8:02 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > Btrfs at the same time? It seems weird to me that adding a feature
> >
> > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> >
> > If you think about it, btrfs and DAX are diametrically opposite things.
> > DAX is about giving raw access to the hardware.  btrfs is about offering
> > extra value (RAID, checksums, ...), none of which can be done if the
> > filesystem isn't in the read/write path.
> >
> > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > to give up all the features you like in btrfs.  So you may as well use
> > a different filesystem.
> 
> So does that mean that DAX is incompatible with those filesystems when
> layered on DM (e.g. through LVM)?

Yes.  It might be possible to work through RAID-0 or read-only through
RAID-1, but I'm not sure anybody's bothered to do that work.

> Also, based on what you're saying, that means that DAX'd resources
> would not be able to use reflinks on XFS, right? That'd put it in
> similar territory as swap files on Btrfs, I would think.

You can use DAX with reflinks because the CPU can do read-only mmaps.
On a write fault, we break the reflink, copy the data and put in a
writable PTE.
