Return-Path: <linux-fsdevel+bounces-27240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B195FB46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0295E2818E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB119A288;
	Mon, 26 Aug 2024 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B4x3oswD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97613CA95
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706638; cv=none; b=dSYUNybIlBqkJfMTdq+nYsm580dj5FixKHuELkQfCubI0XkkQrWTvn1Q1s587frkHtfEVUGcP1pGrOzN2sN2/VFRgRuNznqGl448zoCLSUawAoZCkuVrqM6jVtWmr4gSQYO+YiAWt4otMd0CLcIso6eTYnfZYHQJhDBhA264/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706638; c=relaxed/simple;
	bh=/YtAljW6FyyCqwibkLo/DqUDbvDheWGWuWNA6OLT48c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITjbiCBY16uTHHjh9IN6uq92UYfwTIAcEuhJCKMoBJqa9VUxoxD3a9vEqzTzB9aaPdy80rvkctwZLVXSb7yud0IRwVMMq8TeQK83XsHdOipU3GdwpQb57GikvGg5a9Z5DFyoa0nZOYhsy7E2xUSChdXRllCRo/gMXJstKqo8BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B4x3oswD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 17:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724706635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaC8aYnnshYDuXB3xkqDStpn4QcjqPwT2qzAlFZm4bw=;
	b=B4x3oswDfTQKT5G32KZlZvBiJs4+mierzENSMOLxZqtGz0ZXwgY7VcpSr8oJ8+4GIfGY0I
	zzu5vsDPI7Q6k46Dg5g4e4evPMhvcTMFBUTOmJLNS7cGeefTjJSh9dXrWB0qlWlNwPG0or
	Mh9AbSxrs2fzaatiW0LPKlxSx+sYluM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <jf6dh7icf4vt4dgt4o2h6xvvdlyjewa5wmtn6brumh2tqzlrts@lb7xxthxh7uc>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
 <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 04:44:01PM GMT, Kent Overstreet wrote:
> No, I explained why GFP_NORECLAIM/PF_MEMALLOC_NORECLAIM can absolutely
> apply to a context, not a callsite, and why vmalloc() and kvmalloc()
> ignoring gfp flags is a much more serious issue.
> 
> If you want to do something useful, figure out what we're going to do
> about _that_. If you really don't want PF_MEMALLOC_NORECLAIM to exist,
> then see if Linus will let you plumb gfp flags down to pte allocation -
> and beware, that's arch code that you'll have to fix.
> 
> Reminder: kvmalloc() is a thing, and it's steadily seeing wider use.
> 
> Otherwise, PF_MEMALLOC_NORECLAIM needs to stay; and thank you for
> bringing this to my attention, because it's made me realize all the
> other places in bcachefs that use gfp flags for allocating memory with
> btree locks held need to be switch to memalloc_flags_do().

Additionally: plumbing gfp flags to pte allocation is something we do
need to do. I proposed it before kvmalloc() was a thing, but now it's
become much more of a lurking landmine.

Even with that I'd still be against this series, though. GFP_NOFAIL
interacting badly with other gfp/memalloc flags is going to continue to
be an issue, and I think the only answer to that is stricter runtime
checks (which, thank you mm guys for adding recently).

