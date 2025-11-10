Return-Path: <linux-fsdevel+bounces-67646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD14C45ABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0881885B75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365B2FD675;
	Mon, 10 Nov 2025 09:37:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD81AC44D;
	Mon, 10 Nov 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767439; cv=none; b=mfDK0STXwwHZDnP75CWW9tMnomp2USR/cwiet3f/s1xtC1XvVeHFWVQ4t4EV5270EmGwodO1QuVtKbDKrsFXJ+nGjUWqS5TBJ3xBcJWdMmysQTnv49pZkwTweLH+woEQOUCrgXY/Q7r8eIO0oiKfJw2Q4JGvfQX8k2xbrcATo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767439; c=relaxed/simple;
	bh=0ZQ7pCO5DtWPJojzc59Jt4RON+IjZDgkIkxd6NU0dbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFnCPbXyeAbwGAoD7Z2UMIQ8Zjvkz/CSsnC3hF9AilJDkL1H9vvUvS3QCtxaEZS3j9vQU2CyOLWqoTl9R/onCrsLFRYEbalNw5NfaM88kBFwiph/xApn6sdkglz4QM04X7YpRBQ3khpxzW4W4La8jEIMCOFIjwPsdH9ySkDoAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23912227A87; Mon, 10 Nov 2025 10:37:03 +0100 (CET)
Date: Mon, 10 Nov 2025 10:37:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, Christoph Hellwig <hch@lst.de>,
	Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251110093701.GB22674@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <aRESlvWf9VquNzx3@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRESlvWf9VquNzx3@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 09:15:50AM +1100, Dave Chinner wrote:
> On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
> > * Christoph Hellwig:
> > 
> > > On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
> > >> It's been a few years, I think, and maybe we should drop the allocation
> > >> logic from posix_fallocate in glibc?  Assuming that it's implemented
> > >> everywhere it makes sense?
> > >
> > > I really think it should go away.  If it turns out we find cases where
> > > it was useful we can try to implement a zeroing fallocate in the kernel
> > > for the file system where people want it.
> 
> This is what the shiny new FALLOC_FL_WRITE_ZEROS command is supposed
> to provide. We don't have widepsread support in filesystems for it
> yet, though.

Not really.  FALLOC_FL_WRITE_ZEROS does hardware-offloaded zeroing.
I.e., it does the same think as the just write zeroes thing as the
current glibc fallback and is just as bad for the same reasons.  It
also is something that doesn't make any sense to support in a write
out of place file system.

> Failing to check the return value of a library call that documents
> EOPNOTSUPP as a valid error is a bug. IOWs, the above code *should*
> SIGBUS on the mmap access, because it failed to verify that the file
> extension operation actually worked.
> 
> I mean, if this was "ftruncate(1); mmap(); *p =1" and ftruncate()
> failed and so SIGBUS was delivered, there would be no doubt that
> this is an application bug. Why is should we treat errors returned
> by fallocate() and/or posix_fallocate() any different here?

I think what Florian wants (although I might be misunderstanding him)
is an interface that will increase the file size up to the passed in
size, but never reduce it and lose data.

> > If we can get an fallocate mode that we can use as a fallback to
> > increase the file size with a zero flag argument, we can definitely
> 
> The fallocate() API already support that, in two different ways:
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_WRITE_ZEROS. 

They are both quite different as they both zero the entire passed in
range, even if it already contains data, which is completely different
from the posix_fallocate or fallocate FALLOC_FL_ALLOCATE_RANGE semantics
that leave any existing data intact.


