Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E841FA537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 02:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFPAjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 20:39:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33861 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFPAjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:39:18 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3320C82189D;
        Tue, 16 Jun 2020 10:39:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jkzd1-0001WN-5v; Tue, 16 Jun 2020 10:39:03 +1000
Date:   Tue, 16 Jun 2020 10:39:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200616003903.GC2005@dread.disaster.area>
References: <20200615160244.741244-1-agruenba@redhat.com>
 <20200615233239.GY2040@dread.disaster.area>
 <20200615234437.GX8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615234437.GX8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=rLt4B8utZ7MY9GfhgBkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:44:37PM -0700, Matthew Wilcox wrote:
> On Tue, Jun 16, 2020 at 09:32:39AM +1000, Dave Chinner wrote:
> > On Mon, Jun 15, 2020 at 06:02:44PM +0200, Andreas Gruenbacher wrote:
> > > Make sure iomap_end is always called when iomap_begin succeeds: the
> > > filesystem may take locks in iomap_begin and release them in iomap_end,
> > > for example.
> > 
> > Ok, i get that from the patch, but I don't know anything else about
> > this problem, and nor will anyone else trying to determine if this
> > is a fix they need to backport to other kernels. Can you add some
> > more information to the commit message, such as how was this found
> > and what filesystems it affects? It would also be good to know what
> > commit introduced this issue and whether it need stable back ports
> > (i.e. a Fixes tag).
> 
> I'd assume Andreas is looking at converting a filesystem to use iomap,
> since this problem only occurs for filesystems which have returned an
> invalid extent.

Well, I can assume it's gfs2, but you know what happens when you
assume something....

> I almost wonder if this should return -EFSCORRUPTED rather than -EIO.

We've typically used -EFSCORRUPTED for metadata corruptions and -EIO
for data IO errors that result from metadata corruption. -EIO
implies that the IO failed and the state of the data is
indeterminate (i.e. may be corrupted), but the filesystem is still
ok, whereas EFSCORRUPTED implies the filesystem needs to have fsck
run on it to diagnose and fix the metadata corruption.

This code sort of spans the grey area between them. The error could
come from in in-memory bug and not actually a filesystem corruption,
so it's not clear that corruption is the right thing to report
here...

> Um, except that's currently a per-fs define.  Is it time to move that
> up to errno.h?

Has the "EFSCORRUPTED = EUCLEAN is stupid - let's break a
longstanding user API by defining it to something completely new"
yelling died down enough in the 6 months since this was last
proposed?

https://lore.kernel.org/linux-xfs/20191031010736.113783-1-Valdis.Kletnieks@vt.edu/
https://lore.kernel.org/linux-xfs/20191104014510.102356-11-Valdis.Kletnieks@vt.edu/

We've only been trying to get a generic -EFSCORRUPTED definition
into the kernel errno headers for ~15 years... :(

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
