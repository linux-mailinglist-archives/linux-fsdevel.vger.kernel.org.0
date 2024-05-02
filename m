Return-Path: <linux-fsdevel+bounces-18507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E818D8B9C55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2625DB2098E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7645153513;
	Thu,  2 May 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXQsmmDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655B37147;
	Thu,  2 May 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660411; cv=none; b=uRDkDqPjTx3Yj7YFT1V74Eep6f9pZN8cte+PEzkXYRK3c1w1TTWovf2BpqDvrAMffbtfA25f8sJwz81kYspQkamvxqeKq6x0GRfNWRUfQgHs+LYMUk8MmcMqlqj7YNiWa5z6H2u62ncRYukmIwa+Cv0C8ULHMMnfz5W8aXLmmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660411; c=relaxed/simple;
	bh=xQdO77CyoJxmK3jhS4es9lNj/n0gLTY4Eehz3lTtN3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbS+SqVXPupYixcor0qZ0XnPLfLpSRVHaG3xGh2+ARbhNllZZOY5anN69iaYd4w7JYs3PSaPJUvTs2x05xjVddYKGgfCQdPXLIAk6gy5vI+VMPDALq625toDSC6+N5PbpVp1fw/XbwNFOFAz93RQB0BRRfUP8t0c4VHTIhq9Vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXQsmmDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F7C113CC;
	Thu,  2 May 2024 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660410;
	bh=xQdO77CyoJxmK3jhS4es9lNj/n0gLTY4Eehz3lTtN3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXQsmmDeSTzKE3rGnkHOoM5sZK3O37w1lpH6NDzi+rx6ko9CX6VJF4BunjxFSE3W/
	 IfzOrb/ngK9vNtwXm569S5fDIXmVZUNLuNiyMDeqSSf5HekHGrsIfDpvx4SGVg6hZ9
	 9XTQ8d0xJqlbKhF+pvhfvNHi4nSYRJpPnxU/y9VieHr2zQR76KuA0xTM3pb3Y2Zp6z
	 xZ1uFI6bAezUPi7HfRvc/LvfigmmMLGWdg4dL25E4SkY+eO5Lfw3uB9XSqZY4pLIpB
	 Z7CgkB9gJQeNgRTqrNLiXPwegwrZ5uM8MJMz/76w9cFqTF/3huB+RSpo8DtYyt0+NZ
	 CYfmWkMOs/NeA==
Date: Thu, 2 May 2024 07:33:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-block@vger.kernel.org, Jeremy Bongio <jbongio@google.com>
Subject: Re: [RFC PATCH 1/1] Remove buffered failover for ext4 and block fops
 direct writes.
Message-ID: <20240502143330.GA360891@frogsfrogsfrogs>
References: <20240501231533.3128797-1-bongiojp@gmail.com>
 <20240501231533.3128797-2-bongiojp@gmail.com>
 <ZjMoYkUsQnd33mXm@infradead.org>
 <20240502140139.GE1743554@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502140139.GE1743554@mit.edu>

On Thu, May 02, 2024 at 10:01:39AM -0400, Theodore Ts'o wrote:
> On Wed, May 01, 2024 at 10:45:06PM -0700, Christoph Hellwig wrote:
> > 
> > Please don't combine ext4 and block changes in a single patch.  Please
> > also explain why you want to change things.
> > 
> > AFAIK this is simply the historic behavior of the old direct I/O code
> > that's been around forever.  I think the XFS semantics make a lot more
> > sense, but people might rely on this one way or another.
> 
> I agree that the ext4 and block I/O change should be split into two
> separate patches.
> 
> As for the rest, we discussed this at the weekly ext4 conference call
> last week and at the, I had indicated that this was indeed the
> historical Direct I/O behavior.  Darrick mentioned that XFS is only
> falling back to buffered I/O in one circumstances, which is when there
> is direct I/O to a file which is reflinked, which since the

fsblock unaligned directio writes to a reflinked file, specifically.

> application wouldn't know that this might be the case, falling back to
> buffered I/O was the best of not-so-great alternatives.
> 
> It might be a good idea if we could agree on a unfied set of standard
> semantics for Direct I/O, including what should happen if there is an
> I/O error in the middle of a DIO request; should the kernel return a
> short write?

Given the attitude of "if you use directio you're supposed to know what
you're doing", I think it's fine to return a short write.

>               Should it silently fallback to buffered I/O?  Given that
> XFS has had a fairly strict "never fall back to buffered" practice,
> and there haven't been users screaming bloody murder, perhaps it is
> time that we can leave the old historical Direct I/O semantics behind,
> and we should just be more strict.

The other thing I've heard, mostly from willy is that directio could be
done through the pagecache when it is already caching the data.  I've
also heard about other operating systems <cough> where the mode could
bleed through to other fds (er...).

> Ext4 can make a decision about what to do on its own, but if we want
> to unify behavior across all file systems and all of the direct I/O
> implications in the kernels, then this is a discussion that would need
> to take place on linux-fsdevel, linux-block, and/or LSF/MM.
> 
> With that context, what are folks' thiking about the proposal that we
> unify Linux's Direct I/O semantics?  I think it would be good if it
> was (a) clearly documented, and (b) not be surprising for userspace
> application which they switch beteween file systems, or between a file
> system and a raw block device.  (Which for certain enterprise
> database, is mostly only use for benchmarketing, on the back cover of
> Business Week, but sometimes there might be users who decide to
> squeeze that last 1% of performance by going to a raw block device,
> and it might be nice if they see the same behaviour when they make
> that change.)

Possibly a good idea but how much of LSFMM do we want to spend
relitigating old {,non-}decisions? ;)

--D

> Cheers,
> 
> 					- Ted
> 

