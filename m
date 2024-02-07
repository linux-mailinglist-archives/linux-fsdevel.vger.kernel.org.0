Return-Path: <linux-fsdevel+bounces-10539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCA84C129
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CCA1F253F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971EE3D71;
	Wed,  7 Feb 2024 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HRFUHUKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF621320F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264393; cv=none; b=YtUccnin/X4gUk+7e1hPdzFOec5VHP4aNWcGvgk5srGtavgzzyWOS9eyIM4hgh+X8xSIBthhbxpV+n9CEfSQwi8T3SXpbVMI6Gd0At1Ewe0+xawKy9OoBp983JWBXbNyBrodDIdpkgnLVioP2Ko+7jmY2QXTlF6kO2Fmh/5Q7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264393; c=relaxed/simple;
	bh=zgzRCRc6PlQ0xAur3EaDCOu3AFffom7foEopcrYHzuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkpWDE1c9iJzQ1nNVWFDYgM6D8eQC6QozAQdM7UpeY9Tz+mC8qyQblL7nCpr109/3jmvGyXvrruCAHI+tjvw7govOjVJpfR5ha3SucSjuL4omrSdeqPVQ/Fukm+X8wH5sIXQfpXmmki1tZVezev4i1QBTg90gcDSoG2dVsZ7rH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HRFUHUKg; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a99ef8c7fso16663eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 16:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707264390; x=1707869190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omRTyCmAM7jJxEImrpnKGb2D944Dl743CEPuxVsxa5E=;
        b=HRFUHUKgFWzpHPAk2UYxwxrA7+jwrMrfHrK5Qe0ehAO/CUO4A8foOZORcaQ3rbTCC3
         vXAHuLCti+fDNLbu2RP/HjheIUl0PUcUIfbfmOhV4EQPoF6SwRUHHjDFSRGsd/BoFvsc
         Vnq4g3FziB99BZoxreAEVuOhlmOVTYmpesK43Q6kpJYq9cTm1cY5jtoKSBFcx0/vDxYh
         DW3+05Ed3y/2rHTQA1Moa0wT0MA/5BD0pvjYPFLOP/ArbAEuPrYdZ9N4eAPFDJEWp3CP
         16Xb6l5dGRVfIpcvTbxFxER5FUiDl/85ZffbSBoMQfc/Y5KpoGkPmRylfI9ZCt/K04We
         p4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264390; x=1707869190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omRTyCmAM7jJxEImrpnKGb2D944Dl743CEPuxVsxa5E=;
        b=EpXIzC2thVnhJA9neQNZbGTbVQsw6g8AcCOTHUM0O340eUndJ6/zvwlYJIECoyGV95
         dbBRr5POCNFTi7JpGirjBmOchft+5/JwSdlOSoZdeE3mVuZAeqa6aDYCXrNAnQwZoGr2
         Z5GdPpvbGTd7H6hiX5WeJHDVxHzXXEQhbAJLzgP2w3VZ6LSX2XnucNQ66RTj3im7U3FB
         n1WzYXzjsLUE5QGSZgXflPrxSkzRUWxW5oWMe1RcnTYIVOuHIFJq1NdXmHFKuSFydSy7
         p1FWjENNN/60GiycRJqM0yNoaMvyO5gNgOwKodbeld5KeWyJELJglJFcesPjs6zvwZco
         YLBw==
X-Gm-Message-State: AOJu0YwveX1qn5pl4XzXXXNWoCZG+9VgtJveSzzQcfaBLu48HJtEznTO
	P54k6mIg2NUS16OrxcnIeH6bvyN5o4uDUzgHnOFDh55yVMvVVEieSnFuqzI3Ea8=
