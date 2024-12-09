Return-Path: <linux-fsdevel+bounces-36862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD189E9FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45B2165544
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC5199230;
	Mon,  9 Dec 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kIdPsrFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1E1552E4;
	Mon,  9 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774202; cv=none; b=VzlTXmrXBFQfBtFI3kCeV50by2rQJ76k9LS0pSAfcQFU1/hJRn+Sj+25/uLwrTuMvAy06yHTptxoAjtO8Ta37AZht9ttboX66pl/A/gH75ks2MsE9fNGK+DCKh9Z3qfX/tkkhz2dSS/0MFguR65t9MMCQa11nhfjqPEoE4O1hQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774202; c=relaxed/simple;
	bh=R8oT5/RBe/wGe4d9aepKKZEr60n62HCsVtBcYcwxP0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCZ4vpzQ8k8WmN1UwuhcZ2YDuIyoNUM5nujdxUY3tDFyS4nUQUVw5OJ55kyTINDYpA5k1dn5axQv/Cc1TCzoUaEOtRk3a5w4lq5YwcMgsTG27oLm66MHxu2y18Vw6ALH6wgKp41E9UiIeSU03xkItBXqhWDEkPcwqEC0sm8p42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kIdPsrFi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZjvZs7dj406mh7omju5X70Eo3QS2/S2c66o2uscyJnY=; b=kIdPsrFis90oAW2SlPZ501BneH
	Ld3rTq3hD0odXCj2pybEUpzglwySkK03D3WyDrYzPFTd8ZcvVXLExTC9I8Ll/7Z8/QzbFuxZcUmbE
	NcQaJIoDZzUpRGsDLOIDiUnM7BKPU/S8pM3dNJR8W2222Bg64DRSEvRIZKHDaB+/gj7OmBkn5Q46N
	5eBSuHhVrbBeHIjai2SyUoyyK764LiN+l9N/FAz/PxfLhS+D1sXonIHWvwBgK2mKueZ/GpNVMRPM5
	6iDFpivoVsOLoGoaUMdrcOtDvGfNi0Y3BlaloojqrVuXHCUfAlaidBp/+Vk00xzJ0OsYp72dEnMag
	223jAlJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKjrx-00000006esg-33oV;
	Mon, 09 Dec 2024 19:56:37 +0000
Date: Mon, 9 Dec 2024 19:56:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs: sort out a stale comment about races between fd
 alloc and dup2
Message-ID: <20241209195637.GY3387508@ZenIV>
References: <20241205154743.1586584-1-mjguzik@gmail.com>
 <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 06, 2024 at 01:13:47PM +0100, Christian Brauner wrote:
> On Thu, 05 Dec 2024 16:47:43 +0100, Mateusz Guzik wrote:
> > It claims the issue is only relevant for shared descriptor tables which
> > is of no concern for POSIX (but then is POSIX of concern to anyone
> > today?), which I presume predates standarized threading.
> > 
> > The comment also mentions the following systems:
> > - OpenBSD installing a larval file -- this remains accurate
> > - FreeBSD returning EBADF -- not accurate, the system uses the same
> >   idea as OpenBSD
> > - NetBSD "deadlocks in amusing ways" -- their solution looks
> >   Solaris-inspired (not a compliment) and I would not be particularly
> >   surprised if it indeed deadlocked, in amusing ways or otherwise

FWIW, the note about OpenBSD approach is potentially still interesting,
but probably not in that place...

These days "not an embryo" indicator would probably map to FMODE_OPENED,
so fget side would be fairly easy (especially if we invert that bit -
then the same logics we have for "don't accept FMODE_PATH" would apply
verbatim).

IIRC, the last time I looked into it the main obstacle to untangle had
boiled down to "how do we guarantee that do_dentry_open() failing with
-ESTALE will leave struct file in pristine state" and _that_ got boggled
down in S&M shite - ->file_open() is not idempotent and has no reverse
operation - ->file_free_security() takes care of everything.

If that gets solved, we could lift alloc_empty_file() out of path_openat()
into do_filp_open()/do_file_open_root() - it would require a non-trivial
amount of massage, but a couple of years ago that appeared to have been
plausible; would need to recheck that...  It would reduce the amount of
free/reallocate cycles for struct file in those, which might make it
worthwhile on its own.

Lifting it further would require some massage in the callers, but that
would be on per-caller basis; used to look plausible...

Hell knows - right now I'm ears-deep in ->d_revalidate() crap, but once
that settles down a bit...  Might be worth looking into that again.

LSM ->file_open() behaviour changes would need to be discussed with LSM
crowd, obviously.  Ideally we want it idempotent, so that calling it
twice in a row would have the second call work in the same way as if
the first one hadn't happened.  In-tree instances seem to be trivial
to massage to that (in the worst case you'd need to clear some fields
if the first call hadn't taken a fast path out, but the second one
had), but that really needs a buy-in from maintainers.

