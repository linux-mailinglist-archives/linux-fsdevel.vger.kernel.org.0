Return-Path: <linux-fsdevel+bounces-46259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FDDA85FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C52B9A3134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169F1F12FC;
	Fri, 11 Apr 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjGwgNWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749511DE3AD;
	Fri, 11 Apr 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379840; cv=none; b=chksWaUGaBR2gO0PvpnSrIAGkt7/e/4WDAmwH74WwB58tSCtsVF2QqdN7SsV0/tBskOjhA4kcF5y91ksA3uh3JuG1tRTK/4e6yIySddMl4EGifRqnHTgEsFTG+sFwwOo+1lg8ZqNJK4ZSOMSJVTLipQWXketZwMRS+DFn9q5ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379840; c=relaxed/simple;
	bh=U3q0YH9UABshfZ8DUJHHyezmfDdHh8a15wvB6pQwvKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0JA+SouY+MaLBCnSotk8GoeExNzA63b0xB0lcO1quP063pV4fe+TTfITQJq9s76kOtSXam/eLTik3hBQ0Ev70MRscUxxZVwDJclSj7M/VA7Z7zUN7BWxJQWaISfHcSLZaJih4JoHWutVDG7L5QNkTzPhHEiQaoc6bpnasvI8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjGwgNWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F932C4CEE2;
	Fri, 11 Apr 2025 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379839;
	bh=U3q0YH9UABshfZ8DUJHHyezmfDdHh8a15wvB6pQwvKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjGwgNWpLqKXJ7hxrOOKyBiP4jfyg4aSH17c6SY7YXbTNsW3gck1hVnsYlbjf0s27
	 96MrP2z/YMKmfbl2DmNlJ3RlfjnS9dIERZIho2fPOVfzo8sMW9aeLfApLcrQ7oCBY6
	 SZ5dXY/jl5j+F3qdZFsGLxm0KnGiOvm2wyKXklzVTkcKxBBoBHuuyJaQgQUHjfrMzs
	 DqmC6auq8y8QR8FuLBtHHry4OPPaLI0NsTwHGb2PTcCv/eXm5vTvvsV7OveYeyvgob
	 Hj5wN0dcHqGbB5b+Mph0fSSC8OnuEfEtrvs9C1BPsPkfuPvDdxTR6mtQ+kDPa16acW
	 QQOZrZ81yL1Nw==
From: Christian Brauner <brauner@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][V2] select: do_pollfd: add unlikely branch hint return path
Date: Fri, 11 Apr 2025 15:57:08 +0200
Message-ID: <20250411-lerngruppen-kojen-823467ef0e54@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409155510.577490-1-colin.i.king@gmail.com>
References: <20250409155510.577490-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=brauner@kernel.org; h=from:subject:message-id; bh=U3q0YH9UABshfZ8DUJHHyezmfDdHh8a15wvB6pQwvKY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/lN/Fu+z3D645ysvdW6ts3VtyDt8P6p2wXMctz/j4r g/tMVM2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkXi0jw5XlTA+e3dfY9zso MTow9pWR15UO213nNT7wTWI6srkjwIThf17nubXFHx8ouYacvm23Qm9feeDn6MhL5QtaFpRdWbW cmw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 16:55:10 +0100, Colin Ian King wrote:
> Adding an unlikely() hint on the fd < 0 comparison return path improves
> run-time performance of the poll() system call. gcov based coverage
> analysis based on running stress-ng and a kernel build shows that this
> path return path is highly unlikely.
> 
> Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
> a 6.15-rc1 kernel and a poll of 1024 file descriptors with zero timeout
> shows an call reduction from 32818 ns down to 32635 ns, which is a ~0.5%
> performance improvement.
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] select: do_pollfd: add unlikely branch hint return path
      https://git.kernel.org/vfs/vfs/c/5730609ffd7e

