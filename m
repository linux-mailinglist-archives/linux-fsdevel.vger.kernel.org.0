Return-Path: <linux-fsdevel+bounces-73209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF80D11B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BBF230D4D21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF114284898;
	Mon, 12 Jan 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCTcu5/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219027466A;
	Mon, 12 Jan 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212099; cv=none; b=WsgaJWllAdUkd5u7RI2VC42NyoDFTpn3U1Fjc7/RaR/bqGfyhHYWqS8QeTe9P6sPQ7PRV5KaiXonN3Y79W6qLX3je09B+d+29Pgb21C+Cku8NpxZCJqYuYUTDOlmiklowsgEgfJIMdOM8D6SSWM9ciAfdifnfp1RTXmbiQ1r7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212099; c=relaxed/simple;
	bh=Bz3xndiMP4BQIQ6moWWFi6uBvCwfpxsKpvU5r6BexFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iz545Hh+H5lQl1NY4xIXS+1TJg/fVf0XuaH6TEFhh63SCI/WM8vcsy62JmkZttIkmoB92jt9rNOgqELPIfL6APaqTB/mY214/RdPQKZ2piOT+bOzPBmyJ95bWXaI/AYK7jQ2G7WqLgsKzZpYn3+ukwRCDZcKoT3g7WWf5xDrgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCTcu5/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87E1C16AAE;
	Mon, 12 Jan 2026 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212098;
	bh=Bz3xndiMP4BQIQ6moWWFi6uBvCwfpxsKpvU5r6BexFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCTcu5/OnPyTAledN+w8nuP+qun+tBhwLCvhqTan03znm8dWJU2jQaiqRQ+dTH+Mh
	 iN9rBbO0Gs4dVhvpsAbDNlczGFvef9UTrqtpAxRihHaZLcLRSni4xO/dfGf2m+qe1n
	 dDdNASR7XRQCQkQe0dL8FfCAI7QMiJIoI8RpyEK6DJSZdOJ8TwgI6qu1u+7PAEqLIM
	 nHAQ/rRpwkjLB5VHrBiKaZdoIOSmVULZ8szqoQMacKXIBiD+3aVGKFco2McoSx1qoH
	 ffOnVddAB0FPz8WqmOW2biD/2YCIvX4Fgq2QFbYPKsTfKNSDOpeNHgddYPPSX9BJZd
	 f2FNjBPUPKV1Q==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>,
	Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	rostedt@goodmis.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] device_cgroup: remove branch hint after code refactor
Date: Mon, 12 Jan 2026 11:01:33 +0100
Message-ID: <20260112-oberkante-zugverbindung-acc5585e7e60@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
References: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=brauner@kernel.org; h=from:subject:message-id; bh=Bz3xndiMP4BQIQ6moWWFi6uBvCwfpxsKpvU5r6BexFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHKt7vLxG2yk5YqNDVn3ADS0LE57CmJMxF2rqJF8fm lv8UWR1RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQu/WVkeGW0LaV++a1cke32 jufOu8QxHRNe5Z+p4qoTd+bX5uCz4Qz/c6Zr/86bsyY/a6fvpB8SS2Vusp9Zds5jwichlR5X2// czAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 Jan 2026 06:06:36 -0800, Breno Leitao wrote:
> commit 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the
> common case in devcgroup_inode_permission()") reordered the checks in
> devcgroup_inode_permission() to check the inode mode before checking
> i_rdev, for better cache behavior.
> 
> However, the likely() annotation on the i_rdev check was not updated
> to reflect the new code flow. Originally, when i_rdev was checked
> first, likely(!inode->i_rdev) made sense because most inodes were(?)
> regular files/directories, thus i_rdev == 0.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] device_cgroup: remove branch hint after code refactor
      https://git.kernel.org/vfs/vfs/c/2a255acce2e5

