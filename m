Return-Path: <linux-fsdevel+bounces-50099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACCAC8237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1534A4D96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B5231839;
	Thu, 29 May 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k6NvDVF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DCA1CCEE7;
	Thu, 29 May 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543742; cv=none; b=LzMW1WBqOESpVbn4irFPygwQyYqwifVZbNiuv6w2vNAuKYxhHVCfDvQN5LZYlkdZp0AeJtDlehSzUZj3ohvHQVkLkQhU3JptLOcVEx+IAkmM57Cj7kvPuKeXei4GFizPSjv9SbPhG+LR7t4aBcj7OJq1fet5wLE8Q6wipsc/KLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543742; c=relaxed/simple;
	bh=C+Jg0weYl2tByktIHBL+AJi0hz1ZzqOHcQvpRIR+H1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGQxWRIF7Ts5i3IjPf4w9ELKlrGJjt4z+IQ83MtaKkpXTZpLa+JgfuJ3546ItuA33sN7R+YokLrBujtJQ2nA57/4PXzIVpm/yXEn20aKz2f+5R4cc6dwJVGwkW2Fvs2IDnaTsH1CRysoxykqa6ZM/ZaTpJKG0MM/1g2VWHrtaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k6NvDVF4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=xq9+5mC/OVjdGyLNbBQXbWxFGsNzAFyEwcHrpcKhla8=; b=k6NvDVF4GZRHQTpAtTp2FrPv+Z
	HOU3WoE66ZPSCCh/ni/cJSObNhutQVIGSoGs8reGpJmbing/2zvM2XJW5VbddDjIbYHRyfLff86J+
	UKvbjPPS7Fof1ueb8CJYxpdQIYGkjDhfrrBPfy4ovljD5RmewfFtG5KrSltoI9gQfO5pcgKqzFBq9
	4TNtjEmotDpBXhftZV6ntZnXQmUcS1u5AAJHQ7wF6CFjbgYgvm6hgAdWxVfaQh+uUcsV9t0ahxhet
	wzYu0bqyHyu64MoXJJoPholU0wM0fdvZHzvSLUA4GvFT2MaCzY4EjYDu1mh1YsenADsmx5KYijdp8
	NYyg1QRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKi6K-00000002KY6-37zU;
	Thu, 29 May 2025 18:35:36 +0000
Date: Thu, 29 May 2025 19:35:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
	mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250529183536.GL2023217@ZenIV>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> On Thu, May 29, 2025 at 10:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> >
> > > Current version of path iterator only supports walking towards the root,
> > > with helper path_parent. But the path iterator API can be extended
> > > to cover other use cases.
> >
> > Clarify the last part, please - call me paranoid, but that sounds like
> > a beginning of something that really should be discussed upfront.
> 
> We don't have any plan with future use cases yet. The only example
> I mentioned in the original version of the commit log is "walk the
> mount tree". IOW, it is similar to the current iterator, but skips non
> mount point iterations.
> 
> Since we call it "path iterator", it might make sense to add ways to
> iterate the VFS tree in different patterns. For example, we may
> have an iterator that iterates all files within a directory. Again, we
> don't see urgent use cases other than the current "walk to root"
> iterator.

What kinds of locking environments can that end up used in?

The reason why I'm getting more and more unhappy with this thing is
that it sounds like a massive headache for any correctness analysis in
VFS work.

Going straight to the root starting at a point you already have pinned
is relatively mild - you can't do path_put() in any blocking contexts,
obviously, and you'd better be careful with what you are doing on
mountpoint traversal (e.g. combined with "now let's open that directory
and read it" it's an instant "hell, no" - you could easily bypass MNT_LOCKED
restrictions that way), but if there's a threat of that getting augmented
with other things (iterating through all files in directory would be
a very different beast from the locking POV, if nothing else)... ouch.

Basically, you are creating a spot we will need to watch very carefully
from now on.  And the rationale appears to include "so that we could
expose that to random out-of-tree code that decided to call itself LSM",
so pardon me for being rather suspicious about the details.

PS: one general observation: "some LSM does it" does not imply even
"what that LSM is doing is sane and safe", let along "what that LSM is
doing doesn't happen to avoid breakage only by accident".

