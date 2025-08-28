Return-Path: <linux-fsdevel+bounces-59458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2AB39031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4246E7A25F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F618BC0C;
	Thu, 28 Aug 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1T0sm8nQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80847B665
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341664; cv=none; b=BXOjGpeGlqlY4QRbkSeXKa7+7D87qZq9tTUKyOP/tA3D02DZWxWcdZyAjN3hE5RDvK9ncqh0rVuG9bMNdkoDBlpDWUYWAgefHzwhIyzPacOJB8p/6Yi7CmNJ1SAD+kKFaeSBQBrQQqNNvmbmQkWg+12j3M4ZJrezj25RFuNaNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341664; c=relaxed/simple;
	bh=eWXonzKXuT2hlgSD0TVa0VxyioPuSYWJ7kRmBIkZLJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeUQRxyinGdnIbIWdx0yB3nPSzWqhSUwbLakvXKJdlmBVOzo/n/We/f5Cz+nqVFnQMyXMlKVp02PFtq1p2RGFzR97QWEDg17pOV5e8ZtMs1m7fVAyKFEP/rEIY8eLjszpmdhhkjV4laIlBWry+GeSjBq8jwYXVNV18Q4ECaavDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1T0sm8nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21CFC4CEEB;
	Thu, 28 Aug 2025 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756341664;
	bh=eWXonzKXuT2hlgSD0TVa0VxyioPuSYWJ7kRmBIkZLJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1T0sm8nQ/Ho/dkCfFA3B7he916Mfj+rseOEKA42ScOCxlUE69eQneO9DvfDpAVxbn
	 4XfNOniwEscJ8+l8WjA9JPOK1OK2YQBEgxq0s5Y7xnqcG7ozYX9AnD4lvwo5OGrOGv
	 FC0NqbPl4Xj/lQUNi8Hmvs141HczVTeEYXujEN9A=
Date: Wed, 27 Aug 2025 20:41:02 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250827-sandy-dog-of-perspective-54c2ce@lemur>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur>
 <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>

On Wed, Aug 27, 2025 at 04:40:58PM -0700, Linus Torvalds wrote:
> On Wed, 27 Aug 2025 at 15:49, Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > I have recommended that Link: trailers indicating the provenance of the series
> > should use a dedicated domain name: patch.msgid.link. This should clearly
> > indicate to you that following this link will take you to the original
> > submission, not to any other discussion.
> 
> That doesn't fix anything. It only reinforces the basic stupidity of
> marking the WRONG DIRECTION.
> 
> The fact is, YOU CANNOT SANELY MARK THE COMMIT. Dammit, why do people
> ignore this *fundamental* issue? You literally cannot add information
> to the commit that doesn't exist yet, and the threads that refer to
> bugs etc quite fundamentally WILL NOT EXIST YET when the commit is
> posted.

I'm not sure what you mean. The Link: trailer is added when the maintainer
pulls in the series into their tree. It's not put there by the submitter. The
maintainer marks a reliable mapping of "this commit came from this thread" and
we the use this info for multiple purposes:

1. letting the submitter know when their series is accepted into the
   maintainer's tree
2. marking the series as "mainlined" when we find that commit in your tree
3. it reliably marks provenance for tools like cregit, which largely have to
   guess this info

It serves a real purpose.

> It's the *message* that should be indexed and marked, not the commit.

We cannot *reliably* map commits to patches. A commit can be represented as
any number of patches, all resulting in different patch-id's -- it can be
generated with a different number of context lines, with a different patch
algorithm, it could have been rebased, etc. Maintainers do edit patches they
receive, including the subject lines. I know, because attempting to automate
things without a provenance Link: results in false-positives for projects like
netdev.

> Really. The only valid link is a link to *pre-existing* discussion,
> not to some stupid "this is where I posted this patch", which is
> entirely and utterly immaterial.
> 
> And dammit, lore could do this. Here's one suggested model that at
> least gets the direction of indexing right (I'm not claiming it's the
> only model, or the best model, but it sure as hell beats getting the
> fundamentals completely wrong):
> 
>  (a) messages with patches can be indexed by the patch-id of said patch

They already do, it's been there for a long time now. Here's a random one:
https://lore.kernel.org/lkml/?q=patchid%3A09b124c33929efcffe0ce8df0a805f54d5962f60


> This might well be useful in its own right ("search for this patch"),
> and would be good for the series where the same patch ends up being
> re-posted because the whole series was re-posted.

This is how we are able to pull in trailers sent to previous series, if the
patch-id hasn't changed.

> IOW, just that trivial thing would already allow the lore web
> interface to link to "this patch has been posted before", which is
> useful information on its own, totally aside from any future
> archeology.
> 
> But it's not the end goal, it's only a small step to *get* to the end goal:
> 
>  (b) messages that mention a commit ID (or a subject line) could then
> have referrals to the patch-id of said commit.

To reiterate, a commit is not a patch, so *we cannot reliably arrive from a
commit to always the same patch-id*. We've discovered it the hard way when you
recommended that people send you patches with --histogram and we suddenly
could no longer reliably map commits to patches, because on our end we
generated patches with the default (myers) and they did not match the patches
generated with --histogram, so our automation broke.

This is what I am trying to convey -- commits don't reliably map to patches,
because the same commit can generate any number of perfectly valid patches,
all with different patch-id's.

-K

