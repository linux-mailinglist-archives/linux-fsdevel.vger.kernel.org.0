Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3A598B3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiHRScO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbiHRSb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:31:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563FD1E0C;
        Thu, 18 Aug 2022 11:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A519FB823CF;
        Thu, 18 Aug 2022 18:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E8FC43141;
        Thu, 18 Aug 2022 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660847514;
        bh=8USowyvuGBhRQW/ns/BUh02F3EJfklK34uuxtt7/kn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oHNVY2TjdwwHxeSi0r9q5sOMdhSYIKl7jP9F8uM20zyMWZR5O8X6+4GHcyCw2ncdZ
         Wwoa/f36/JURNJf31LowfAFV5lUEYedcVQSQQiavGuycI2jxP3qyVCE48dpK946WQj
         2K4ds8+1GJl9ai2Bqu1THn7AVbYx+1nC1kqqKCKqtw4R9MgC3FFokYOwDFzn0JbwBH
         4rY58VMA1B/ZwM2mvrySgp/vto54JhcJMu7Z+s2mx4Jq+sFBDPCfDMMZV3Z2kSplWd
         IanukIJ5DI1/zzQHV9lDpLlppuV5gpclSajtX5SKNJOejs88O6ceEhey79QUAEj9sm
         L40Vh/b2Wi8jQ==
Received: by mail-wr1-f44.google.com with SMTP id n7so2685918wrv.4;
        Thu, 18 Aug 2022 11:31:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo39PybyZEdUgT6XB0OAQqsjTEevPA0zH1QZfBdDEmxVZfPoy7Al
        klWi/DQTtRrPJq5k0LE/61sOu++lO6l1f863l58=
X-Google-Smtp-Source: AA6agR4xsjyYGQaxxkDlbtMCKs/I9P0FWYs9o5YmZdb7NYLFKbglYxR0HQ08A++eQnkr57w5XGx99ijdnWG8AttS3uo=
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id
 g8-20020adfd1e8000000b002230bca8019mr2275405wrd.562.1660847512502; Thu, 18
 Aug 2022 11:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220715184433.838521-1-anna@kernel.org> <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com> <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area> <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area> <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
 <20220722004458.GS3600936@dread.disaster.area> <C581A93D-6797-4044-8719-1F797BA17761@oracle.com>
In-Reply-To: <C581A93D-6797-4044-8719-1F797BA17761@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 18 Aug 2022 14:31:36 -0400
X-Gmail-Original-Message-ID: <CAFX2JfmOO7RK3SirXLrRA9kpBC=ROnZydYBje4rowxi+vdoJLg@mail.gmail.com>
Message-ID: <CAFX2JfmOO7RK3SirXLrRA9kpBC=ROnZydYBje4rowxi+vdoJLg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS implementation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <Josef@toxicpanda.com>,
        ng-linux-team <ng-linux-team@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:09 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jul 21, 2022, at 8:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Jul 20, 2022 at 04:18:36AM +0000, Chuck Lever III wrote:
