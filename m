Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA12F05A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 07:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbhAJGOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 01:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbhAJGOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 01:14:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA5C061786;
        Sat,  9 Jan 2021 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNdziTbQbEJ9mo4mjqBaEUuZozMS1eNM8r/cJMJoprY=; b=SsfT8KjpTJHHhQ8OIYtxfv9/Ii
        TdZoUe768+SB0A2U8voTxFHiKC7KjTFx9AElQatAVXunYvC6bM4WdH9g1fq3IbWOmbO6SK/GDSBAk
        Beznn47owEO/xpUe5dBBTOY2zElJZrLyLh5THB9hoN+QcO0POI2/FeW4TCKpfnl2t/TIjyx8LjG2R
        pLCEf4RZMXyipHT+QZ8x3k8mma4VCk8BbYfYLAKvsb+9sMs1JWPyjA5/ZB8fl42iyEis5CWJ/tSnz
        5EtHLksnUq35W5uGAi0IhRNu2CulCK4X0XwCg8eGv3HZdIVBVVKyCTBkTcNHVIDaSWAr6FEAb8JSD
        /oCMRNhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyTyb-001Rl1-QK; Sun, 10 Jan 2021 06:13:24 +0000
Date:   Sun, 10 Jan 2021 06:13:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Expense of read_iter
Message-ID: <20210110061321.GC35215@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:59:01PM -0500, Mikulas Patocka wrote:
> On Thu, 7 Jan 2021, Matthew Wilcox wrote:
> > On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > > I'd like to ask about this piece of code in __kernel_read:
> > > 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
> > > 		return warn_unsupported...
> > > and __kernel_write:
> > > 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> > > 		return warn_unsupported...
> > > 
> > > - It exits with an error if both read_iter and read or write_iter and 
> > > write are present.
> > > 
> > > I found out that on NVFS, reading a file with the read method has 10% 
> > > better performance than the read_iter method. The benchmark just reads the 
> > > same 4k page over and over again - and the cost of creating and parsing 
> > > the kiocb and iov_iter structures is just that high.
> > 
> > Which part of it is so expensive?
> 
> The read_iter path is much bigger:
> vfs_read		- 0x160 bytes
> new_sync_read		- 0x160 bytes
> nvfs_rw_iter		- 0x100 bytes
> nvfs_rw_iter_locked	- 0x4a0 bytes
> iov_iter_advance	- 0x300 bytes

Number of bytes in a function isn't really correlated with how expensive
a particular function is.  That said, looking at new_sync_read() shows
one part that's particularly bad, init_sync_kiocb():

static inline int iocb_flags(struct file *file)
{
        int res = 0;
        if (file->f_flags & O_APPEND)
                res |= IOCB_APPEND;
     7ec:       8b 57 40                mov    0x40(%rdi),%edx
     7ef:       48 89 75 80             mov    %rsi,-0x80(%rbp)
        if (file->f_flags & O_DIRECT)
     7f3:       89 d0                   mov    %edx,%eax
     7f5:       c1 e8 06                shr    $0x6,%eax
     7f8:       83 e0 10                and    $0x10,%eax
                res |= IOCB_DIRECT;
        if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
     7fb:       89 c1                   mov    %eax,%ecx
     7fd:       81 c9 00 00 02 00       or     $0x20000,%ecx
     803:       f6 c6 40                test   $0x40,%dh
     806:       0f 45 c1                cmovne %ecx,%eax
                res |= IOCB_DSYNC;
     809:       f6 c6 10                test   $0x10,%dh
     80c:       75 18                   jne    826 <new_sync_read+0x66>
     80e:       48 8b 8f d8 00 00 00    mov    0xd8(%rdi),%rcx
     815:       48 8b 09                mov    (%rcx),%rcx
     818:       48 8b 71 28             mov    0x28(%rcx),%rsi
     81c:       f6 46 50 10             testb  $0x10,0x50(%rsi)
     820:       0f 84 e2 00 00 00       je     908 <new_sync_read+0x148>
        if (file->f_flags & __O_SYNC)
     826:       83 c8 02                or     $0x2,%eax
                res |= IOCB_SYNC;
        return res;
     829:       89 c1                   mov    %eax,%ecx
     82b:       83 c9 04                or     $0x4,%ecx
     82e:       81 e2 00 00 10 00       and    $0x100000,%edx

We could optimise this by, eg, checking for (__O_SYNC | O_DIRECT |
O_APPEND) and returning 0 if none of them are set, since they're all
pretty rare.  It might be better to maintain an f_iocb_flags in the
struct file and just copy that unconditionally.  We'd need to remember
to update it in fcntl(F_SETFL), but I think that's the only place.


> If we go with the "read" method, there's just:
> vfs_read		- 0x160 bytes
> nvfs_read		- 0x200 bytes
> 
> > Is it worth, eg adding an iov_iter
> > type that points to a single buffer instead of a single-member iov?

>      6.57%  pread    [nvfs]            [k] nvfs_rw_iter_locked
>      2.31%  pread    [kernel.vmlinux]  [k] new_sync_read
>      1.89%  pread    [kernel.vmlinux]  [k] iov_iter_advance
>      1.24%  pread    [nvfs]            [k] nvfs_rw_iter
>      0.29%  pread    [kernel.vmlinux]  [k] iov_iter_init

>      2.71%  pread    [nvfs]            [k] nvfs_read

> Note that if we sum the percentage of nvfs_iter_locked, new_sync_read, 
> iov_iter_advance, nvfs_rw_iter, we get 12.01%. On the other hand, in the 
> second trace, nvfs_read consumes just 2.71% - and it replaces 
> functionality of all these functions.
> 
> That is the reason for that 10% degradation with read_iter.

You seem to be focusing on your argument for "let's just permit
filesystems to implement both ->read and ->read_iter".  My suggestion
is that we need to optimise the ->read_iter path, but to do that we need
to know what's expensive.

nvfs_rw_iter_locked() looks very complicated.  I suspect it can
be simplified.  Of course new_sync_read() needs to be improved too,
as do the other functions here, but fully a third of the difference
between read() and read_iter() is the difference between nvfs_read()
and nvfs_rw_iter_locked().
