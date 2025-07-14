Return-Path: <linux-fsdevel+bounces-54833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FAFB03D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0812317AFB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF1246798;
	Mon, 14 Jul 2025 11:40:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA524502D
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493239; cv=none; b=rY8J/DPEx1BC9lHDhclfWxXcWk9pJjPCHZmF6j1fw5Xy9zaprAnSTQko1d2WY3Oo2BoAv71vVrazs3/Jcs9I3x3pcADtL0k0S9eYEwL3+WpRcbcccoKr1HOHKBSXBJL54BFayLlsybIT+iqIU9/YQebUTp6W6iIxD7klsVlI0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493239; c=relaxed/simple;
	bh=0FEjbi5VVykfHO0uISkkN0dQw/0K2FcnbLFcq32RoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6PMTPcUiDdcJxFC6djma9CW78htGA0+uZ1NQxUTpkcK8wzL0uPxN0UtAFfsfos4HtWjlsn1YEFtpx64+Obz7QMPy4T9U5iQgbIwo57gGsHKDdYWsWUb0AJnF2VBjlV0H8Us+UBzCsqqYDRxl0XJZXEgzPRBInkKh4Q7rh5+R3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8638B227A8E; Mon, 14 Jul 2025 13:40:31 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:40:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	hch@lst.de, miklos@szeredi.hu, brauner@kernel.org,
	anuj20.g@samsung.com, kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] fuse: use iomap for buffered writes
Message-ID: <20250714114030.GA1847@lst.de>
References: <20250709221023.2252033-1-joannelkoong@gmail.com> <20250709221023.2252033-2-joannelkoong@gmail.com> <20250712044611.GI2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712044611.GI2672029@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 09:46:11PM -0700, Darrick J. Wong wrote:
[fullquote deleted. Any chance you could only quote the actually relevant
parts as per usual email ettiquette?]
> > @@ -1419,6 +1449,15 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  			goto out;
> >  		written = direct_write_fallback(iocb, from, written,
> >  				fuse_perform_write(iocb, from));
> 
> Random unrelatd question: does anyone know why fuse handles IOCB_DIRECT
> in its fuse_cache_{read,write}_iter functions and /also/ sets
> ->direct_IO?  I thought filesystems only did one or the other, not both.

Nothing really should be setting ->direct_IO these days except for
legacy reasons.  It's another one of those method that aren't methods
but just callbacks that require file system specific context.


