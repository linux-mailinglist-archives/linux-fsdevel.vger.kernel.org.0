Return-Path: <linux-fsdevel+bounces-28367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017E969E29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422331C20FFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6001A7254;
	Tue,  3 Sep 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="i5T6CMcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E11D0940
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367486; cv=none; b=m6cIUlRJK+TjM4+kPhRWevwnOdr73xldnfvrCdAPBMYqdCx/3o7jJWu+GpCF8uJhPqv6BM0uF4s88SoZYqmJlQxQA67nyevokyTbj+aYkuemFBrstXs/9MLAdzkawR4K/wfiJtrfdutu/urT8qi02xOd5/8xX1MNTLztD4Z1s3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367486; c=relaxed/simple;
	bh=SvdjRllqM3M+6KPCvtoNOCwh59VMkdSxkQaxbo5KBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYve8bNmUyrYJoajVZmTLLVBKUA/Yj07m0SCx085DabOylMPhX9GNIHR8+4+JvSR5+O2Ths/mRR30sP0hFymba3770LUO+XWvHSxaehz/I8+NJvFmCiKgtoNqD40UK6R1kgER+IkQGiJnrMcJsWcEn4gfDdb8rK13r7p15Hgyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=i5T6CMcG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483CiGh5026786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 08:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725367459; bh=BU550l4eAokGBa7f7wtEc3aBDu1uTbcSaIyWmfz9yvo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=i5T6CMcG9egOqG5iE45OW6fH61iR3oH5/WcW96/zgKhfpa9pzNZZMq2tx1mYINN7R
	 Yky1AsiPFVHLUcdlQ8pvor22wj5KbxWTjyWlQREQXPmoK4Pu0IAuwUKeYxIpPQx71k
	 +ri+gJNWNtZFCX/JJqvjTknN8gWE4tUSXUq2gBbXgBq7cCcNjxYfET8IYS8qExqm7z
	 lSIBbZW/qkmSQ/J9qw38lkeXFDS349QjbiuzYv34ecR3mfi70dP3Qy6kLjlxrAlJGF
	 NxNYT9+gXQFFodqqc8onQVOQynXo1psC0vSLl06w40zmApJxY8kH4mGaqXIXuVrQZd
	 fzB+WXkQZI9fg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 75A9F15C02C4; Tue, 03 Sep 2024 08:44:16 -0400 (EDT)
Date: Tue, 3 Sep 2024 08:44:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <20240903124416.GE424729@mit.edu>
References: <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
 <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>

On Tue, Sep 03, 2024 at 02:34:05PM +0800, Yafang Shao wrote:
>
> When setting GFP_NOFAIL, it's important to not only enable direct
> reclaim but also the OOM killer. In scenarios where swap is off and
> there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
> result in an infinite loop. In other words, GFP_NOFAIL should not be
> used with GFP_NOFS. Unfortunately, many call sites do combine them.
> For example:
> 
> XFS:
> 
> fs/xfs/libxfs/xfs_exchmaps.c: GFP_NOFS | __GFP_NOFAIL
> fs/xfs/xfs_attr_item.c: GFP_NOFS | __GFP_NOFAIL
> 
> EXT4:
> 
> fs/ext4/mballoc.c: GFP_NOFS | __GFP_NOFAIL
> fs/ext4/extents.c: GFP_NOFS | __GFP_NOFAIL
> 
> This seems problematic, but I'm not an FS expert. Perhaps Dave or Ted
> could provide further insight.

GFP_NOFS is needed because we need to signal to the mm layer to avoid
recursing into file system layer --- for example, to clean a page by
writing it back to the FS.  Since we may have taken various file
system locks, recursing could lead to deadlock, which would make the
system (and the user) sad.

If the mm layer wants to OOM kill a process, that should be fine as
far as the file system is concerned --- this could reclaim anonymous
pages that don't need to be written back, for example.  And we don't
need to write back dirty pages before the process killed.  So I'm a
bit puzzled why (as you imply; I haven't dug into the mm code in
question) GFP_NOFS implies disabling the OOM killer?

Regards,

					- Ted

P.S.  Note that this is a fairly simplistic, very conservative set of
constraints.  If you have several dozen file sysetems mounted, and
we're deep in the guts of file system A, it might be *fine* to clean
pages associated with file system B or file system C.  Unless of
course, file system A is a loop-back mount onto a file located in file
system B, in which case writing into file system A might require
taking locks related to file system B.  But that aside, in theory we
could allow certain types of page reclaim if we were willing to track
which file systems are busy.

On the other hand, if the system is allowed to get that busy,
performance is going to be *terrible*, and so perhaps the better thing
to do is to teach the container manager not to schedule so many jobs
on the server in the first place, or having the mobile OS kill off
applications that aren't in the foreground, or giving the OOM killer
license to kill off jobs much earlier, etc.  By the time we get to the
point where we are trying to use these last dozen or so pages, the
system is going to be thrashing super-badly, and the user is going to
be *quite* unhappy.  So arguably these problems should be solved much
higher up the software stack, by not letting the system get into such
a condition in the first place.

