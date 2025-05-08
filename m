Return-Path: <linux-fsdevel+bounces-48512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF7AB0492
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16D49889DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DE28C5DF;
	Thu,  8 May 2025 20:25:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093E28C840
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735934; cv=none; b=t4tq5yOKcBeAYAP1WIX4Wo1NePdXuN357XZkf05dV1QkizqMWgf5IX4Xxm51X6HgETgIVBSwc6cAUKRiSDEoRkmUf0RXG6+HYdsBaH5X99mVzoSOLNOcYkIpahOSA/oPvidnDc/3f6RxEPmyeX41fcTgvqbyIgbAlMIQxvOUn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735934; c=relaxed/simple;
	bh=GkFms8Q6aKyCL3Gr2QweKHG4yGXfIq2w7/Eg1rsvABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiTsC18rw6x7EA38blKVOj0vw2YwbRF5cWYp9vHOqBoSWTQ7pamhdz6NZaQcbiccdnzjTMJlJXg8hDyQ3LOaD3VFa2aik3067ueiTR97uDBx2KFZiJgVP+na6AUAZzR8yw5jxzr0hrFDvJGVcXqFFenHBpAI2uN5rKYfxbPq8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 548KOOaX022511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 16:24:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 371DE2E00E1; Thu, 08 May 2025 16:24:24 -0400 (EDT)
Date: Thu, 8 May 2025 16:24:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250508202424.GA30222@mit.edu>
References: <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
 <20250508050147.GA26916@lst.de>
 <68172a9e-cf68-4962-8229-68e283e894e1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68172a9e-cf68-4962-8229-68e283e894e1@huaweicloud.com>

On Thu, May 08, 2025 at 08:17:14PM +0800, Zhang Yi wrote:
> On 2025/5/8 13:01, Christoph Hellwig wrote:
> >>
> >> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
> >> only bdev or files where bdev_unmap_write_zeroes() returns true. In
> >> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
> >> are not consistent, they are two independent features. Even if some
> >> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
> >> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
> >> devices and drivers currently cannot reliably ascertain whether they
> >> support the unmap write zero command; however, certain devices, such as
> >> specific cloud storage devices, do support it. Users of these devices
> >> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
> >> process.
> > 
> > What are those "cloud storage devices" where you set it reliably,
> > i.e.g what drivers?
> 
> I don't have these 'cloud storage devices' now, but Ted had mentioned
> those cloud-emulated block devices such as Google's Persistent Desk or
> Amazon's Elastic Block Device in. I'm not sure if they can accurately
> report the BLK_FEAT_WRITE_ZEROES_UNMAP feature, maybe Ted can give more
> details.
> 
> https://lore.kernel.org/linux-fsdevel/20250106161732.GG1284777@mit.edu/

There's nothing really exotic about what I was referring to in terms
of "cloud storage devices".  Perhaps a better way of describing them
is to consider devices such as dm-thin, or a Ceph Block Device, which
is being exposed as a SCSI or NVME device.

The distinction I was trying to make is performance-related.  Suppose
you call WRITE_ZEROS on a 14TB region.  After the WRITES_ZEROS
complete, a read anywhere on that 14TB region will return zeros.
That's easy.  But the question is when you call WRITE_ZEROS, will the
storage device (a) go away for a day or more before it completes (which
would be the case if it is a traditional spinning rust platter), or
(b) will it be basically instaneous, because all dm-thin or a Ceph Block
Device needs to do is to delete one or more entries in its mapping
table.

The problem is two-fold.  First, there's no way for the kernel to know
whether a storage device will behave as (a) or (b), because SCSI and
other storage specifications say that performance is out of scope.
They only talk about the functional results (afterwards, if yout try
to read from the region, you will get zeros), and are utterly silent
about how long it migt take.  The second problem is that if you are an
application program, there is no way you will be willing to call
fallocate(WRITE_ZEROS, 14TB) if you don't know whether the disk will
go away for a day or whether it will be instaneous.

But because there is no way for the kernel to know whether WRITE_ZEROS
will be fast or not, how would you expect the kernel to expose
STATX_ATTR_WRITE_ZEROES_UNMAP?  Cristoph's formulation "breaking the
abstraction" perfectly encapsulate the SCSI specification's position
on the matter, and I agree it's a valid position.  It's just not
terribly useful for the application programmer.

Things which some programs/users might want to know or rely upon, but which is normally quite impossible are: 

* Will the write zero / discard operation take a "reasonable" amount
  of time?  (Yes, not necessarilly well defined, but we know it when
  we see it, and hours or days is generally not reasonable.)

* Is the operation reliable --- i.e., is the device allowed to
  randomly decide that it won't actually zero the requested blocks (as
  is the case of discard) whenever it feels like it.

* Is the operation guaranteed to make the data irretreviable even in
  face of an attacker with low-level access to the device.  (And this
  is also not necessarily well defined; does the attacker have access
  to a scanning electronic microscope, or can do a liquid nitrogen
  destructive access of the flash device?)

The UFS (Universal Flash Storage) spec comes the closest to providing
commands that distinguish between these various cases, but for most
storage specifications, like SCSI, it is absolutely requires peaking
behind the abstraction barrier defined by the specification, and so
ultimately, the kernel can't know.

About the best you can do is to require manual configuration; perhaps a
config file at the database or userspace cluster file system level
because the system adminsitrator knows --- maybe because the hyperscale
cloud provider has leaned on the storage vendor to tell them under
NDA, storage specs be damned or they won't spend $$$ millions with
that storage vendor ---  or because the database administrator discovers
that using fallocate(WRITE_ZEROS) causes performance to tank, so they
manually disable the use of WRITE_ZEROS.

Could this be done in the kernel?  Sure.  We could have a file, say,
/sys/block/sdXX/queue/write_zeros where the write_zeros file is
writeable, and so the administrator can force-disable WRITES_ZERO by
writing 0 into the file.  And could this be queried via a STATX
attribute?  I suppose, although to be honest, I'm used to doing this
by looking at the sysfs files.  For example, just recently I coded up
the following:

static int is_rotational (const char *device_name EXT2FS_ATTR((unused)))
{
	int		rotational = -1;
#ifdef __linux__
	char		path[1024];
	struct stat	st;
	FILE		*f;

	if ((stat(device_name, &st) < 0) || !S_ISBLK(st.st_mode))
		return -1;

	snprintf(path, sizeof(path), "/sys/dev/block/%d:%d/queue/rotational",
		major(st.st_rdev), minor(st.st_rdev));
	f = fopen(path, "r");
	if (!f) {
		snprintf(path, sizeof(path),
			"/sys/dev/block/%d:%d/../queue/rotational",
			major(st.st_rdev), minor(st.st_rdev));
		f = fopen(path, "r");
	}
	if (f) {
		if (fscanf(f, "%d", &rotational) != 1)
			rotational = -1;
		fclose(f);
	}
#endif
	return rotational;
}

Easy-peasy!   Who needs statx?   :-)


						- Ted

