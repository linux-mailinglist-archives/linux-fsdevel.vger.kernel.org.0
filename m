Return-Path: <linux-fsdevel+bounces-13450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16508701CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991BD286891
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C713D3B4;
	Mon,  4 Mar 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVj0626x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783301D53F;
	Mon,  4 Mar 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556473; cv=none; b=LUZkiTibTgtQ31ShzGJCPoPpkkTkf6mVCIBxlB5iqbmjCIHyXaKQq+mai2NmwCPt78I6Qje0gFHBZILXmSZyL0M/Ng3Vkmq78E4bfh8uUuzFSqAYR88V87Cry9hkgcTueCxXjrcxnP7kw2yPOPyxmt9hcTbkTw99Dw7Gkhs7ZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556473; c=relaxed/simple;
	bh=jLz5ELcfTObaRFcBiCY6jXqzV+/2ipsEzVEnweNaefw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkAxw353/ZNWQeKpoRy3EZu84Q8lrhc4uuPBn0EqRiJxnnW5UDtC9cA81O+W1ASATxdRF3sEnh87AiYuenEJ9if+zHUkc/mVWWsyH688x3lziNdQa/DkSsNxu3tCcDY7Qkj74jt/aT3IRD63j4dDTvLsvOiGCPaTMlhYLkJ0RlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVj0626x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93EC433C7;
	Mon,  4 Mar 2024 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709556473;
	bh=jLz5ELcfTObaRFcBiCY6jXqzV+/2ipsEzVEnweNaefw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVj0626xPWKm6oCku+qVbL1lqwYTouqrHQCaH3UFjNpYcgerz8YrBQAxVLMUMDzVu
	 5A3CY7dLUz10f/4pLRxilXh7LkoOU5E2AhJfEuDr5r0NsZ2QULjgK/AEX/4cVXO15z
	 N/4d3xLgdzIl3Oo5SDDPOMTzc1uRRm7QmCHgibWDu2Wf+49YC0k9fSXY9b/VuLgIO4
	 LKshwUAICdZjbWyf0jSR2lECh+l3LDWx2FvJrYzJI+ObQIdmxJobd6UUaVCRr5uPjO
	 kfCzAaA7gtshaoPK6wL6Kviuof0JMnw+vaX3Tc7QJ4gco6EsYOO0hhOUVlJsSyOvMN
	 RjXYJoVDPbZMg==
Date: Mon, 4 Mar 2024 13:47:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in
 path_openat()
Message-ID: <20240304-pendant-implantat-4e19caa87151@brauner>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
 <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>

On Fri, Mar 01, 2024 at 09:51:18AM -0800, Linus Torvalds wrote:
> On Fri, 1 Mar 2024 at 09:07, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > This is just an example of using the kmem_cache_charge() API.  I think
> > it's placed in a place that's applicable for Linus's example [1]
> > although he mentions do_dentry_open() - I have followed from strace()
> > showing openat(2) to path_openat() doing the alloc_empty_file().
> 
> Thanks. This is not the right patch,  but yes, patches 1-3 look very nice to me.
> 
> > The idea is that filp_cachep stops being SLAB_ACCOUNT. Allocations that
> > want to be accounted immediately can use GFP_KERNEL_ACCOUNT. I did that
> > in alloc_empty_file_noaccount() (despite the contradictory name but the
> > noaccount refers to something else, right?) as IIUC it's about
> > kernel-internal opens.
> 
> Yeah, the "noaccount" function is about not accounting it towards nr_files.
> That said, I don't think it necessarily needs to do the memory
> accounting either - it's literally for cases where we're never going
> to install the file descriptor in any user space.

Exactly.

> Your change to use GFP_KERNEL_ACCOUNT isn't exactly wrong, but I don't
> think it's really the right thing either, because
> 
> > Why is this unfinished:
> >
> > - there are other callers of alloc_empty_file() which I didn't adjust so
> >   they simply became memcg-unaccounted. I haven't investigated for which
> >   ones it would make also sense to separate the allocation and accounting.
> >   Maybe alloc_empty_file() would need to get a parameter to control
> >   this.
> 
> Right. I think the natural and logical way to deal with this is to
> just say "we account when we add the file to the fdtable".
> IOW, just have fd_install() do it. That's the really natural point,
> and also makes it very logical why alloc_empty_file_noaccount()
> wouldn't need to do the GFP_KERNEL_ACCOUNT.
> 
> > - I don't know how to properly unwind the accounting failure case. It
> >   seems like a new case because when we succeed the open, there's no
> >   further error path at least in path_openat().
> 
> Yeah, let me think about this part. Becasue fd_install() is the right
> point, but that too does not really allow for error handling.
> 
> Yes, we could close things and fail it, but it really is much too late
> at this point.

It would also mean massaging 100+ callsites. And having a non-subsystems
specific failure step between file allocation, fd reservation and
fd_install() would be awkward and an invitation for bugs.

> What I *think* I'd want for this case is
> 
>  (a) allow the accounting to go over by a bit
> 
>  (b) make sure there's a cheap way to ask (before) about "did we go
> over the limit"
> 
> IOW, the accounting never needed to be byte-accurate to begin with,
> and making it fail (cheaply and early) on the next file allocation is
> fine.

I think that's a good idea.

