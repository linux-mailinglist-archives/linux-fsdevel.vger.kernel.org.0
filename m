Return-Path: <linux-fsdevel+bounces-67878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F4C4CBC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C9D188A795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C212F25FB;
	Tue, 11 Nov 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V72njAGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2E221FBF;
	Tue, 11 Nov 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854128; cv=none; b=QJslxRnJ3y4kd6yi/56e4vqXb6DOYVyEjYD6V54x8G6nWmLsBP8YaLHhZN5krdwVqYLxb22VTE5T4o8LLJ3jOYtrb5263f30yNo/yt7Rbemvap8YZVD0x3W1OM8fnnZsNQIrAcc0pILXVeJbNCaHS5dZJ33lxeQ111lnz+cqJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854128; c=relaxed/simple;
	bh=nkOExo96s2hxfPSIrdzXcnwfH+qx2wZ532PcFs6PPvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvFyxIpz+JVq8IKhexArd+PgaPCabz0HPoiLoVB3GgmlUYu9sbNHVI0CNZn6RUggH3MbI8ypl3QMEo9CMhBtV8R3ldYNZAkmJgGkFaZs9+gG4Dwy0rF3euGT5u127FZPbzv5VtJv0HnXmqx55nq+pKyimFfSHUUhNw9Ua7IE4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V72njAGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD98C116B1;
	Tue, 11 Nov 2025 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854128;
	bh=nkOExo96s2hxfPSIrdzXcnwfH+qx2wZ532PcFs6PPvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V72njAGQ7zSNksaeixnxUDvKYSEgW8nxnTX0Kaduk8lrHbDyBtz/Q+1esA5yp5Qes
	 YD9vwmVs6H3oLlQufPxVG3UBan/BJfjbl9R9l3wdcasOYKougEuZQm+xDPaJx+BtVV
	 xqUI7DMSDvs7wPFBO2ASL933FuyP+eVgacn2IzpqqcfXJT8XdeFPZ0xNLsvjkKeqdO
	 r0d3Tc2yPq1jhxPd9VYp75WOoP6AIyFhUKjIOgAxS2hQNlF/pcI9WtDyumz0m5+JfA
	 6qCMj5CeA8Ua3cne5Wf83GoiVA84LOkyndS25KowkIvMlvtpGHMhhaGY74Q3D4fVPh
	 /wIAae+rYz3GA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cheaper MAY_EXEC handling for path lookup
Date: Tue, 11 Nov 2025 10:42:02 +0100
Message-ID: <20251111-brillant-umgegangen-e7c891513bce@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=brauner@kernel.org; h=from:subject:message-id; bh=nkOExo96s2hxfPSIrdzXcnwfH+qx2wZ532PcFs6PPvs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKs7yOmLn4h1rdtr3zjn3WPy4euS9vC7/NT2lDdqWG5 fFlTPFTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay7xfD/3TDW9YRpcePF6QW X5W8bPd8m/fqtJbpyx+z/uA4VbCZU43hf8KPwK/qdmIzXv6pupPwO3Zjzbw3kRKr3t+X2Dd7yRu xclYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Nov 2025 15:21:46 +0100, Mateusz Guzik wrote:
> Commit message in patch 1 says it all.
> 
> In short, MAY_WRITE checks are elided.
> 
> This obsoletes the idea of pre-computing if perm checks are necessary as
> that turned out to be too hairy. The new code has 2 more branches per
> path component compared to that idea, but the perf difference for
> typical paths (< 6 components) was basically within noise. To be
> revisited if someone(tm) removes other slowdowns.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
      https://git.kernel.org/vfs/vfs/c/5ecf656231cc
[2/3] btrfs: utilize IOP_FASTPERM_MAY_EXEC
      https://git.kernel.org/vfs/vfs/c/d0231059c7f2
[3/3] fs: retire now stale MAY_WRITE predicts in inode_permission()
      https://git.kernel.org/vfs/vfs/c/e3059792dec1

