Return-Path: <linux-fsdevel+bounces-54931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3AB056F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D4E3A3F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BE23BF83;
	Tue, 15 Jul 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujHlnNAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7A2E370F;
	Tue, 15 Jul 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572779; cv=none; b=ogfKtRXu9QwP+ienAs5IaZ1j3+uuejw2B5RWRbvFQvNr4zkFnQAk8R+V+iU28tC7YYlwX7TyzUyhPakHiE4OFu51B9QpWbBh8BUm8lA0CZfjx4OXNafmABXWEFugRryZ3cprY44PspHTpzVLobQHulBPD4PeUo4Ph1kTphDrz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572779; c=relaxed/simple;
	bh=DvMn1+kJJS4mpkjItuPNort/35ADM97sjbzMmBt+yVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUnNSwlI77/DHk6I60OmCi9J4SOM3S3pMN41YRr1c9lyy5Z7DBIMUE1GlogS4G61E18rgHFDgkeG9MEqlaTFTLPeHMywu3gJfVNJEN6QpdbM38f3HEMiYIvJot/VTKxE2g0icwJbLxdgPtF/k6EyjnuKzXJgnKK759frfxE+2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujHlnNAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E109C4CEE3;
	Tue, 15 Jul 2025 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572778;
	bh=DvMn1+kJJS4mpkjItuPNort/35ADM97sjbzMmBt+yVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujHlnNAUGAUBBmAQ2om1XEiIXT2BUbn8lhue6BT4jHyYEWNkDlZp0w7Oba4hDhqj/
	 VJPclQ8cVxb/G5UXM2gjQ4XafiyskWyaT9esy6NGjYQOqyD2/LRJDe1CG2cpTxkDHM
	 +mvyghWhiQ/bOSW7n7MXq53CJ5qBU+sawg5bbONf+54Q35GoAgHSRzOIJTdaATafT/
	 LbSkBoeGWEHM9JUPMK996Nn8tB5BWswme4PQ+9Q6HyL1C0G1FNrct3seJmn83Y0GXG
	 Jl3iCK+/XhMHFoGYOM4BdXEMQ1lnF/Pv+6Z/NobtOWN7mmCNcREeD4kv8qxh6ZWlzy
	 mh/8CP4u0bEpw==
From: Christian Brauner <brauner@kernel.org>
To: netdev@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in unix_open_file()
Date: Tue, 15 Jul 2025 11:46:12 +0200
Message-ID: <20250715-pikiert-hallt-0a1a163a6872@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250712054157.GZ1880847@ZenIV>
References: <20250712054157.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=brauner@kernel.org; h=from:subject:message-id; bh=DvMn1+kJJS4mpkjItuPNort/35ADM97sjbzMmBt+yVI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUKaf6vq5r/Fj98qUcj/bRxfJJJw9q9MqlsDXtq6gQ2 fjkAK9dRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET27GFkWPztg4rCn3t5btte 233iPfA+vyg+0IH/1Z5ZDudWvbKKkWZkuNqx7c+iTvPXamy7DVTiw3Zw/Sl4s+Jm3wHx2g1PGMq 2cAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 12 Jul 2025 06:41:57 +0100, Al Viro wrote:
> Once unix_sock ->path is set, we are guaranteed that its ->path will remain
> unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
> does not modify the path passed to it.
> 
> IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
> can just pass it to dentry_open() and be done with that.
> 
> [...]

Applied to the vfs-6.17.pidfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.pidfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.pidfs

[1/1] don't bother with path_get()/path_put() in unix_open_file()
      https://git.kernel.org/vfs/vfs/c/1f531e35c146

