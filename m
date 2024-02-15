Return-Path: <linux-fsdevel+bounces-11704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A534A85641E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6105928180B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037712FF72;
	Thu, 15 Feb 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tqNyv2lP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D112FB27;
	Thu, 15 Feb 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002868; cv=none; b=DmJUTx0sX3KYyXm4gIY1GpJx6pWt9Wdfqg07IWehpZabQJuJgrA/ROsiFmJPxzHS3B6sFXE/mzaprxzfy6FHvppJiw4jh83c2gtHg8yAZAV+irsVtYtqJowYTNZzkwkR9gVqh5S+RrrNdTQg6nDYg5dsPb2jszDWCt7G97SPUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002868; c=relaxed/simple;
	bh=aSiEOAMP+IX1K7V6GgqsGetPTkw7NYZFyUb+tQIMQaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZzNlE43OjhSI+XzG9bz3mSY4ZWg3naGsLgXbt1aPSnOYe562jVJLcJHZHH2RUM8hZoTZ0vBtA+FeOCpP8bwqkuPWNo7jhAFoWUg7EBpY16k18ikSQhgT5QBrl0hFJOQAxoh2Op/ltXF4Fk4Wf3kbnO18WO8KU2Z81mknDSTW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tqNyv2lP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aSiEOAMP+IX1K7V6GgqsGetPTkw7NYZFyUb+tQIMQaA=; b=tqNyv2lPaElUwgXN/ZbSzA+Yqd
	Fb98SIa8PgosPexpaoiiiFLDUr0Dkey/VrclZzHmDBkKDPCutrBSUqsyQZoBSj9SMpS53XTExfmKO
	ErDVecKRPkTxVG/5wWncItPjvfJXDIGwuGaAIpgy1CHrlG3cjtxweRgKZ6TjB7iPTSDAVQCVOObQ+
	KJR1SghT/ZByON8CBBhZqwa/EcCFo9Z1aDz5PBWjIkxPu0eTcmHhTyidVlZzFzxYyCFAxeZNwy+BW
	z5Nq3yS4i1uaDe/UxlKRmTLakgCKMBssQPYUt2uaxlTQw8tsHl6safyFKeDHlwupnGg+E6nfrv4DE
	2CxocTZw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rabZG-00000001v7c-0Rda;
	Thu, 15 Feb 2024 13:14:22 +0000
Date: Thu, 15 Feb 2024 13:14:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Christopn Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: shmem patches headsup: Re: [ANNOUNCE] xfs-linux: for-next
 updated to 9ee85f235efe
Message-ID: <Zc4OLvfTiVUDd_28@casper.infradead.org>
References: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240214080305.GA10568@lst.de>
 <0e8d50e9-4254-7acc-e9b4-9b6ad63a25da@google.com>
 <38716bcd-f26b-a7f5-2ef9-1ad554d42357@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38716bcd-f26b-a7f5-2ef9-1ad554d42357@google.com>

On Wed, Feb 14, 2024 at 11:39:06PM -0800, Hugh Dickins wrote:
> I wonder what the fuss is: Matthew (thank you) has been giving excellent
> reviews, and mm is a cooperative not a dickinstatorship (but I was upset
> that he caught that GFP_HIGHUSER, which I had been eager to point out).

Sorry; it's always frustrating when somebody else says the same thing
you were going to say ;-)

