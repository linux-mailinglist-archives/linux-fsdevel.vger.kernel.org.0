Return-Path: <linux-fsdevel+bounces-34422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0699C5274
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009E7B2FC29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA720F5B6;
	Tue, 12 Nov 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="sqEcSnpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiwMk+jp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CC20D4E2;
	Tue, 12 Nov 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405058; cv=none; b=qhrN93OX2Ep7KLZdpSvZBdKQD1iUPdjjy9zcvgOSObdsgcESuk/Nhq0qP8Bpi7Wz2k9Rzk/oUKJwPI94elJs2Y28CAX0blBvcuDhnUgzzX50pYYGWRoxTT68jEF/WDPvtudl+tr0fnCSXwPajTR8pWhPPtjFqMLgVPoBU28rjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405058; c=relaxed/simple;
	bh=r+NsbfXDvnvHK9K3j38eOhCBOVbduvPgYb5sl6GPr78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH3g2EEXjMWQL5wtG7VRx+Dn5HqRqnEHOymzvjpuwrnGXLovBWYZXqyY+wwpcHVn87mWP6VdCx5idxcAyT8hr2xMShn6e5R095V5L/vYzUB++UCnUleaHJBK1tXU9WtNntFiWT5Bfk3zEWAYnNZIqMUG9UPGHb940PBI+WRa3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=sqEcSnpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiwMk+jp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id ACB661140214;
	Tue, 12 Nov 2024 04:50:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 12 Nov 2024 04:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731405054; x=
	1731491454; bh=q6d4TW3b9u4ERBhUXTON+1lh+lOfBpLQCjeY8XLQHRQ=; b=s
	qEcSnpAxRWFu4D3RBfoLcFrMbOZ4tGmkoSwQt4g4syulATNYNEk7t0Tb1XoEfvFJ
	zKA5VrPe2L1E+bexnENdIvdk8EZpzmdJDH2l/nP5Bv7K6Z33wyVz0YpAfj6bflIj
	c6q38S/Zaj1MKis4qdYsPbBAHWlhpUP709ccxsCAK6FVCuvr4MyWqbfG8q6d9DLw
	lv+H81SQeWxCkcfxGYZ0fJinUIVETGm6It5A7QFx80TTATJLar9lVqq5vxls8Xy9
	SH8MNzVYa8zu16u+BGSugl5vox/ADaAqMPwkWhQbygVUA6ml6M1VkOFA2TIsdNA4
	5o97a/7IElN7nCIbJC0gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731405054; x=1731491454; bh=q6d4TW3b9u4ERBhUXTON+1lh+lOfBpLQCje
	Y8XLQHRQ=; b=CiwMk+jp+BR7V3cpmHYvsqhm1AJB1ek8zLh7j5vrUb3SCXyrbDh
	GonYvh+OvM2Oa1t+ZFv2rojrA32W6dnOMc2BDnlVtmCY/1W9936QNi+G/Xoz0gYh
	FMlJdVoJG2eBR7P3FXVhsH+3v7n5epXgGEb1g5aSBCUFsfoKtEdXGWAAHQSbjJ0k
	J1HTy8PjMDpDl6KrZI/VLXTnqM8T7Q2b6578Pux6zjUh0XZ/b1UNsG0wiFgwyCWH
	FuJj6/IMEwp7lXn0tjYfA33glxoBwG3No/n5KTzowKod5vUXwB/q3VpYb5AhYdmz
	AQq/0pGrsrooR50VORt5UogfPdQfjnL5r9A==
X-ME-Sender: <xms:_SQzZzxCXw2vyp4p5-XxtCs1lkKtOhGEZcrm6rZdrZ7ygFq3eiKzBQ>
    <xme:_SQzZ7Q3V6bHIfTh4WDM9mb-KstoZRH8kGBYA8Cro-ladcwLMvmFXP4kl5wyPiQMO
    3DoQLmYfFhXSCnJ04o>
X-ME-Received: <xmr:_SQzZ9XHfpjvzjeC0p0zXSsw9e3i834S-KEe6FdA1XVJzoSvNC_06Dr5BcihaVj7dyZxkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrvhhiugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopegrgigsohgv
    sehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtth
    hopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:_SQzZ9jfwwj0xtOYcS25l2-9tqKTY7ngJE5eOSqFViCa5mkdWe-dlQ>
    <xmx:_SQzZ1Aj5p0yPv53sjF3peCwSi2o8_fUbauIMhNWaWElxcwcQUO8rQ>
    <xmx:_SQzZ2KFXW3oINlnSeJRVPxoPzXHWtIt3Y8TBbr9f2UONox2TP1WYg>
    <xmx:_SQzZ0BonfvPTLF9NxIukA0ZJH4Pf_CdceJi5SPr9Y4kb8wqb5-31g>
    <xmx:_iQzZ6K0x-6jfb9f3_fLNVbrOe7z9DqB8Yi1CzfY4iYxS--XeOrHVzQT>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:50:50 -0500 (EST)
Date: Tue, 12 Nov 2024 11:50:46 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/16] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <2sjhov4poma4o4efvwe2xk474iorxwvf4ifqa5oee74744ke2e@lipjana3f5ti>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-11-axboe@kernel.dk>
 <ZzKn4OyHXq5r6eiI@dread.disaster.area>
 <0487b852-6e2b-4879-adf1-88ba75bdecc0@kernel.dk>
 <ZzMLmYNQFzw9Xywv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzMLmYNQFzw9Xywv@dread.disaster.area>

On Tue, Nov 12, 2024 at 07:02:33PM +1100, Dave Chinner wrote:
> I think the post-IO invalidation that these IOs do is largely
> irrelevant to how the page cache processes the write. Indeed,
> from userspace, the functionality in this patchset would be
> implemented like this:
> 
> oneshot_data_write(fd, buf, len, off)
> {
> 	/* write into page cache */
> 	pwrite(fd, buf, len, off);
> 
> 	/* force the write through the page cache */
> 	sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);
> 
> 	/* Invalidate the single use data in the cache now it is on disk */
> 	posix_fadvise(fd, off, len, POSIX_FADV_DONTNEED);
> }
> 
> Allowing the application to control writeback and invalidation
> granularity is a much more flexible solution to the problem here;
> when IO is sequential, delayed allocation will be allowed to ensure
> large contiguous extents are created and that will greatly reduce
> file fragmentation on XFS, btrfs, bcachefs and ext4. For random
> writes, it'll submit async IOs in batches...
> 
> Given that io_uring already supports sync_file_range() and
> posix_fadvise(), I'm wondering why we need an new IO API to perform
> this specific write-through behaviour in a way that is less flexible
> than what applications can already implement through existing
> APIs....

Attaching the hint to the IO operation allows kernel to keep the data in
page cache if it is there for other reason. You cannot do it with a
separate syscall.

Consider a scenario of a nightly backup of the data. The same data is in
cache because the actual workload needs it. You don't want backup task to
invalidate the data from cache. Your snippet would do that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

