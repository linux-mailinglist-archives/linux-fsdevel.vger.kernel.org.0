Return-Path: <linux-fsdevel+bounces-55631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74BB0CE73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 01:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8590B6C15C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C324679F;
	Mon, 21 Jul 2025 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEIMdXl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8B19D082
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142154; cv=none; b=WXxq9ME3GkMD5sFnofM6taO/sMD+2ym39M9Zuun5b/AIgliTjwh0Qwd1/a0cAy1IT3uXa0QsiM/324eUTwcnH1OdxZCsc1mK4YRCYM/T3DOHWXxeVHNnPnbyYOT1mSqrOLNUzpd3JNugjI3X/x/hCEX0PdCDskzLSLRHSQvsRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142154; c=relaxed/simple;
	bh=UANzIvmpZF/jIeiIEaYT5SQ/ASjZi3aiLj9RP2qf1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk1zF44S3YGEioM/WD5V/mqfJkReUJ0qUyUFsv4rYPeG4HiVO5qqKZpgdED6gaFUFkOAKxlGrR835npwHr9loIujmnqpd1F6u9lUflgfHR8bPKTlSfxmUCWsGjxvaDRcb4UXcN0Gim8hjzZxxCXn1CxBQNIougElhs0Qrb28gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEIMdXl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6BC4CEED;
	Mon, 21 Jul 2025 23:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753142154;
	bh=UANzIvmpZF/jIeiIEaYT5SQ/ASjZi3aiLj9RP2qf1Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEIMdXl2bVwqCSyvusG9anYMkKcQoNqTOOnHd6puU2HC6P2oS/qjWxD49XQfhSM1c
	 fI6ZuWEQJbRaeufwbvW1LHYDEq2mL6TG+YTy0i1fYaNwnlBbBO2mKCkQSEaNLcmV78
	 P1zyEul+AzSAS160c61swPElr/QIjOzAeYpxIliwmNeZzjF/ycPqYAuM8TW/dUP6g7
	 FJKpW7U0gOigzr6P6eXX7aidOQ/7v0cO9qPlxcFaBAtWFmnAPdM1tkyak2kPDSUmw0
	 Z/I3SkyJCE6tOEatutrULUy0Nr/2uzno5LxpiNBJZGgQacVPeVbo9TgEU7sHX36zqH
	 DQFOyz0Uoikwg==
Date: Mon, 21 Jul 2025 16:55:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250721235552.GB85006@quark>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250718160414.GC1574@quark>
 <20250721061411.GA28632@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721061411.GA28632@lst.de>

On Mon, Jul 21, 2025 at 08:14:11AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 18, 2025 at 09:04:14AM -0700, Eric Biggers wrote:
> > If done properly, fixing this would be great.  I've tried to minimize
> > the overhead of CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY when those
> > features are not actually being used at runtime.  The struct inode
> > fields are the main case where we still don't do a good job at that.
> 
> Can you take a look if my idea of not allocating the verity data for
> all inodes but just those where verity is enabled and then looking that
> up using a rhashtable makes any sense?
> 

I wrote a prototype that puts the fsverity_info structs in an
rhashtable, keyed by the ownening 'struct inode *'.  It passes the
'verity' group of xfstests on ext4.  However, I'm working on checking
how bad the performance and code size overhead is, and whether my
implementation is actually correct in all cases.  Unfortunately, the
rhashtable API and implementation is kind of a mess, and it seems it's
often not as efficient as it should be.

I suppose an XArray would be the main alternative.  But XArray needs
'unsigned long' indices, and it doesn't work efficiently when they are
pointers.  (And i_ino won't do, since i_ino isn't unique.)

- Eric

