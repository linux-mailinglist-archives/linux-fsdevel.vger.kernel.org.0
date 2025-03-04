Return-Path: <linux-fsdevel+bounces-43052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD00A4D6ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6B7172F20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857AD1FC119;
	Tue,  4 Mar 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC5yp1rO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5E18A6A9;
	Tue,  4 Mar 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078045; cv=none; b=QBbtx5XKFAO4v4ThwA0X7vPyAEOQWC9G05/4wENOgwSu4TDzbNyTn8rBwW1LCdah6JFBtsWL9ypDshUehu5BnIg1mb6ZE3CMV91SU0Z+FOzPWVYR0Ey0d+fEUCmJ5JbKc/INFUOzxGvLxvexQ1F7MX3caeKIS/wOBJI7bUh0iH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078045; c=relaxed/simple;
	bh=LJssublaZF16iNMJ5WdKqWXeSC4uPRdKNU0G/ZLZXvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMbY701BEGrS/D4UxUqu6oRD6JLjpZ91k84SOAB8zmvYq0nCZcm8eSozbTgPCtITHlhQ4c/HITNTnTY/zrhfEldqHus9argpfCeObfIAoEZ7gw7pp/U7QdEEdolQdNZKp+BwVy6bkJGtHou71SOQY92qLlG0Sp4rwIlv4X2qznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC5yp1rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC59C4CEE8;
	Tue,  4 Mar 2025 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741078044;
	bh=LJssublaZF16iNMJ5WdKqWXeSC4uPRdKNU0G/ZLZXvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tC5yp1rOPuFzVA+shdX1QoFQ56/twvdPTBHD7hqYgd/igv+x3WsjWujkhbA79xjcT
	 Zw0ESOnLYvJ2s2xT93/GqXC87aglrTxct+CF3N465nwgEMARs+/3EZtODxLuE+Q02w
	 N3E9iJWTLpEvCVBvL5bTqmo1UVrKWTukp9zaApJTbSdAYF/YVdfHCbW36B+OpzcmoU
	 ANpe9IMsSxNtg6c/6tee6D/OWBsaCQiJwGY2jSmkOxQR7Qau1rIiBFb5yjxBfv+rQy
	 tq5415eJmvge/tnjoSMmramBBthP9VgPKfx0VIZMeZWXi2mIK2bgheOnni91rvlSEE
	 KNsqulmkAGIKQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>,
	peterz@infradead.org
Cc: Christian Brauner <brauner@kernel.org>,
	oleg@redhat.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 0/3] some pipe + wait stuff
Date: Tue,  4 Mar 2025 09:46:46 +0100
Message-ID: <20250304-respekt-zuwider-dfe23f0f5027@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303230409.452687-1-mjguzik@gmail.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=brauner@kernel.org; h=from:subject:message-id; bh=LJssublaZF16iNMJ5WdKqWXeSC4uPRdKNU0G/ZLZXvM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf2yda4Hj2WNblIzXhl3/LMU3Z3X365afLnzZFBKrkN HoyBKpe6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI8z2Gf6bSse1tnofLhMK8 bzuxfmOKlxD59WUxQ7bAPUsNRwvzfIa/QhHaR5L6vV8HTgtimVguc3WH9ot0bjuzhn8SnHkW1Tu 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 00:04:06 +0100, Mateusz Guzik wrote:
> As a side effect of looking at the pipe hang I came up with 3 changes to
> consider for -next.
> 
> The first one is a trivial clean up which I wont mind if it merely gets
> folded into someone else's change for pipes.
> 
> The second one reduces page alloc/free calls for the backing area (60%
> less during a kernel build in my testing). I already posted this, but
> the cc list was not proper.
> 
> [...]

This looks sane to me.
Would be good to get an Ack from Peter on the wait change.

---

Applied to the vfs-6.15.pipe branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pipe branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pipe

[1/3] pipe: drop an always true check in anon_pipe_write()
      https://git.kernel.org/vfs/vfs/c/a40cd5849dab
[2/3] pipe: cache 2 pages instead of 1
      https://git.kernel.org/vfs/vfs/c/46af8e2406c2
[3/3] wait: avoid spurious calls to prepare_to_wait_event() in ___wait_event()
      https://git.kernel.org/vfs/vfs/c/84654c7f4730

