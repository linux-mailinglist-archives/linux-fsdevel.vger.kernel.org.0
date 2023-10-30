Return-Path: <linux-fsdevel+bounces-1535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3627DB7FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181C11C20A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4711C93;
	Mon, 30 Oct 2023 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMQoW8NT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0011196
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A40C433C9;
	Mon, 30 Oct 2023 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698661501;
	bh=HwZC9pP22kn0OW2U98JRm5leuqIjcFYJqSB6SiV2Igo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMQoW8NTpxWDJGXQJQUyW78lIpBQ7gAE0+SzCObomFGyGRsggebsZMp8JkGKRtTbT
	 2Wb++X6JGoGFycht3sxazi53zoDfSN8j8yNlrIYVhS2+jCaBQdmkNKxucl0/Xz5Ija
	 g+W4kzcozgxzag64nxmFIhoO0NeOCQkjmxII85cj1u3wIzZwA3nWHccuAMMqaKCAxc
	 5FLDoX0vi15Ot4EjT5fwFAaR1uuGNsIdjxKHbqfP3TYftwgEOgC4LIj/xf3L65z9aN
	 MbyzOSwJl9cfXPKSSid7UaeE+L/k4gCtiZUjPA2Il6rNMZwLCocMesmWhsqoDwhgZn
	 1ZZtTnI7WwEnQ==
Date: Mon, 30 Oct 2023 11:24:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
Message-ID: <20231030-imponieren-tierzucht-1d1ef70bce3f@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>

On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
> On 27/10/23 22:33, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Summary */
> > This ports autofs to the new mount api. The patchset has existed for
> > quite a while but never made it upstream. Ian picked it back up.
> > 
> > This also fixes a bug where fs_param_is_fd() was passed a garbage
> > param->dirfd but it expected it to be set to the fd that was used to set
> > param->file otherwise result->uint_32 contains nonsense. So make sure
> > it's set.
> > 
> > One less filesystem using the old mount api. We're getting there, albeit
> > rather slow. The last remaining major filesystem that hasn't converted
> > is btrfs. Patches exist - I even wrote them - but so far they haven't
> > made it upstream.
> 
> Yes, looks like about 39 still to be converted.
> 
> 
> Just for information, excluding btrfs, what would you like to see as the
> 
> priority for conversion (in case me or any of my colleagues get a chance
> 
> to spend a bit more time on it)?

I think one way to prioritize them is by how likely they are to have
(more than a couple) active users.

So recently I've done overlayfs because aside from btrfs that was
probably one of the really actively used filesystems that hadn't yet
been converted. And that did surface some regression

So 9p, fat, devpts, f2fs, zonefs, ext2 are pretty obvious targets.
Judging from experience, the more mount options a filesystem has the
bigger the conversion patch will usually be.

Another way is by function. For example, we expose mount_bdev() which is
basically the legacy version of get_tree_bdev(). And they sort of are
almost copies of each other. So converting all callers to the new mount
api means we can get rid of mount_bdev(). But that's like 25 of the
remaining 39.

But in the end any filesystem that is converted is great.