X-Google-Smtp-Source: AGHT+IHiEV0kPrsYCZ5D4idtfD/y3CYew0/pD//7f+VRvKHiVIONBEgAn8yWDtGOGxC8Y3YI9LQrEg==
X-Received: by 2002:a05:6358:72aa:b0:178:6211:871 with SMTP id w42-20020a05635872aa00b0017862110871mr1250737rwf.0.1707264389674;
        Tue, 06 Feb 2024 16:06:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlFPrCqm45GRCKDup0Jl3jQtxKZOIXJnGfPbYnwZsm3dOzxzuQlyklUaEcnOlll+fFIW9ta343vcUOy+YqzXGcn6BowzOMxhB18Hee1+5tMEHEt7pwQgqkgfnN8Y/eX2om/1uQKlyMwTvZkayp8I3Atf9gHtalxDTY8G78rnKfzdHEkUxES49wY34tTHvqL+2exoa7raCQzsua4l3qmLWiZL+uvV6kNyHppkq8beGxOLpJMM6kogpMciUr6mlcxqcfHCIN5XXktmr68b0WFbd6AYJnZX+pbdhsrRVsmzx6Brou7hHuYEHIi1FTTLaT/15UmyhckKhbSCcIAKrS4T2YWsmduX9Hew+0Q0IaBZRp3eiak1mqNzUiEVM0BQ/cdKZ3fGrkE/dHiD7GqoV16xXueGm4cqwy/ghcMJuzwvusbnjycRmFLWlE329i18d9pr4a
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b006e0350189f0sm80668pfj.91.2024.02.06.16.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:06:29 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXVSL-0032pa-2w;
	Wed, 07 Feb 2024 11:06:25 +1100
Date: Wed, 7 Feb 2024 11:06:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Message-ID: <ZcLJgVu9A3MsWBI0@dread.disaster.area>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>

On Tue, Feb 06, 2024 at 09:53:11AM +0000, John Garry wrote:
> Hi Dave,
> 
> > > > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > > > index 18c8f168b153..758dc1c90a42 100644
> > > > > --- a/fs/xfs/xfs_iomap.c
> > > > > +++ b/fs/xfs/xfs_iomap.c
> > > > > @@ -289,6 +289,9 @@ xfs_iomap_write_direct(
> > > > >    		}
> > > > >    	}
> > > > > +	if (xfs_inode_atomicwrites(ip))
> > > > > +		bmapi_flags = XFS_BMAPI_ZERO;
> > 
> > We really, really don't want to be doing this during allocation
> > unless we can avoid it. If the filesystem block size is 64kB, we
> > could be allocating up to 96GB per extent, and that becomes an
> > uninterruptable write stream inside a transaction context that holds
> > inode metadata locked.
> 
> Where does that 96GB figure come from?

My inability to do math. The actual number is 128GB.

Max extent size = XFS_MAX_BMBT_EXTLEN * fs block size.
	        = 2^21 * fs block size.

So for a 4kB block size filesystem, that's 8GB max extent length,
and that's the most we will allocate in a single transaction (i.e.
one new BMBT record).

For 64kB block size, we can get 128GB of space allocated in a single
transaction.

> > > > Why do we want to write zeroes to the disk if we're allocating space
> > > > even if we're not sending an atomic write?
> > > > 
> > > > (This might want an explanation for why we're doing this at all -- it's
> > > > to avoid unwritten extent conversion, which defeats hardware untorn
> > > > writes.)
> > > 
> > > It's to handle the scenario where we have a partially written extent, and
> > > then try to issue an atomic write which covers the complete extent.
> > 
> > When/how would that ever happen with the forcealign bits being set
> > preventing unaligned allocation and writes?
> 
> Consider this scenario:
> 
> # mkfs.xfs -r rtdev=/dev/sdb,extsize=64K -d rtinherit=1 /dev/sda
> # mount /dev/sda mnt -o rtdev=/dev/sdb
> # touch  mnt/file
> # /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file # direct IO, atomic
> write, 4096B at pos 0

Please don't write one-off custom test programs to issue IO - please
use and enhance xfs_io so the test cases can then be put straight
into fstests without adding yet another "do some minor IO variant"
test program. This also means you don't need a random assortment of
other tools.

i.e.

# xfs_io -dc "pwrite -VA 0 4096" /root/mnt/file

Should do an RWF_ATOMIC IO, and

# xfs_io -dc "pwrite -VAD 0 4096" /root/mnt/file

should do an RWF_ATOMIC|RWF_DSYNC IO...


> # filefrag -v mnt/file

xfs_io -c "fiemap" mnt/file

