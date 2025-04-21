Return-Path: <linux-fsdevel+bounces-46788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA30A94E26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D629D18914A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514321127D;
	Mon, 21 Apr 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXpwN9P1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7613C3F6;
	Mon, 21 Apr 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745224537; cv=none; b=lXjnwyOkOq+WmpmSa+HNDI4Ypox52sPPpJI8AboX6THZKTOOnzO6GAOD8c4iWX5YDDgNWDolZX3cLSra0hBQdYEITdkFp4z5YTO/4haqQkAjzTk9QFZKu9Sm82zrGYOKSCn7cE58sX7MCGFOgpx92MF4FIDBoGjDpFlg54zVDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745224537; c=relaxed/simple;
	bh=6lOT7WBpRHE3rkOIBj3B4eJewXNB1TNKuzbAkrF46+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plbh8UDLQVoIS2+/k9mxoeM3Ysetms2IrkZmsUOGjz5zLo1hdc2SFai8WuqjM6+sUzXi9Iz+UQWrNjw4vf+arBFkX4QAzg/V3d50M1EDGta2d8vIqGyqzibHJZP7Xjp2WVlGvvw+AWpUPrpaY2N8xucEOag0QhSMCX121G8ila4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXpwN9P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA7C4CEE4;
	Mon, 21 Apr 2025 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745224536;
	bh=6lOT7WBpRHE3rkOIBj3B4eJewXNB1TNKuzbAkrF46+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXpwN9P1KaGF57A234+RON91rgR+HyVTNwW7RrJLsX4olCT9NYoxypRfWLbmcW2Mt
	 SiNz8npmAfG0LvxEZtVtNeiOFKefmvAGtqEkIUPgQYT4oRDCzX7PPGvi2a7sGEoawY
	 I2WCpRHenYMA9W8tEZFf7ivukvaLhw/p0T0sD5SOSDHFT3o50z6ZxketytMLTwP8Hr
	 7skM0a8YPzVI+IPc7akHp4MaKS9dBS6Q3ohJ7ghBQjC+QTznul8W/owdbDO1q4XLLH
	 rZMZ/Q3gbJ/JBxQJoPUkEEW9sOVhKYnrLRIq6udWQK2avuwEfZT5NFSP2k0ScYtBoT
	 jOECGZiHCdgjg==
Date: Mon, 21 Apr 2025 10:35:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <20250421-galaktisch-pseudologie-65c81978dd38@brauner>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
 <3A9139D5CD543962+89831381-31b9-4392-87ec-a84a5b3507d8@radxa.com>
 <20250420-monument-zeitschrift-6e8126bf53c9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250420-monument-zeitschrift-6e8126bf53c9@brauner>

On Sun, Apr 20, 2025 at 12:54:29PM +0200, Christian Brauner wrote:
> On Fri, Apr 18, 2025 at 10:15:01AM +0800, Xilin Wu wrote:
> > On 2025/4/7 17:54:15, Christian Brauner wrote:
> > > This allows the VFS to not trip over anonymous inodes and we can add
> > > asserts based on the mode into the vfs. When we report it to userspace
> > > we can simply hide the mode to avoid regressions. I've audited all
> > > direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> > > and i_op inode operations but it already uses a regular file.
> > > 
> > > Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> > > Cc: <stable@vger.kernel.org> # all LTS kernels
> > > Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Hi Christian and FSdevel list,
> > 
> > I'm reporting a regression introduced in the linux-next tree, which I've
> > tracked down using `git bisect` to this commit.
> > 
> > Starting with `linux-next` tag `next-20250408` (up to the latest
> > `next-20250417` I tested), attempting to start an SDDM Wayland session
> > (using KDE Plasma's KWin) results in a black screen. The `kwin_wayland` and
> > `sddm-helper-start-wayland` processes both enter a state consuming 100% CPU
> > on a single core indefinitely, preventing the login screen from appearing.
> > The last known good kernel is `next-20250407`.
> > 
> > Using `strace` on the `kwin_wayland` process revealed it's stuck in a tight
> > loop involving `ppoll` and `ioctl`:
> > 
> > ```
> > ioctl(29, FIONREAD, [0])                = 0
> > ppoll([{fd=10, events=POLLIN}, {fd=37, events=POLLIN}, {fd=9,
> > events=POLLIN}, {fd=5, events=POLLIN}, {fd=29, events=POLLIN}, {fd=17,
> > events=POLLIN}, {fd=3, events=POLLIN}], 7, NULL, NULL, 8) = 1 ([{fd=29,
> > revents=POLLIN}])
> > ioctl(29, FIONREAD, [0])                = 0
> > ppoll([{fd=10, events=POLLIN}, {fd=37, events=POLLIN}, {fd=9,
> > events=POLLIN}, {fd=5, events=POLLIN}, {fd=29, events=POLLIN}, {fd=17,
> > events=POLLIN}, {fd=3, events=POLLIN}], 7, NULL, NULL, 8) = 1 ([{fd=29,
> > revents=POLLIN}])
> > # ... this repeats indefinitely at high frequency
> > ```
> > 
> > Initially, I suspected a DRM issue, but checking the file descriptor
> > confirmed it's an `inotify` instance:
> > 
> > ```
> > $ sudo ls -l /proc/<kwin_pid>/fd/29
> > lr-x------ 1 sddm sddm 64 Apr 17 14:03 /proc/<kwin_pid>/fd/29 ->
> > anon_inode:inotify
> > ```
> > 
> > Reverting this commit resolves the issue, allowing SDDM and KWin Wayland to
> > start normally.
> > 
> > Could you please take a look at this? Let me know if you need any further
> > information or testing from my side.
> 
> I'll take a look latest Tuesday.

Fixed. We need to ensure that we call the ioctl handler for anonymous
inodes and not the generic FIONREAD call.

