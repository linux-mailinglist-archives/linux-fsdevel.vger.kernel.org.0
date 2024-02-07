Return-Path: <linux-fsdevel+bounces-10635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72084CF9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300DA28E8F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26D823D8;
	Wed,  7 Feb 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj1uLws0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A880C00;
	Wed,  7 Feb 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326162; cv=none; b=ez1GFrLS7eJ72jAW6YDw0kMI2ZDOcu3L6UK6hL8oPg1NEWoNdTjm8PatY5fPioCu9hQPBqvtvFDq9PkjumTuOGLDiv93U1mXtMNnaO4G9junp1xUE6syD3sBLm/laWWLzrlTXf6IeZbm6OBScUrEWpzlw7u8/f50hxZZWKt48jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326162; c=relaxed/simple;
	bh=YEJtTqT8spDDKxLpGC2lvI8xDbQGR7mItvjQxB6zfts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8hGyyO9dtG1jx+VWnBEpaerEYs0rAqFHiGO8R8bvkjumT3HtrFgT0aAY2qAwArRCUoxSAmLG6ipN7K7s1BZ+9jLIx+b6XCE3ibkrlOBf8QjsdMVFQPTTAIVU8Xpk3c7lJyjwZMi2VeegOGqpOV9R4ZG8JaoWRzHKbfW1EYBiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj1uLws0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B482C433F1;
	Wed,  7 Feb 2024 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707326161;
	bh=YEJtTqT8spDDKxLpGC2lvI8xDbQGR7mItvjQxB6zfts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wj1uLws0RC5NTlAAelSW0K6IgDYt7hiw+JS+k6T2vzM6OzXpxw7D1K7pfzQQtgAp7
	 gOyJEAYvfCbaFNXKD476/2IAyYmRyPxZGa/sVTDqQ0w2u6zIIUEbkowN+jaO3GOK+m
	 zzkjXYRuYcmqNnOYgdpDTG1JvU6UvHx0A4x1Da+ZWn2hkj59N3/HjRSzhav6TkICqg
	 qyQP9gMoNJ4V+mHbKLjioF7InzSSQ9yzWcahc3fUHEUflqap4epCiX/jvSMHJG+9G5
	 sD8r3ZJx/EFSPTVRJMW2kjx4SY9x1wN57tgmG6PC/pzyQv2PEHyI1VQymoHyrrI/i1
	 Z5Qyi5Vv5QOsg==
Date: Wed, 7 Feb 2024 09:16:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <20240207171600.GC6226@frogsfrogsfrogs>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>

On Wed, Feb 07, 2024 at 10:54:34AM +0100, Miklos Szeredi wrote:
> [I'm not planning to attend LSF this year, but I thought this topic
> might be of interest to those who will.]
> 
> The errno thing is really ancient and yet quite usable.  But when
> trying to find out where a particular EINVAL is coming from, that's
> often mission impossible.
> 
> Would it make sense to add infrastructure to allow tracing the source
> of errors?  E.g.
> 
> strace --errno-trace ls -l foo
> ...
> statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
> ...
> 
> Don't know about others, but this issue comes up quite often for me.
> 
> I would implement this with macros that record the place where a
> particular error has originated, and some way to query the last one
> (which wouldn't be 100% accurate, but good enough I guess).

Hmmm, weren't Kent and Suren working on code tagging for memory
allocation profiling?  It would be kinda nice to wrap that up in the
error return paths as well.

Granted then we end up with some nasty macro mess like:

[Pretend that there's a struct errno_tag, DEFINE_ALLOC_TAG, and
__alloc_tag_add symbols that looks mostly like struct alloc_tag from [1]
and then (backslashes elided)]

#define Err(x)
({
	int __errno = (x);
	DEFINE_ERRNO_TAG(_errno_tag);

	trace_return_errno(__this_address, __errno)
	__errno_tag_add(&_errno_tag, __errno);
	__errno;
})

	foo = kmalloc(...);
	if (!foo)
		return Err(-ENOMEM);

or

	if (fs_is_messed_up())
		return Err(-EINVAL);

This would get us the ability to ftrace for where errno returns
initiate, as well as collect counters for how often we're actually
doing that in production.  You could even add time_stats too, but
annotating the entire kernel might be a stretch.

--D

[1] https://lwn.net/Articles/906660/

> Thanks,
> Miklos
> 

