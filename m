Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3BE671183
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjARDIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 22:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjARDIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:08:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3B5084E
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 19:08:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z3so855030pfb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 19:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUKXZKTsbYRCrRiyD4l6vOhZZfGrn2LcV5GgwuQd5oM=;
        b=ws4AS0/475a+w48Ib6Rjf9rozR62HpyHQErj7HgS5N0CgmbYSU+PZx2lElJWJxowEM
         ssYE3qHzMgANfNvqdQNmB4xRyhkP2tvLDCtxtY40UHUJ5alYuhCXmHCM3YE66judtB+o
         J2h8r1aYHDw0XtO16N+KRmi9v4g5RdV/R9TUxsvOROenzqRbK0HWL9S+n3yDqoNNH5U4
         GwZ71iEo3ZRlqbn3ee8hFRaNswWvelyyGt+YsC0TjzHzw3xD9HOaEb3gbbhaYsz5aIK+
         z8SR9nHhudauw2Zu45tPcVS4SiYvGvrB6Fd7b6Gurw91d3uqVIDD+TYvJKB5ozoesVK7
         SFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUKXZKTsbYRCrRiyD4l6vOhZZfGrn2LcV5GgwuQd5oM=;
        b=2czAiCYrL1DPDMznXe5AQx2OLzjUbg0HJb8NRZI2MQSDaQzj/Lcq1TnoAtA+Gg5YdE
         QsgyuUE+C6nLLl8hJk6zkNaCduL7FLW0Eq8Ob9EWs8GuAENrQVcvrIG5gkqmQd8d6RWJ
         oalcD3mSvcZ9+cZdQMe66vIY4uU4wnsXQW/PtnUVDHvhd3MdiRrqPHSxOkXooTPiTP3G
         QE6wu8vQHxCx1nj9bSaMhhU82BgcSRT5ekwJd3PMcUwbc6SG6lC3h0c+pX5iHixRm2GY
         Pt9EYtNaJR7pLvk79G/oCfE5N+17HGZs8dR+MWnowqdX9m+MqkkgrYDORN5nfZdqE/yj
         5/7w==
X-Gm-Message-State: AFqh2kpb4f0RK1m5bfdB8b+8PHht+CL5m2xxV1VZuJEKM4wRpm/+QxUT
        8OUTkiVvvzWC5HmM+nS/x9DN4tW0CsdtKwNX
X-Google-Smtp-Source: AMrXdXt/KzrjhRmABn7lDjx3EJ4ebYagvAILhg+/QLmG+T7BF/shtTNtJhQlzpkeAoHzcCilo18OSg==
X-Received: by 2002:a05:6a00:1ca3:b0:58d:bce6:3d52 with SMTP id y35-20020a056a001ca300b0058dbce63d52mr5875479pfw.29.1674011321490;
        Tue, 17 Jan 2023 19:08:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id 3-20020a621503000000b00581c741f95csm19041666pfv.46.2023.01.17.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:08:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHyoW-004OV9-8m; Wed, 18 Jan 2023 14:08:36 +1100
Date:   Wed, 18 Jan 2023 14:08:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH v2 2/6] composefs: Add on-disk layout
Message-ID: <20230118030836.GC937597@dread.disaster.area>
References: <cover.1673623253.git.alexl@redhat.com>
 <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
 <20230116012904.GJ2703033@dread.disaster.area>
 <fe2e39b16d42ca871428e508935f1aa21608b4ee.camel@redhat.com>
 <20230116230647.GK2703033@dread.disaster.area>
 <c0c928880f35b40f8231036d21251ae3efa340db.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c928880f35b40f8231036d21251ae3efa340db.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:11:33PM +0100, Alexander Larsson wrote:
