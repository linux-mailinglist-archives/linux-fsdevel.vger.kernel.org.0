Return-Path: <linux-fsdevel+bounces-51772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B6BADB3B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092AB174780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CB17C219;
	Mon, 16 Jun 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDGLymyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C834126F0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083666; cv=none; b=nAAqxQcC5B3cEMo9kAXpZbzeD/TYQsml9xbuTht8ll4Bw0MktCSNXdmVIuGt+kFrvTqz/aEF7fUhvUX0ie43aUUh1FljnESoaq1a74YcwutVnAxHTf02j7rH+aVicysztEU6iHbohr2PMN7YJcjk4UAo2LSWzcXFSt8jrYgiTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083666; c=relaxed/simple;
	bh=luH013RHZJm1fvt/xhVy02d7K44MTEchER3/I9awUm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJpf0GU83I4rSRGR4I/TczEnLbIpGXyoQtjgJLLe3uyM2p5ZK+r6N3SFkfLpE6XjnsIXB3EPujhvbZQ4UB3+KCE9tG5n662hLhY01/q0TnN8zhYCHNTzVGH6IAzgizJtwcKCfhCLdPaCwW4xAOw3OJjiBpFLvw+kIrlnSASa6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDGLymyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC10C4CEEA;
	Mon, 16 Jun 2025 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083665;
	bh=luH013RHZJm1fvt/xhVy02d7K44MTEchER3/I9awUm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDGLymyg6WuKARyssEOu++N3EeUbXM4ItVMFlw5d6lNdMw862n+gpeq3RX+YrQqfe
	 oYGYuV7bWKlDrhs0GdRU48ZbIP0cWZWPKv51CRuw64ksXKw7UlYij/urs6Pb0NpToz
	 Yw6B0sDx+Ls49sISAUvHllGdaMsl1nmrjad5pFaTbk2tTaQuRjr4ZCK0g1Fu+Bj/2Z
	 LntjxMY814x5v5gOpnRWkgFbJHT8/yi+KritN5EpEidhBJHlOG9ckR5vY0+5kr3Bc6
	 vVuWBeB8dfQbzDlsYHoMxTrAcaF40dAnbPU+KOPE68mRdLO/vj3xfyL3axS3gp0Yo1
	 SgGGeQC/Ld5XQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: (subset) [PATCH] proc_fd_getattr(): don't bother with S_ISDIR() check
Date: Mon, 16 Jun 2025 16:21:00 +0200
Message-ID: <20250616-chipkarte-fassen-35d8578af01c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250615003321.GC3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250615003216.GB3011112@ZenIV> <20250615003321.GC3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=brauner@kernel.org; h=from:subject:message-id; bh=luH013RHZJm1fvt/xhVy02d7K44MTEchER3/I9awUm8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEaPjO28u05MOpC5Ia7769rr66VHv7rFqnBQ8ZEjec+ t4c7X+qsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiilMYGYAGiif3rAwy89Fm 011Sqi0TphSi/aC/mUFQUYLVT0qUkeFgbuvlZkehas9K8S2W/xfl1T7uk30+S5qt0YdpxfYdlgw A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 15 Jun 2025 01:33:21 +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> that thing is callable only as ->i_op->getattr() instance and only
> for directory inodes (/proc/*/fd and /proc/*/task/*/fd)
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

[1/1] proc_fd_getattr(): don't bother with S_ISDIR() check
      https://git.kernel.org/vfs/vfs/c/592063f3e692

