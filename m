Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5463F66D28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjAPXHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjAPXHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:07:24 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268CE27D49
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:06:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so8801605pjg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AxKgGZed1xEUE7IWDtpU8h2FQVqHzocWMXua2qNu5o=;
        b=K7GKLUS5uDH1RA+KVm51yL5QifY0WztQTKpx0KT66jL1sKJGhGJri1hpMMKq8fmSzt
         YBEqM4BmLc9Hir+KonWs3V/WJuFrQ+DuUMvjN6HDkNhhdOoMsMVjAgC6GKDffwUdss/6
         BHeBurifl0WGd/KYQNoKcjTHMVcc/iun6w9304fjEeb5BWxHRS8NGsFID/L9ZgkXIzKa
         vvHFn2XgitjnWUtOj9s648aV8H9MfxJChaYFaIBHRkxi8z6Y834E0nmgdC3bosZAHEwv
         wzym/KldBpkVeK5L4uifkuQQp9OAeCbOASA9shZHDbJO2xRyDFeQEsrrza3t0S85OIQn
         0NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AxKgGZed1xEUE7IWDtpU8h2FQVqHzocWMXua2qNu5o=;
        b=7GpkPqfsLDwxqN/LfHY2nylEfpQxZDDM+6kD77LidZ+yKaq4OXA47c+7ykgCrs27Mh
         IYzQ2xvuEVULaWzKSnFHMewYzDsdf6lnpApMZaQLf9oC1a25a96xSSnheMFQfFXcWEjq
         UJJsqZD7jJeh7Bf8FNvRjMbFXNbHpcC/oPyzeVYfeOQMU79ewKk7ASOEYZci8QOVjb5a
         +Pkjkbxe6JZBQl0ylMX8M+CD04aoUdggEdsby1rQbJtCnWpMmxvHZpuBIOmr5Wz5CTn1
         dJWHPwkbsA9Y497Pf4zVN3RJar86pZ1Yd7HERwCZUzALfSFHPlOgeyHvYcHP1P+VsNon
         hdlQ==
X-Gm-Message-State: AFqh2kq389DqVASvOnDiKSxV/E1y5vlAPaw115NCOM5pLlAi3+hU3gwA
        GLHXQ1Dm/EcNmoP2APwNcmctpIk2QDFTkodJ
X-Google-Smtp-Source: AMrXdXt9+1Vzzh/rHuDVFIfVqwaEwMNEaZmnYoIRu30HbF2z5eT5lDwnNQbhyqEOM4pRm+JGr7R+QQ==
X-Received: by 2002:a17:902:8601:b0:194:4285:dfef with SMTP id f1-20020a170902860100b001944285dfefmr1318226plo.49.1673910411324;
        Mon, 16 Jan 2023 15:06:51 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm6603805pli.309.2023.01.16.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:06:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHYYx-003vr3-7Z; Tue, 17 Jan 2023 10:06:47 +1100
Date:   Tue, 17 Jan 2023 10:06:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH v2 2/6] composefs: Add on-disk layout
Message-ID: <20230116230647.GK2703033@dread.disaster.area>
References: <cover.1673623253.git.alexl@redhat.com>
 <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
 <20230116012904.GJ2703033@dread.disaster.area>
 <fe2e39b16d42ca871428e508935f1aa21608b4ee.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe2e39b16d42ca871428e508935f1aa21608b4ee.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:00:03PM +0100, Alexander Larsson wrote:
