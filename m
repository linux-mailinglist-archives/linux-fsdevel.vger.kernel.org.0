Return-Path: <linux-fsdevel+bounces-35745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739299D79B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C888162A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2CD268;
	Mon, 25 Nov 2024 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnXBNBw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FF4A28;
	Mon, 25 Nov 2024 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497309; cv=none; b=S/PD4MIKWDyZRL5kHkq5/gb2TLL0i6qwmmSdhLKb04zwHnhBFC5sbkXSas2cU8Op8QlHq3Mlc8MIkTBNTl7oayN56WJ4rp05NRDDOV5pFK+8fSbc79XGnB//B57D3Ox8l12oNzEyNLzog6vIDIeoLSikwWnxXzgjsHA9AdPA6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497309; c=relaxed/simple;
	bh=FghVjbvvMpiTx3fdRcwk7Gj66JU3/jr9pR44rasDigk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN6Tuwkwd83fzJwlxLT9IrPcf/yxpOhCHCB8aX83gBpACiv/UPuwsEruWa1Y1I1FMLuhsKR9tJwz5cRE6Pghh/oSekIdjAee+arrZsRjVQpUQBge3BRLhHF3FwtlbvY0uj4+MejQAA88EatZM0hCHN+mxEiwjth5FSmvZEWw1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnXBNBw3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DPJxPRNtak+qMVMCGKE8L3WE4BezG2ABg27oPUZbe3M=; b=rnXBNBw3yzZnxhJIGUHJxMVUBN
	EsnGZV6pUmGXQxXpVRf63e/Vd8rUfLeYLeiCuW/y3D1UGsJXb2HbfAt5KYAvOuZG+tTEfascZ39GK
	wysE9XKEahtGw5ln/xMwpeuKx427lnIvdC7QKhZoLmkrVXvTGIraQah5FRStBgD/H/+gmkjDmhv3b
	cQkYmw57mmi1Upm1vaEeN48xakUPrJR4YVoRTAblIO72unUb+0526mATh1tloL214DPycESfDvWf3
	ZhaKtKNPaGL1rzrlEFVWbAz+PNG9e86lO850briCSPrY29A5Wk8pFS2ym95byAghyAfEXVuVzNkSx
	tPhIT+gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFNgt-0000000BA8K-3ooS;
	Mon, 25 Nov 2024 01:15:03 +0000
Date: Mon, 25 Nov 2024 01:15:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <Z0PPl_B6kxGRCZk7@casper.infradead.org>
References: <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV>
 <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
 <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
 <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>

On Sun, Nov 24, 2024 at 04:53:39PM -0800, Linus Torvalds wrote:
> On Sun, 24 Nov 2024 at 15:53, Matthew Wilcox <willy@infradead.org> wrote:
> Look, let's write 5.000950, 6.000150 and 7.000950, while there is a
> single reader (and let's assume these are all properly ordered reads
> and writes):
> 
>   W1.s 5
>   W1.ns 950
>   W2.s 6
>   R.ns (950)
>   R.s (6)
>   W2.ns 150
>   W3.s 7
>   W3.ns 950
>   R.ns (950)
> 
> and look how the reader is happy, because it got the same nanoseconds
> twice. But the reader thinks it had a time of 6.000950, and AT NO
> POINT was that actually a valid time.

I literally said that.

"Now we have a time of 6:950 which is never a time that this file had,
but it's intermediate in time between two times that the file _did_
have, so it won't break make."

