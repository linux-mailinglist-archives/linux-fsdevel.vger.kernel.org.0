Return-Path: <linux-fsdevel+bounces-39424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E653AA140A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BEA7A259A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD2231C8E;
	Thu, 16 Jan 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWDASun1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69A153808;
	Thu, 16 Jan 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047966; cv=none; b=NnSmPena1mjvFpfQYN4TiTsww0WYm2We6YUXRF31zIN95X5PlM4B9CQUybOkHWQ/5Tx5KbcSlcXLn0Uoiq5Z1qW98ddNK7oSKKgT07dZxoFWg2prlPBJFA895hAt0EZ3guFd8t7SdPJFrj7Jyimr5E+lIFM7k/OpxVVGln7IPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047966; c=relaxed/simple;
	bh=YIoWdKHGdFmsZJhT/FUx6sQICOoP0aC2w3v4diiifNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAZxYxie7hmBLfH21h2OIfKRhhf594b8YSPLFYP9aifDUcDjujav12+k1KjRp5Sx9w4O78Me4VR18yrreQjjtZzge+LH3yv7WRhiUBS5wN2kAL7Gb2y7C+mFeFozHg88s+SWT1ajPB7QV06f78ahR9ndJuYzyBqvQKgQqE4v/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWDASun1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63B6C4CEE2;
	Thu, 16 Jan 2025 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047966;
	bh=YIoWdKHGdFmsZJhT/FUx6sQICOoP0aC2w3v4diiifNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWDASun1oa3I5A0jonA1qX+rkJH+mPfklPrR3+kUsyVih2hdO2dEMlY05XL8WJF9e
	 +yFUt6VgOCkIvGT75OxuRkEFsRkvMVHnkSgGuaQTt4U3ZtC8t5inP2v8117FJWh3Ho
	 6Cv0xUF0+n8duBz4M37XdjCVS1C9Scuov/yCP7yO2WTUZuncKsYY4BRIE7By5VIcsD
	 sTA0KirRW9AsOS3Ok6IaaBcf5DyuWJ2w6c0sflr3lnoPne6MLVra7dm564sbUd9Ni0
	 F16fKJYG5VkOS436XrHO3C0KLpIABvqqzbgHIJr7CBKidmXLt/QuPeugLZQl0ohCiB
	 H1S2yWUo0cDaA==
Date: Thu, 16 Jan 2025 17:19:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: register inodes which is able to donate pages
Message-ID: <Z4k_nKT3V1xuhXGc@google.com>
References: <20250115221814.1920703-1-jaegeuk@kernel.org>
 <20250115221814.1920703-2-jaegeuk@kernel.org>
 <Z4imEs-Se-VWcpBG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4imEs-Se-VWcpBG@infradead.org>

On 01/15, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 10:16:51PM +0000, Jaegeuk Kim wrote:
> > This patch introduces an inode list to keep the page cache ranges that users
> > can donate pages together.
> > 
> >  #define F2FS_IOC_DONATE_RANGE		_IOW(F2FS_IOCTL_MAGIC, 27,	\
> > 						struct f2fs_donate_range)
> >  struct f2fs_donate_range {
> > 	__u64 start;
> > 	__u64 len;
> >  };
> 
> > e.g., ioctl(F2FS_IOC_DONATE_RANGE, &range);
> 
> This is not a very good description.  "donate" here seems to basically
> mean a invalidate_inode_pages2_range.  Which is a strange use of the
> word.  what are the use cases?  Why is this queued up to a thread and
> not done inline?  Why is this in f2fs and not in common code.

The idea is let apps register some file ranges for page donation and admin
recliam such pages all togehter if they expect to see memory pressure soon.
We can rely on LRU, but this is more user-given trigger. I'm not sure whether
there's a need in general, hence, wanted to put it in f2fs first to get more
concrete use-cases beyond this Android case.

> 
> I also which file systems wouldn't just add random fs specific ioctls
> all the time without any kinds of discussion of the API.  f2fs is by
> far the worst offender there, but not the only one.

