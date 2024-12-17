Return-Path: <linux-fsdevel+bounces-37612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E89F44D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E021887FDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806F16EB7C;
	Tue, 17 Dec 2024 07:11:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC62BAF7;
	Tue, 17 Dec 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419471; cv=none; b=te6XowLRD82h8HpakBJ4x5WL2x11RVEyg44/nsYq8Mcz78SjGyjhgNrfwH1J+tT4/tmo4w2VMcdNpCgy1204vCAAgNkFKgct9vcDyEMUGQdwfbbuM8npq6uycNhOxVqcffynzk14vSnVJXO/CzAaLlZ9Em8HH3h+rYymy3fYoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419471; c=relaxed/simple;
	bh=t8TgbVgXdk/cTIQuqmCe2DwdZlSdU1zys3Q7LifDjbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI18zxGzrBCnAQ6KJrDUz7ezAscT4nWux3cKrPFcpNgjVkvSAsw/w7cRH3sMhFnYCtb17kpSRHYuRhRiwp/HrARI4by7l43KKLJNbNVeeRtQRWlYW6YkJS3v24eGSLiDlGMjCJHWmSlras/CUvOCKoaHXv0piiizKM0KEUEvue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1958D68B05; Tue, 17 Dec 2024 08:11:05 +0100 (CET)
Date: Tue, 17 Dec 2024 08:11:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
Message-ID: <20241217071104.GB19358@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com> <20241213143841.GC16111@lst.de> <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com> <20241213172243.GA30046@lst.de> <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 13, 2024 at 05:43:09PM +0000, John Garry wrote:
>> So if the redo log uses buffered I/O I can see how that would bloat writes.
>> But then again using buffered I/O for a REDO log seems pretty silly
>> to start with.
>>
>
> Yeah, at the low end, it may make sense to do the 512B write via DIO. But 
> OTOH sync'ing many redo log FS blocks at once at the high end can be more 
> efficient.
>
> From what I have heard, this was attempted before (using DIO) by some 
> vendor, but did not come to much.

I can't see how buffered I/O will be fast than an optimized direct I/O
implementation.  Then again compared to very dumb dio code that doesn't
replace the caching in the page I can easily see how dio would be
much worse.  But given that people care about optimizing this workload
enough to look into changes all over the kernel I/O stack I would
expected that touching the code to write the redo log should not be
out of the picture.