> >>> On Jul 19, 2022, at 10:36 PM, Dave Chinner <david@fromorbit.com> wrote:
> >>> On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
> >>>>> On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> >>>>> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
> >>>>> read operation" from the filesystem rather than the current "read
> >>>>> that fills holes with zeroes". i.e. a read operation that sets an
> >>>>> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
> >>>>> read to just the ranges that contain data.
> > .....
> >>>> Now how does the server make that choice? Is there an attribute
> >>>> bit that indicates when a file should be treated as sparse? Can
> >>>> we assume that immutable files (or compressed files) should
> >>>> always be treated as sparse? Alternately, the server might use
> >>>> the file's data : hole ratio.
> >>>
> >>> None of the above. The NFS server has no business knowing intimate
> >>> details about how the filesystem has laid out the file. All it cares
> >>> about ranges containing data and ranges that have no data (holes).
> >>
> >> That would be the case if we want nothing more than impermeable
> >> software layering. That's nice for software developers, but
> >> maybe not of much benefit to average users.
> >>
> >> I see no efficiency benefit, for example, if a 10MB object file
> >> has 512 bytes of zeroes at a convenient offset and the server
> >> returns that as DATA/HOLE/DATA. The amount of extra work it has
> >> to do to make that happen results in the same latencies as
> >> transmitting 512 extra bytes on GbE. It might be even worse on
> >> faster network fabrics.
> >
> > Welcome to the world of sparse file IO optimisation - NFS may be new
> > to this, but local filesystems have been optimising this sort of
> > thing for decades. Don't think we don't know about it - seek time
> > between 2 discontiguous extents is *much worse* than the few extra
> > microseconds that DMAing a few extra sectors worth of data in a
> > single IO. Even on SSDs, there's a noticable latency difference
> > between a single 16KB IO and two separate 4kB IOs to get the same
> > data.
> >
> > As it is, we worry about filesystem block granularity, not sectors.
> > A filesystem would only report a 512 byte range as a hole if it had
> > a 512 byte block size. Almost no-one uses such small block sizes -
> > 4kB is the default for ext4 and XFS - so the minimum hole size is
> > generally 4KB.
> >
> > Indeed, in this case XFS will not actually have a hole in the file
> > layout - the underlying extent would have been allocated as a single
> > contiguous unwritten extent, then when the data gets written it will
> > convert the two ranges to written, resulting in a physically
> > contiguous "data-unwritten-data" set of extents. However,
> > SEEK_HOLE/DATA will see that unwritten extent as a hole, so you'll
> > get that reported via seek hole/data or sparse reads regardless of
> > whether it is optimal for READ_PLUS encoding.
> >
> > However, the physical layout is optimal for XFS - if the hole gets
> > filled by a future write, it ends up converting the file layout to a
> > single contiguous data extent that can be read with a single IO
> > rather than three physically discontigous data extents that require
> > 3 physical IOs to read.
> >
> > ext4 optimises this in a different way - it will allocate small
> > holes similar to the way XFS does, but it will also fill the with
> > real zeros rather than leaving them unwritten. As a result, ext4
> > will have a single physically contiguous extent on disk too, but it
> > will -always- report as data even though the data written by the
> > application is sparse and contains a run of zeroes in it.
> >
> > IOWs, ext4 and XFS will behave differently for the simple case you
> > gave because they've optimised small holes in sparse file data
> > differently. Both have their pros and cons, but it also means that
> > the READ_PLUS response for the same file data written the same way
> > can be different because the underlying filesystem on the server is
> > different.
> >
> > IOWs, the NFS server cannot rely on a specific behaviour w.r.t.
> > holes and data from the underlying filesystem. Sparseness of a file
> > is determined by how the underlying filesystem wants to optimise the
> > physical layout or the data and IO patterns that data access results
> > in. The NFS server really cannot influence that, or change the
> > "sparseness" it reports to the client except by examining the
> > data it reads from the filesystem....
>
> What I'm proposing is that the NFS server needs to pick and
> choose whether to internally use sparse reads or classic
> reads of the underlying file when satisfying a READ_PLUS
> request.
>
> I am not proposing that the server should try to change the
> extent layout used by the filesystem.
>
>
> >> On fast networks, the less the server's host CPU has to be
> >> involved in doing the READ, the better it scales. It's
> >> better to set up the I/O and step out of the way; use zero
> >> touch as much as possible.
> >
> > However, as you demonstrate for the NFS client below, something has
> > to fill the holes. i.e. if we aren't doing sparse reads on the NFS
> > server, then the filesystem underneath the NFS server has to spend
> > the CPU to instantiate pages over the hole in the file in the page
> > cache, then zero them before it can pass them to the "zero touch"
> > NFS send path to be encoded into the READ reponse.
> >
> > IOWs, sending holes as zeroed data from the server is most
> > definitely not zero touch even if NFS doesn't touch the data.
> >
> > Hence the "sparse read" from the underlying filesystem, which avoids
> > the need to populate and zero pages in the server page cache
> > altogether, as well as enabling NFS to use it's zero-touch
> > encode/send path for the data that is returned. And with a sparse
> > read operation, the encoding of hole ranges in READ_PLUS has almost
> > zero CPU overhead because the calculation is dead simple (i.e. hole
> > start = end of last data, hole len = start of next data - end of
> > last data).
> >
> > IOWs, the lowest server CPU and memory READ processing overhead
> > comes from using READ_PLUS with sparse reads from the filesystem and
> > zero-touch READ_PLUS data range encoding.
>
> Agree on zero-touch: I would like to enable the use of
> splice read for CONTENT_DATA wherever it can be supported.
>
> Sparse reads for large sparse files will avoid hole
> instantiation, and that's a good thing as well.
>
> For small to average size files, I'm not as clear. If the
> server does not instantiate a hole, then the clients end
> up filling that hole themselves whenever re-reading the
> file. That seems like an unreasonable expense for them.
>
> The cost of hole instantiation is low and amortized over
> the life of the file, and after instantiated, zero touch
> can be used to satisfy subsequent READ_PLUS requests. On
> balance that seems like a better approach.
>
>
> >> Likewise on the client: it might receive a CONTENT_HOLE, but
> >> then its CPU has to zero out that range, with all the memory
> >> and cache activity that entails. For small holes, that's going
> >> to be a lot of memset(0). If the server returns holes only
> >> when they are large, then the client can use more efficient
> >> techniques (like marking page cache pages or using ZERO_PAGE).
> >
> > Yes, if we have sparse files we have to take that page cache
> > instantiation penalty *somewhere* in the IO stack between the client
> > and the server.
> >
> > Indeed, we actually want this overhead in the NFS client, because we
> > have many more NFS clients than we do NFS servers and hence on
> > aggregate there is way more CPU and memory to dedicate to
> > instantiating zeroed data on the client side than on the server
> > side.
> >
> > IOWs, if we ship zeroes via RDMA to the NFS client so the NFS client
> > doesn't need to instantiate holes in the page cache, then we're
> > actually forcing the server to perform hole instantiation. Forcing
> > the server to instantiate all the holes for all the files that all
> > the clients it is serving is prohibitive from a server CPU and
> > memory POV,
>
> I would hope not. Server-side hole instantiation is what we
> already have today with classic NFS READ, right?
>
> Anyway, the value proposition of RDMA storage protocols is
> that the network fabric handles data transfer on behalf of
> both the client and server host CPU -- that way, more CPU
> capacity is available on the client for applications running
> there.
>
> NFS servers are typically overprovisioned with CPU because
> serving files is not CPU intensive work. If anything, I would
> be concerned that hole instantiation would increase the amount
> of I/O (as a form of write amplification). But again, NFS
> server hardware is usually designed for I/O capacity, and
> IIUC the server already does hole instantiation now.
>
> But, it's academic. READ_PLUS is not efficient on NFS/RDMA
> as READ because with NFS/RDMA the client has to register
> memory for the server to write the payload in. However, the
> client cannot know in advance what the payload looks like
> in terms of DATA and HOLEs. So it's only choice is to set up
> a large buffer and parse through it when it gets the reply.
> That buffer can be filled via an RDMA Write, of course, but
> the new expense for the client is parsing the returned
> segment list. Even if it's just one segment, the client will
> have to copy the payload into place.
>
> For a classic READ over NFS/RDMA, that buffer is carved out
> of the local page cache and the server can place the payload
> directly into that cache. The client NFS protocol stack never
> touches it. This enables 2-3x higher throughput for READs. We
> see a benefit even with software-implemented RDMA (siw).
>
> So we would need to come up with some way of helping each
> NFS/RDMA client to set up receive buffers that will be able
> to get filled via direct data placement no matter how the
> server wants to return the payload. Perhaps some new protocol
> would be needed. Not impossible, but I don't think NFSv4.2
> READ_PLUS can do this.
>
>
> > even if you have the both the server network bandwidth
> > and the cross-sectional network bandwidth available to ship all
> > those zeros to all the clients.
> >
> >> On networks with large bandwidth-latency products, however,
> >> it makes sense to trade as much server and client CPU and
> >> memory for transferred bytes as you can.
> >
> > Server, yes, client not so much. If you focus purely on single
> > client<->server throughput, the server is not going to scale when
> > hundreds or thousands of clients all demand data at the same time.
> >
> > But, regardless of this, the fact is that the NFS server is a
> > consumer of the sparseness data stored in the underlying filesystem.
> > Unless it wants to touch every byte that is read, it can only export
> > the HOLE/DATA information that the filesystem can provide it with.
> >
> > What we want is a method that allows the filesystem to provide that
> > information to the NFS server READ_PLUS operation as efficiently as
> > possible. AFAICT, that's a sparse read operation....
>
> I'm already sold on that. I don't want NFSD touching every
> byte in every READ payload, even on TCP networks. And
> definitely, for reads of large sparse files, the proposed
> internal sparse read operation sounds great.
>
>
> >> The mechanism that handles sparse files needs to be distinct
> >> from the policy of when to return more than a single
> >> CONTENT_DATA segment, since one of our goals is to ensure
> >> that READ_PLUS performs and scales as well as READ on common
> >> workloads (ie, not HPC / large sparse file workloads).
> >
> > Yes, so make the server operation as efficient as possible whilst
> > still being correct (i.e. sparse reads), and push the the CPU and
> > memory requirements for instantiating and storing zeroes out
> > to the NFS client.
>
> Again, I believe that's a policy choice. It really depends on
> the CPU available on both ends and the throughput capacity
> of the network fabric (which always depends on instantaneous
> traffic levels).
>
>
> > If the NFS client page cache instantiation can't
> > keep up with the server sending it encoded ranges of zeros, then
> > this isn't a server side issue; the client side sparse file support
> > needs fixing/optimising.
>
> Once optimized, I don't think it will be a "can't keep up"
> issue but rather a "how much CPU and memory bandwidth is being
> stolen from applications" issue.
>
>
> >>> If the filesystem can support a sparse read, it returns sparse
> >>> ranges containing data to the NFS server. If the filesystem can't
> >>> support it, or it's internal file layout doesn't allow for efficient
> >>> hole/data discrimination, then it can just return the entire read
> >>> range.
> >>>
> >>> Alternatively, in this latter case, the filesystem could call a
> >>> generic "sparse read" implementation that runs memchr_inv() to find
> >>> the first data range to return. Then the NFS server doesn't have to
> >>> code things differently, filesystems don't need to advertise
> >>> support for sparse reads, etc because every filesystem could
> >>> support sparse reads.
> >>>
> >>> The only difference is that some filesystems will be much more
> >>> efficient and faster at it than others. We already see that sort
> >>> of thing with btrfs and seek hole/data on large cached files so I
> >>> don't see "filesystems perform differently" as a problem here...
> >>
> >> The problem with that approach is that will result in
> >> performance regressions on NFSv4.2 with exports that reside
> >> on underperforming filesystem types. We need READ_PLUS to
> >> perform as well as READ so there is no regression between
> >> NFSv4.2 without and with READ_PLUS, and no regression when
> >> migrating from NFSv4.1 to NFSv4.2 with READ_PLUS enabled.
> >
> > Sure, but fear of regressions is not a valid reason for preventing
> > change from being made.
>
> I don't believe I'm stating a fear, but rather I'm stating
> a hard requirement for our final READ_PLUS implementation.
>
> In any event, a good way to deal with fear of any kind is
> to do some reality testing. I think we have enough consensus
> to build a prototype, if Anna is willing, and then assess
> its performance.
>
> There are two mechanisms:
>
> 1 The sparse internal read mechanism you proposed

