Return-Path: <linux-fsdevel+bounces-39307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F8A12884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C747165494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B6155391;
	Wed, 15 Jan 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fOkgpmY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446C4D8DA;
	Wed, 15 Jan 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957973; cv=none; b=CkkDgs9ez3ChDnuiD1IY4LD5tTC0KMOpCyJPIaVDbsdX7CkROGH+QvZJLSUBoNLqTQOXXAtaMSATn1MmM0a/KxutRbyDozLqWmthi7jpGFMw2l1INKBzOe+UWdSMNXdi3tjVDlaRKcFJqJ5dLZQP+VQPU0ibtol4xcGxrvs3A0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957973; c=relaxed/simple;
	bh=UKPMayxqLUUmB4MBUdl5cS1110T3lcFE76VxBV/hyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqp6t5AOyzKrKlQderBnoQWkZX6hM37ZI0IfI6D+pRGwcz3GDuH8+vfv/C4eMFRlMEdImyXOI9/SzfqQ/DQlav2P5F3Yz0RstLEIhx0PY3TWFmjEf3tlOY8MzTQuAGAK/81nzL9VvU00n1jbssiUZftHuAY5tftnMHhLdwHsmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fOkgpmY0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0lBVDwJUw+CMCM92e/Xx6S2OgMOSg+yI9aNtIXGyh+c=; b=fOkgpmY0Kx9GSCTBNhOkHb+i+L
	+mfE1FzVIIM2AejWAid9uhCikjCtfFGdZahlLK1sbcK2wrweL9rSM1JgBsIGI7t40bWsQ0gYWNVxR
	OjpZo+bwoPd7DkCD6/wIP2S2nhH18QJfxnUnDzbM2zyyTZGlsYcprGDyItK5XdyCSlMBo5o/djJVq
	votFxjMcysin9VnRholCXj2bY06R7mMZUVnY7C+/x1B2hB6cAaumHt0vrSJtM+4vQVIjXcmoGBy5L
	bpr/3oVCmMvfVD1jMJIKcBS6llqCEXoKUBBEUDVayQINrznviwF1STk3QNocyOPz0zBiFWQY7HNlB
	m3s3cKBw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tY676-0000000G1Yr-1YkB;
	Wed, 15 Jan 2025 16:19:28 +0000
Date: Wed, 15 Jan 2025 16:19:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <Z4fgENA-045TFLOh@casper.infradead.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4fO2_WZEO39jupG@casper.infradead.org>
 <4c59eb2d-132e-40d9-a2cc-1da65b661fd7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c59eb2d-132e-40d9-a2cc-1da65b661fd7@oracle.com>

On Wed, Jan 15, 2025 at 10:31:51AM -0500, Chuck Lever wrote:
> On 1/15/25 10:06 AM, Matthew Wilcox wrote:
> > On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> > > I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.
> > 
> > I think we need more information.  I read over the [2] and [3] threads
> > and the spec.  It _seems like_ the intent in the spec is to expose the
> > underlying SCSI WRITE SAME command over NFS, but at least one other
> > response in this thread has been to design an all-singing, all-dancing
> > superset that can write arbitrary sized blocks to arbitrary locations
> > in every file on every filesystem, and I think we're going to design
> > ourselves into an awful implementation if we do that.
> > 
> > Can we confirm with the people who actually want to use this that all
> > they really want is to be able to do WRITE SAME as if they were on a
> > local disc, and then we can implement that in a matter of weeks instead
> > of taking a trip via Uranus.
> 
> IME it's been very difficult to get such requesters to provide the
> detail we need to build to their requirements. Providing them with a
> limited prototype and letting them comment is likely the fastest way to
> converge on something useful. Press the Easy Button, then evolve.
> 
> Trond has suggested starting with clone_file_range, providing it with a
> pattern and then have the VFS or file system fill exponentially larger
> segments of the file by replicating that pattern. The question is
> whether to let consumers simply use that API as it is, or shall we
> provide some kind of generic infrastructure over that that provides
> segment replication?
> 
> With my NFSD hat on, I would prefer to have the file version of "write
> same" implemented outside of the NFS stack so that other consumers can
> benefit from using the very same implementation. NFSD (and the NFS
> client) should simply act as a conduit for these requests via the
> NFSv4.2 WRITE_SAME operation.
> 
> I kinda like Dave's ideas too. Enabling offload will be critical to
> making this feature efficient and thus valuable.

So I have some experience with designing an API like this one which may
prove either relevant or misleading.

We have bzero() and memset().  If you want to fill with a larger pattern
than a single byte, POSIX does not provide.  Various people have proposed
extensions, eg
https://github.com/ajkaijanaho/publib/blob/master/strutil/memfill.c

But what people really want is the ability to use the x86 rep
movsw/movsl/movsq instructions.  And so in Linux we now have
memset16/memset32/memset64/memset_l/memset_p which will map to one
of those hardware calls.  Sure, we could implement memfill() and then
specialcase 2/4/8 byte implementations, but nobody actually wants to
use that.


So what API actually makes sense to provide?  I suggest an ioctl,
implemented at the VFS layer:

struct write_same {
	loff_t pos;	/* Where to start writing */
	size_t len;	/* Length of memory pointed to by buf */
	char *buf;	/* Pattern to fill with */
};

ioctl(fd, FIWRITESAME, struct write_same *arg)

'pos' must be block size aligned.
'len' must be a power of two, or 0.  If 0, fill with zeroes.
If len is shorter than the block size of the file, the kernel
replicates the pattern in 'buf' within the single block.  If len
is larger than block size, we're doing a multi-block WRITE_SAME.

We can implement this for block devices and any filesystem that
cares.  The kernel will have to shoot down any page cache, just
like for PUNCH_HOLE and similar.


For a prototype, we can implement this in the NFS client, then hoist it
to the VFS once the users have actually agreed this serves their needs.

