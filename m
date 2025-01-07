Return-Path: <linux-fsdevel+bounces-38505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F4A03426
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 01:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C841883466
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EE4879B;
	Tue,  7 Jan 2025 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6WHCaS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB835948;
	Tue,  7 Jan 2025 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210676; cv=none; b=K8IvtLWqQtUkkSq8H9b6Do9mKNdZh4voUFBzC+zQ1j54GG0ig8dj84DxnpIjURzdvUbVkFgrKYQKGMNBGUUygpRjcKX2FOFkFoMpDkZ6dxe0L3wEA9htpYsfq/7ltcTotNm8DOXV4WqGpaEkTrI2o9ffwSDqTynL4jy0nZi4T00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210676; c=relaxed/simple;
	bh=YC/DkJPAKUsdCiz/RgqX7UN7pkyqCECAQ40nKvx3KEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkPxXsAn4Tg0/Y/jJvqxpdaunVBvMRh9+grAaRJz0P8pm7UpFuUihrhuEwfeYtBBvEc5Q2/71QIjpN/K5kHRC+eIC822UJ4vZU8FNM+wA5K39GE8pdOcow1QdQwpVG+d4wl/f1mXUZs4OGdbkiI0LeXY8q+9wq632lMWzzv4eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6WHCaS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F6FC4CED2;
	Tue,  7 Jan 2025 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736210676;
	bh=YC/DkJPAKUsdCiz/RgqX7UN7pkyqCECAQ40nKvx3KEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6WHCaS2HDXddQkTK6KnTPymgGQKyYA+Mi+z3SMY7ENDvJW1BuVxa/vxkMSSHKyTO
	 //8e4bMU8a8bf6sxg/gXNhgJH1ksYYGTPlNArpc+jk2jm60ZbIjb2UaDWPb9yzGIwI
	 9yhU465GMn9gXHTLAG6/ugwyG4p0HIwVy6MnxzKgdLGgf1vsYpKQZdiGBsWprqdTf+
	 bw7RJuHThVn9ebZGoTLWQWrkdLBN/TAEuxSrBBF+JQVx14vySkGzOH3xlMgQzc1SMe
	 2/uPDYsNgF3Y3Ta86dY9Ye9WvL1FTSoPVBbdYb0Llw0subqhXETms7mxcZxr6v5IBl
	 ZO3biR+owBatw==
Date: Mon, 6 Jan 2025 16:44:33 -0800
From: Kees Cook <kees@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-ID: <202501061643.986D9453@keescook>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>

On Mon, Jan 06, 2025 at 10:26:27AM -0800, Jeff Xu wrote:
> + Kees because this is related to W^X memfd and security.
> 
> On Fri, Jan 3, 2025 at 7:14 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 7:19 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > +             if (is_exec_sealed(seals)) {
> > >
> > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > I've not tested this scenario so don't know if we somehow disallow this in
> > > another way but note on write checks we only care about shared mappings.
> > >
> > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > the data into an anon buffer and doing what you want with it, here you
> > > could argue the same...
> > >
> > > So probably we should only care about VM_SHARED?
> >
> > FWIW I think it doesn't make sense to distinguish between
> > shared/private mappings here - in the scenario described in the cover
> > letter, it wouldn't matter that much to an attacker whether the
> > mapping is shared or private (as long as the VMA contents haven't been
> > CoWed already).
> +1 on this.
> The concept of blocking this for only shared mapping is questionable.

Right -- why does sharedness matter? It seems more robust to me to not
create a corner case but rather apply the flag/behavior universally?

-- 
Kees Cook

