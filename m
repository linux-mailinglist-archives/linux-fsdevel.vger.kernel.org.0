Return-Path: <linux-fsdevel+bounces-67644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A6C45A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EE13A5E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD73002AD;
	Mon, 10 Nov 2025 09:31:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF32E8E0E;
	Mon, 10 Nov 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767118; cv=none; b=JCtlwJ1vRJ5Pg/Bra3FUsA/BHLd1d6+kOkzcG5jTt87r7ZD4YWI3dDunAJI7GNXCgnImVxfHFd0KtHmYoH3pjlKHcHGy6w4hF7vrWoyXN6tElgpQ/8EKpTmi7oe6k5t2KkeoOH+tzR9q8a3HVHiWtaRTvF8qxRR380F9a26QDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767118; c=relaxed/simple;
	bh=nmuldyuZD2nRGq42cOH+SbbeN+lRYZeaUiYdGciqMnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV17MXE4ptAyi5sADaT/m1TItS9kFOqz366VOQatCGnfcrWTKl3b/W3X8ZifPLtUJ1+qk6yXCC2tpGKEqg4CMUStzaxuPCvKnishTsH7HZyQLZZHpRmWXq1YPL6Tg31ggC8OY/g8mSp7C/3VGmdvOzAV0NXDlbruBS3prVCzYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D2FF227A87; Mon, 10 Nov 2025 10:31:41 +0100 (CET)
Date: Mon, 10 Nov 2025 10:31:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251110093140.GA22674@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qgg4sh1.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
> main(void)
> {
>   FILE *fp = tmpfile();
>   if (fp == NULL)
>     abort();
>   int fd = fileno(fp);
>   posix_fallocate(fd, 0, 1);
>   char *p = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>   *p = 1;
> }
> 
> should not crash even if the file system does not support fallocate.
> I hope we can agree on that.  I expect avoiding SIGBUS errors because
> of insufficient file size is a common use case for posix_fallocate.
> This use is not really an optimization, it's required to get mmap
> working properly.

That's a weird use of posix_fallocate, but if an interface to increase
the file without the chance of reducing it is useful that's for
sure something we could add.

> If we can get an fallocate mode that we can use as a fallback to
> increase the file size with a zero flag argument, we can definitely
> use that in posix_fallocate (replacing the fallback path on kernels
> that support it).  All local file systems should be able to implement
> that (but perhaps not efficiently).  Basically, what we need here is a
> non-destructive ftruncate.

fallocate seems like an odd interface choice for that, but given that
(f)truncate doesn't have a flags argument that might still be the
least unexpected version.

> Maybe add two flags, one for the ftruncate replacement, and one that
> instructs the file system that the range will be used with mmap soon?
> I expect this could be useful information to the file system.  We
> wouldn't use it in posix_fallocate, but applications calling fallocate
> directly might.

What do you think "to be used with mmap" flag could be useful for
in the file system?  For file systems mmap I/O isn't very different
from other use cases.


