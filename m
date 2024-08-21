Return-Path: <linux-fsdevel+bounces-26457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2099596B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BE71F21443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD4188A34;
	Wed, 21 Aug 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlxWS6sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F31531D7;
	Wed, 21 Aug 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227984; cv=none; b=P0759f/6S9GoSGBIM+pPRyZ6aHhOQHPEBFkMc4gLSDeUKOZwcR76lSn9mqgt99RuRxsqu5n2sxWs80OvV/UVSQKdKSOcyBC6ga6mn2al3Xk8wEQkUjcPvOT+zltWORaLsqAkFuuBmSwHK1mye8EnluzqVO+1HW4SmvbcOqOVjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227984; c=relaxed/simple;
	bh=OKRSLZg7P9zOd0NxN52EI30tXAwi2KRvt/ZPHX2qB8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ1bDSD2qer2TVa5zLkX2U9TcIi/vyAQ8LiSFA3Ec7ackA+elx5kHMC0EO/JWGI43/mdSmcr8nbdgxrVCEpy60f7nJL62QmXAnBdYqJnDpcX9WUEHDJvVRJEpnTl21GACUhgMuos07YCkkFjfH1ocq5d6m9MvXrlXWB3Uve15PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlxWS6sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98055C32782;
	Wed, 21 Aug 2024 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724227984;
	bh=OKRSLZg7P9zOd0NxN52EI30tXAwi2KRvt/ZPHX2qB8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlxWS6sp8wEgcl/LayFmvliQREEx21Yx5r8ug+Ea7xOi/KbzBz4yWL+Kvsu1554vR
	 l7/80faymfhUkCyDgWb6dSvrwa7Jr9q8mREEk8WZ2Gb8hJ6c2eOenzvQxkucOJIHoR
	 Kt/qYNmN6+2ZoTjMrv4RdaMfsdFfa4ZpgysmD5/RZae0ucqWfv0OVgkfYn6pi26b4G
	 68RRHV4MuB5sOkl/0AJOB1QpL4NeRwBBshcpEKGT6P9I/iALsJ+suodG2sQJuHnZFH
	 wor/dT4G5nnIcdD5KN6iIy7zdMQExDRtZ1zdTlaaGJYyy8pPkseudRYgVZ81KopD5D
	 2eLK64mYnLcsA==
From: Christian Brauner <brauner@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/4] Squashfs: Ensure all readahead pages have been used
Date: Wed, 21 Aug 2024 10:12:32 +0200
Message-ID: <20240821-erfinden-gegeben-be787ce7eb3b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820232622.19271-1-phillip@squashfs.org.uk>
References: <20240820232622.19271-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=brauner@kernel.org; h=from:subject:message-id; bh=OKRSLZg7P9zOd0NxN52EI30tXAwi2KRvt/ZPHX2qB8o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQdXdjp+Ek16ld4euaZ2QwmIQ2XTlnJbvx72KnzgJAX7 7mplvs2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkEz8jw5/G+ZMPSjYc1lt6 vuzh/ugyz4Mi689sk7lUtDFvSvuJiikMv9k7TDb5/Dls0eaer3nP12GHcU35ekfFPnPLrtXuPWV l7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 00:26:22 +0100, Phillip Lougher wrote:
> In the recent work to remove page->index, a sanity check
> that ensured all the readhead pages were covered by the
> Squashfs data block was removed [1].
> 
> To avoid any regression, this commit adds the sanity check
> back in an equivalent way.  Namely the page actor will now
> return error if any pages are unused after completion.
> 
> [...]

Applied to the vfs.folio branch of the vfs/vfs.git tree.
Patches in the vfs.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.folio

[5/5] Squashfs: Ensure all readahead pages have been used
      https://git.kernel.org/vfs/vfs/c/5d85f9c952d8

