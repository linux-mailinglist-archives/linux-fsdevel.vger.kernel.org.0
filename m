Return-Path: <linux-fsdevel+bounces-71493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4CDCC5164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 21:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A40303D9D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D372F362D;
	Tue, 16 Dec 2025 20:21:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846825785D;
	Tue, 16 Dec 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916514; cv=none; b=jEhiY7Hyt6YTD+2+MBvGwl5B5ft9BAPhZvFYZReZhz7H9QmFPQj5mLZpB1VQ+uj7MSAOgIpaCoIcEUhxcs2+UyDhruFf/7zAiudHzJlGdzdBChkTvMiC6f60QhtW1h+O+eYM0jzbC1LrqabJ+LwxWlb/t1BP2BVxUhRMmtFouiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916514; c=relaxed/simple;
	bh=V+sqxc4eSqAYey4UO6s5kAiOWowGucEpTnh9hWJQ6f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo3peOLiuqXKCZuAZtSKdDDl9DdjRNFBAT1KuC1CRLs/4Gn0m1oNPRoRyPEriRpZ9i0iVHxTW8bKZh3ehyARCaOuJsEcgZAPj5ox4q0SDfdP9ZVvXGaemfdtPGANxFY1/O2Mde6XXrA6DdetI7lSI8tBUm+NuT5QEXYNlah99cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (178-062-210-188.ip-addr.inexio.net [188.210.62.178])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id A94AAE0280;
	Tue, 16 Dec 2025 21:12:47 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 16 Dec 2025 21:12:46 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Subject: Re: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
Message-ID: <b3ygfin4h2v64fs2cup2fu5pux7skm7nby7nhostqo7ejgbw2r@zvr6yre5vr57>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-7-luis@igalia.com>
 <CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
 <874ipqcq5q.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ipqcq5q.fsf@wotan.olymp>

On Tue, Dec 16, 2025 at 05:06:25PM +0000, Luis Henriques wrote:
> On Tue, Dec 16 2025, Miklos Szeredi wrote:
...
> >
> > I think it should be either
> >
> >   - encode nodeid + generation (backward compatibility),
> >
> >   - or encode file handle for servers that support it
> >
> > but not both.
> 
> OK, in fact v1 was trying to do something like that, by defining the
> handle with this:
> 
> struct fuse_inode_handle {
> 	u32 type;
> 	union {
> 		struct {
> 			u64 nodeid;
> 			u32 generation;
> 		};
> 		struct fuse_file_handle fh;
> 	};
> };
> 
> (The 'type' is likely to be useless, as we know if the server supports fh
> or not.)
> 
> > Which means that fuse_iget() must be able to search the cache based on
> > the handle as well, but that should not be too difficult to implement
> > (need to hash the file handle).
> 
> Right, I didn't got that far in v1.  I'll see what I can come up to.
> Doing memcmp()s would definitely be too expensive, so using hashes is the
> only way I guess.
> 
Please excuse my ignorance, but why would memcmp() be too expensive for a proof of concept?
Inode handles are limited and the cache is somewhat limited.

Cheers,
Horst

