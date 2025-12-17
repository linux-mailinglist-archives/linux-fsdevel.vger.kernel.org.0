Return-Path: <linux-fsdevel+bounces-71579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81ACC93A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 19:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C094E303A830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE02C0275;
	Wed, 17 Dec 2025 18:11:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB81C84DC;
	Wed, 17 Dec 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995112; cv=none; b=hIJDEMdHp6kLU+RSTEYQXsfByjKgS9xkV6M9VqH76zFJugCzRlhfW24MaW3wiiyixNRwjjuIZAUfUqPAEyndA3xufhGbDwIQSQLigv4TCCS7SOCOzbXiuPhY1PEicF3b6SqVpMtGybvsIP1FgvGTzoVSy1XUH/tzCVmoQjXuR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995112; c=relaxed/simple;
	bh=vm8a1janoB7WpLFUOWh7yvdb8qIWYCjfTEHzve5El9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwB/UE3kKWCrnY5FhmSrqX7EZ81DpLfdrcCv4ZIbWGCg+qCeDYxzOPxfdh1zNB+Bjn8d7eAsZIRCzuLXelu75IA+aZ2vTJGqkJKxBws13gOTlmA2Et/09O4pk7r6KZ0Q1JiTeJeRCYdPqjkyjvtj+HG9B3jVGtPqnzS8LGflfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (178-062-210-188.ip-addr.inexio.net [188.210.62.178])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id A55ACE04FE;
	Wed, 17 Dec 2025 19:02:55 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 17 Dec 2025 19:02:54 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
Message-ID: <zm53hropvk565xfkjpfy4v2pvgj56pvg37ajm5s4zptjdegdqv@xdbxobdwkimd>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-7-luis@igalia.com>
 <CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
 <874ipqcq5q.fsf@wotan.olymp>
 <b3ygfin4h2v64fs2cup2fu5pux7skm7nby7nhostqo7ejgbw2r@zvr6yre5vr57>
 <87jyyloxbw.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyyloxbw.fsf@wotan.olymp>

On Wed, Dec 17, 2025 at 05:02:59PM +0000, Luis Henriques wrote:
> On Tue, Dec 16 2025, Horst Birthelmer wrote:
> 
> > On Tue, Dec 16, 2025 at 05:06:25PM +0000, Luis Henriques wrote:
> >> On Tue, Dec 16 2025, Miklos Szeredi wrote:
> > ...
> >> >
> >> > I think it should be either
> >> >
> >> >   - encode nodeid + generation (backward compatibility),
> >> >
> >> >   - or encode file handle for servers that support it
> >> >
> >> > but not both.
> >> 
> >> OK, in fact v1 was trying to do something like that, by defining the
> >> handle with this:
> >> 
> >> struct fuse_inode_handle {
> >> 	u32 type;
> >> 	union {
> >> 		struct {
> >> 			u64 nodeid;
> >> 			u32 generation;
> >> 		};
> >> 		struct fuse_file_handle fh;
> >> 	};
> >> };
> >> 
> >> (The 'type' is likely to be useless, as we know if the server supports fh
> >> or not.)
> >> 
> >> > Which means that fuse_iget() must be able to search the cache based on
> >> > the handle as well, but that should not be too difficult to implement
> >> > (need to hash the file handle).
> >> 
> >> Right, I didn't got that far in v1.  I'll see what I can come up to.
> >> Doing memcmp()s would definitely be too expensive, so using hashes is the
> >> only way I guess.
> >> 
> > Please excuse my ignorance, but why would memcmp() be too expensive for a proof of concept?
> > Inode handles are limited and the cache is somewhat limited.
> 
> (Oops, looks like I missed your email.)

Don't worry about it.

> So, if every time we're looking for a file handle we need to memcmp() it
> with all the handles until we find it (or not!), that would easily be very
> expensive if we have a lot of handles cached.  That's what I meant in my
> reply, comparing this with an hash-based lookup.

I get all that. My point was more of a suggestion to not worry too much about
that comparison, since the data size is really limited.
If you know and/or have figured out all the rest, you can think about what exactly
to hash if necessary.

BTW, I really liked your approach, that's why I said that. 
It was more of a general comment than a technical one.

> 
> (Not sure I answered your question, as I may have also misunderstood
> Miklos suggestions.  It happens quite often!  Just read my replies in this
> patchset :-) )
I have read the replies ;-)

Cheers,
Horst

