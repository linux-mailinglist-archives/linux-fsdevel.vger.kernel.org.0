Return-Path: <linux-fsdevel+bounces-49880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE10AC45E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 03:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8563BAA87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE38633A;
	Tue, 27 May 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mMAlLGF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF7BA2E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309078; cv=none; b=C8s2ARFZ8Ccouq/1Vi8tK6DotnmI00kd3vgKz/7Hcsv21CEtqqPjpoYZP76HwLJnzldkQ9OTayHcqJVHizNx6imZXvH3U8IUPvmj2SWpqwwiZVYhrgfw4bhuUElizVOBzBnk4sgGCCQQxPIDQ1tbFBoudAEFbTozspWjSgmVGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309078; c=relaxed/simple;
	bh=edKPbJ9KxJRCdZ59maj2fKJWh+2t1+3sBsIRbXGx8x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJnwFfFsUSIPQp98MPXbmrZtGazdv31Wgxz7lJA0NBGlwCKkpe4Ake8PoCK25xoQDPn4am9dS3kepoZWIlT24D48M5a7MM3gzZOAkX4+ABmgdrPJgLvZSQSf9YkAfAKXirmbXvOxzna+DuEPWb1YW1miW3zJewg4dyczUi2/XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mMAlLGF1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VuHW8bt0xhxfdrOn9bR6pmhSt8NUMLzm0ppaKtCixz4=; b=mMAlLGF14ZAPVSVXRSBugjOT/u
	KMk+uLdpjTuELhm7aZgK+ylP1o8pkCO5xsJH0YK2+dTqFnYaxefMDL/S5zJuPu0yAmbpQVd32POtW
	3FGJOgKlhJzFrAQRFdP+mwn0ibTDkhOptRNGLV+7DNg3CsUypscd/hrClRM5NECbF/AEzJGYrrOH3
	CLQcrdQFrdDfXvt5m0b9jQRMDfeXqO+VYYvTM9F+DqekKuAN7f+3v27lq9Uu2Ttx1teWH7v0T7LPy
	cibOHA/gkz+u/DYcqIMNNt9wq1Vo3UCP8BdZwrJVFG8gl8yCPaO4DGT7xDUs4UJSKO8fin2adhJvl
	IyFTek4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJj3P-00000009dNG-2jLB;
	Tue, 27 May 2025 01:24:31 +0000
Date: Tue, 27 May 2025 02:24:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250527012431.GA2023217@ZenIV>
References: <20250525083209.GS2023217@ZenIV>
 <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
 <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
 <20250526235600.GZ2023217@ZenIV>
 <5a66f3f5-7038-4807-b744-d07103ebaea2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a66f3f5-7038-4807-b744-d07103ebaea2@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 26, 2025 at 06:58:47PM -0600, Jens Axboe wrote:
> On 5/26/25 5:56 PM, Al Viro wrote:
> > On Mon, May 26, 2025 at 11:38:53AM -0600, Jens Axboe wrote:
> >>> I'll poke a bit more...
> >>
> >> I _think_ we're racing with the same folio being marked for writeback
> >> again. Al, can you try the below?
> > 
> > It seems to survive on top of v6.15^^
> 
> Thanks for testing, Al! Assuming it goes without saying, but that's 6.15
> with 478ad02d6844 reverted, right?

That's 6.15 without two last commits - 478ad02d6844 and the version bump ;-)

