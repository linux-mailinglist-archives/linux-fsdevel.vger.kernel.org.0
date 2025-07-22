Return-Path: <linux-fsdevel+bounces-55637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC387B0D162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE757A45F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D128C2BE;
	Tue, 22 Jul 2025 05:49:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166621CC43
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163356; cv=none; b=MfjP0H5ELxUEz+xwMoe/Mvf4WXwKT8pT0qV71dXlvn4puXgfr8y7YajHFnOV/LfKTrlYzmlLfKOt3uaj/gU5M19GH+YR/dZkP6IkhWzStxI4L1g35MhOyIntytAsdGtWwookfifKWhiEvSozQkHk8DaPXoyYZT07TIDJr6WPs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163356; c=relaxed/simple;
	bh=TlFvxEHUaDgoa4uFDHKS5AK21R3eTd5ZTflsouUrQdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLaysRsxhZVKRE1grZTSOLs8w10Eq9HS0VLjSc58zqxSBVyfTy6vV+cJ4uZ8rlqJudblC6hc4uUdilU6OKh9IWqxx79M2SHQdBoHAxiMEM+2AJ8y8K41uSo9V+qTkYj5IWg/5McekBT56GKRFNuvXCAtW3tspxK6tBScOqi7FJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CA2068AA6; Tue, 22 Jul 2025 07:49:08 +0200 (CEST)
Date: Tue, 22 Jul 2025 07:49:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250722054908.GA13599@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <20250718160414.GC1574@quark> <20250721061411.GA28632@lst.de> <20250721235552.GB85006@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721235552.GB85006@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 04:55:52PM -0700, Eric Biggers wrote:
> I wrote a prototype that puts the fsverity_info structs in an
> rhashtable, keyed by the ownening 'struct inode *'.  It passes the
> 'verity' group of xfstests on ext4.  However, I'm working on checking
> how bad the performance and code size overhead is, and whether my
> implementation is actually correct in all cases.  Unfortunately, the
> rhashtable API and implementation is kind of a mess, and it seems it's
> often not as efficient as it should be.

While not exactly the prettiest API I think it isn't too bad if you
stick to the simple parts.  Having spent some time with it I'd be
happy to look over your code.

> I suppose an XArray would be the main alternative.  But XArray needs
> 'unsigned long' indices, and it doesn't work efficiently when they are
> pointers.  (And i_ino won't do, since i_ino isn't unique.)

I'm not sure an xarray is a good fit, as the xarray works best when
the indices are clustered, which they probably won't be here.
But the unsigned long should not be a problem, just hash the inode
pointer instead of i_ino.


