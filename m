Return-Path: <linux-fsdevel+bounces-66301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C319AC1B09E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B771AA4162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431A29B78D;
	Wed, 29 Oct 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDCCBZVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14E29E11A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745190; cv=none; b=Qdm6EdrhhOLnNY7tKlaE7tS1W3Ya0CXR5YmDLNX6GBCzFjWjrQn3LCIE250Uq+2AVcAKGhPW77Of/LN1232rSY41MIbetU48Pz1gKskCljJEf9RQy9BqRnKJxcgbNgPg634anma+8ipS/2e9n6lNqlIPrYV+JZRk7o7Pqv4EbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745190; c=relaxed/simple;
	bh=6sXCJvCvl07yNdH9KVsTTRPtKr+sGa5V0qf+fzFh0W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aub4GRgDrYbDlmV/7sk5rGU8ZdQJvGJi1V5DmjZrZXCQ/jWoQ/PFGhTfaocmZzyXhHcv/RNKYHjPpS4HVLFog8GQZar42JvXzxgEzG2CPH2h5uc5f7TIQXfZlHZgrXVKebM3dGs2YQ2K8I5gdDjE2GmekZaVQf+3k4Ghzn0NkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDCCBZVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D293C4CEF7;
	Wed, 29 Oct 2025 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745190;
	bh=6sXCJvCvl07yNdH9KVsTTRPtKr+sGa5V0qf+fzFh0W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDCCBZVYTGX8CyNxB3HHbJLVcYSe1bBLCFHc4TH7FFCaH5USbI7OuJo6itZdgbkMJ
	 2IHc9u9Su3HsVoKE6EqZR4G77ElTVmpKi1Vh2pY5dgpTKLaldVe6PGMp328TGl5gf3
	 MifUjAzM1QWbWV3e/8RIrJpOsBtZcMNV4XFZi/PUti9vQyG6HR+CsXoEEJXqjWR+az
	 aknwSXk9LCN80r3xaT1wNoQxH7JqYkL55/HJRxuPbc/yd/L7Jr+bLBSVtzX4epWpOE
	 G0sX2C7Ey+N+x3382fZniWJ/3Dz+9cQ63Ae15V8ds2ABZVHM5+8wpPMs9aouyooHnB
	 616KVLsVEXgtg==
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Tigran Aivazian <aivazian.tigran@gmail.com>
Subject: Re: [PATCH v2 (REPOST)] bfs: Reconstruct file type when loading from disk
Date: Wed, 29 Oct 2025 14:39:45 +0100
Message-ID: <20251029-abmessungen-bewohnbar-2ce651a69b82@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fabce673-d5b9-4038-8287-0fd65d80203b@I-love.SAKURA.ne.jp>
References: <fabce673-d5b9-4038-8287-0fd65d80203b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=brauner@kernel.org; h=from:subject:message-id; bh=6sXCJvCvl07yNdH9KVsTTRPtKr+sGa5V0qf+fzFh0W8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQySSr9mtFeGpXq81o6aupcKY1Ey5ppf14u294bOpHz7 uv3v397d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk9SZGhnY2+dPO5buZFxiZ vvz0993BNz2FUpwmoe/iS+/7RGy23cPwi/nuNgfDGbM5TvsHnFKdaKm8yWrDgu3H35RyPjzw6/n dJYwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 22:25:49 +0900, Tetsuo Handa wrote:
> syzbot is reporting that S_IFMT bits of inode->i_mode can become bogus when
> the S_IFMT bits of the 32bits "mode" field loaded from disk are corrupted
> or when the 32bits "attributes" field loaded from disk are corrupted.
> 
> A documentation says that BFS uses only lower 9 bits of the "mode" field.
> But I can't find an explicit explanation that the unused upper 23 bits
> (especially, the S_IFMT bits) are initialized with 0.
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

[1/1] bfs: Reconstruct file type when loading from disk
      https://git.kernel.org/vfs/vfs/c/34ab4c75588c

