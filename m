Return-Path: <linux-fsdevel+bounces-42896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BFA4B15D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D72F16E07B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA01E1C09;
	Sun,  2 Mar 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D60Ysl43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C54C85;
	Sun,  2 Mar 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916930; cv=none; b=RLMPDyJTo9kj0nrI+B/keBom3F/W7X26/30QD+1wTE3+iydjDUUmT1h+2QOqsexdn3slpemH4Hn5uUfZSfH8MWtYECABmwZUSsa6Vv4iOkIjYi00T2iECapvZqYOyAZy3qJRlpkN/6ObIShOLZ+fiX1gvzihj/baWyp9+Jlgpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916930; c=relaxed/simple;
	bh=Y3d7CHbHk2BzsQCQyKY7Nf+rLRsp9ec6zmoDZApfv5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmk1gxo/5c1HEwdPoayYAfIpBa2C0PV9K+A0CusZHViemMiJxxO2U6os6JBg6WnzP5/ndjaLujpvcW4cV68Nk6/0YKZIgqPb0gTMUEgwW0aLjgHyJSPDB8YKVySui5Mf0WiMBrAYchv1I7g2a32JtidvCXhy53yYPP/oSyn4QOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D60Ysl43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD480C4CED6;
	Sun,  2 Mar 2025 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740916929;
	bh=Y3d7CHbHk2BzsQCQyKY7Nf+rLRsp9ec6zmoDZApfv5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D60Ysl43z/0MKvjnd/kbCdNYe6NrWnRFmZbjOK3suODd78knB62P0ORUyv0oLDdpJ
	 qUuG/maYghNwJ3GdpY7IjGWpOE6b4SFXyaXMgP7SFbOTEYIsTAxzVvYbgkDaMmxZnp
	 13w5oeoQzNO3GW8+tg4GrdRniSqji79FzCNlnbsl1Ez6/cL6n+yv4Qj5EqbrVPQTbJ
	 itcpBjpNGuBtoGcpxpDJB1C110C98H1ZVdKu/R8Z2c3k0VHrrHEU+rQWcwqHZPGl77
	 cUT55K9a0Dz87bcAlrcXZG25gDWSXvqMuTQDdWo67UMqG+yHvxidqCliBtyTDbJIjM
	 Q8f5ek4NklFqw==
From: Christian Brauner <brauner@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cred: Fix RCU warnings in override/revert_creds
Date: Sun,  2 Mar 2025 13:01:49 +0100
Message-ID: <20250302-fazit-pillen-3e7500ee5fbf@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Z8QGQGW0IaSklKG7@gondor.apana.org.au>
References: <Z8QGQGW0IaSklKG7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=brauner@kernel.org; h=from:subject:message-id; bh=Y3d7CHbHk2BzsQCQyKY7Nf+rLRsp9ec6zmoDZApfv5k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf8dhdezhrevDz3Avu7jMnBAmKrli/hXP+7Dj1a4l7i x862qfad5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk2EFGhrtBoqt+lHbvtnLh 8rx9RrfcwH5mXMlLO76fN92UJp8O/MvIML0pU0HZl/HNTY0+DbkdZx7cXZblxXrzzZcbt9+vSi3 pYwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 02 Mar 2025 15:18:24 +0800, Herbert Xu wrote:
> Fix RCU warnings in override_creds and revert_creds by turning
> the RCU pointer into a normal pointer using rcu_replace_pointer.
> 
> These warnings were previously private to the cred code, but due
> to the move into the header file they are now polluting unrelated
> subsystems.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] cred: Fix RCU warnings in override/revert_creds
      https://git.kernel.org/vfs/vfs/c/e04918dc5946

