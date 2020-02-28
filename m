Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16D172F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 04:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgB1D2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 22:28:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgB1D2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:28:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so1523032oie.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 19:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEX6rvdBlO7hz9k8V7o5YOXnBqCUwNjK2oTZUppbe28=;
        b=iFtgCGgz7stZT+cTg0hEEXaO6+15FCXvWoh0GPbqKQE17YrUava9nJT2WH5/fEUePy
         hWaaTAxg8ONBYVQnvIyUU0UXZdpKmU5/h54lowSHdTy1ko2XzKsUE/V82ZvP4RN7dCu7
         qKTGAa8oWqij2/t07hF3e+G/Cm431bgJzuBWfBUFL1Lr2JEDqbmSscKoldDvYrL6NP8G
         S/xqMZttg9FiCRMgNIczj2TwUN/45WkdAne58ZRNQ8yodldeCCLic/LXD0i1FZ12upL+
         4UjrSmXjdFhQC5TmfNfJmn1kWGKcDxNczhFRqNRKTcG+yAFNJ82E6v90QTo8/keoV2qI
         q87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEX6rvdBlO7hz9k8V7o5YOXnBqCUwNjK2oTZUppbe28=;
        b=dKC3tbOliJ8iNWQZtvTrRoyV0c/UWihpIAKIgfl/2p7fWpSv7lBifnJSzszNa+Wz3z
         6ziME7jwTuMshLzyhkRmL1y/jMebYxLqStA8dxS/PyylW8YDJMa10EsWUVhvbCKctJBB
         ipj2DJQ0ubQh28Q0ahRyur+F3wK8Z3ElG5xxQEhcaGVrrkBjHuT4t8oH/ERBkEPJbbGd
         CIYObVvDBOlC52Xq0eMNhO1sfV5mLoGZRd1nbUwzFUTXtkig/zMIT2I9U+njipEjYCTw
         8n4Pv4LJV3LmHeiRTxskIGBwgmmcL9Wv6wcSHLbax6f4fz0viIy1FihQzx6XodGv3xWI
         eEug==
X-Gm-Message-State: APjAAAWRQH128Z6SIdc5yUMHbP1E51g86LDFe+p9KUU9pbfrmZO7DLhR
        CLOLnvxgs/9cK/WyadiJQIgngV0+y42iTehlP0L06w==
X-Google-Smtp-Source: APXvYqwQar6+RTCUGLwq/zZ52sZmJNQGhbFyt0+u8eKfi4z6SLcYdrIfqOMEAyhGR5Y0vg5HRZsmmP1OzNllORh8E8c=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr1636050oia.73.1582860532725;
 Thu, 27 Feb 2020 19:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area> <20200224153844.GB14651@redhat.com>
 <20200227030248.GG10737@dread.disaster.area> <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
 <20200228013054.GO10737@dread.disaster.area>
In-Reply-To: <20200228013054.GO10737@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Feb 2020 19:28:41 -0800
Message-ID: <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:31 PM Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Feb 26, 2020 at 08:19:37PM -0800, Dan Williams wrote:
[..]
> > So you want the FS to have error handling for just pmem errors or all
> > memory errors?
>
> Just pmem errors in the specific range the filesystem manages - we
> really only care storage errors because those are the only errors
> the filesystem is responsible for handling correctly.
>
> Somebody else can worry about errors that hit page cache pages -
> page cache pages require mapping/index pointers on each page anyway,
> so a generic mechanism for handling those errors can be built into
> the page cache. And if the error is in general kernel memory, then
> it's game over for the entire kernel at that point, not just the
> filesystem.
>
> > And you want this to be done without the mm core using
> > page->index to identify what to unmap when the error happens?
>
> Isn't that exactly what I just said? We get the page address that
> failed, the daxdev can turn that into a sector address and call into
> the filesystem with a {sector, len, errno} tuple. We then do a
> reverse mapping lookup on {sector, len} to find all the owners of
> that range in the filesystem. If it's file data, that owner record
> gives us the inode and the offset into the file, which then gives us
> a {mapping, index} tuple.
>
> Further, the filesytem reverse map is aware that it's blocks can be
> shared by multiple owners, so it will have a record for every inode
> and file offset that maps to that page. Hence we can simply iterate
> the reverse map and do that whacky collect_procs/kill_procs dance
> for every {mapping, index} pair that references the the bad range.
>
> Nothing ever needs to be stored on the struct page...

Ok, so fs/dax.c needs to coordinate with mm/memory-failure.c to say
"don't perform generic memory-error-handling, there's an fs that owns
this daxdev and wants to disposition errors". The fs/dax.c
infrastructure that sets up ->index and ->mapping would still need to
be there for ext4 until its ready to take on the same responsibility.
Last I checked the ext4 reverse mapping implementation was not as
capable as XFS. This goes back to why the initial design avoided
relying on not universally available / stable reverse-mapping
facilities and opted for extending the generic mm/memory-failure.c
implementation.

If XFS optionally supplants mm/memory-failure.c I would expect we'd
want to do better than the "whacky collect_procs/kill_procs"
implementation and let applications register for a notification format
better than BUS_MCEERR_AO signals.

> > Memory
> > error scanning is not universally available on all pmem
> > implementations, so FS will need to subscribe for memory-error
> > handling events.
>
> No. Filesystems interact with the underlying device abstraction, not
> the physical storage that lies behind that device abstraction.  The
> filesystem should not interface with pmem directly in any way (all
> direct accesses are hidden inside fs/dax.c!), nor should it care
> about the quirks of the pmem implementation it is sitting on. That's
> what the daxdev abstraction is supposed to hide from the users of
> the pmem.

I wasn't proposing that XFS have a machine-check handler, I was trying
to get to the next level detail of the async notification interface to
the fs.

>
> IOWs, the daxdev infrastructure subscribes to memory-error event
> subsystem, calls out to the filesystem when an error in a page in
> the daxdev is reported. The filesystem only needs to know the
> {sector, len, errno} tuple related to the error; it is the device's
> responsibility to handle the physical mechanics of listening,
> filtering and translating MCEs to a format the filesystem
> understands....
>
> Another reason it should be provided by the daxdev as a {sector,
> len, errno} tuple is that it also allows non-dax block devices to
> implement the similar error notifications and provide filesystems
> with exactly the same information so the filesystem can start
> auto-recovery processes....

The driver layer does already have 'struct badblocks' that both pmem
and md use, just no current way for the FS to get a reference to it.
However, my hope was to get away from the interface being sector based
because the error granularity is already smaller than a sector in the
daxdev case as compared to a bdev. A daxdev native error record should
be a daxdev relative byte offset, not a sector. If the fs wants to
align the blast radius of the error to sectors or fs-blocks that's its
choice, but I don't think the driver interface should preclude
sub-sector error handling. Essentially I don't want to add more bdev
semantics to fs/dax.c while Vivek is busy removing them.
