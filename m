Return-Path: <linux-fsdevel+bounces-51314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39DAD541D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EA16247A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888625BEE4;
	Wed, 11 Jun 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAAMFrzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668382E610C;
	Wed, 11 Jun 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641814; cv=none; b=ouqgIGUE24cuGqZuYsI0EXdd7/aq/eMItyhvQh190UPgZ05saviCmxtly0J41BpQGtvRs3pHFDJqpmAo1jY74+s88hYCIHzFpeqNSOw/8EWF2mL85gPaj22n9ylJ2yXdhxwUrQNjpoJUgA9i3rKNLpTD59iPPtfKx4qFtnkH4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641814; c=relaxed/simple;
	bh=tXcGTOft1K2ZjeGPYHByKIvWsDYDZGjFIvK1fLYm37k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3F7rj884dA1xfKmSViJBavlNhwR1LBY99vail/LZjvd497SuyxHUS8T4Tc9BnpI7bJDBR1sAC+P6TJiSS370PuXPqN7RP2Kn1INPyhCh+JT7UefTxuVhrhXeiipgRHitKdUZwePyzWv4BL/hNpbzfW9SncOL0kYS9MlXhpcjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAAMFrzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C030C4CEEE;
	Wed, 11 Jun 2025 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749641814;
	bh=tXcGTOft1K2ZjeGPYHByKIvWsDYDZGjFIvK1fLYm37k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAAMFrzmMdbLqG2eV/Tb9nLSFiQvkj1g2mFx+AIAfIxYA0Zp7tXVlhmqARSVJJcKB
	 FQ5PpcPP3L902FMZUMnZmil5vyYdYnGR36yLK+KQyUPYIARY6DlQIdcglLqbSKuIcG
	 CFAiPAWOUCJI95wE4KW4Z9CuOcBTyNGdR8wNCc/MMzWJ54RKRqohKQp/wgN25NtEmq
	 uk2qx5mgjtPNQP/mYJ19Y8X0QiRk00+hznjp+XePCot1xO1LETEy6+8yBa9jp1sEws
	 DcocQUbO3sob7L5Km0NsVhZZKSh9sHFFbMY3A4G6fGTvB39j5BPagQ/sYiOYoJKLM7
	 BXiNOA3dk8efw==
Date: Wed, 11 Jun 2025 13:36:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Song Liu <song@kernel.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Al Viro <viro@zeniv.linux.org.uk>, amir73il@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, gnoack@google.com, jack@suse.cz, jlayton@kernel.org, 
	josef@toxicpanda.com, kernel-team@meta.com, kpsingh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, martin.lau@linux.dev, mattbobrowski@google.com, 
	repnop@google.com
Subject: Re: [PATCH v3 bpf-next 0/5] bpf path iterator
Message-ID: <20250611-bindung-pulver-6158a3053c87@brauner>
References: <20250606213015.255134-1-song@kernel.org>
 <dbc7ee0f1f483b7bc2ec9757672a38d99015e9ae.1749402769@maowtm.org>
 <CAPhsuW7n_+u-M7bnUwX4Go0D+jj7oZZVopE1Bj5S_nHM1+8PZg@mail.gmail.com>
 <97cdb6c5-0b46-4442-b19f-9980e33450c0@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97cdb6c5-0b46-4442-b19f-9980e33450c0@maowtm.org>

