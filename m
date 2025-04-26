Return-Path: <linux-fsdevel+bounces-47447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9FA9D866
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C21BC74BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC241D63CD;
	Sat, 26 Apr 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJxiphkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826804414;
	Sat, 26 Apr 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648954; cv=none; b=bW1/kE0W/wpH1T2MOKNZJ4oo5t9xE6OTeGS+aajRS/TuvX6Ayl11UQahddM3Ji3nEl5P7SLux1PZ1Yj0Z8eAZwBP6l7tJDVsrYMikhOdoF/Ebd8kEBcs8a3VTk7ZAGE56/eShyLTsS6SbZuY53o37aCRwMjQRSnNM65yvl50Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648954; c=relaxed/simple;
	bh=CwtoCaEwiTUrpNzo5zHNsmceswlFZAlAFiBVZxCCdwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gz/+79LXB/BEeg86uJkh1cA8ZnNJOG43gBwiNZmggPd/S8Q5ORlrZMEQUDBmHhEJNPZi1emt0fJaxDuSNTO79PJ8BhEJKAK4zmjhpKJW6v43xZZ1mEkksggUeTfMdCk6WyiDgEBo51s8PmlOF631S4Uo8EAdVFJ8b/iKTVKq7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJxiphkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F18AC4CEE2;
	Sat, 26 Apr 2025 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648954;
	bh=CwtoCaEwiTUrpNzo5zHNsmceswlFZAlAFiBVZxCCdwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJxiphkw/nEpHBGFGrfbdevA2CipjH1UHHY9qUdKqvWyoMTAjZYC0i6F5G6v0+xks
	 D0bz+Rt8PLhq8lGRxd/xA0vpQYlTmmmyLOuq4FTLxuMyOyEow/TBFDgvTZHJy5amyg
	 fuZHnHz2oaQIyoPku0MUCWZHoswqOqh/AamBnbLE/Izkv53Ss4iJ0yMvYseT2XxnJJ
	 4aVschQYpQ18I903FVuQaCv+mQqw1g6eyTy0/RQnzC6f+EZVtXipGW4RlxWtbk47X4
	 aHFdfhZDAC3JrEC7TosGRrFvCmWWON/o9him6DT2VfFohbuC4/NH47Ac01X83XbJCB
	 vTTS9PCH6Orbw==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	David Rheinsberg <david@readahead.eu>,
	Jan Kara <jack@suse.cz>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Luca Boccassi <bluca@debian.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 0/4] net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid
Date: Sat, 26 Apr 2025 08:28:55 +0200
Message-ID: <20250426-unbeteiligt-kalium-61b1b4a215de@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=brauner@kernel.org; h=from:subject:message-id; bh=CwtoCaEwiTUrpNzo5zHNsmceswlFZAlAFiBVZxCCdwY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTw1Bo9FjecxcqyN+Hh0+MRTfMMz9lViFTt3F6wdZPtr 2lvZ8jxdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkchbDP721H/UNlZac+dNu Ipvyvbs6ac031wjG4ocibHfnbVZhm8XI8HP9z5avdf/L7sZ5Pp6xvqY99sUXw6mvHjDrSSdNkf3 qzwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 25 Apr 2025 10:11:29 +0200, Christian Brauner wrote:
> SO_PEERPIDFD currently doesn't support handing out pidfds if the
> sk->sk_peer_pid thread-group leader has already been reaped. In this
> case it currently returns EINVAL. Userspace still wants to get a pidfd
> for a reaped process to have a stable handle it can pass on.
> This is especially useful now that it is possible to retrieve exit
> information through a pidfd via the PIDFD_GET_INFO ioctl()'s
> PIDFD_INFO_EXIT flag.
> 
> [...]

Applied to the vfs-6.16.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.pidfs

[1/4] pidfs: register pid in pidfs
      https://git.kernel.org/vfs/vfs/c/477058411c45
[2/4] net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
      https://git.kernel.org/vfs/vfs/c/fd0a109a0f6b
[3/4] pidfs: get rid of __pidfd_prepare()
      https://git.kernel.org/vfs/vfs/c/a71f402acd71
[4/4] net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid
      https://git.kernel.org/vfs/vfs/c/358ab1fd6922

