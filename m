Return-Path: <linux-fsdevel+bounces-66853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E058C2DABF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B6618914F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31909313273;
	Mon,  3 Nov 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2ZihU4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2228C5A3;
	Mon,  3 Nov 2025 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194373; cv=none; b=aYI1S3ePWDxM/uCZcKC24SZIKX3xpjp2lGtdpQ9eFux4EPG1Tsav76lj/DT5WIiG9UEnmDRUc6UI0XxURxictKh/R1HdfjNx6aDrsgTQctoosp0NUw0uhAWrLTl83VM3UjGSKv8UW4GIJSp0nSjQFx2meZBAzbj8QWjPVgeO07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194373; c=relaxed/simple;
	bh=sRSZoD69PFGuks85RFT1srPpiVwKNmQT4VB9C/IpXzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STCdiAA4GxlhsCa3Wzv6wibP+f22ZnXJp8HPhulAaP+GuQ2CkZRHKbmpW8NX1NYKN0jfeNW/cISmMCj9X6nSHqsW29lFPQqqgLgvLmFaoeMjUTli6bD2kcaymKzgWGz6SXZJka6ojP3idfYNs8WfY23wfsyiK5OxhygIc7zrCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2ZihU4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E46FC4CEE7;
	Mon,  3 Nov 2025 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762194372;
	bh=sRSZoD69PFGuks85RFT1srPpiVwKNmQT4VB9C/IpXzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2ZihU4a88IT22zwpS3yuXfwvIiDBx6cfn1WYWQSDZ0xh3tIib40apeN4lEUDlsX3
	 ToplXbMzIQHKdhYoYnpUJZY/X28X0853r/1gcExjQpT6+M03Qr/r8fq66Ubpt005QI
	 lEjPlDHCiWHCcaiKGVayPuOCEAb9Iowqqse2T5SDi99SFOl/49Kw3MRC5npoWHbNF1
	 9Fg7pNPHEoJt1z8Jv/UZY4TDEv7S/ZdciooTlybikXQR+dzkZgLQv5AE6AjGZSnjBX
	 MhrhZq1pmf460cWqCHWDF15Z0zLANqmVOwVSO3MDzXgnt60931PdYq3Kup5Ke3jGVg
	 8O/C1FWGJ7oNw==
Date: Mon, 3 Nov 2025 11:26:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Llamas <cmllamas@google.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aQjzwh3iAQREjndH@kbusch-mbp>
References: <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
 <20251028225648.GA1639650@google.com>
 <20251028230350.GB1639650@google.com>
 <20251029070618.GA29697@lst.de>
 <20251030174015.GC1624@sol>
 <20251031091820.GA9508@lst.de>
 <20251103181031.GI1735@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103181031.GI1735@sol>

On Mon, Nov 03, 2025 at 10:10:31AM -0800, Eric Biggers wrote:
> On Fri, Oct 31, 2025 at 10:18:20AM +0100, Christoph Hellwig wrote:
> > 
> > xfstests just started exercising this and we're getting lots of interesting
> > reports (for the non-fscrypt case).
> 
> Great to hear that it's starting to be tested.  But it's concerning that
> it's just happening now, 3 years after the patches went in, and is also
> still finding lots of bugs.  It's hard for me to understand how it was
> ready, or even useful, in the first place.

I've been using these memory alignment capabilities in production for
quite some time without issue on real hardware, and it's proven very
useful at reducing memory and cpu utilization because that's really how
the data alignment comes into the services responisble for running the
disk io, and the alignment is outside the service's control.

Christoph is testing different use cases with check summing and finding
much of the infrastructure wasn't ready to accept the more arbitrary
memory offsets and lengths.

Finding it now is more of an indication that those two use cases haven't
overlapped.

