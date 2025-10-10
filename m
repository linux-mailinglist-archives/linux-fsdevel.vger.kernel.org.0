Return-Path: <linux-fsdevel+bounces-63752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95336BCCC73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C098B4FC516
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E02EE5F5;
	Fri, 10 Oct 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9WPTwy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A81FA178;
	Fri, 10 Oct 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095772; cv=none; b=tC1/3FIX3vE4UwTHg3nmxb0f0BdmX10yCurWcZXGULTODDIY7PkYhd31LraniDMsnlrDqi72cJ10XrwFmPKvaA48lkOVRGWtNVGNGP0ZEg0j/+2NE7xBMHjIfTTbPYM2cWUK40N+evNHxwqQqaEQACawTmvFp+MrWpc++aDlCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095772; c=relaxed/simple;
	bh=9iUazEeH838HwxGqjDtvMsozzJM3gRqcf39FT96xPtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyAn+tW/sWqYgD/ODCtJAcFlZV7H8Yf9OHzJDO33PxmTn1EFkrUooNUnepVfjcKPkR7ttBDMty6pQZjon0WwgjrY1EZwxfikyfJLjAVF3p7nLLVYqzxApOj2EExUAg8IrsDFGs2wfVG5UVpvQz7neK1U7mWVn6kIpTGVq61530M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9WPTwy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5952C4CEF1;
	Fri, 10 Oct 2025 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760095771;
	bh=9iUazEeH838HwxGqjDtvMsozzJM3gRqcf39FT96xPtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9WPTwy67jViEmKdEuSwSQCzfx+l8BsEyCm7MScArrgwoeeocq2SMofxYVHaijgoq
	 2dVV9+FwJPTKXIJBMWchgq2D082vw010EwqMIT8pbWOHm1G62iHfNNrXr12Kn5yJsB
	 oNHqYIi4sN3cGH8/qp+UBTKD37Jww6Vcj5Q94c8HmCNk93H+UanI6sPcmcfLJ0/5P9
	 Yoq3yO2LUglqvbLVeAyhekz55hW1t3pKTf5obc2cCp7BHIPrCdQoiZ2RZpw60VtKcJ
	 Pq8fqO6GYchCSUliwcOMKjfeV+8WRpzBTYobYK1VENq4oHk+MF8LqGhVxQXtbxl8JS
	 vHxpQA98y9ByA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 00/14] hide ->i_state behind accessors
Date: Fri, 10 Oct 2025 13:29:24 +0200
Message-ID: <20251010-kneifen-klarheit-0c92d1d8ab01@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=brauner@kernel.org; h=from:subject:message-id; bh=9iUazEeH838HwxGqjDtvMsozzJM3gRqcf39FT96xPtw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS8eCcadDug1EQ+6nI1x5PVTeI7ViasmFXF3cPVs+vf9 pdTJ6yv7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIwiyG/4FPor5zMhjKqtbZ ZUi9+3c/jmlt3NK9/Hvz30S/FzRW7mFkeHH6xhPG3+8v7ZPbdOD6kd+3v/2K0W6Nk/5h3flMMHY PCycA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 09 Oct 2025 09:59:14 +0200, Mateusz Guzik wrote:
> Commit message from the patch adding helpers quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> [...]

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[01/14] fs: move wait_on_inode() from writeback.h to fs.h
        https://git.kernel.org/vfs/vfs/c/6605bf7d9536
[02/14] fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
        https://git.kernel.org/vfs/vfs/c/1fdd36da49d5
[03/14] fs: provide accessors for ->i_state
        https://git.kernel.org/vfs/vfs/c/1f4e908f28da
[04/14] Coccinelle-based conversion to use ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/91d75e00d68f
[05/14] Manual conversion to use ->i_state accessors of all places not covered by coccinelle
        https://git.kernel.org/vfs/vfs/c/5b953be62d20
[06/14] btrfs: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/b77405952757
[07/14] ceph: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/9e121446182b
[08/14] smb: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/6f44aedc8692
[09/14] f2fs: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/60d14a5b26e3
[10/14] gfs2: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/8b5a2dbef579
[11/14] overlayfs: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/46ee05af3842
[12/14] nilfs2: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/ff6d2b3d3473
[13/14] xfs: use the new ->i_state accessors
        https://git.kernel.org/vfs/vfs/c/fdbb1cb57675
[14/14] fs: make plain ->i_state access fail to compile
        https://git.kernel.org/vfs/vfs/c/708bcf48adda