Assuming nobody else has started working on the sparse-read function,
I would like to check my understanding of what it would look like:

- The function splice_directo_to_actor() takes a "struct splice_desc"
as an argument. The sparse read function would take something similar,
a "struct sparse_desc", which has callbacks used by the underlying
filesystem to tell the server to encode either a hole or data segment
next.

In the default case, the VFS tells the server to encode the entire
read range as data. If underlying filesystems opt-in, then whenever a
data extent is found the encode_data_segment() function is called and
whenever a hole is found it calls the encode_hole_segment() function.

The NFS server would need to know file offset and length of each
segment, so these would probably be arguments to both functions. How
would reading data work, though? The server needs to reserve space in
the xdr stream for the offset & length metadata, but also the data
itself. I'm assuming it would do something similar to
fs/nfsd/vfs.c:nfsd_readv() and set up an iov_iter or kvec that the
underlying filesystem can use to place file data?

Does that sound about right? Am I missing anything?

I can definitely do the NFS server portion of this, and probably the
vfs-level sparse read function as well. I'll need help with the
underlying filesystem piece though, if anybody has a few spare cycles
once I cobble together a vfs function.

Thanks,
Anna

>
> 2 The classic splice/readv mechanism that READ uses
>
>
> There are three usage scenarios:
>
> A Large sparse files that reside on a filesystem that supports
>   storing sparse file
>
> B Small to average size files that may or may not be sparse,
>   residing on a filesystem that supports storing sparse files
>
> C Files that reside on a filesystem that does not support
>   storing files sparsely (or, IIUC, does not support iomap)
>
>
> I think we agree that scenario A should use mechanism 1 and
> scenario C should use mechanism 2. The question is whether
> mechanism 1 will perform as well as 2 for scenario B. If
> yes, then READ_PLUS can use mechanism 1 to handle scenarios
> A and B, and 2 to handle C. If no, then READ_PLUS can use
> mechanism 1 to handle scenario A and 2 to handle scenarios
> B and C.
>
> Both mechanisms need to be implemented no matter what, so it
> looks to me like very little of the prototype code would be
> wasted if such a change in direction becomes necessary once
> performance evaluation is complete.
>
>
> --
> Chuck Lever
>
>
>
