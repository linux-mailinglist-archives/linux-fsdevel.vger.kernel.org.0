Return-Path: <linux-fsdevel+bounces-30939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E598FDC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0602817F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB8139CE2;
	Fri,  4 Oct 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k11QLPld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496A13957E;
	Fri,  4 Oct 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026707; cv=none; b=F73/+zu4V3ZbDknBWQJssarQhtX5ESGZpwZrTFs0K2gGl762dwGIRIrUJVmHC61hWlfGCkusdrYJvkhHG5Rr0whM30nfSJHwXFk1JOSmwV6f+a6wAqBIXzm0dJakHnazUf3lFkE8p8p9Yxq7z65w4TxZ1VEAB2pPgNUAlY4jNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026707; c=relaxed/simple;
	bh=ox0/7qp/2Dq4kEyBgTZRN6pkZoZOR57GiIeS/LuHzc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW0Gnd4Bb+3gVyhU9RIkOJH0rAvFXt88HNlnvqX7/t0I/pybI0U5BgPasbBMeSEnZAkVjvCodbZSF1XvlEoyAJQ8pHde8mpI+jG3+e7NtHZoAy1wX5bUOf4kgVu+H3jLyNkD0TJJcdzjQX/0f3vMjK3PUfkQqMsaWsGfWlpbofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k11QLPld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26267C4CEC6;
	Fri,  4 Oct 2024 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728026706;
	bh=ox0/7qp/2Dq4kEyBgTZRN6pkZoZOR57GiIeS/LuHzc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k11QLPldqRmsJfEq/SOtT1cY9NkV8rs3UgsRKcjz5E+0HUxa2tRZ0UIus3UdoZlsq
	 yzHvO28pBUhgf2KkGbA5+F4QERLx7oVaPKrpUbm76tFhxXdTmSt0qmgdaDXkNf6lNg
	 8IYB3R9KOjnxKBiTbeEhJH3yJqb59HhCMhZr4bJze/V4xTwiZzj+gwE0IYYIUTxBzO
	 WsRnEV54bUIDOByhgyE75OPSvKy7eD0lwXjM42PhEdyP8E/Cpv4DREd0fz19qqLrjV
	 bRX1P2EZNbKr8E8GcW0wn5pzUlpWvWb1WHrrhb7Dom46H7G8/MjKYI09vDhXaH5WET
	 TkBmI5gkL/wUw==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/6] Filesystem page flags cleanup
Date: Fri,  4 Oct 2024 09:24:57 +0200
Message-ID: <20241004-witzig-eisern-e47b5e26031a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002040111.1023018-1-willy@infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=brauner@kernel.org; h=from:subject:message-id; bh=ox0/7qp/2Dq4kEyBgTZRN6pkZoZOR57GiIeS/LuHzc8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9n+HNkSV9YNpxw4l3JC4wn+CwVhN0WPYtv61PsG2y9 HlhzbuSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5Y8vI0H6H5XRKtVdyeKDD 4S/Sk+QX8nGerxc/IVr8PY99wZsvXgx/OBO4xSa8Mqo0ZtVPr+K+ONfTacf9bVtUlZtKD7HcvP2 aHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 05:01:02 +0100, Matthew Wilcox (Oracle) wrote:
> I think this pile of patches makes most sense to take through the VFS
> tree.  The first four continue the work begun in 02e1960aafac to make the
> mappedtodisk/owner_2 flag available to filesystems which don't use
> buffer heads.  The last two remove uses of Private2 (we're achingly
> close to being rid of it entirely, but that doesn't seem like it'll
> land this merge window).
> 
> [...]

Applied to the vfs.pagecache branch of the vfs/vfs.git tree.
Patches in the vfs.pagecache branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.pagecache

[1/6] fs: Move clearing of mappedtodisk to buffer.c
      https://git.kernel.org/vfs/vfs/c/9c33d85e34c2
[2/6] nilfs2: Convert nilfs_copy_buffer() to use folios
      https://git.kernel.org/vfs/vfs/c/a38117bc0de6
[3/6] mm: Remove PageMappedToDisk
      https://git.kernel.org/vfs/vfs/c/a04d5f82fa38
[4/6] btrfs: Switch from using the private_2 flag to owner_2
      https://git.kernel.org/vfs/vfs/c/a6752a6e7fb0
[5/6] ceph: Remove call to PagePrivate2()
      https://git.kernel.org/vfs/vfs/c/fd15ba4cb00a
[6/6] migrate: Remove references to Private2
      https://git.kernel.org/vfs/vfs/c/7735348d9f3a