> On Tue, 2023-01-17 at 10:06 +1100, Dave Chinner wrote:
> > On Mon, Jan 16, 2023 at 12:00:03PM +0100, Alexander Larsson wrote:
> > > On Mon, 2023-01-16 at 12:29 +1100, Dave Chinner wrote:
> > > > On Fri, Jan 13, 2023 at 04:33:55PM +0100, Alexander Larsson
> > > > wrote:
> > > > > +} __packed;
> > > > > +
> > > > > +struct cfs_header_s {
> > > > > +       u8 version;
> > > > > +       u8 unused1;
> > > > > +       u16 unused2;
> > > > 
> > > > Why are you hyper-optimising these structures for minimal space
> > > > usage? This is 2023 - we can use a __le32 for the version number,
> > > > the magic number and then leave....
> > > > 
> > > > > +
> > > > > +       u32 magic;
> > > > > +       u64 data_offset;
> > > > > +       u64 root_inode;
> > > > > +
> > > > > +       u64 unused3[2];
> > > > 
> > > > a whole heap of space to round it up to at least a CPU cacheline
> > > > size using something like "__le64 unused[15]".
> > > > 
> > > > That way we don't need packed structures nor do we care about
> > > > having
> > > > weird little holes in the structures to fill....
> > > 
> > > Sure.
> > 
> > FWIW, now I see how this is used, this header kinda defines what
> > we'd call the superblock in the on-disk format of a filesystem. It's
> > at a fixed location in the image file, so there should be a #define
> > somewhere in this file to document it's fixed location.
> 
> It is at offset zero. I don't really think that needs a define, does
> it? Maybe a comment though.

Having the code use magic numbers for accessing fixed structures
(e.g. the hard coded 0 in the superblock read function)
is generally considered bad form.

If someone needs to understand how an image file is laid out, where
do they look to find where structures are physically located? Should
it be defined in a header file that is easy to find, or should they
have to read all the code to find where the magic number is embedded
in the code that defines the location of critical structures?


> > Also, if this is the in-memory representation of the structure and
> > not the actual on-disk format, why does it even need padding,
> > packing or even store the magic number?
> 
> In this case it is the on-disk format though.

Yeah, that wasn't obvious at first glance.

> > > > > +} __packed;
> > > > > +
> > > > > +enum cfs_inode_flags {
> > > > > +       CFS_INODE_FLAGS_NONE = 0,
> > > > > +       CFS_INODE_FLAGS_PAYLOAD = 1 << 0,
> > > > > +       CFS_INODE_FLAGS_MODE = 1 << 1,
> > > > > +       CFS_INODE_FLAGS_NLINK = 1 << 2,
> > > > > +       CFS_INODE_FLAGS_UIDGID = 1 << 3,
> > > > > +       CFS_INODE_FLAGS_RDEV = 1 << 4,
> > > > > +       CFS_INODE_FLAGS_TIMES = 1 << 5,
> > > > > +       CFS_INODE_FLAGS_TIMES_NSEC = 1 << 6,
> > > > > +       CFS_INODE_FLAGS_LOW_SIZE = 1 << 7, /* Low 32bit of
> > > > > st_size
> > > > > */
> > > > > +       CFS_INODE_FLAGS_HIGH_SIZE = 1 << 8, /* High 32bit of
> > > > > st_size */
> > > > 
> > > > Why do we need to complicate things by splitting the inode size
> > > > like this?
> > > > 
> > > 
> > > The goal is to minimize the image size for a typical rootfs or
> > > container image. Almost zero files in any such images are > 4GB. 
> > 
> > Sure, but how much space does this typically save, versus how much
> > complexity it adds to runtime decoding of inodes?
> > 
> > I mean, in a dense container system the critical resources that need
> > to be saved is runtime memory and CPU overhead of operations, not
> > the storage space. Saving a 30-40 bytes of storage space per inode
> > means a typical image might ber a few MB smaller, but given the
> > image file is not storing data we're only talking about images the
> > use maybe 500 bytes of data per inode. Storage space for images
> > is not a limiting factor, nor is network transmission (because
> > compression), so it comes back to runtime CPU and memory usage.
> 
> Here are some example sizes of composefs images with the current packed
> inodes: 
> 
> 6.2M cs9-developer-rootfs.composefs
> 2.1M cs9-minimal-rootfs.composefs
> 1.2M fedora-37-container.composefs
> 433K ubuntu-22.04-container.composefs
> 
> If we set all the flags for the inodes (i.e. fixed size inodes) we get:
> 
> 8.8M cs9-developer-rootfs.composefs
> 3.0M cs9-minimal-rootfs.composefs
> 1.6M fedora-37-container.composefs
> 625K ubuntu-22.04-container.composefs
> 
> So, images are about 40% larger with fixed size inodes.

40% sounds like a lot, but in considering the size magnitude of the
image files I'd say we just don't care about a few hundred KB to a
couple of MB extra space usage. Indeed, we'll use much more than 40%
extra space on XFS internally via speculative EOF preallocation when
writing those files to disk....

Also, I don't think that this is an issue for shipping them across
the network or archiving the images for the long term: compression
should remove most of the extra zeros.

Hence I'm still not convinced that the complexity of conditional
field storage is worth the decrease in image file size...

> > The inodes are decoded out of the page cache, so the memory for the
> > raw inode information is volatile and reclaimed when needed.
> > Similarly, the VFS inode built from this information is reclaimable
> > when not in use, too. So the only real overhead for runtime is the
> > decoding time to find the inode in the image file and then decode
> > it.
> 
> I disagree with this characterization. It is true that page cache is
> volatile, but if you can fit 40% less inode data in the page cache then
> there is additional overhead where you need to read this from disk. So,
> decoding time is not the only thing that affects overhead.

True, but the page cache is a secondary cache for inodes - if you
are relying on secondary caches for performance then you've already
lost because it means the primary cache is not functioning
effectively for your production workload.

> Additionally, just by being larger and less dense, more data has to be
> read from disk, which itself is slower.

That's a surprisingly common fallacy.

e.g. we can do a 64kB read IO for only 5% more time and CPU cost
than a 4kB read IO. This means we can pull 16x as much information
into the cache for almost no extra cost. This has been true since
spinning disks were invented more than 4 decades ago, but it's still
true with modern SSDs (for different reasons).

A 64kb IO is going to allow more inodes to be bought into the cache
for effectively the same IO cost, yet it provides a 16x improvement
in subsequent cache hit probability compared to doing 4kB IO. In
comparison, saving 40% in object size only improves the cache hit
probability for the same IO by ~1.5x....

Hence I don't consider object density isn't a primary issue for a
secondary IO caches; what matters is how many objects you can bring
into cache per IO, and how likely a primary level cache miss for
those objects will be in the near future before memory reclaim
removes them from the cache again.

As an example of this, the XFS inode allocation layout and caching
architecture is from the early 1990s, and it is a direct embodiment
of the the above principle. We move inodes in and out of the
secondary cache in clusters of 32 inodes (16KB IOs) because it is
much more CPU and IO efficient than doing it in 4kB IOs... 

> > Given the decoding of the inode -all branches- and is not
> > straight-line code, it cannot be well optimised and the CPU branch
> > predictor is not going to get it right every time. Straight line
> > code that decodes every field whether it is zero or not is going to
> > be faster.
> >
> > Further, with a fixed size inode in the image file, the inode table
> > can be entirely fixed size, getting rid of the whole unaligned data
> > retreival problem that code currently has (yes, all that
> > "le32_to_cpu(__get_unaligned(__le32, data)" code) because we can
> > ensure that all the inode fields are aligned in the data pages. This
> > will significantly speed up decoding into the in-memory inode
> > structures.
> 
> I agree it could be faster. But is inode decode actually the limiting
> factor, compared to things like disk i/o or better use of page cache?

The limiting factor in filesystem lookup paths tends to CPU usage.
It's spread across many parts of the kernel, but every bit we can
save makes a difference. Especially on a large server running
thousands of containers - the less CPU we use doing inode lookup and
instantiation, the more CPU there is for the user workloads. We are
rarely IO limited on machines like this, and as SSDs get even faster
in the near future, that's going to be even less of a problem than
it now.

> > > > > +struct cfs_dir_s {
> > > > > +       u32 n_chunks;
> > > > > +       struct cfs_dir_chunk_s chunks[];
> > > > > +} __packed;
> > > > 
> > > > So directory data is packed in discrete chunks? Given that this
> > > > is a
> > > > static directory format, and the size of the directory is known
> > > > at
> > > > image creation time, why does the storage need to be chunked?
> > > 
> > > We chunk the data such that each chunk fits inside a single page in
> > > the
> > > image file. I did this to make accessing image data directly from
> > > the
> > > page cache easier.
> > 
> > Hmmmm. So you defined a -block size- that matched the x86-64 -page
> > size- to avoid page cache issues.  Now, what about ARM or POWER
> > which has 64kB page sizes?
> > 
> > IOWs, "page size" is not the same on all machines, whilst the
> > on-disk format for a filesystem image needs to be the same on all
> > machines. Hence it appears that this:
> > 
> > > > > +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> > 
> > should actually be defined in terms of the block size for the
> > filesystem image, and this size of these dir chunks should be
> > recorded in the superblock of the filesystem image. That way it
> > is clear that the image has a specific chunk size, and it also paves
> > the way for supporting more efficient directory structures using
> > larger-than-page size chunks in future.
> 
> Yes, its true that assuming a (min) 4k page size is wasteful on some
> arches, but it would be hard to read a filesystem created for 64k pages
> on a 4k page machine, which is not ideal. However, wrt your commend on
> multi-page mappings, maybe we can just totally drop these limits. I'll
> have a look at that.

It's not actually that hard - just read in all the pages into the
page cache, look them up, map them, do the operation, unmap them.

After all, you already ahve a cfs_buf that you could store a page
array in, and then you have an object that you can use for single
pages (on a 64kB machine) or 16 pages (4kB page machine) without the
code that is walking the buffers caring about the underlying page
size. This is exactly what we do with the struct xfs_buf. :)

> 
> > > If we had dirent data spanning multiple pages
> > > then we would either need to map the pages consecutively (which
> > > seems
> > > hard/costly) or have complex in-kernel code to handle the case
> > > where a
> > > dirent straddles two pages.
> > 
> > Actually pretty easy - we do this with XFS for multi-page directory
> > buffers. We just use vm_map_ram() on a page array at the moment,
> > but in the near future there will be other options based on
> > multipage folios.
> > 
> > That is, the page cache now stores folios rather than pages, and is
> > capable of using contiguous multi-page folios in the cache. As a
> > result, multipage folios could be used to cache multi-page
> > structures in the page cache and efficiently map them as a whole.
> > 
> > That mapping code isn't there yet - kmap_local_folio() only maps the
> > page within the folio at the offset given - but the foundation is
> > there for supporting this functionality natively....
> > 
> > I certainly wouldn't be designing a new filesystem these days that
> > has it's on-disk format constrained by the x86-64 4kB page size...
> 
> Yes, I agree. I'm gonna look at using multi-page mapping for both
> dirents and xattr data, which should completely drop these limits, as
> well as get rid of the dirent chunking.

That will be interesting to see :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
