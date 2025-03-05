Return-Path: <linux-fsdevel+bounces-43263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B2A5018F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CC618955B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0FD2144A4;
	Wed,  5 Mar 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ruv7Sxpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F32746B;
	Wed,  5 Mar 2025 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184156; cv=none; b=Z0TmMyc/dU6AcB2u8Frp54nroZv10l5L7qNzXR/ubSnjjL4w1fYeOEft6c1kfxVFhaWzXt+fUP3Yq2gUP2xtsjsdEowX8CxUWlhdK43pVQGRyUYCiqOTd/YJvor3zJX5wXtkSZM7GV8jq8ZKv1OWUBtF8GUdLy/I3ZEdxrbr5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184156; c=relaxed/simple;
	bh=Jd0oFoBFCKY0hrFzbb92DWtvlLdcSoRBduiUG5Uiqks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaoT0aEAxvA+Wo/O6HSYSRbcwoKXbcMmNrR0z+uhmHXpBvFXA2LyDyh08HRC8ukmbuRmBrChj7PVUdehsBmD54zd0wgfHIgZkkSmKLzUjlB3X74OFcQ6zmKU4/iqkA5TFDKHqXSoiEMVsSFAvlNRy5UDdou6xIHK0QwzMRnsvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ruv7Sxpk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EcLdV6q+VbbCZ2RH5VzC2yHi/7sMLvo0VgctfZO0l8I=; b=Ruv7SxpkDeNaqUBwXW3IRjSHE8
	d5cHgB9CYPcPAEkpL2rtt/DnBnE94Y+4XjYe7W2v3mYKpLzL46PA1Xzetl1lkB+QClgCnwyiQH1DL
	qMd6WuET3d3IdZVm0Ln9Id3asAlmZdvmmkOdZCvp7HsK4FICQ/o1FLqHv6+F1IMwcmgv4DR8n9UXG
	kzxJDXkw/JcQkDgD+BMVEg/bkaAt9Jdi7C2FmjwmJRoElrGaUHIKePFY3oLzNIAM0JfDdNW3z5bCr
	Qw5FA3+Dj+6/blmh4kjdNXlOlIAXI1BmQbOfvS77H4ImsvLJQKAAPR877iQpydmAA66e2pA040/Kl
	2oRoqyYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tppXH-00000005dx5-1koi;
	Wed, 05 Mar 2025 14:15:47 +0000
Date: Wed, 5 Mar 2025 14:15:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <Z8hck6aKEopiezug@casper.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <Z8fpZWHNs8eI5g38@casper.infradead.org>
 <20250305063330.GA2803730@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063330.GA2803730@frogsfrogsfrogs>

On Tue, Mar 04, 2025 at 10:33:30PM -0800, Darrick J. Wong wrote:
> > So this is expedient because XFS happens to not call sb_set_blocksize()?
> > What is the path forward for filesystems which call sb_set_blocksize()
> > today and want to support LBS in future?
> 
> Well they /could/ set sb_blocksize/sb_blocksize_bits themselves, like
> XFS does.

I'm kind of hoping that isn't the answer.

> Luis: Is the bsize > PAGE_SIZE constraint in set_blocksize go away?
> IOWs, will xfs support sector sizes > 4k in the near future?

Already there in linux-next.  47dd67532303 in next-20250304.

