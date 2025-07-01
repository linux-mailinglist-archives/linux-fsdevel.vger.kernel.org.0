Return-Path: <linux-fsdevel+bounces-53413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB772AEEE18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD7F7A6BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679DD23F43C;
	Tue,  1 Jul 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcuH7gjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A1199385;
	Tue,  1 Jul 2025 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349927; cv=none; b=jWjZw2mfWOF/aPkc0vfuGmAQGUqUwnCF5Mxu7hn2T2FsMpNcNixCsPUoZ3A5HB7TjajaruCn4IlDKKVfSnMtD5UwTJHxfa+MOkfhSib6whjLLRVd6o0RdtULkZ5VTHu4QtRR7Hjr6svIZ5oaDgfBfJgfPl1cr9/dXtSZX8NhEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349927; c=relaxed/simple;
	bh=pSCuDFnwDxBhbTppOZDG2M2468hbks5s/BFAGKvZBWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs8AUJBYEfTEEkNX0kAJ3Gq82MLYystD9kRXm91lYC9yONJ2kv9T90QSfQv9L1VSefDM0ZOh+wyQLjjuLD8l6SMh/lqi6W4XLgp97uMDmWkjW0eRWIUJbF7R2qvU2NSGSEF1EhuhTYUPNPMpAcQyYFfgJYqmvFxQb/r/hOv9n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcuH7gjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C0CC4CEEB;
	Tue,  1 Jul 2025 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751349927;
	bh=pSCuDFnwDxBhbTppOZDG2M2468hbks5s/BFAGKvZBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcuH7gjYjH+jreHnn9JAOhwJLLroeoDAMrqcJyVDAxtpqHvIaiIm2F1KhcG6RVzK2
	 ZHLPrJ6VDoHe7hKsBc+6c44SUtM/uLzP43XO6+OkQqgm/oTnyMjsCBPiQBMi41/BFX
	 f5/zaeaRgVVuHBTB0WVo2OLywVt4oGEJjmnoWvLkJdyIjmIt6FhtzfLQ/JskpNsMAW
	 TCFr63X6M7EdCbaLhcUoaK0oVO7ICe7Qj1qtiqV3EmuWevWRzrb9g0b8ji5UICLhi5
	 PDwJE32iFuizPQRu89tHuPhIj7DNPL+etUeu/ySsj/hq1hzZaXVVh7NHt+IPM0f/jK
	 9iKXfetFK1xnw==
Date: Mon, 30 Jun 2025 23:05:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC[RAP] V2] fuse: use fs-iomap for better performance so we
 can containerize ext4
Message-ID: <20250701060526.GH9987@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250613173710.GL6138@frogsfrogsfrogs>
 <CAJfpegui8-_J3o1QKOxGqMKOSt5O6Xw979YnnmwTF3P0yh_j+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegui8-_J3o1QKOxGqMKOSt5O6Xw979YnnmwTF3P0yh_j+Q@mail.gmail.com>

On Mon, Jun 23, 2025 at 03:16:53PM +0200, Miklos Szeredi wrote:
> On Fri, 13 Jun 2025 at 19:37, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Top of that list is timestamps and file attributes, because fuse no
> > longer calls the fuse server for file writes.  As a result, the kernel
> > inode always has the most uptodate versions of the some file attributes
> > (i_size, timestamps, mode) and just want to send FUSE_SETATTR whenever
> > the dirty inode gets flushed.
> 
> This is already the case for cached writes, no new code should be needed.

Are you talking about the fc->writeback_cache stuff?  Yeah, that mostly
works out for fuse2fs.  Though I was wondering, when does atime get
updated?  fs/fuse sets S_NOATIME, so I guess it's up to the fuse server
to update it when it wants to, and a later FUSE_GETATTR can pick it up?
If so, how do fuse servers implement lazytime/relatime?

--D

> Thanks,
> Miklos
> 

