Return-Path: <linux-fsdevel+bounces-67865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD086C4C8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A0944F62F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2032ED846;
	Tue, 11 Nov 2025 09:05:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D272586E8;
	Tue, 11 Nov 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851907; cv=none; b=p8tx1S6WAZTa/wMRvo2oydkfzWXibRXDC8IMHbEI5sae1WFf8V256Uau1U7uos5sTkRBU5PWCEhSznL4xrnYO3/RertGyJrN5c+YyT78DVYfvduVVSjgIRaETpjvGALSsklrb/4jiOfuzxF2wl2FMq9EDT6xLbNGWnBh7GvrX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851907; c=relaxed/simple;
	bh=p4uF4Vyz6pDkt+BIpm/hfqQUVCIcHglKLllHnH5MJW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgc0NwhFpNhcrqvudY8yjDk6hi222/AyfzSJF2/lIEHhT3gYsrrjliXiKvcv/HMtYI0jwllv7l/M8Zd1YkjTvMkgvFIJ7MxmYYBECRS5r5XuyVE3s5UaTtxDzbUierSd4rVNkd2yfKQk2gNeH+pPnfCdfvhiZZk4nSXXnigyHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD2E3227A87; Tue, 11 Nov 2025 10:04:57 +0100 (CET)
Date: Tue, 11 Nov 2025 10:04:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fw@deneb.enyo.de>,
	Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251111090457.GB11723@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <aRESlvWf9VquNzx3@dread.disaster.area> <20251110093701.GB22674@lst.de> <aRJaLn72i4yh1mkp@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRJaLn72i4yh1mkp@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 08:33:34AM +1100, Dave Chinner wrote:
> > Not really.  FALLOC_FL_WRITE_ZEROS does hardware-offloaded zeroing.
> 
> That is not required functionality - it is an implementation
> optimisation.

It's also the reason why it exists.

> WRITE_ZEROES requires that the subsequent write must not need to
> perform filesystem metadata updates to guarantee data integrity.
> How the filesystem implements that is up to the filesystem....

No, it can;t require that.  But it is optimizing for that.

> > I think what Florian wants (although I might be misunderstanding him)
> > is an interface that will increase the file size up to the passed in
> > size, but never reduce it and lose data.
> 
> Ah, that's not a "zeroing fallocate()" like was suggested. These are
> the existing FALLOC_FL_ALLOCATE_RANGE file extension semantics.

Yes, just without allocating.

> AFAICT, this is exactly what the proposed patch implements - it
> short circuits the bit we can't guarantee (ENOSPC prevention via
> preallocation) but retains all the other aspects (non-destructive
> truncate up) when it returns success.

Yes.

> I don't see how a glibc posix_fallocate() fallback that does a
> non-desctructive truncate up though some new interface is any better
> than just having the filesystem implement ALLOCATE_RANGE without the
> ENOSPC guarantees in the first place?

For one because applications specifically probing the low-level Linux
system call will find out what is supported or not.  And Linux fallocate
has always failed when not supporting the exact semantics, while
posix_fallocate in glibc always had a (fairly broken) fallback and thus
applications can somewhat reasonable expect it to not fail.

> > They are both quite different as they both zero the entire passed in
> > range, even if it already contains data, which is completely different
> > from the posix_fallocate or fallocate FALLOC_FL_ALLOCATE_RANGE semantics
> > that leave any existing data intact.
> 
> Yes. However:
> 
> 	fallocate(fd, FALLOC_FL_WRITE_ZEROES, old_eof, new_eof - old_eof);
> 
> is exactly the "zeroing truncate up" operation that was being
> suggested. It will not overwrite any existing data, except if the
> application is racing other file extension operations with this one.

FALLOC_FL_WRITE_ZEROES is defined to zero the entire range.
FALLOC_FL_ALLOCATE_RANGE or a truncate up do not zero existing data.


