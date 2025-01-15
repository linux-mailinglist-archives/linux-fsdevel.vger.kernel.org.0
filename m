Return-Path: <linux-fsdevel+bounces-39319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B520A12AC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7575D165B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45851D5178;
	Wed, 15 Jan 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OElh6CXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AA24A7D5;
	Wed, 15 Jan 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965204; cv=none; b=WWNbmDHlYtrJRUhELk0t/CkNtfSmuyP8vwA+9AH+zWjsy3N1NRsCMDIF/2qnD8akN/uf/xkoxCQUhJXQZ7+QZAkcKcx841UJirGvyj02b0grgwo4gJ5KfVW+/Tv0VIrvoUZSqmR9GrsGOaaWFNUbR+Eyz1FoycdvRuixECUJ9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965204; c=relaxed/simple;
	bh=vZiJ7W5B7/8pT/voUBWm+eWlBRO5BGw7NBEsB9jt53E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2X7Xy8hLL8Urbm8CrVHrEq2n1t0DjEDY3r57heKi95jf/4vov8Xzj6sss0d/8MP3oH2cajXFRIMZRP60G0lcmTMTKI5YO0Zy2A8bP1v4EsOaVOEYQbYI+AhB0RptpwBSJXcs1Z4hWYc5YMn/Yra+A8UZStb/hwhqalzbUWFKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OElh6CXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8489DC4CED1;
	Wed, 15 Jan 2025 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736965203;
	bh=vZiJ7W5B7/8pT/voUBWm+eWlBRO5BGw7NBEsB9jt53E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OElh6CXKoa+fyGzjARD1ritEEZBHj/mm9+C2SeTPDEjYBseZvmGL9z5XlsriXDqH7
	 4RFqni4AOVEqvhHW04adSVCbNMf+azFzSyy6HAfJIxVXcAeOdlM7/HKR1iSYyonCXo
	 T//5c6mMuv8ig0JOKSH2LcrgPaCUM6CN5yuI5Xm2SE7fXQTOyPebdxL7qLj0tEJ8Z5
	 emcWGGqLV+dLik90i0UYZS01sJXVlSdtHC6PUbM7EfIWKrNlg9SxdCWicLRnH3fCaj
	 uSZnfnA3eCNsU/dCui0Jn+4lYSTfsWMZDySSxmktM9gmswd3I0b5j/PV1pg/6dbMPG
	 7A7TE3MOHH7BA==
Date: Wed, 15 Jan 2025 10:20:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <20250115182002.GG3561231@frogsfrogsfrogs>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4fO2_WZEO39jupG@casper.infradead.org>
 <4c59eb2d-132e-40d9-a2cc-1da65b661fd7@oracle.com>
 <Z4fgENA-045TFLOh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fgENA-045TFLOh@casper.infradead.org>

On Wed, Jan 15, 2025 at 04:19:28PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 15, 2025 at 10:31:51AM -0500, Chuck Lever wrote:
> > On 1/15/25 10:06 AM, Matthew Wilcox wrote:
> > > On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> > > > I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.
> > > 
> > > I think we need more information.  I read over the [2] and [3] threads
> > > and the spec.  It _seems like_ the intent in the spec is to expose the
> > > underlying SCSI WRITE SAME command over NFS, but at least one other
> > > response in this thread has been to design an all-singing, all-dancing
> > > superset that can write arbitrary sized blocks to arbitrary locations
> > > in every file on every filesystem, and I think we're going to design
> > > ourselves into an awful implementation if we do that.
> > > 
> > > Can we confirm with the people who actually want to use this that all
> > > they really want is to be able to do WRITE SAME as if they were on a
> > > local disc, and then we can implement that in a matter of weeks instead
> > > of taking a trip via Uranus.
> > 
> > IME it's been very difficult to get such requesters to provide the
> > detail we need to build to their requirements. Providing them with a
> > limited prototype and letting them comment is likely the fastest way to
> > converge on something useful. Press the Easy Button, then evolve.
> > 
> > Trond has suggested starting with clone_file_range, providing it with a
> > pattern and then have the VFS or file system fill exponentially larger
> > segments of the file by replicating that pattern. The question is
> > whether to let consumers simply use that API as it is, or shall we
> > provide some kind of generic infrastructure over that that provides
> > segment replication?
> > 
> > With my NFSD hat on, I would prefer to have the file version of "write
> > same" implemented outside of the NFS stack so that other consumers can
> > benefit from using the very same implementation. NFSD (and the NFS
> > client) should simply act as a conduit for these requests via the
> > NFSv4.2 WRITE_SAME operation.
> > 
> > I kinda like Dave's ideas too. Enabling offload will be critical to
> > making this feature efficient and thus valuable.
> 
> So I have some experience with designing an API like this one which may
> prove either relevant or misleading.
> 
> We have bzero() and memset().  If you want to fill with a larger pattern
> than a single byte, POSIX does not provide.  Various people have proposed
> extensions, eg
> https://github.com/ajkaijanaho/publib/blob/master/strutil/memfill.c
> 
> But what people really want is the ability to use the x86 rep
> movsw/movsl/movsq instructions.  And so in Linux we now have
> memset16/memset32/memset64/memset_l/memset_p which will map to one
> of those hardware calls.  Sure, we could implement memfill() and then
> specialcase 2/4/8 byte implementations, but nobody actually wants to
> use that.
> 
> 
> So what API actually makes sense to provide?  I suggest an ioctl,
> implemented at the VFS layer:
> 
> struct write_same {
> 	loff_t pos;	/* Where to start writing */

You probably need at least a:

	u64 count;	/* Number of bytes to write */

Since I think the point is that you write buf[len] to the file/disk over
and over again until count bytes have been written, correct?

> 	size_t len;	/* Length of memory pointed to by buf */

(and maybe call this buflen)

--D

> 	char *buf;	/* Pattern to fill with */
> };
> 
> ioctl(fd, FIWRITESAME, struct write_same *arg)
> 
> 'pos' must be block size aligned.
> 'len' must be a power of two, or 0.  If 0, fill with zeroes.
> If len is shorter than the block size of the file, the kernel
> replicates the pattern in 'buf' within the single block.  If len
> is larger than block size, we're doing a multi-block WRITE_SAME.
> 
> We can implement this for block devices and any filesystem that
> cares.  The kernel will have to shoot down any page cache, just
> like for PUNCH_HOLE and similar.
> 
> 
> For a prototype, we can implement this in the NFS client, then hoist it
> to the VFS once the users have actually agreed this serves their needs.
> 

