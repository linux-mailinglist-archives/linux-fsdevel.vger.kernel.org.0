Return-Path: <linux-fsdevel+bounces-51840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3BCADC14F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E843B52A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C223B629;
	Tue, 17 Jun 2025 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2gcINPyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEC188A3A;
	Tue, 17 Jun 2025 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137004; cv=none; b=UolYa2ozwD0HnL/ybnKX7AGTL+FQwg79ebSsS7Pd0FTi8CW4K0e3zbhqxi0caKqu2Jx/JgvT6IveqYgKKknnVYzjM0L62TjBl20vLDBoCCwkpjL8zhX1/mFv4f8j3aMvisJN9B0//AuOVakQTHlZ1HueAXVvMWRDR2k5JVdteqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137004; c=relaxed/simple;
	bh=e6F/U8KK+JHo5QqmKZF8HChaFF0qtrKFcOPjmUPZzbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip0WaMNOfkku02MTydhFfkNWx82RYBXYGpom0pw4EppAw1T4I7jWKxSTVrmW3iWiUhb1AmUf9dbSBVlX0qJb9DzXsoKfEjmu3Uo7zhM554KhoIYJGyfxq+gG+mA8RK9fUwDLPQDTAZ5fZrAhglPCBN/1PEwf61NHu3Dr5nT/45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2gcINPyO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DGMGg4G/vCV2eg1kp9R5xDSi1djMxRdxqFweh59FJEo=; b=2gcINPyOI9wJompQfi+CsRVQLi
	m67uComR4aqj/PS3FfM9xGyUC1qRq5JHshJEj7ZVfLdtc9sKqyxuW8j7UKiqze8ngqHg0aCoNj+KJ
	QySeBUehb0E0pQqXkf6rleydbiviw3u4i7SymVr+b2XneAjweD41xw9xYoG00cJkNUGrZZJ78uR3t
	TTgyziKtq2xAaiwUX2Dkc+r8nQnFmElIlksdlOkcJhAPNeRUZNIyyks0VEAGUfwXgd0uqNYS0I6ki
	8T4e9mDB1pUDYk3D81kA2RIea1DuI4S7RhnYfMynY+5WhlcoNkDd297VVMQwNlzBAs5FFKXYchMJQ
	p8c53nMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uROaA-00000006E2Z-3tTA;
	Tue, 17 Jun 2025 05:10:02 +0000
Date: Mon, 16 Jun 2025 22:10:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
Message-ID: <aFD4qhupi8pxDzy0@infradead.org>
References: <20250616062856.1629897-1-dlemoal@kernel.org>
 <yq1zfe7xv9s.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1zfe7xv9s.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 16, 2025 at 05:24:43PM -0400, Martin K. Petersen wrote:
> > For a SCSI disk, this defaults to 2560 KB, which significantly improve
> > performance for buffered reads.
> 
> I believe this number came from a common RAID stripe configuration at
> the time. However, it's really not a great default and has caused
> problems with many devices that expect a power of two. Personally, I'd
> like this default to be something like 2MB or 4MB. MD, DM, and most
> hardware RAID devices report their stripe width correctly so the
> existing "RAID-friendly" default really shouldn't be needed.

Yeah, that number always felt weird.  I'm all for using a more
round value here.  But as you said, separate isue.


