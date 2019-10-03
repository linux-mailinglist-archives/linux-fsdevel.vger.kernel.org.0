Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB0C9A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfJCInn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 04:43:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbfJCInm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:43:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 094CDB144;
        Thu,  3 Oct 2019 08:43:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3588D1E4810; Thu,  3 Oct 2019 10:43:59 +0200 (CEST)
Date:   Thu, 3 Oct 2019 10:43:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Lease semantic proposal
Message-ID: <20191003084359.GB17911@quack2.suse.cz>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
 <2b42cf4ae669cedd061c937103674babad758712.camel@kernel.org>
 <20191002192711.GA21386@fieldses.org>
 <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-10-19 16:35:55, Jeff Layton wrote:
> On Wed, 2019-10-02 at 15:27 -0400, J. Bruce Fields wrote:
> > On Wed, Oct 02, 2019 at 08:28:40AM -0400, Jeff Layton wrote:
> > > On Tue, 2019-10-01 at 11:17 -0700, Ira Weiny wrote:
> > > > On Mon, Sep 23, 2019 at 04:17:59PM -0400, Jeff Layton wrote:
> > > > > On Mon, 2019-09-23 at 12:08 -0700, Ira Weiny wrote:
> > > > > > Since the last RFC patch set[1] much of the discussion of supporting RDMA with
> > > > > > FS DAX has been around the semantics of the lease mechanism.[2]  Within that
> > > > > > thread it was suggested I try and write some documentation and/or tests for the
> > > > > > new mechanism being proposed.  I have created a foundation to test lease
> > > > > > functionality within xfstests.[3] This should be close to being accepted.
> > > > > > Before writing additional lease tests, or changing lots of kernel code, this
> > > > > > email presents documentation for the new proposed "layout lease" semantic.
> > > > > > 
> > > > > > At Linux Plumbers[4] just over a week ago, I presented the current state of the
> > > > > > patch set and the outstanding issues.  Based on the discussion there, well as
> > > > > > follow up emails, I propose the following addition to the fcntl() man page.
> > > > > > 
> > > > > > Thank you,
> > > > > > Ira
> > > > > > 
> > > > > > [1] https://lkml.org/lkml/2019/8/9/1043
> > > > > > [2] https://lkml.org/lkml/2019/8/9/1062
> > > > > > [3] https://www.spinics.net/lists/fstests/msg12620.html
> > > > > > [4] https://linuxplumbersconf.org/event/4/contributions/368/
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Thank you so much for doing this, Ira. This allows us to debate the
> > > > > user-visible behavior semantics without getting bogged down in the
> > > > > implementation details. More comments below:
> > > > 
> > > > Thanks.  Sorry for the delay in response.  Turns out this email was in my
> > > > spam...  :-/  I'll need to work out why.
> > > > 
> > > > > > <fcntl man page addition>
> > > > > > Layout Leases
> > > > > > -------------
> > > > > > 
> > > > > > Layout (F_LAYOUT) leases are special leases which can be used to control and/or
> > > > > > be informed about the manipulation of the underlying layout of a file.
> > > > > > 
> > > > > > A layout is defined as the logical file block -> physical file block mapping
> > > > > > including the file size and sharing of physical blocks among files.  Note that
> > > > > > the unwritten state of a block is not considered part of file layout.
> > > > > > 
> > > > > > **Read layout lease F_RDLCK | F_LAYOUT**
> > > > > > 
> > > > > > Read layout leases can be used to be informed of layout changes by the
> > > > > > system or other users.  This lease is similar to the standard read (F_RDLCK)
> > > > > > lease in that any attempt to change the _layout_ of the file will be reported to
> > > > > > the process through the lease break process.  But this lease is different
> > > > > > because the file can be opened for write and data can be read and/or written to
> > > > > > the file as long as the underlying layout of the file does not change.
> > > > > > Therefore, the lease is not broken if the file is simply open for write, but
> > > > > > _may_ be broken if an operation such as, truncate(), fallocate() or write()
> > > > > > results in changing the underlying layout.
> > > > > > 
> > > > > > **Write layout lease (F_WRLCK | F_LAYOUT)**
> > > > > > 
> > > > > > Write Layout leases can be used to break read layout leases to indicate that
> > > > > > the process intends to change the underlying layout lease of the file.
> > > > > > 
> > > > > > A process which has taken a write layout lease has exclusive ownership of the
> > > > > > file layout and can modify that layout as long as the lease is held.
> > > > > > Operations which change the layout are allowed by that process.  But operations
> > > > > > from other file descriptors which attempt to change the layout will break the
> > > > > > lease through the standard lease break process.  The F_LAYOUT flag is used to
> > > > > > indicate a difference between a regular F_WRLCK and F_WRLCK with F_LAYOUT.  In
> > > > > > the F_LAYOUT case opens for write do not break the lease.  But some operations,
> > > > > > if they change the underlying layout, may.
> > > > > > 
> > > > > > The distinction between read layout leases and write layout leases is that
> > > > > > write layout leases can change the layout without breaking the lease within the
> > > > > > owning process.  This is useful to guarantee a layout prior to specifying the
> > > > > > unbreakable flag described below.
> > > > > > 
> > > > > > 
> > > > > 
> > > > > The above sounds totally reasonable. You're essentially exposing the
> > > > > behavior of nfsd's layout leases to userland. To be clear, will F_LAYOUT
> > > > > leases work the same way as "normal" leases, wrt signals and timeouts?
> > > > 
> > > > That was my intention, yes.
> > > > 
> > > > > I do wonder if we're better off not trying to "or" in flags for this,
> > > > > and instead have a separate set of commands (maybe F_RDLAYOUT,
> > > > > F_WRLAYOUT, F_UNLAYOUT). Maybe I'm just bikeshedding though -- I don't
> > > > > feel terribly strongly about it.
> > > > 
> > > > I'm leaning that was as well.  To make these even more distinct from
> > > > F_SETLEASE.
> > > > 
> > > > > Also, at least in NFSv4, layouts are handed out for a particular byte
> > > > > range in a file. Should we consider doing this with an API that allows
> > > > > for that in the future? Is this something that would be desirable for
> > > > > your RDMA+DAX use-cases?
> > > > 
> > > > I don't see this.  I've thought it would be a nice thing to have but I don't
> > > > know of any hard use case.  But first I'd like to understand how this works for
> > > > NFS.
> > > > 
> > > 
> > > The NFSv4.1 spec allows the client to request the layouts for a
> > > particular range in the file:
> > > 
> > > https://tools.ietf.org/html/rfc5661#page-538
> > > 
> > > The knfsd only hands out whole-file layouts at present. Eventually we
> > > may want to make better use of segmented layouts, at which point we'd
> > > need something like a byte-range lease.
> > > 
> > > > > We could add a new F_SETLEASE variant that takes a struct with a byte
> > > > > range (something like struct flock).
> > > > 
> > > > I think this would be another reason to introduce F_[RD|WR|UN]LAYOUT as a
> > > > command.  Perhaps supporting smaller byte ranges could be added later?
> > > > 
> > > 
> > > I'd definitely not multiplex this over F_SETLEASE. An F_SETLAYOUT cmd
> > > would probably be sufficient, and maybe just reuse
> > > F_RDLCK/F_WRLCK/F_UNLCK for the iomode?
> > > 
> > > For the byte ranges, the catch there is that extending the userland
> > > interface for that later will be difficult.
> > 
> > Why would it be difficult?
> > 
> 
> Legacy userland code that wanted to use byte range enabled layouts would
> have to be rebuilt to take advantage of them. If we require a range from
> the get-go, then they will get the benefit of them once they're
> available.

