Return-Path: <linux-fsdevel+bounces-41061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B94A2A812
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32897A22FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9222CBE9;
	Thu,  6 Feb 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9z6cSyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31468228C99;
	Thu,  6 Feb 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843511; cv=none; b=oxe5x6j+8rieOT6TOfsnWXcTBMnJuuIK5Oq6KubDOhS3mJiEg95Ns10x8y1i7eN9RsmT2ERavGvn+OwTxffPhCuciw4PlG6X2n6LvVJ/7GkFPOIL/VNuTWaC0y9QC3J7xeQJkt6j/8U1H8TmsCkKFN5JhlcNpC0/WiExIhCMsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843511; c=relaxed/simple;
	bh=i62yYKT4n/xJDZEV97mEjPFaZNxa6AkVmaoo2YAjbkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da7A7Oy13dZ52fAiQt17yWj7taV/y3Abmayxx2iKLoZEsI+vh5YyQb9r03ViSEYc6l4J79nrSw7/wluW7m3GWF+bzdvGg5Lu/c73EXPI3SvNOK9APvA0YZrRDcBcXUG+AkyqbNwLCm8lT4xoiwScRcBEYp9hFjwEb/z9HR4FZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9z6cSyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE04C4CEDD;
	Thu,  6 Feb 2025 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738843509;
	bh=i62yYKT4n/xJDZEV97mEjPFaZNxa6AkVmaoo2YAjbkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9z6cSySTmd2gPfGGnXIa18GneNsRy6CHhhbypaPrXDINNF4jWeLmUZbVGP31mcpg
	 Mw5VRCYsm+VvlnrScdq9VWV1WhOPC6dmH5lsBXo9xlki5+UvkmvfrouNW8hZm8CTwU
	 WUKNOqxT71RqCu9m2Qa4/O5WP55m4MD4AVdOzRsBrgzqsb4pE0L2uqZtvmtTNpBhjY
	 GuhOtrjlJOtyR/8BPf0Ye4r2Ug6EK+nXrromZ6NAhBzKamMH7EWnAQrq7PuA9TvekE
	 UCZzvQktYuO7yjlHlTtgZzL27J/IlGfOf/scdds+4590nac4wkL6ZzJOOv1jrlKDT8
	 lj7Wfs8fn0G9Q==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: allow the file system to submit the writeback bios
Date: Thu,  6 Feb 2025 13:04:57 +0100
Message-ID: <20250206-kopfbahnhof-ablesen-fbf3a3cb52a3@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206064035.2323428-2-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de> <20250206064035.2323428-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=brauner@kernel.org; h=from:subject:message-id; bh=i62yYKT4n/xJDZEV97mEjPFaZNxa6AkVmaoo2YAjbkU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvWZrX93xOmUGz0vaNu+b4iCQnFPSfnMMzhc+nunjBf 1ftF2tPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykwo+R4fR2ll8v3p0ujA81 nvM7rnvxvfy9/z7HbS7ZPNvodBn31vcM/4w989LFdp94W7CoNnxHD+Ppdd7MWXOr1Wa+WeTwrWe SFy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 07:39:59 +0100, Christoph Hellwig wrote:
> Change ->prepare_ioend to ->submit_ioend and require file systems that
> implement it to submit the bio.  This is needed for file systems that
> do their own work on the bios before submitting them to the block layer
> like btrfs or zoned xfs.  To make this easier also pass the writeback
> context to the method.
> 
> 
> [...]

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[01/11] iomap: allow the file system to submit the writeback bios
        https://git.kernel.org/vfs/vfs/c/c50105933f0c
[02/11] iomap: simplify io_flags and io_type in struct iomap_ioend
        https://git.kernel.org/vfs/vfs/c/710273330663
[03/11] iomap: add a IOMAP_F_ANON_WRITE flag
        https://git.kernel.org/vfs/vfs/c/034c29fb3e7c
[04/11] iomap: split bios to zone append limits in the submission handlers
        https://git.kernel.org/vfs/vfs/c/5fcbd555d483
[05/11] iomap: move common ioend code to ioend.c
        https://git.kernel.org/vfs/vfs/c/63b66913d11c
[06/11] iomap: factor out a iomap_dio_done helper
        https://git.kernel.org/vfs/vfs/c/ae2f33a519af
[07/11] iomap: optionally use ioends for direct I/O
        https://git.kernel.org/vfs/vfs/c/e523f2d4c974
[08/11] iomap: add a io_private field to struct iomap_ioend
        https://git.kernel.org/vfs/vfs/c/d06244c60aec
[09/11] iomap: pass private data to iomap_page_mkwrite
        https://git.kernel.org/vfs/vfs/c/02b39c4655d5
[10/11] iomap: pass private data to iomap_zero_range
        https://git.kernel.org/vfs/vfs/c/c6d1b8d15450
[11/11] iomap: pass private data to iomap_truncate_page
        https://git.kernel.org/vfs/vfs/c/ddd402bbbf66

