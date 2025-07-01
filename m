Return-Path: <linux-fsdevel+bounces-53465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D0AEF4AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F04A34D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA99270551;
	Tue,  1 Jul 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQfhlrM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A691DF73A;
	Tue,  1 Jul 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364799; cv=none; b=scS6kzgQK/U3LG4ToukCsjyhVw2DdzuACmLM1cGu250aLdiNhfx8KTNOIZgg3DJKxtCXDkz1mu/KOPdQX9EFWfmaHia2/B/77IlyMglWeOYaat6gqiN7rpeHVSvpgN9QzjP3XoByVKR1UCAVk2jAl3X65sUm3TTStN5a2HBlU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364799; c=relaxed/simple;
	bh=TEMonp015D51LqvvTvGwKgPLEymL9NHIJMLfJIT8Klw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W11REbBWUzaV+kSNvR6PWcovJpMuSp1Iwk5AtFUEWTt8M/ffCXJTNDcqK40tFrJrCtWlN+r0p0fgGPfjaGOES83c9bYTi1O0ptAJsHj5G0ss6nV75GtGCF5jBtwVn8agFk747SmJgqC/XFalEqwxPm180K+ImkZ3gj55kt89h9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQfhlrM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C4AC4CEEE;
	Tue,  1 Jul 2025 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751364799;
	bh=TEMonp015D51LqvvTvGwKgPLEymL9NHIJMLfJIT8Klw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQfhlrM63ddLxRAXWWPz57hu9kh2f3FDxtgMDohsdsOxj/qhkvorMEr6E3TPyoqvC
	 /fuep2fvjcYLotitXHEeB6haOkbmOlwimnJ6DE+8qW+9G1/5KgLVIqSgxvi5bm91bD
	 8JVQIAqqIUakfZvGX4fCnqiCid9WrbgnBNRPxShpUOH8t7BPsT9qPPQOM94XC3CKTU
	 tZP19sQvcU7hhsUzCtwnvcxjv1IoVNxWLlaZq1prhpCw+yQNxNXA3WuY8VIuXhrs5G
	 iBSnRWHpdRBeOY5ZT2YUWr+Fsh+OtOLe0ncHsm0Gbf1Yzf0NR6tXk0m3D6ukvBkSKX
	 qCAN5XTsAgbqQ==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	akpm@linux-foundation.org,
	dada1@cosmosbay.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: Prevent file descriptor table allocations exceeding INT_MAX
Date: Tue,  1 Jul 2025 12:13:07 +0200
Message-ID: <20250701-produkt-eulen-69bd80b6d1d2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250629074021.1038845-1-sashal@kernel.org>
References: <20250629074021.1038845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org; h=from:subject:message-id; bh=TEMonp015D51LqvvTvGwKgPLEymL9NHIJMLfJIT8Klw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQkb9kpZq9Q1HFsS2hb/sv2zIuvz9gFtvaIX07z1rz9o FKqIupVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETU8hn+p88y43sv/bXM+8H1 LZ/DuLYK+lW3bfokFq5druPLMD2wi+E329Y9cglHVn+y/5ASs2BCkWbplR3+n7zWP//gfqP4aOA JfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 29 Jun 2025 03:40:21 -0400, Sasha Levin wrote:
> When sysctl_nr_open is set to a very high value (for example, 1073741816
> as set by systemd), processes attempting to use file descriptors near
> the limit can trigger massive memory allocation attempts that exceed
> INT_MAX, resulting in a WARNING in mm/slub.c:
> 
>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs: Prevent file descriptor table allocations exceeding INT_MAX
      https://git.kernel.org/vfs/vfs/c/c608a019c82f