> Filesystem type is: 58465342
> File size of mnt/file is 4096 (1 block of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected:
> flags:
>     0:        0..       0:         24..        24:      1:
> last,eof
> mnt/file: 1 extent found
> # /test-pwritev2 -a -d -l 16384 -p 0 /root/mnt/file
> wrote -1 bytes at pos 0 write_size=16384
> #

Whole test as one repeatable command:

# xfs_io -d -c "truncate 0" -c "chattr +r" \
	-c "pwrite -VAD 0 4096" \
	-c "fiemap" \
	-c "pwrite -VAD 0 16384" \
	/mnt/root/file
> 
> For the 2nd write, which would cover a 16KB extent, the iomap code will iter
> twice and produce 2x BIOs, which we don't want - that's why it errors there.

Yes, but I think that's a feature.  You've optimised the filesystem
layout for IO that is 64kB sized and aligned IO, but your test case
is mixing 4kB and 16KB IO. The filesystem should be telling you that
you're doing something that is sub-optimal for it's configuration,
and refusing to do weird overlapping sub-rtextsize atomic IO is a
pretty good sign that you've got something wrong.

The whole reason for rtextsize existing is to optimise the rtextent
allocation to the typical minimum IO size done to that volume. If
all your IO is sub-rtextsize size and alignment, then all that has
been done is forcing the entire rt device IO into a corner it was
never really intended nor optimised for.

Why should we jump through crazy hoops to try to make filesystems
optimised for large IOs with mismatched, overlapping small atomic
writes?

> With the change in this patch, instead we have something like this after the
> first write:
> 
> # /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file
> wrote 4096 bytes at pos 0 write_size=4096
> # filefrag -v mnt/file
> Filesystem type is: 58465342
> File size of mnt/file is 4096 (1 block of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected:
> flags:
>     0:        0..       3:         24..        27:      4:
> last,eof
> mnt/file: 1 extent found
> #
> 
> So the 16KB extent is in written state and the 2nd 16KB write would iter
> once, producing a single BIO.

Sure, I know how it works. My point is that it's a terrible way to
go about allowing that second atomic write to succeed.

> > > In this
> > > scenario, the iomap code will issue 2x IOs, which is unacceptable. So we
> > > ensure that the extent is completely written whenever we allocate it. At
> > > least that is my idea.
> > 
> > So return an unaligned extent, and then the IOMAP_ATOMIC checks you
> > add below say "no" and then the application has to do things the
> > slow, safe way....
> 
> We have been porting atomic write support to some database apps and they
> (database developers) have had to do something like manually zero the
> complete file to get around this issue, but that's not a good user
> experience.

Better the application zeros the file when it is being initialised
and doesn't have performance constraints rather than forcing the
filesystem to do it in the IO fast path when IO performance and
latency actually matters to the application.

There are production databases that already do this manual zero
initialisation to avoid unwritten extent conversion overhead during
runtime operation. That's because they want FUA writes to work, and
that gives 25% better IO performance over the same O_DSYNC writes
doing allocation and/or unwritten extent conversion after
fallocate() which requires journal flushes with O_DSYNC writes.

Using atomic writes is no different.

> Note that in their case the first 4KB write is non-atomic, but that does not
> change things. They do these 4KB writes in some DB setup phase.

And therein lies the problem.

If you are doing sub-rtextent IO at all, then you are forcing the
filesystem down the path of explicitly using unwritten extents and
requiring O_DSYNC direct IO to do journal flushes in IO completion
context and then performance just goes down hill from them.

The requirement for unwritten extents to track sub-rtextsize written
regions is what you're trying to work around with XFS_BMAPI_ZERO so
that atomic writes will always see "atomic write aligned" allocated
regions.

Do you see the problem here? You've explicitly told the filesystem
that allocation is aligned to 64kB chunks, then because the
filesystem block size is 4kB, it's allowed to track unwritten
regions at 4kB boundaries. Then you do 4kB aligned file IO, which
then changes unwritten extents at 4kB boundaries. Then you do a
overlapping 16kB IO that *requires* 16kB allocation alignment, and
things go BOOM.

Yes, they should go BOOM.

This is a horrible configuration - it is incomaptible with 16kB
aligned and sized atomic IO. Allocation is aligned to 64kB, written
region tracking is aligned to 4kB, and there's nothing to tell the
filesystem that it should be maintaining 16kB "written alignment" so
that 16kB atomic writes can always be issued atomically.

i.e. if we are going to do 16kB aligned atomic IO, then all the
allocation and unwritten tracking needs to be done in 16kB aligned
chunks, not 4kB. That means a 4KB write into an unwritten region or
a hole actually needs to zero the rest of the 16KB range it sits
within.

The direct IO code can do this, but it needs extension of the
unaligned IO serialisation in XFS (the alignment checks in
xfs_file_dio_write()) and the the sub-block zeroing in
iomap_dio_bio_iter() (the need_zeroing padding has to span the fs
allocation size, not the fsblock size) to do this safely.

Regardless of how we do it, all IO concurrency on this file is shot
if we have sub-rtextent sized IOs being done. That is true even with
this patch set - XFS_BMAPI_ZERO is done whilst holding the
XFS_ILOCK_EXCL, and so no other DIO can map extents whilst the
zeroing is being done.

IOWs, anything to do with sub-rtextent IO really has to be treated
like sub-fsblock DIO - i.e. exclusive inode access until the
sub-rtextent zeroing has been completed.

> > > > I think we should support IOCB_ATOMIC when the mapping is unwritten --
> > > > the data will land on disk in an untorn fashion, the unwritten extent
> > > > conversion on IO completion is itself atomic, and callers still have to
> > > > set O_DSYNC to persist anything.
> > > 
> > > But does this work for the scenario above?
> > 
> > Probably not, but if we want the mapping to return a single
> > contiguous extent mapping that spans both unwritten and written
> > states, then we should directly code that behaviour for atomic
> > IO and not try to hack around it via XFS_BMAPI_ZERO.
> > 
> > Unwritten extent conversion will already do the right thing in that
> > it will only convert unwritten regions to written in the larger
> > range that is passed to it, but if there are multiple regions that
> > need conversion then the conversion won't be atomic.
> 
> We would need something atomic.
> 
> > 
> > > > Then we can avoid the cost of
> > > > BMAPI_ZERO, because double-writes aren't free.
> > > 
> > > About double-writes not being free, I thought that this was acceptable to
> > > just have this write zero when initially allocating the extent as it should
> > > not add too much overhead in practice, i.e. it's one off.
> > 
> > The whole point about atomic writes is they are a performance
> > optimisation. If the cost of enabling atomic writes is that we
> > double the amount of IO we are doing, then we've lost more
> > performance than we gained by using atomic writes. That doesn't
> > seem desirable....
> 
> But the zero'ing is a one off per extent allocation, right? I would expect
> just an initial overhead when the database is being created/extended.

So why can't the application do that manually like others already do
to enable FUA optimisations for O_DSYNC writes?

FWIW, we probably should look to extend fallocate() to allow
userspace to say "write real zeroes, not fake ones" so the
filesystem can call blkdev_issue_zeroout() after preallocation to
offload the zeroing to the hardware and then clear the unwritten
bits on the preallocated range...

> > > > >    	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
> > > > >    			rblocks, force, &tp);
> > > > >    	if (error)
> > > > > @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
> > > > >    	if (error)
> > > > >    		goto out_unlock;
> > > > > +	if (flags & IOMAP_ATOMIC) {
> > > > > +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
> > > > > +		unsigned int unit_min, unit_max;
> > > > > +
> > > > > +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> > > > > +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
> > > > > +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
> > > > > +
> > > > > +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
> > > > > +			error = -EINVAL;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +
> > > > > +		if ((offset & mp->m_blockmask) ||
> > > > > +		    (length & mp->m_blockmask)) {
> > > > > +			error = -EINVAL;
> > > > > +			goto out_unlock;
> > > > > +		}
> > 
> > That belongs in the iomap DIO setup code, not here. It's also only
> > checking the data offset/length is filesystem block aligned, not
> > atomic IO aligned, too.
> 
> hmmm... I'm not sure about that. Initially XFS will only support writes
> whose size is a multiple of FS block size, and this is what we are checking
> here, even if it is not obvious.

Which means, initially, iomap only supposed writes that are a
multiple of filesystem block size. regardless, this should be
checked in the submission path, not in the extent mapping callback.

FWIW, we've already established above that iomap needs to handle
rtextsize chunks rather than fs block size for correct zeroing
behaviour for atomic writes, so this probably just needs to go away.

> The idea is that we can first ensure size is a multiple of FS blocksize, and
> then can use br_blockcount directly, below.

Yes, and we can do all these checks on the iomap that we return to
the iomap layer. All this is doing is running the checks on the XFS
imap before it is formatted into the iomap iomap and returned to the
iomap layer. These checks can be done on the returned iomap in the
iomap layer if IOMAP_ATOMIC is set....

> However, the core iomap code does not know FS atomic write min and max per
> inode, so we need some checks here.

So maybe we should pass them down to iomap in the iocb when
IOCB_ATOMIC is set, or reject the IO at the filesytem layer when
checking atomic IO alignment before we pass the IO to the iomap
layer...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

