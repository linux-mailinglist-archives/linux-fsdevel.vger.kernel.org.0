Return-Path: <linux-fsdevel+bounces-26105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD2954748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852FA1F22D38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8D198E7E;
	Fri, 16 Aug 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPYcjOZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BC198A32;
	Fri, 16 Aug 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805786; cv=none; b=To3z2jm4wXKUz9ROkSRIJE8e8PX0T7nZjNFXZroqCQso7r3MSqVW/bRo23ILWRzcAJXaDvpa14BLa3d2s9C52g5jBowH5atYDYPapkmzVD7OSj8/vZX/+w6Ofvp8b8GKJSgQUULKKJZoLn4+ACmt+fu6QNAY8LaMtL8cGmbJLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805786; c=relaxed/simple;
	bh=pyTa9dPu9oVB1p3RNRYnO3QSsfYU06JEbFq4M8hqeSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaiXtue+NenHMytXdVxtKl/LS+LsvXaEMOfUG/cdCe3Artr/wirKeaZHjzLjoxdyKHBelbE97HQ6HtoYbb+BbkDnf0v5mKPfovHU6EljshkgAXruaCGLXfMafCh9uiS+f0w4D8Z4lbPtxPB50fMRxY8fxNDC6CCxcPum5AFeec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPYcjOZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F1C4AF09;
	Fri, 16 Aug 2024 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805786;
	bh=pyTa9dPu9oVB1p3RNRYnO3QSsfYU06JEbFq4M8hqeSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPYcjOZUmB2gvdr/szNvHsWamcM41r23Bppsd4bOVDn7u6v1fLGyRBsXfeSN2UHVt
	 iJSFSqml+SgLhpx149krPYfMHltvzkVrmS3g34VVCWIJJq/drgGEYcpxsKahVDVXUC
	 XclowKSUngpHB3V5U+j+GHj/JYk1sHqnp3x86hEzOcVRw+HwK4FikS8wNouhpBxB3x
	 TGluFfljV3dZHDHGBf8+DP3j9eov+coAzWuRqtnKjZq+oVGD1VMEob06rrbnqU0Bvj
	 hvGfJgcm13nHm+FpTPOs11WmqfMv/u2HLLAULawQPpkwi9MuXjWSknXtY7ejsXuneQ
	 cTkHzIAubtcLw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: elide smp_mb in iversion handling in the common case
Date: Fri, 16 Aug 2024 12:56:19 +0200
Message-ID: <20240816-wertarbeit-steil-90ff676fb2d1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815083310.3865-1-mjguzik@gmail.com>
References: <20240815083310.3865-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=brauner@kernel.org; h=from:subject:message-id; bh=pyTa9dPu9oVB1p3RNRYnO3QSsfYU06JEbFq4M8hqeSg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTtNwjmntNp6Nt+6+/npw98fpz/HB4Q9nuxd8jKvysLP A3u6Fzv7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIqSMjw2nv84oWz6Il0le8 k2i+JfGph/+J68EnZ5VmS/2vPbrcqpOR4cry7DU8l9TCGL8FWZ37mXjisEiqcKXtWYG+1SIxdde +8gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 10:33:10 +0200, Mateusz Guzik wrote:
> According to bpftrace on these routines most calls result in cmpxchg,
> which already provides the same guarantee.
> 
> In inode_maybe_inc_iversion elision is possible because even if the
> wrong value was read due to now missing smp_mb fence, the issue is going
> to correct itself after cmpxchg. If it appears cmpxchg wont be issued,
> the fence + reload are there bringing back previous behavior.
> 
> [...]

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

[1/1] vfs: elide smp_mb in iversion handling in the common case
      https://git.kernel.org/vfs/vfs/c/5570f04d0bb1

