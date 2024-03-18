Return-Path: <linux-fsdevel+bounces-14690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C587E1DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1811C220E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF41BF3F;
	Mon, 18 Mar 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGjj8klp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13317547;
	Mon, 18 Mar 2024 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726221; cv=none; b=WnDv/K1YhsBkyXDxZNpGBdJ2aqMonQ1jwayGj8Q7AdjbCHTb9AGyE8MoQnd3WDXItX2kQJp3zmW53lzIiXOcC9b1QUQsQ8sNBgvG+7ppsQeZ3OhfN2pDdGQiwT/TBVIQ4AQ1maWoA96mOCTSDBun4h/qZmC65KgtsDhXkdmKu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726221; c=relaxed/simple;
	bh=6wHEGScGebsB8YZRoj0nM1zwl1+GcBDIVvkwATpv8zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifvp53igP515QbwOdA1hBxSqHfRU/PURm7oc+yd4Rulkt+1rhZyniPIPqBve0Bpx/XaRK8gBDfc5aJR2P8/d31PH6wqKQVzjERT/Ut1mNXjZ+wclbJMq0AiPCO8TjZy4tAS4/i3JxF0mUKxT/qyBPBv21aXV3WBdEY5mYG0RQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GGjj8klp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CmiL69yLYxuLopaHcgf4mF4zui4cUo2PKK6V1SVPigA=; b=GGjj8klpW+I8gN7jruJLDZgsSW
	cTmqGZDEIlJHw0ffydZUOH5HbE7M0xvV68lN5B0M1i/xA7iNww2RbDS+9I6/U+i6G4R9b+NEALtVz
	pUKV4+f4bwkeEIPV7fsGV75fFRpeZRV5Pnjml1vPDr6GdkOW11k5zHcGJL9QnhOUutUR2m1vPTHJz
	IWMVes++e1U3tP5/K7PgvK6qO5uxnlZkOqLV4UajjgSshqe1ibPP+kEeD0BUh6kASDhi85NQz134b
	168eCh4xRbW0XROgrDqhmUgCKY0Vp2KGo9qbuD3G2wJn3rD7RqjOR2WOtKrghVvCnEGaBTNtrDUmV
	3E6v5EwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm22N-00000006xQw-1tZ6;
	Mon, 18 Mar 2024 01:43:39 +0000
Date: Sun, 17 Mar 2024 18:43:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, aalbersh@redhat.com, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 26/40] xfs: add fs-verity support
Message-ID: <ZfecSzBoVDW5328l@infradead.org>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246327.2684506.14573441099126414062.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246327.2684506.14573441099126414062.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just skimming over the series from the little I've followed from the
last rounds (sorry, to busy with various projects):

> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -92,6 +92,9 @@ typedef struct xfs_inode {
>  	spinlock_t		i_ioend_lock;
>  	struct work_struct	i_ioend_work;
>  	struct list_head	i_ioend_list;
> +#ifdef CONFIG_FS_VERITY
> +	struct xarray		i_merkle_blocks;
> +#endif

This looks like very much a blocker to me.  Adding a 16 byte field to
struct inode that is used just for a few read-only-ish files on
select few file systems doesn't seem very efficient.  Given that we
very rarely update it and thus concurrency on the write side doesn't
matter much, is there any way we could get a away with a fs-wide
lookup data structure and avoid this?

