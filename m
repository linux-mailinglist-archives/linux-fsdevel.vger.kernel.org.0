Return-Path: <linux-fsdevel+bounces-10958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06A84F734
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABDFB24D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE169953;
	Fri,  9 Feb 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzDVX4sh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975FF383BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488525; cv=none; b=cZrZhXGkBtUeey7XB+V5l3y2eExryUiZpjsEeSpHSScTGDcdSPVnsmlcopAuQ/MDNehGCLC0KF36MhN+PeA1zYyBRFzN05aWPpa4i1HGhLzlbzQ5MlQk80/2AyfPUzrVDKg9hUVOJY1/eHpeywe7lRBDLDtAUoVPsEr9suGbmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488525; c=relaxed/simple;
	bh=3f0I0xEezWNND8G6bTNtOjNioGpA0jEzstUxsqt7Bxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6zusenpnwTbkEmSEISO+SNgjAUgM5OK4dVyYvaUYEjjWyaFdfHhdMP0RqWlIzTgg3pHoTA1TzOTJmnDwrrJ2prLRzbRw+BbYqplaD+/XBSAgaVeGrDtfhevEqgMiy1yDK+OCLkS0rHwBrd2tOZvPHwnSYgdEwGxrJF60A02sFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzDVX4sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B51FC433F1;
	Fri,  9 Feb 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707488525;
	bh=3f0I0xEezWNND8G6bTNtOjNioGpA0jEzstUxsqt7Bxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzDVX4sh3eRw8l9vPHTu+9lHcaKs9fzPtWsQOvYvsHCSuMJ3YdVs83m9oFMxdcETZ
	 PEBDmgcvxC3HRrUQF9ffbosZ5OwKatj6AYhdm/uS8ntuS7ZTbvSUBAoVcblBa562ro
	 Lq5qhEeXpYxvmxpJybN1h6E86Mo5RhJR8HhdgvOqfpGWS/ipNZ5hvrzcuKxwyQqz+g
	 eyy1yvBKBlEJ2I0qicbliJ08wu5sdHq67XQ5b1GSWpI4uU9xCijaVfKekTd6QcI1LQ
	 z5/Omifc0K2lPSmCP8aCfMNq8O72VxDg9pvzCOQFi4pnmClW4gSrm7m7MfE88HiuRS
	 XbGlJyPNqpDqg==
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Date: Fri,  9 Feb 2024 15:21:45 +0100
Message-ID: <20240209-distribuieren-semester-e0b28f6cd279@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209125220.330383-1-dmantipov@yandex.ru>
References: <20240209125220.330383-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=brauner@kernel.org; h=from:subject:message-id; bh=3f0I0xEezWNND8G6bTNtOjNioGpA0jEzstUxsqt7Bxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeM2W2Da1oP7Ay40uV8GPutxM/y21e57e6SlBNsvd3r pJ5Q4l4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETkgxkZpmqce7GQO7FyIksv y+r31lYPL394b+ybIHp4Q8fb3R5XJzMyvMnXlC/KjT/AHLt6UfMfabt/NQfmPdFM8g1zfOe7S6q eFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 15:52:19 +0300, Dmitry Antipov wrote:
> In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
> 'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
> https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
> where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
> https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
> as well. Comments are highly appreciated.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: prefer kfree_rcu() in fasync_remove_entry()
      https://git.kernel.org/vfs/vfs/c/f5f7ac72f4ee

