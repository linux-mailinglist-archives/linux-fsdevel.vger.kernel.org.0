Return-Path: <linux-fsdevel+bounces-27237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA2895FAC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C638B22495
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358919B59C;
	Mon, 26 Aug 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IMQNyr/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E919A2B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705045; cv=none; b=Rdf4wUp5tQ0K8UeequoUqiRjkIgtfPPC88SIEXyeby0bsKB+2qTlz/X9yTGE5YOQC5szDnycDhEBGu753RpORTciRR5sxBvLnRpdRAIZoxEavngOgYyH5h9+3HxpO4L9faYVhiy4JeanmBb4yVhw6Gjo7eEjxmLwxSjBSsoa4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705045; c=relaxed/simple;
	bh=IUUOyvn+i1r53b+jZY7VcMPx3kopfnOd23gYj54IHb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcsVfWrFU9f4zL1x75d5qhhX9Kjre0w5Y/Afr9Gty7ieR5jm1obIbux6G+YlPEalGUJSa5atAuGlFOm1INeAm5tGty/8SFynW4YpmXfLtFRMcARq/7e6WIquc3jA3oqxJhHBP2oL0kYedqAxpvreBvbtmDXxchRApfXoYmo7tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IMQNyr/Y; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 16:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724705041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3mziorGpfLu3KYeI2tTjbhb2E9xHhtNxzP0Q319XOE=;
	b=IMQNyr/Yfrw7mrlXHINKQ6+WbnxF7kjT0GNIQ+5K0r/LujubHRZQqydUaRWUhoK+Jf26e1
	0rrJmuHFT6aJE8CQkcs0S6v1p5oH22dsWsxKHOGKS9FsXLFplyLzkJQZ3I4zhI5APvcj6Y
	mJUK0eBicp9TRciIt3lPPqb1WQHjkDo=
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
Message-ID: <ut5zfyvpkigjqev43kttxhxmpgnbkfs4vdqhe4dpxr6wnsx6ct@qmrazzu3fxyx>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <ZszeUAMgGkGNz8H9@tiehlicka>
 <d5zorhk2dmgjjjta2zyqpyaly66ykzsnje4n4j4t5gjxzt57ty@km5j4jktn7fh>
 <ZszlQEqdDl4vt43M@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszlQEqdDl4vt43M@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 10:27:44PM GMT, Michal Hocko wrote:
> On Mon 26-08-24 16:00:56, Kent Overstreet wrote:
> > On Mon, Aug 26, 2024 at 09:58:08PM GMT, Michal Hocko wrote:
> > > On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> > > > On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > 
> > > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > > > 
> > > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > > dangerous to use if the caller doesn't control the full call chain with
> > > > > this flag set. E.g. if any of the function down the chain needed
> > > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > > > cause unexpected failure.
> > > > > 
> > > > > While this is not the case in this particular case using the scoped gfp
> > > > > semantic is not really needed bacause we can easily pus the allocation
> > > > > context down the chain without too much clutter.
> > > > 
> > > > yeah, eesh, nack.
> > > 
> > > Sure, you can NAK this but then deal with the lack of the PF flag by
> > > other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
> > > are going to support at the MM level. 
> > > 
> > > I have done your homework and shown that it is really easy
> > > to use gfp flags directly. The net result is passing gfp flag down to
> > > two functions. Sure part of it is ugglier by having several different
> > > callbacks implementing it but still manageable. Without too much churn.
> > > 
> > > So do whatever you like in the bcache code but do not rely on something
> > > that is unsupported by the MM layer which you have sneaked in without an
> > > agreement.
> > 
> > Michal, you're being damned hostile, while posting code you haven't even
> > tried to compile. Seriously, dude?
> > 
> > How about sticking to the technical issues at hand instead of saying
> > "this is mm, so my way or the highway?". We're all kernel developers
> > here, this is not what we do.
> 
> Kent, we do respect review feedback. You are clearly fine ignoring it
> when you feels like it (eab0af905bfc ("mm: introduce
> PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") is a clear example of it).
> 
> I have already made my arguments (repeatedly) why implicit nowait
> allocation context is tricky and problematic. Your response is that you
> simply "do no buy it" which is a highly technical argument.

No, I explained why GFP_NORECLAIM/PF_MEMALLOC_NORECLAIM can absolutely
apply to a context, not a callsite, and why vmalloc() and kvmalloc()
ignoring gfp flags is a much more serious issue.

If you want to do something useful, figure out what we're going to do
about _that_. If you really don't want PF_MEMALLOC_NORECLAIM to exist,
then see if Linus will let you plumb gfp flags down to pte allocation -
and beware, that's arch code that you'll have to fix.

Reminder: kvmalloc() is a thing, and it's steadily seeing wider use.

Otherwise, PF_MEMALLOC_NORECLAIM needs to stay; and thank you for
bringing this to my attention, because it's made me realize all the
other places in bcachefs that use gfp flags for allocating memory with
btree locks held need to be switch to memalloc_flags_do().

