Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D205B8C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINQBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiINQB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6914606A0;
        Wed, 14 Sep 2022 09:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA8A6164C;
        Wed, 14 Sep 2022 16:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BEFC433C1;
        Wed, 14 Sep 2022 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663171285;
        bh=BM4D7AH4yvHm0GxHXDSvKWfndiTEgl9zsYRJs6mes08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8oWU5KCkE573b2yHUL7CFsszVUhGg9QlenZS5BXfZJdNgGwvC+7KMfXhPJhNgzLG
         uJz3W9k4TaYa4ML++I2JEHU+yGjHBZ3GNovNSqFtTPDtG6SRE4i1hfB94kmQk83rxN
         mEtIxwufhUto8N0lr5XTnvOwH9efKPpx8VMJdz+n5/+kw9F4ECykPdeie6q8xOuZBO
         ODjGGtS2WVi4qpDBvIWapmhKESBLwbdjyKheZEEnZ08VN3pbnE4hxP56la/gejm78Z
         ZQss3wYIsHQ9kGP+49WfYaoonnOlp0FttZ6AjODzujtwS3qRCyYgDwpzqeGO3yj6En
         Oie7bYVKWRg4w==
Date:   Wed, 14 Sep 2022 09:01:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <YyH61deSiW1TnY//@magnolia>
References: <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 05:40:46PM +0300, Amir Goldstein wrote:
> On Tue, Jun 21, 2022 at 3:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 11:59 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > > > > How exactly do you imagine the synchronization of buffered read against
> > > > > buffered write would work? Lock all pages for the read range in the page
> > > > > cache? You'd need to be careful to not bring the machine OOM when someone
> > > > > asks to read a huge range...
> > > >
> > > > I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> > > > today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> > > > when reading data into user buffer, but before that, I would like to issue
> > > > and wait for read of the pages in the range to reduce the probability
> > > > of doing the read I/O under XFS_IOLOCK_SHARED.
> > > >
> > > > The pre-warm of page cache does not need to abide to the atomic read
> > > > semantics and it is also tolerable if some pages are evicted in between
> > > > pre-warn and read to user buffer - in the worst case this will result in
> > > > I/O amplification, but for the common case, it will be a big win for the
> > > > mixed random r/w performance on xfs.
> > > >
> > > > To reduce risk of page cache thrashing we can limit this optimization
> > > > to a maximum number of page cache pre-warm.
> > > >
> > > > The questions are:
> > > > 1. Does this plan sound reasonable?
> > >
> > > Ah, I see now. So essentially the idea is to pull the readahead (which is
> > > currently happening from filemap_read() -> filemap_get_pages()) out from under
> > > the i_rwsem. It looks like a fine idea to me.
> >
> 
> Although I was able to demonstrate performance improvement
> with page cache pre-warming on low latency disks, when testing
> on a common standard system [*], page cache pre-warming did not
> yield any improvement to the mixed rw workload.
> 
> [*] I ran the following fio workload on e2-standard-8 GCE machine:
> 
> [global]
> filename=/mnt/xfs/testfile.fio
> norandommap
> randrepeat=0
> size=5G
> bs=8K
> ioengine=psync
> numjobs=8
> group_reporting=1
> direct=0
> fallocate=1
> end_fsync=0
> runtime=60
> 
> [xfs-read]
> readwrite=randread
> 
> [xfs-write]
> readwrite=randwrite
> 
> The difference between ext4 and xfs with this machine/workload was
> two orders of magnitude:
> 
> root@xfstests:~# fio ./ext4.fio
> ...
> Run status group 0 (all jobs):
>    READ: bw=826MiB/s (866MB/s), 826MiB/s-826MiB/s (866MB/s-866MB/s),
> io=40.0GiB (42.9GB), run=49585-49585msec
>   WRITE: bw=309MiB/s (324MB/s), 309MiB/s-309MiB/s (324MB/s-324MB/s),
> io=18.1GiB (19.5GB), run=60003-60003msec
> 
> root@xfstests:~# fio ./xfs.fio
> ...
> Run status group 0 (all jobs):
>    READ: bw=7053KiB/s (7223kB/s), 7053KiB/s-7053KiB/s
> (7223kB/s-7223kB/s), io=413MiB (433MB), run=60007-60007msec
>   WRITE: bw=155MiB/s (163MB/s), 155MiB/s-155MiB/s (163MB/s-163MB/s),
> io=9324MiB (9777MB), run=60006-60006msec
> 
> I verified that without XFS_IOLOCK_SHARED xfs fio results are on par
> with ext4 results for this workload.
> 
> >
> > > just cannot comment on whether calling this without i_rwsem does not break
> > > some internal XFS expectations for stuff like reflink etc.
> >
> > relink is done under xfs_ilock2_io_mmap => filemap_invalidate_lock_two
> > so it should not be a problem.
> >
> > pNFS leases I need to look into.
> >
> 
> I wonder if xfs_fs_map_blocks() and xfs_fs_commit_blocks()
> should not be taking the invalidate lock before calling
> invalidate_inode_pages2() like the xfs callers of
> truncate_pagecache_range() do?
> 
> If we do that, then I don't see a problem with buffered read
> without XFS_IOLOCK_SHARED w.r.t. correctness of layout leases.
> 
> Dave, Christoph,
> 
> I know that you said that changing the atomic buffered read semantics
> is out of the question and that you also objected to a mount option
> (which nobody will know how to use) and I accept that.
> 
> Given that a performant range locks implementation is not something
> trivial to accomplish (Dave please correct me if I am wrong),
> and given the massive performance impact of XFS_IOLOCK_SHARED
> on this workload,
> what do you think about POSIX_FADV_TORN_RW that a specific
> application can use to opt-out of atomic buffer read semantics?
> 
> The specific application that I want to modify to use this hint is Samba.
> Samba uses IO threads by default to issue pread/pwrite on the server
> for IO requested by the SMB client. The IO size is normally larger than
> xfs block size and the range may not be block aligned.
> 
> The SMB protocol has explicit byte range locks and the server implements
> them, so it is pretty safe to assume that a client that did not request
> range locks does not need xfs to do the implicit range locking for it.
> 
> For this reason and because of the huge performance win,
> I would like to implement POSIX_FADV_TORN_RW in xfs and
> have Samba try to set this hint when supported.
> 
> It is very much possible that NFSv4 servers (user and kennel)
> would also want to set this hint for very similar reasons.
> 
> Thoughts?

How about range locks for i_rwsem and invalidate_lock?  That could
reduce contention on VM farms, though I can only assume that, given that
I don't have a reference implementation to play with...

--D

> Thanks,
> Amir.
