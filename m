Return-Path: <linux-fsdevel+bounces-29310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625A977F51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A79E281150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848061D9346;
	Fri, 13 Sep 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRvVf7oj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E51C175F;
	Fri, 13 Sep 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229489; cv=none; b=iLtPx5TXqIveGJju7eRjDRjbp9WzoYC+R3rFPBX/mf1VnEw34bqdRz3A20sxswtrktM5aBKJz4YONK3RIS3fuMFM0U3/OtYb9UHGDJDDX8E3PoGFaiXcW2ydviBsSRMhiIYbKJsByZyfUfBmBuxKvX7+8GiwF7W22jnGzMhXgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229489; c=relaxed/simple;
	bh=7xIfV9cbzSwkAOH/0KEgBigHdF3rNbLzHt6TgHTSjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq7T/jJndbko7flxNKTSpeqmW7sz4Sy/LaRdpLcLqoRNlWFfWorEjj4m3gO2qQQQ0bKbNhMbtxphYLGH+L9JV+OUVRE2XMjzvYfBhB0D0fsl26ftpac5QLEEuc0JEUO7DgINRYWqUTPvQIaZKGdoKG0teIxBhRcBCUHldf0XeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRvVf7oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A34C4CEC0;
	Fri, 13 Sep 2024 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726229488;
	bh=7xIfV9cbzSwkAOH/0KEgBigHdF3rNbLzHt6TgHTSjX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRvVf7ojKKKqLD9YWcx/3bpn4sdndF1F9fraVJqDU9bsn8N9wDsH6LxXzx5WXi26H
	 RwHxd2OsJbu+eV3786Ep4aqOwbz5xkjy5VnVOCcecIYWaO3v3JiJ0ZpPpXxnUFn4KO
	 akkoN0/Q3X/1rJ7i6GOfDOxsjXqtkxqROJ40T1bVJEwb6JaS6OH9ApegotS4CmLHIk
	 a167Sb5gvXUNQxhLfgiAjmCLv1c6M/jLZJoD7pcXz4WFNe/SzshO7m76/XfsWddZrF
	 MFKoPSvf8yrcXolFmwP3Swuwl7aTm+lUg/5KGOG/DCxutKVu5/zyJ3g7l79DG5f0y9
	 gdfel2VlMccNg==
Date: Fri, 13 Sep 2024 14:11:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>, clm@meta.com, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <20240913-ortsausgang-baustart-1dae9a18254d@brauner>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:25:50PM GMT, Linus Torvalds wrote:
> On Thu, 12 Sept 2024 at 15:12, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > When I saw Christian's report, I seemed to recall that we ran into this
> > at Meta too. And we did, and hence have been reverting it since our 5.19
> > release (and hence 6.4, 6.9, and 6.11 next). We should not be shipping
> > things that are known broken.
> 
> I do think that if we have big sites just reverting it as known broken
> and can't figure out why, we should do so upstream too.
> 
> Yes,  it's going to make it even harder to figure out what's wrong.
> Not great. But if this causes filesystem corruption, that sure isn't
> great either. And people end up going "I'll use ext4 which doesn't
> have the problem", that's not exactly helpful either.
> 
> And yeah, the reason ext4 doesn't have the problem is simply because
> ext4 doesn't enable large folios. So that doesn't pin anything down
> either (ie it does *not* say "this is an xfs bug" - it obviously might
> be, but it's probably more likely some large-folio issue).
> 
> Other filesystems do enable large folios (afs, bcachefs, erofs, nfs,
> smb), but maybe just not be used under the kind of load to show it.
> 
> Honestly, the fact that it hasn't been reverted after apparently
> people knowing about it for months is a bit shocking to me. Filesystem
> people tend to take unknown corruption issues as a big deal. What
> makes this so special? Is it because the XFS people don't consider it
> an XFS issue, so...

So this issue it new to me as well. One of the items this cycle is the
work to enable support for block sizes that are larger than page sizes
via the large block size (LBS) series that's been sitting in -next for a
long time. That work specifically targets xfs and builds on top of the
large folio support.

If the support for large folios is going to be reverted in xfs then I
see no point to merge the LBS work now. So I'm holding off on sending
that pull request until a decision is made (for xfs). As far as I
understand, supporting larger block sizes will not be meaningful without
large folio support.

