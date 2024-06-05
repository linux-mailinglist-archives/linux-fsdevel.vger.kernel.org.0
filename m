Return-Path: <linux-fsdevel+bounces-21053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16DC8FD193
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62121C21FC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062E481B3;
	Wed,  5 Jun 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxSIBGH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE619D8A2;
	Wed,  5 Jun 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601169; cv=none; b=jIbL/8eEphguyO0orUznfK/1fk+1/0PRDFfKsnx9CV1pk1Mc/QR8zaQ1nF21eAOKi7FHyDZvh6FhAw8DhqrUBtHiRLUedUzgc2aVweJvaAW4EfVpILcFfkDdjDPgl9sRGr2l7SIWPq8g39RP3ZP6IjJr2Q0EnGrPNwpobfuL/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601169; c=relaxed/simple;
	bh=jZnPdnaeLmJO5kHuCGrxoXWrDPQ+XKI6fsrjEvqiiVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=envxarqUcZfqVGrB9+dGgaMABhWCNCwDfbv+5D0T3vCYTnIBjTUtBLLtgK1uMTWvEZioRgbW3Uc9jqY/YFYzcx6oeRn99TdvhYLTdVc1jO8p5tqGD9s3I4t/zX9529UZjgJmQZ7pwBQ0IdeQvuQ+ZXzyaG/4vgzsQQ1zhEa0XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxSIBGH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADEEC2BD11;
	Wed,  5 Jun 2024 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717601169;
	bh=jZnPdnaeLmJO5kHuCGrxoXWrDPQ+XKI6fsrjEvqiiVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxSIBGH6rRgGrOvWHVda0jAQp3yhRM782xGt9XMZcSl7d0ZA1lIizB1m02OTh41lU
	 OrgAkmc26Q+hlkecOcTIdgf4h0DD7g3Qf8a9CiHFwye67f6dMi24jzxoSljrTYTDqg
	 FF3vy/uyk7Hbv2d1UWIxVQyN/cSjKma5vY9TasiN9eLBbGHOdp3g0+C17YonBncNeQ
	 4z5CdS2uEe3o+SrmoXZ1adaCx8EVoK7FzIYJiEcRFdT6IupN2Lyutk+jkCaTew7aMI
	 6G0NQWBVJzAuF/rcttJUUz1NJttM7PHuB332ybK/OXHgqyc27x208p9iQL2n8igUVL
	 rGoril+oaHeIA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] whack user_path_at_empty, cleanup getname_flags
Date: Wed,  5 Jun 2024 17:10:03 +0200
Message-ID: <20240605-notation-rausnehmen-c4bd0c38f994@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604155257.109500-1-mjguzik@gmail.com>
References: <20240604155257.109500-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=brauner@kernel.org; h=from:subject:message-id; bh=jZnPdnaeLmJO5kHuCGrxoXWrDPQ+XKI6fsrjEvqiiVA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQlNLf5fI6WunTQXPrVzJ7D7z+qPG30nKiW3nC/y2zSA qMP50JedJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkfiEjw0OHuokvp7l8dRCw /t3r4uaVlpa6+IR8EpdDzkcBoZIlqxgZru84+TJkoc6z+dZ1jSvlHk1ew6h89t321bVpQuqptql bGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Jun 2024 17:52:54 +0200, Mateusz Guzik wrote:
> I tried to take a stab at the atomic filename refcount thing [1], found
> some easy cleanup to do as a soft prerequisite.
> 
> user_path_at_empty saddles getname_flags with an int * argument nobody
> else uses, so it only results in everyone else having to pass NULL
> there. This is trivially avoidable.
> 
> [...]

Snatched with some minor changes unless I hear complaints.

---

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

[1/3] vfs: stop using user_path_at_empty in do_readlinkat
      https://git.kernel.org/vfs/vfs/c/d63b3a67520b
[2/3] vfs: retire user_path_at_empty and drop empty arg from getname_flags
      https://git.kernel.org/vfs/vfs/c/a01c264715dc
[3/3] vfs: shave a branch in getname_flags
      https://git.kernel.org/vfs/vfs/c/12a8c8f491b4

