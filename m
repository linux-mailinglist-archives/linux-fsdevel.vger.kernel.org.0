Return-Path: <linux-fsdevel+bounces-24590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22E940CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324CD1F21B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F15193069;
	Tue, 30 Jul 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqQ66qZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846018C325
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330042; cv=none; b=lJCuKlbPj0/UVP1Rmy5D1ynAXyDwIdE2TN8USpYcAGyiYSslG2jF6s1283ya0fRb6Xv+6H/59ANHNVXKI4Bqhki7m3MO/brlN/j+zF+GqfGcp+f9POLDuYWl56vHmopYVffpMEIaf1L07UIEoJM7oIa/ziIU2vyRE4UswBsKpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330042; c=relaxed/simple;
	bh=DIpTYwtWXCW8YUzekZU0UMx0Wgh4MfFRhN56cWwZnU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjVjqfzntvhUEa1/Zcj6Xn9LNc09DhjIq/vJScuoKvaSydC71GWwfhyHiUGILoF6B6fAD+YUnFFmbSRgg5zOi1TMQ3GM1ZZSg7Y0NUH/ZaWPtftaZJOCGCeMGtxnwyZNJ7nKbLz50eHXFvb/ScAkh5G7Lm+J15OpeQ6HJ13Tzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqQ66qZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC4CC32782;
	Tue, 30 Jul 2024 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722330041;
	bh=DIpTYwtWXCW8YUzekZU0UMx0Wgh4MfFRhN56cWwZnU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqQ66qZDP2Hl14RL0TkfChaU4eNvQKbF1dqaMLq26ABpZWMAMeKCJ4+VJ2wYNWFRk
	 vOpOFTogXARs52e26HlNrnsXayGX6qvJczNB6X7frkNWMcXPmirou6L5EuqMAmJ/PR
	 VrdCe8ziolUpathF2j2G1j5Dd1QYN5oyKPm9uYeXd8rXzEa6oldqc7tctUbr1sj3CG
	 d5QVyxI3spR2k7PmYC67R3B64viXT89MoQ1MfOoiijZutWTz57/7tYsGOEEiO6cCXA
	 i43vcRsyCCz24YCEVd/sxp7T5g0hwNt7mE2UHil5Ny0rJgIE4HeGhsZEnJcWaPwtqS
	 N+/+PlQruKIPA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Omar Sandoval <osandov@osandov.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] filelock: fix name of file_lease slab cache
Date: Tue, 30 Jul 2024 11:00:32 +0200
Message-ID: <20240730-gelesen-hebamme-65463a0e2488@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com>
References:  <2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=brauner@kernel.org; h=from:subject:message-id; bh=DIpTYwtWXCW8YUzekZU0UMx0Wgh4MfFRhN56cWwZnU0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStWL35oE/ipp3xTufj2mLTbF4U9JlueVqRO1Wr3Gavm jq/iWR/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERS0hgZVs53jT1q8lw98EnI xv8OSpYsTndO+zssbyrOFJ/F/eX1RIZ/uuJx6U3ba3ZUJM6bFs7Gs781KM06O3Kj4FNxwYXcL5+ yAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 15:48:12 -0700, Omar Sandoval wrote:
> When struct file_lease was split out from struct file_lock, the name of
> the file_lock slab cache was copied to the new slab cache for
> file_lease. This name conflict causes confusion in /proc/slabinfo and
> /sys/kernel/slab. In particular, it caused failures in drgn's test case
> for slab cache merging.
> 
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

[1/1] filelock: fix name of file_lease slab cache
      https://git.kernel.org/vfs/vfs/c/af1e6ab8c0e5

