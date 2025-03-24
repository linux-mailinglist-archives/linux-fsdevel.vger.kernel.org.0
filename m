Return-Path: <linux-fsdevel+bounces-44872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DEAA6DDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1443AD64E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C625FA2B;
	Mon, 24 Mar 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBUtQeBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195F9450;
	Mon, 24 Mar 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828569; cv=none; b=tjmAeh7KMYnnIE89lOpOm+xABms7l2alK4pMCWTwb30B88vdCuXRfGbdKu7dtqz9ic5eVogaqDi1N96I/AbmlMn6pd5N7ohftvHEEcI9xHxbsXBp5JSrHVCL8UIdGkyKpVnijF4JU3ZflK5Xp2phC5MYFLWi8vvBVxy9SE6zfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828569; c=relaxed/simple;
	bh=yv61cHAJiH0JNvFm2SJMGEiqMHIGpIt9dw/H9oZc3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2o19QtboQiC34501n9QYqzCm5KU0nabbygD4/wIfps9U9+xHta84NKD+sPJHkmwq9tTqHUOdz5lR3bcrfcJ1+MYkb44xvE16afw3PzlTgJi9YfL40QtZJFsrROQ9bDmtO4e/U4r0eyu5gqlzNZZ5hp+0hQNHilqlcm085e7Wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBUtQeBP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=35uXtVKGaER37nteavlftmrAz1omkXbLtRVHdTRcrGg=; b=FBUtQeBPskXqJVfpcbX/bRxJvQ
	U2UCMFZYdpfbptLlHKjGYxLU2B8/oQDhAPnh21t9yzMuEVHHDwfI1ONuI6/zAc0hjPr1f7m1TZtZO
	e2dBaQR4jEQWGFfU+py5gItU6l5FA0x5kChkEyVut1rJ9GQXTwqjj/3UsuDEMZyQIdEioE301qkJA
	HTV1KguSRIZ0g9ni6Lw5xaadMh2gnEAIsmQknuozj4ZbDD08+uHfbDcSY3Y5DFFVBtrG3sBRLvxMH
	8FDNI2L8lziT8Qzs2L6EqViVNqEq99VAOspCmx48yoD+PJtOba1BhHVs5tnsdSeddHaa5CsiS3EY3
	Z8eGSKnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twjJu-00000000odr-3Z0q;
	Mon, 24 Mar 2025 15:02:30 +0000
Date: Mon, 24 Mar 2025 15:02:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
Message-ID: <Z-F0BgYykhh9DFby@casper.infradead.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
 <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
 <Z9w9FWG2hKCe7mhR@casper.infradead.org>
 <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>
 <Z9xB4kZiZfSdFJfV@casper.infradead.org>
 <e399689b-c0e9-4499-b200-3d7e110a359f@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e399689b-c0e9-4499-b200-3d7e110a359f@acm.org>

On Mon, Mar 24, 2025 at 06:58:26AM -0400, Bart Van Assche wrote:
> If the goal is to reduce DRAM costs then I recommend SSD manufacturers
> to implement zoned storage (ZNS) instead of only increasing the logical
> block size. A big advantage of zoned storage is that the DRAM cost is
> reduced significantly even if the block size is not increased.
> 
> Are there any applications that benefit from a block size larger than
> 64 KiB? If not, why to increase BLK_MAX_BLOCK_SIZE further? Do you agree
> that this question should be answered in the patch description?

Do I agree that we should use the commit message to enter into a
philosophical debate about whether ZNS or large block sizes are better?
No, I do not.  I don't even think we should have this discussion
any more on this mailing list; I think everyone is aware that both
alternatives exist.  You don't like it, and that's your prerogative.
But at some point you have to stop being an awkward cuss about it.

I think CXL is an abomination; I've made this point often enough that
everybody is aware of it.  I don't make it any more.  All I do is NACK
the inclusion of patches that are only for the benefit of CXL until
CXL has actually demonstrated its utility.

