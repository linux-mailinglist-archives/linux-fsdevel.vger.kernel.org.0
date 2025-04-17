Return-Path: <linux-fsdevel+bounces-46621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E909A91879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B638461202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5E22A7EE;
	Thu, 17 Apr 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ2y/3rs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA441C84AD;
	Thu, 17 Apr 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883899; cv=none; b=igFMYVDAYe//3GeQEuqRpFkMeRVcH8uQFqJ73h6Q/8z2kL20Xdx49phfk4SOgSzV4Z6d9VK8SAxc8hCd6V07WqBbBDcHHYzzN4ilV0ATORubKhaDeeN2aDs8ULvKnqCAk6ECmQCqwPZC7GTzQaiqnZvhfDoHlIwQvPYGx+qWi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883899; c=relaxed/simple;
	bh=XKfzMU1FYpRJY8gsd2/4gHvZ0QLwqAm+grYaFWdFud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6EYkTEl/47AfLh+8LU3oiD9t+02vyFUk2u66VC9BGCwKcCUhjXbY8WI2Fn9NgZndco4rDo1j2gcB3dUopcrlMrfLLtCBN3oU8clEDL5s5K1a/bcKi+9O/uoPlh7NILMv3EofjWT49Hkp0mTRfDHrhwoiGdqvDAKxRNnKuIYQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ2y/3rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3FCC4CEE4;
	Thu, 17 Apr 2025 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883898;
	bh=XKfzMU1FYpRJY8gsd2/4gHvZ0QLwqAm+grYaFWdFud0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQ2y/3rsaJf1lr4h3arCc3AGGaekutRzZ3Aflp+xfuE+onK/ZbkOhh1oFMYzAIPyv
	 a41GWzdLy4tdggpl3OYUY5EnvPyJ7MUq9ap/QExd42TcC0l0+4SNxl9lnfJ/6IBZAm
	 FkHcKaOm7IpIkP8UNMY5SVHlsLss80jnDlSKT0SMfpyBYbLd4jXnSm8GNkQV2sE8sd
	 wRMKHQ4l11anriWEWLpA3yS1zyWK4HNBTubBhmfl2H7YBg23UMkjhrjFVaMVyqShXl
	 4bwK8Ijo9Fjtl00XnWzhTjoNYdKzoFSkbrSMst43ihmeipN+vQVAirACmra+6ZxOpY
	 q7h/08NHiL7EQ==
Date: Thu, 17 Apr 2025 11:58:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	mcgrof@kernel.org, willy@infradead.org, hare@suse.de, djwong@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 0/7] fs/buffer: split pagecache lookups into atomic
 or blocking
Message-ID: <20250417-jagdhund-ruhmreich-f1c979cdd58d@brauner>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>

On Tue, Apr 15, 2025 at 04:16:28PM -0700, Davidlohr Bueso wrote:
> Hello,
> 
> This is a respin of the series[0] to address the sleep in atomic scenarios for
> noref migration with large folios, introduced in:
> 
>       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")

Please resend based on vfs.fixes.

> The main difference is that it removes the first patch and moves the fix (reducing
> the i_private_lock critical region in the migration path) to the final patch, which
> also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
> patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
> users will take the folio lock and hence wait for migration, and otherwise nonblocking
> callers will bail the lookup if a noref migration is on-going. Blocking callers
> will also benefit from potential performance gains by reducing contention on the
> spinlock for bdev mappings.
> 
> It is noteworthy that this series is probably too big for Linus' tree, so there are
> two options:
> 
>  1. Revert 3c20917120ce61, add this series + 3c20917120ce61 for next. Or,
>  2. Cherry pick patch 7 as a fix for Linus' tree, and leave the rest for next.
>     But that could break lookup callers that have been deemed unfit to bail.
> 
> Patch 1: carves a path for callers that can block to take the folio lock.
> Patch 2: adds sleeping flavors to pagecache lookups, no users.
> Patches 3-6: converts to the new call, where possible.
> Patch 7: does the actual sleep in atomic fix.
> 
> Thanks!
> 
> [0] https://lore.kernel.org/all/20250410014945.2140781-1-mcgrof@kernel.org/
> 
> Davidlohr Bueso (7):
>   fs/buffer: split locking for pagecache lookups
>   fs/buffer: introduce sleeping flavors for pagecache lookups
>   fs/buffer: use sleeping version of __find_get_block()
>   fs/ocfs2: use sleeping version of __find_get_block()
>   fs/jbd2: use sleeping version of __find_get_block()
>   fs/ext4: use sleeping version of sb_find_get_block()
>   mm/migrate: fix sleep in atomic for large folios and buffer heads
> 
>  fs/buffer.c                 | 73 +++++++++++++++++++++++++++----------
>  fs/ext4/ialloc.c            |  3 +-
>  fs/ext4/mballoc.c           |  3 +-
>  fs/jbd2/revoke.c            | 15 +++++---
>  fs/ocfs2/journal.c          |  2 +-
>  include/linux/buffer_head.h |  9 +++++
>  mm/migrate.c                |  8 ++--
>  7 files changed, 82 insertions(+), 31 deletions(-)
> 
> --
> 2.39.5
> 