> On Mon, 2023-01-16 at 12:29 +1100, Dave Chinner wrote:
> > On Fri, Jan 13, 2023 at 04:33:55PM +0100, Alexander Larsson wrote:
> > > This commit adds the on-disk layout header file of composefs.
> > 
> > This isn't really a useful commit message.
> > 
> > Perhaps it should actually explain what the overall goals of the
> > on-disk format are - space usage, complexity trade-offs, potential
> > issues with validation of variable payload sections, etc.
> > 
> 
> I agree, will flesh it out. But, as for below discussions, one of the
> overall goals is to keep the on-disk file size low.
> 
> > > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > > Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > > ---
> > >  fs/composefs/cfs.h | 203
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 203 insertions(+)
> > >  create mode 100644 fs/composefs/cfs.h
> > > 
> > > diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
> > > new file mode 100644
> > > index 000000000000..658df728e366
> > > --- /dev/null
> > > +++ b/fs/composefs/cfs.h
> > > @@ -0,0 +1,203 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * composefs
> > > + *
> > > + * Copyright (C) 2021 Giuseppe Scrivano
> > > + * Copyright (C) 2022 Alexander Larsson
> > > + *
> > > + * This file is released under the GPL.
> > > + */
> > > +
> > > +#ifndef _CFS_H
> > > +#define _CFS_H
> > > +
> > > +#include <asm/byteorder.h>
> > > +#include <crypto/sha2.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/stat.h>
> > > +#include <linux/types.h>
> > > +
> > > +#define CFS_VERSION 1
> > 
> > This should start with a description of the on-disk format for the
> > version 1 format.
> 
> There are some format descriptions in the later document patch. What is
> the general approach here, do we document in the header, or in separate
> doc file? For example, I don't see much of format descriptions in the
> xfs headers. I mean, I should probably add *some* info here for easier
> reading of the stuff below, but I don't feel like headers are a great
> place for docs.

it's fine to describe the format in the docs, but when reading the
code there needs to at least an overview of the structure the code
is implementing so that the code makes some sense without having to
go find the external place the format is documented.

> > > +
> > > +#define CFS_MAGIC 0xc078629aU
> > > +
> > > +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> > > +#define CFS_MAX_XATTRS_SIZE 4096
> > 
> > How do we store 64kB xattrs in this format if the max attr size is
> > 4096 bytes? Or is that the maximum total xattr storage?
> 
> This is a current limitation of the composefs file format.

Yes, but is that 4kB limit the maximum size of a single xattr, or is
it the total xattr storage space for an inode?

> I am aware
> that the kernel maximum size is 64k,

For a single xattr, yes. Hence my question....

> > > +static inline int cfs_digest_from_payload(const char *payload,
> > > size_t payload_len,
> > > +                                         u8
> > > digest_out[SHA256_DIGEST_SIZE])
.....
> > Too big to be a inline function.
> 
> Yeah, I'm aware of this. I mainly put it in the header as the
> implementation of it is sort of part of the on-disk format. But, I can
> move it to a .c file instead.

Please do - it's really part of the reader implementation, not the
structure definition.