I don't think this is true. Because current implementation of locking the
whole file may hide implementation bugs in userspace. So the new
range lock handling may break userspace and history shows such
problems with APIs are actually rather common. So I think switching to
range locking *must* be conscious decision of the application and as
such having separate API for that is the most natural thing to do.

> > > What I'd probably suggest
> > > (and what would jive with the way pNFS works) would be to go ahead and
> > > add an offset and length to the arguments and result (maybe also
> > > whence?).
> > 
> > Why not add new commands with range arguments later if it turns out to
> > be necessary?
> 
> We could do that. It'd be a little ugly, IMO, simply because then we'd
> end up with two interfaces that do almost the exact same thing.
> 
> Should byte-range layouts at that point conflict with non-byte range
> layouts, or should they be in different "spaces" (a'la POSIX and flock
> locks)? When it's all one interface, those sorts of questions sort of
> answer themselves. When they aren't we'll have to document them clearly
> and I think the result will be more confusing for userland programmers.
> 
> If you felt strongly about leaving those out for now, you could just do
> something similar to what Aleksa is planning for openat2 -- have a
> struct pointer and length as arguments for this cmd, and only have a
> single iomode member in there for now.
> 
> The kernel would have to know how to deal with "legacy" and byte-range-
> enabled variants if we ever extend it, but that's not too hard to
> handle.

Yeah, so we can discuss how to make possible future extension towards
range locking the least confusing to userspace. E.g. we can just put the
ranges in the API and require that start is always 0 and end is always
ULONG_MAX or whatever. But switching to smaller ranges must be the decision
in the application after the kernel supports it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
