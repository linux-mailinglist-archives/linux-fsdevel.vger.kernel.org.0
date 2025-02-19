Return-Path: <linux-fsdevel+bounces-42047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC97A3BA80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66AC67A86ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF41BC9F0;
	Wed, 19 Feb 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk4X7I+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46B15B971;
	Wed, 19 Feb 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957904; cv=none; b=ncq7NJgalyvsVEO7PRVdLWXmE8CVKOThWEK5yt22cFIk7KilMcXYV6LUADUtVFT0Kp7s43sgHzjzztBm7SdvRI5Z8v7vgv6xZEFNOYCZSHA9/NRc/wAYju2qr29oKGaJIV78vMPwhyBusVMCV4UbwtbWse8FzxelwQe89FmTeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957904; c=relaxed/simple;
	bh=80I3NFEQ9dB3idbQ3rrlutO1WpxNEwV3ESxpvEHssw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCAPEHz8CWug/WFODb9ulfYVJSZAm2LMR9eTSEI00dczsLlCFNSeDP/ZdIFRuHHRhsMv2MHbhYrUKbJjQ0PaErgSZvRswIKtGOVM5jDhYzPbEqCru5Q2l8jSrSGby97iD+f5uLWCOME0QDLVhQ160X0MzRij93EGfowPGLvoGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk4X7I+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B1C4CED1;
	Wed, 19 Feb 2025 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957903;
	bh=80I3NFEQ9dB3idbQ3rrlutO1WpxNEwV3ESxpvEHssw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mk4X7I+4NK641JPh0lH3mxXQjPoMemeHNJVvxuFmmLHC/ixCa1WumSq6dDN+UTlpw
	 zpUgxeiJXqYBElyQ0DUuYW0guCtjDYpCi78mBTZdKc1ZYh1YOvEi9mJvXP9b6EHWlm
	 YQERNL01Ou2rIWZUSUECfVGTKQQXNoBJ3nDyfpn9bhl6froDTMMH46SmIILX7oxuAg
	 Gc9nPV0WuyOoDvloGJC95f13CxxB9MO5/fFpM0spaDwQ25NgZy/oitF3thNmdPPSOc
	 4MrXUl8X5T49bOg9sM1P1IOiNOngbfg1IgoTW8bfr/EAseOp0qJHA7zCpi7XDqslBr
	 ZZRGTJCy24gpQ==
Date: Wed, 19 Feb 2025 09:38:21 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 0/2 v9] reclaim file-backed pages given POSIX_FADV_NOREUSE
Message-ID: <Z7WmjagtARpTA781@google.com>
References: <20250212023518.897942-1-jaegeuk@kernel.org>
 <Z7REHrJ3ImdrF476@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7REHrJ3ImdrF476@infradead.org>

On 02/18, Christoph Hellwig wrote:
> This still has a file system sysfs HACK, you're still not Ccing the
> right list, etc.
> 
> Can you pleae at least try to get it right?

I was modifying the patch having 1) declaring a static global list, 2) adding
some fields to superblock and inode structures to keep the given range in the
inode through fadvise, 3) adding hooks in evict_inode to handle the list, 4)
exploring which sysfs entry in MM to reclaim them explicitly.

But, I stopped at some point, as it looks not good at all. Moreover, I started
to be questioning why not just doing in F2FS back, given sementically I didn't
change anything  on general behavior of fadvise(POSIX_FADV_NOREUSE), IIUC, which
moves pages back to LRU. In addiiton to that, I'd like to keep the range hint in
a filesystem and provide a sysfs entry to manage the hints additionally.
In addition, I don't think there's rule that filesystem cannot reclaim file-back
pages, as it just uses the exported symbol that all filesystems are using in
various different purpose. Hence, I don't get the point which is wrong.

Thanks,

> 
> On Wed, Feb 12, 2025 at 02:31:55AM +0000, Jaegeuk Kim wrote:
> > This patch series does not add new API, but implements POSIX_FADV_NOREUSE where
> > it keeps the page ranges in the f2fs superblock and add a way for users to
> > reclaim the pages manually.
> > 
> > Change log from v8:
> >  - remove new APIs, but use fadvise(POSIX_FADV_NOREUSE)
> > 
> > Jaegeuk Kim (2):
> >   f2fs: keep POSIX_FADV_NOREUSE ranges
> >   f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages
> > 
> >  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
> >  fs/f2fs/debug.c                         |  3 +
> >  fs/f2fs/f2fs.h                          | 14 +++-
> >  fs/f2fs/file.c                          | 60 +++++++++++++++--
> >  fs/f2fs/inode.c                         | 14 ++++
> >  fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
> >  fs/f2fs/super.c                         |  1 +
> >  fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
> >  8 files changed, 246 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.48.1.601.g30ceb7b040-goog
> > 
> > 
> ---end quoted text---

