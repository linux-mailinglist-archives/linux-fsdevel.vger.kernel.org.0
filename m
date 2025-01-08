Return-Path: <linux-fsdevel+bounces-38681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A42A067ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 23:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86BD3A7075
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63026205AD7;
	Wed,  8 Jan 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBzY9i6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFB205ABB;
	Wed,  8 Jan 2025 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374048; cv=none; b=Ikp6MI5Js/TIiF1YM1Gav/BhJKhRwd3Ikz+EY5XZpifk02r0yYh0exZpLhGFEpja7DKryZ+JaL4Be0KHAGPw5ZzNjbGRmTB5LW+7MljRzT9CqldNHI4RsI/DcBfxkqhpC57/+X3OZ1LGxi0kOtOfnbQqLD7gsjchJacSLgJm6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374048; c=relaxed/simple;
	bh=HZMtphnmGpO98shKkSgLqE5zhCeRjx5Z8omYdITC2Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR8XDZD2Nt74klPAFy5jXFbldGyxk/HZhp6KyP87Gl0JHnNmlgsnPzWf+Zp1N+Aj+0sxk+pXUHMyuID0xZ3RAcoyjVLG/5gvzW/GQQ7WKzHoWE1WiVSkYU38aGKtcvJTdLbu4Ht5ZFfljmKBzxY4/Q1h1us7KvTMsCfzv1GHr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBzY9i6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DB1C4CEE2;
	Wed,  8 Jan 2025 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736374046;
	bh=HZMtphnmGpO98shKkSgLqE5zhCeRjx5Z8omYdITC2Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBzY9i6xZm7Q5qxptV4de0bTHK7HCunPfhrBNUQilnqhL3pZE+uI0vC/9Pb7nI8Ms
	 FS8iAMLQvjEGMcujFh/LA+mxhbxR29d0J1gJqXDXpRffnKNCwE3LBt6jOyxTdF+Yys
	 qMPXKnuDdo+prruBE41e9QgBLCiyzcxHxC8v/A29S5ThSsGfnKb2xG/pZHQDj9MVQI
	 CoC1lwV9dUHE3GN2FJ65TIcr2tyzKf/WC619/o4n6hUvk2je+b6VXXRdZ/1C45Waa/
	 qnsEHu4c/gnLxSthwJ9xKAucthsZXBYgmlO6MOjihIray8iTnJHMz/87HNp2pEhDMy
	 J661iaYTv1q4w==
Date: Wed, 8 Jan 2025 14:07:23 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Jann Horn <jannh@google.com>,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <202501081358.3EF3114D6E@keescook>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
 <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>

On Wed, Jan 08, 2025 at 07:06:13PM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 06, 2025 at 04:44:33PM -0800, Kees Cook wrote:
> > On Mon, Jan 06, 2025 at 10:26:27AM -0800, Jeff Xu wrote:
> > > + Kees because this is related to W^X memfd and security.
> > >
> > > On Fri, Jan 3, 2025 at 7:14 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Fri, Dec 6, 2024 at 7:19 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > > > +             if (is_exec_sealed(seals)) {
> > > > >
> > > > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > > > I've not tested this scenario so don't know if we somehow disallow this in
> > > > > another way but note on write checks we only care about shared mappings.
> > > > >
> > > > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > > > the data into an anon buffer and doing what you want with it, here you
> > > > > could argue the same...
> > > > >
> > > > > So probably we should only care about VM_SHARED?
> > > >
> > > > FWIW I think it doesn't make sense to distinguish between
> > > > shared/private mappings here - in the scenario described in the cover
> > > > letter, it wouldn't matter that much to an attacker whether the
> > > > mapping is shared or private (as long as the VMA contents haven't been
> > > > CoWed already).
> > > +1 on this.
> > > The concept of blocking this for only shared mapping is questionable.
> >
> > Right -- why does sharedness matter? It seems more robust to me to not
> > create a corner case but rather apply the flag/behavior universally?
> >
> 
> I'm struggling to understand what you are protecting against, if I can receive a
> buffer '-not executable-'. But then copy it into another buffer I mapped, and
> execute it?
> 
> I mean am I missing something? It's very possible :)

Jann, how do you see a private mapping being exploited this way? My
mental model of the attack depends on a malicious process tricking a
victim process -- i.e. setting it executable and then gaining exec
control of the victim to point into the buffer. An attack on a private
mapping would require a way to trick the process into making the mapping
executable (which seems a high barrier) first.

> The cost is complexity. And the difference between mappings which are shared and
> those which are private and moreso MAP_PRIVATE of an fd are actually quite a lot
> internally (go look at anon_vma code if you have the great benefit of not yet
> doing so to see the deepest, darkest, 9th circle of complexity hell :>).

Ah, okay, I thought it would be pretty "early" in the VMA logic. i.e.
asking the question "Can I make this executable?" I was expecting to be
common across the VMA regardless of private/shared. I will need to go
read the code more carefully.

Still, it seems nicer to me if the "can this be made executable in the
future" question doesn't matter on sharing, just from a perspective of
least surprise.

-- 
Kees Cook

