Return-Path: <linux-fsdevel+bounces-40574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7831A254A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BE27A291A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC71FC7D6;
	Mon,  3 Feb 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rujSz8jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8E1FBE88;
	Mon,  3 Feb 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572025; cv=none; b=U89xNuWLEJcZzfnqX9GXvAZ7aCJM7Qgel0rq1Vse+Vsa+ilIWRkYIn77Y2m0HwaNQHDGDKjGQExPq7rDRCovvfZAPT8VoYF9I3HRGyIgX8LgXT+gsoBDMtu2tNfKTBaAPDiRg8IMgSL5Vjqrz4AX30Qkb/3qulWVltik1JY0Tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572025; c=relaxed/simple;
	bh=waYpN7LpZAmyAUaa4NA5GrgsMJO83yriUtMP+pHWFVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKM2BVuyh65cFkJgmv8JSCZrfNpg9tC82qvF05cAB7y1mLoY8kd7DwyzfRgH01VtvSxGvhiXU1bqyPrsZuOVO6IMcg9m6NmwSnj7Z3dLPfpG5fY0bVczSoguKr4V94VGd1pbhbuVDcpkTrTvHfojDdKf2lEgUn5XcOdevrksqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rujSz8jy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O5ZOcb6eRlEeqZR3m2BdJeOr/ABU2XZiCq8VPElSOWk=; b=rujSz8jym+q7b+Ud3nk4FAHVHr
	RhznCRmYeqlurHh4sP2FLsm3uFdXkF9OPGtLZQCU8J/Rt0A0w0VdnPU/7YO6bmAgnBZpdAcePUfwP
	6G4akFmyQ3DRP3c677ukrsFvGHJvjPJYIbk/XEVckQKOQJYNPJGQlHrNlDVXIG2wNTRzaFWVjnNBC
	K50mCtktPo4eXrRw7HvH+kr1WzZ2QH8whHvUDRtrVTI9ZC5rohS+HQ9nWhoRbW7Qh7FtfktvDuoC1
	LVn7QZN+ZcdcbLk8hQVK+1Z0FAcGGVy7mJZ3Eqyr78R3I5P8/DcmUttVuVrZaofpucTAhJDsK8p6N
	rOVQHNAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tes0E-0000000EsPn-0c4a;
	Mon, 03 Feb 2025 08:40:22 +0000
Date: Mon, 3 Feb 2025 00:40:22 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6CA9sDUZ_nDj5LD@infradead.org>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
 <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 07:06:15PM +1030, Qu Wenruo wrote:
> Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
> This will make btrfs to align with EXT4/XFS behavior, without the complex
> AS_STABLE_FLAGS passing (and there is no way for user space to probe that
> flag IIRC).
> 
> But that will break the current per-inode level NODATASUM setting, and will
> cause some incompatibility (a new incompat flag needed, extra handling if no
> data csum found, extra fsck support etc).

I don't think simply removing the checksums when using direct I/O is
a good idea as it unexpectedly reduces the protection envelope.  The
best (or least bad) fix would be to simply not support actually direct
I/O without NODATASUM and fall back to buffered I/O (preferably the new
uncached variant from Jens) unless explicitly overridden.


