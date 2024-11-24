Return-Path: <linux-fsdevel+bounces-35731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6809D7885
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6438B22B29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA0175D48;
	Sun, 24 Nov 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="buyiRUPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAD5103F;
	Sun, 24 Nov 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487096; cv=none; b=Rvl0RrUB5m+DO7ugqd83MG3WLjuOMtL3lIyejilZB3sRR1l+/hDKDPGoxPeDHFGd8oMt59O7rR81bcyR+KSu1HK9fs/POEBJ+Ga/WVxNR6wCSIfGzYbvjXmCIJX0AT2sIUiIVx9mH5yMlcUJQ57MbF0wcUmzxrN1cVxCDyegbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487096; c=relaxed/simple;
	bh=Zi+1DSYjFgZgKpq0CrKo9BUQzWx2wnHkfdlb5yvL+T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBq6VDHwbuVkAACvfKCLYl2ow+Lg5xHhHKsVQtKzKgJ5ZRHSHQiWrmgrgLlt1i5Mob3p3rvGt9i50ClSfGfYnNNcm0URdTO7KjM+YR1hkiA8mK3xKwQyozMKkk6yfPx9eNe7DMHxV8KIZvfPYhf10KeyGCLf3zcnv1U/MOOgEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=buyiRUPi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/TFDoJRszzjGyURV1ueprQ9a3PpbzyyEyj/6sQObMOQ=; b=buyiRUPiMlafdDteVVG6lFF9qI
	Ju7bnYElMpzQUPVxi7o0fCTw3sebC7490JrNzRNQ8NkTZsJNnJSriT76lnxG0ESWpRaP/R9N/5dvS
	guvpScoBTa4+8yUmcO3PzTs762w1UCc5qU3xK5mvtRJLiz5VpWFKyj15GBLl/bY7Jx70L6sysGlwF
	rgIv9l7L4SfzfrdCb81+kBmyXXIH/uNhrvGiHsdBgpeG5HVfq3uQhgX9PJJkVgDuz1lti75V4VECW
	Wf5uXeFItiEd/Qjh1VX0KwQcL96mFtTer5a9Lj1/T5BWuoAz4A9v14cbJPRzPvXsyImCJq7OGup4r
	l0f3IfRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFL2A-00000001Kd8-0Z7g;
	Sun, 24 Nov 2024 22:24:50 +0000
Date: Sun, 24 Nov 2024 22:24:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <20241124222450.GB3387508@ZenIV>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 02:10:30PM -0800, Linus Torvalds wrote:

> I *do* think that we could perhaps extend (and rename) the
> inode->i_size_seqcount to just cover all of the core inode metadata
> stuff.

That would bring ->i_size_seqcount to 64bit architectures and
potentially extend the time it's being held quite a bit even
on 32bit...

> And then - exactly like we already do in practice with
> inode->i_size_seqcount - some places might just choose to ignore it
> anyway.
> 
> But at least using a sequence count shouldn't make things like stat()
> any worse in practice.
>
> That said, I don't think this is a real problem in practice. The race
> window is too small, and the race effects are too insignificant.
> 
> Yes, getting the nanoseconds out of sync with the seconds is a bug,
> but when it effectively never happens, and when it *does* happen it
> likely has no real downsides, I suspect it's also not something we
> should worry over-much about.
> 
> So I mention the "rename and extend i_size_seqcount" as a solution
> that I suspect might be acceptable if somebody has the motivation and
> energy, but honestly I also think "nobody can be bothered" is
> acceptable in practice.

*nod*