> > > +struct cfs_vdata_s {
> > 
> > Drop the "_s" suffix to indicate the type is a structure - that's
> > waht "struct" tells us.
> 
> Sure.
> 
> > > +       u64 off;
> > > +       u32 len;
> > 
> > If these are on-disk format structures, why aren't the defined as
> > using the specific endian they are encoded in? i.e. __le64, __le32,
> > etc? Otherwise a file built on a big endian machine won't be
> > readable on a little endian machine (and vice versa).
> 
> On disk all fields are little endian. However, when we read them from
> disk we convert them using e.g. le32_to_cpu(), and then we use the same
> structure in memory, with native endian. So, it seems wrong to mark
> them as little endian.

Then these structures do not define "on-disk format". Looking a bit
further through the patchset, these are largely intermediate
structures that are read once to instatiate objects in memory, then
never used again. The cfs_inode_s is a good example of this - I'll
come back to that.

> 
> > 
> > > +} __packed;
> > > +
> > > +struct cfs_header_s {
> > > +       u8 version;
> > > +       u8 unused1;
> > > +       u16 unused2;
> > 
> > Why are you hyper-optimising these structures for minimal space
> > usage? This is 2023 - we can use a __le32 for the version number,
> > the magic number and then leave....
> >
> > > +
> > > +       u32 magic;
> > > +       u64 data_offset;
> > > +       u64 root_inode;
> > > +
> > > +       u64 unused3[2];
> > 
> > a whole heap of space to round it up to at least a CPU cacheline
> > size using something like "__le64 unused[15]".
> > 
> > That way we don't need packed structures nor do we care about having
> > weird little holes in the structures to fill....
> 
> Sure.

FWIW, now I see how this is used, this header kinda defines what
we'd call the superblock in the on-disk format of a filesystem. It's
at a fixed location in the image file, so there should be a #define
somewhere in this file to document it's fixed location.

Also, if this is the in-memory representation of the structure and
not the actual on-disk format, why does it even need padding,
packing or even store the magic number?

i.e. this information could simply be stored in a few fields in the cfs
superblock structure that wraps the vfs superblock, and the
superblock read function could decode straight into those fields...


> > > +} __packed;
> > > +
> > > +enum cfs_inode_flags {
> > > +       CFS_INODE_FLAGS_NONE = 0,
> > > +       CFS_INODE_FLAGS_PAYLOAD = 1 << 0,
> > > +       CFS_INODE_FLAGS_MODE = 1 << 1,
> > > +       CFS_INODE_FLAGS_NLINK = 1 << 2,
> > > +       CFS_INODE_FLAGS_UIDGID = 1 << 3,
> > > +       CFS_INODE_FLAGS_RDEV = 1 << 4,
> > > +       CFS_INODE_FLAGS_TIMES = 1 << 5,
> > > +       CFS_INODE_FLAGS_TIMES_NSEC = 1 << 6,
> > > +       CFS_INODE_FLAGS_LOW_SIZE = 1 << 7, /* Low 32bit of st_size
> > > */
> > > +       CFS_INODE_FLAGS_HIGH_SIZE = 1 << 8, /* High 32bit of
> > > st_size */
> > 
> > Why do we need to complicate things by splitting the inode size
> > like this?
> > 
> 
> The goal is to minimize the image size for a typical rootfs or
> container image. Almost zero files in any such images are > 4GB. 

Sure, but how much space does this typically save, versus how much
complexity it adds to runtime decoding of inodes?

I mean, in a dense container system the critical resources that need
to be saved is runtime memory and CPU overhead of operations, not
the storage space. Saving a 30-40 bytes of storage space per inode
means a typical image might ber a few MB smaller, but given the
image file is not storing data we're only talking about images the
use maybe 500 bytes of data per inode. Storage space for images
is not a limiting factor, nor is network transmission (because
compression), so it comes back to runtime CPU and memory usage.

The inodes are decoded out of the page cache, so the memory for the
raw inode information is volatile and reclaimed when needed.
Similarly, the VFS inode built from this information is reclaimable
when not in use, too. So the only real overhead for runtime is the
decoding time to find the inode in the image file and then decode
it.

Given the decoding of the inode -all branches- and is not
straight-line code, it cannot be well optimised and the CPU branch
predictor is not going to get it right every time. Straight line
code that decodes every field whether it is zero or not is going to
be faster.

Further, with a fixed size inode in the image file, the inode table
can be entirely fixed size, getting rid of the whole unaligned data
retreival problem that code currently has (yes, all that
"le32_to_cpu(__get_unaligned(__le32, data)" code) because we can
ensure that all the inode fields are aligned in the data pages. This
will significantly speed up decoding into the in-memory inode
structures.

And to take it another step, the entire struct cfs_inode_s structure
could go away - it is entirely a temporary structure used to shuffle
data from the on-disk encoded format to the the initialisation of
the VFS inode. The on-disk inode data could be decoded directly into
the VFS inode after it has been instantiated, rather than decoding
the inode from the backing file and the instantiating the in-memory
inode.

i.e. instead of:

cfs_lookup()
	cfs_dir_lookup(&index)
	cfs_get_ino_index(index, &inode_s)
		cfs_get_inode_data_max(index, &data)
		inode_s->st_.... = cfs_read_....(&data);
		inode_s->st_.... = cfs_read_....(&data);
		inode_s->st_.... = cfs_read_....(&data);
		inode_s->st_.... = cfs_read_....(&data);
	cfs_make_inode(inode_s, &vfs_inode)
		inode = new_inode(sb)
		inode->i_... = inode_s->st_....;
		inode->i_... = inode_s->st_....;
		inode->i_... = inode_s->st_....;
		inode->i_... = inode_s->st_....;

You could collapse this straight down to:

cfs_lookup()
	cfs_dir_lookup(&index)
	cfs_make_inode(index, &vfs_inode)
		inode = new_inode(sb)
		cfs_get_inode_data_max(index, &data)
		inode->i_... = cfs_read_....(&data);
		inode->i_... = cfs_read_....(&data);
		inode->i_... = cfs_read_....(&data);
		inode->i_... = cfs_read_....(&data);

This removes an intermediately layer from the inode instantiation
fast path completely. ANd if the inode table is fixed size and
always well aligned, then the cfs_make_inode() code that sets up the
VFS inode is almost unchanged from what it is now. There are no new
branches, the file image format is greatly simplified, and the
runtime overhead of instantiating inodes is significantly reduced.

Similar things can be done with the rest of the "descriptor"
abstraction - the intermediate in-memory structures can be placed
directly in the cfs_inode structure that wraps the VFS inode, and
the initialisation of them can call the decoding code directly
instead of using intermediate structures as is currently done.

This will remove a chunk of code from the implemenation and make it
run faster....

> Also, we don't just "not decode" the items with the flag not set, they
> are not even stored on disk.

Yup, and I think that is a mistake - premature optimisation and all
that...

> 
> > > +       CFS_INODE_FLAGS_XATTRS = 1 << 9,
> > > +       CFS_INODE_FLAGS_DIGEST = 1 << 10, /* fs-verity sha256
> > > digest */
> > > +       CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD = 1 << 11, /* Compute
> > > digest from payload */
> > > +};
> > > +
> > > +#define CFS_INODE_FLAG_CHECK(_flag,
> > > _name)                                     \
> > > +       (((_flag) & (CFS_INODE_FLAGS_##_name)) != 0)
> > 
> > Check what about a flag? If this is a "check that a feature is set",
> > then open coding it better, but if you must do it like this, then
> > please use static inline functions like:
> > 
> >         if (cfs_inode_has_xattrs(inode->flags)) {
> >                 .....
> >         }
> > 
> 
> The check is if the flag is set, so maybe CFS_INODE_FLAG_IS_SET is a
> better name. This is used only when decoding the on-disk version of the
> inode to the in memory one, which is a bunch of:
> 
> 	if (CFS_INODE_FLAG_CHECK(ino->flags, THE_FIELD))
> 		ino->the_field = cfs_read_u32(&data);
> 	else
> 		ino->the_field = THE_FIELD_DEFUALT;
> 
> I can easily open-code these checks, although I'm not sure it makes a
> great difference either way.

If they are used only once, then it should be open coded. But I
think the whole "optional inode fields" stuff should just go away
entirely at this point...

> > > +#define CFS_INODE_DEFAULT_MODE 0100644
> > > +#define CFS_INODE_DEFAULT_NLINK 1
> > > +#define CFS_INODE_DEFAULT_NLINK_DIR 2
> > > +#define CFS_INODE_DEFAULT_UIDGID 0
> > > +#define CFS_INODE_DEFAULT_RDEV 0
> > > +#define CFS_INODE_DEFAULT_TIMES 0
> > 
> > Where do these get used? Are they on disk defaults or something
> > else? (comment, please!)
> 
> They are the defaults that are used when inode fields on disk are
> missing. I'll add some comments.

They go away entirely with fixed size on-disk inodes.

> > > +       u32 st_mode; /* File type and mode.  */
> > > +       u32 st_nlink; /* Number of hard links, only for regular
> > > files.  */
> > > +       u32 st_uid; /* User ID of owner.  */
> > > +       u32 st_gid; /* Group ID of owner.  */
> > > +       u32 st_rdev; /* Device ID (if special file).  */
> > > +       u64 st_size; /* Size of file, only used for regular files
> > > */
> > > +
> > > +       struct cfs_vdata_s xattrs; /* ref to variable data */
> > 
> > This is in the payload that follows the inode?  Is it included in
> > the payload_length above?
> > 
> > If not, where is this stuff located, how do we validate it points to
> > the correct place in the on-disk format file, the xattrs belong to
> > this specific inode, etc? I think that's kinda important to
> > describe, because xattrs often contain important security
> > information...
> 
> No, all inodes are packed into the initial part of the file, each
> containing a flags set, a variable size (from flags) chunk of fixed
> size elements and an variable size payload. The payload is either the
> target symlink for symlinks, or the path of the backing file for
> regular files.

Ok, I think you need to stop calling that a "payload", then. It's
the path name to the backing file. The backing file is only relevant
for S_IFREG and S_IFLINK types - directories don't need path names
as they only contain pointers to other inodes in the image file.
Types like S_IFIFO, S_IFBLK, etc should not have backing files,
either - they should just be instantiated as the correct type in the
VFS inode and not require any backing file interactions at all...

Hence I think this "payload" should be called something like
"backing path" or something similar.

> Other data, such as xattrs and dirents are stored in a
> separate part of the file and the offsets for those in the inode refer
> to offsets into that area.

So "variable data" and "payload" are different sections in the file
format? You haven't defined what these names mean anywhere in this
file (see my original comment about describing the format in the
code), so it's hard to understand the difference without any actual
reference....

> > Why would you have this in the on-disk structure, then also have
> > "digest from payload" that allows the digest to be in the payload
> > section of the inode data?
> 
> The payload is normally the path to the backing file, and then you need
> to store the verity digest separately. This is what would be needed
> when using this with ostree for instance, because we have an existing
> backing file repo format we can't change.

*nod*

> However, if your backing
> store files are stored by their fs-verity digest already (which is the
> default for mkcomposefs), then we can set this flag and avoid storing
> the digest unnecessary.

So if you name your files according to the fsverity digest using
FS_VERITY_HASH_ALG_SHA256, you have to either completely rebuild
the repository if you want to change to FS_VERITY_HASH_ALG_SHA512
or you have to move to storing the fsverity digest in the image
files anyway?

Seems much better to me to require the repo to use an independent
content index rather than try to use the same hash to index the
contents and detect tampering at the same time. This, once again,
seems like an attempt to minimise file image size at the expense of
everything else and I'm very much not convinced this is the right
tradeoff to be making for modern computing technologies.

.....

> > > +struct cfs_dir_s {
> > > +       u32 n_chunks;
> > > +       struct cfs_dir_chunk_s chunks[];
> > > +} __packed;
> > 
> > So directory data is packed in discrete chunks? Given that this is a
> > static directory format, and the size of the directory is known at
> > image creation time, why does the storage need to be chunked?
> 
> We chunk the data such that each chunk fits inside a single page in the
> image file. I did this to make accessing image data directly from the
> page cache easier.

Hmmmm. So you defined a -block size- that matched the x86-64 -page
size- to avoid page cache issues.  Now, what about ARM or POWER
which has 64kB page sizes?

IOWs, "page size" is not the same on all machines, whilst the
on-disk format for a filesystem image needs to be the same on all
machines. Hence it appears that this:

> > > +#define CFS_MAX_DIR_CHUNK_SIZE 4096

should actually be defined in terms of the block size for the
filesystem image, and this size of these dir chunks should be
recorded in the superblock of the filesystem image. That way it
is clear that the image has a specific chunk size, and it also paves
the way for supporting more efficient directory structures using
larger-than-page size chunks in future.

> We can just kmap_page_local() each chunk and treat
> it as a non-split continuous dirent array, then move on to the next
> chunk in the next page.

OK.

> If we had dirent data spanning multiple pages
> then we would either need to map the pages consecutively (which seems
> hard/costly) or have complex in-kernel code to handle the case where a
> dirent straddles two pages.

Actually pretty easy - we do this with XFS for multi-page directory
buffers. We just use vm_map_ram() on a page array at the moment,
but in the near future there will be other options based on
multipage folios.

That is, the page cache now stores folios rather than pages, and is
capable of using contiguous multi-page folios in the cache. As a
result, multipage folios could be used to cache multi-page
structures in the page cache and efficiently map them as a whole.

That mapping code isn't there yet - kmap_local_folio() only maps the
page within the folio at the offset given - but the foundation is
there for supporting this functionality natively....

I certainly wouldn't be designing a new filesystem these days that
has it's on-disk format constrained by the x86-64 4kB page size...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