On Mon, Jun 09, 2025 at 09:08:34AM +0100, Tingmao Wang wrote:
> On 6/9/25 07:23, Song Liu wrote:
> > On Sun, Jun 8, 2025 at 10:34 AM Tingmao Wang <m@maowtm.org> wrote:
> > [...]
> >> Hi Song, Christian, Al and others,
> >>
> >> Previously I proposed in [1] to add ability to do a reference-less parent
> >> walk for Landlock.  However, as Christian pointed out and I do agree in
> >> hindsight, it is not a good idea to do things like this in non-VFS code.
> >>
> >> However, I still think this is valuable to consider given the performance
> >> improvement, and after some discussion with Mickaël, I would like to
> >> propose extending Song's helper to support such usage.  While I recognize
> >> that this patch series is already in its v3, and I do not want to delay it
> >> by too much, putting this proposal out now is still better than after this
> >> has merged, so that we may consider signature changes.
> >>
> >> I've created a proof-of-concept and did some brief testing.  The
> >> performance improvement attained here is the same as in [1] (with a "git
> >> status" workload, median landlock overhead 35% -> 28%, median time in
> >> landlock decreases by 26.6%).
> >>
> >> If this idea is accepted, I'm happy to work on it further, split out this
> >> patch, update the comments and do more testing etc, potentially in
> >> collaboration with Song.
> >>
> >> An alternative to this is perhaps to add a new helper
> >> path_walk_parent_rcu, also living in namei.c, that will be used directly
> >> by Landlock.  I'm happy to do it either way, but with some experimentation
> >> I personally think that the code in this patch is still clean enough, and
> >> can avoid some duplication.
> >>
> >> Patch title: path_walk_parent: support reference-less walk
> >>
> >> A later commit will update the BPF path iterator to use this.
> >>
> >> Signed-off-by: Tingmao Wang <m@maowtm.org>
> > [...]
> >>
> >> -bool path_walk_parent(struct path *path, const struct path *root);
> >> +struct parent_iterator {
> >> +       struct path path;
> >> +       struct path root;
> >> +       bool rcu;
> >> +       /* expected seq of path->dentry */
> >> +       unsigned next_seq;
> >> +       unsigned m_seq, r_seq;
> > 
> > Most of parent_iterator is not really used by reference walk.
> > So it is probably just separate the two APIs?
> 
> I don't mind either way, but I feel like it might be nice to just have one
> style of APIs (i.e. an iterator with start / end / next vs just one
> function), even though this is not totally necessary for the ref-taking
> walk.  After all, the BPF use case is iterator-based.  This also means
> that the code at the user's side (mostly thinking of Landlock here) is
> slightly simpler.
> 
> But I've not experimented with the other way.  I'm open to both, and I'm
> happy to send a patch later for a separate API (in that case that would
> not depend on this and I might just start a new series).
> 
> Would like to hear what VFS folks thinks of this first tho, and whether
> there's any preference in one or two APIs.

I really dislike exposing the sequence number for mounts an for
dentries. That's just nonsense and a non-VFS low-level consumer of this
API has zero business caring about any of that. It's easy to
misunderstand, it's easy to abuse so that's not a good way of doing
this. It's the wrong API.

> 
> > 
> > Also, is it ok to make m_seq and r_seq available out of fs/?

No, it's not.

> 
> The struct is not intended to be used directly by code outside.  Not sure

That doesn't mean anything. It's simply the wrong API if it has to spill
so much of its bowels.

> what is the standard way to do this but we can make it private by e.g.
> putting the seq values in another struct, if needed.  Alternatively I
> think we can hide the entire struct behind an opaque pointer by doing the
> allocation ourselves.
> 
> > 
> >> +};
> >> +
> >> +#define PATH_WALK_PARENT_UPDATED               0
> >> +#define PATH_WALK_PARENT_ALREADY_ROOT  -1
> >> +#define PATH_WALK_PARENT_RETRY                 -2
> >> +
> >> +void path_walk_parent_start(struct parent_iterator *pit,
> >> +                           const struct path *path, const struct path *root,
> >> +                           bool ref_less);
> >> +int path_walk_parent(struct parent_iterator *pit, struct path *next_parent);
> >> +int path_walk_parent_end(struct parent_iterator *pit);
> > 
> > I think it is better to make this rcu walk a separate set of APIs.
> > IOW, we will have:
> > 
> > int path_walk_parent(struct path *path, struct path *root);
> > 
> > and
> > 
> > void path_walk_parent_rcu_start(struct parent_iterator *pit,
> >                            const struct path *path, const struct path *root);
> > int path_walk_parent_rcu_next(struct parent_iterator *pit, struct path
> > *next_parent);
> > int path_walk_parent_rcu_end(struct parent_iterator *pit);
> 
> (replied above)

Exposing two sets of different APIs for essentially the same things is
not going to happen.

The VFS doesn't expose a rcu variant and a non-rcu variant for itself so
we are absolutely not going to do that for outside stuff.

It always does the try RCU first, then try to continue the walk by
falling back to REF walk (e.g., via try_to_unlazy()). If that doesn't
work then let the caller know and require them to decide whether to
abort or redo everything in ref-walk.

There's zero need in that scheme for the caller to see any of the
internals of the VFS and that's what you should aim for.

