Return-Path: <linux-fsdevel+bounces-71340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C17CBE399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3A1C3014F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DE33A6F1;
	Mon, 15 Dec 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HflWFVqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F433A039;
	Mon, 15 Dec 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808028; cv=none; b=Hhm1P84nx/eEnKjhryCqo3Rqrq5bZrZ9ndm//dkWglmQZJyAxg1pox/Xs82HOsdMYPWmi0edT1BQWVOwQyOxgtFspUSxzC0v7Ou37WyyQ0SG049HXYuivrmWe4F545dzQ58HSQAg8w4nNypzwWF8r+AzBbh7AR1oUx5GLsroyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808028; c=relaxed/simple;
	bh=m3i3iwxp5OsOcI8oD68UsVKqQyef/36yw8egizy9blw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZmtNBUsHwxWINwfMlNLqNI9mn/mPE5F51rzurWFp2cVUpY1bighY5AlOlhO09vaGyMX8ij0qqYBu4LRpcvxJjOtbmJUjoJh+/oMweA+oSek1X4wEfVLXSDydYj9ATsYg2Oze30fVwwQBNLI5pn3KobRM0ZrlAf1VMEo5DqfsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HflWFVqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199BFC4CEF5;
	Mon, 15 Dec 2025 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765808027;
	bh=m3i3iwxp5OsOcI8oD68UsVKqQyef/36yw8egizy9blw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HflWFVqKNdY2GZEPU09+ZBF7GU/QbHs69ZckCZ9ltDArpslFfuhqbsEfy/f9+DHIL
	 2LK8Lm/Hsmwrk3GlWl3nRpT/jCOvvx15keGMRT49AxpaPh1M175dB3Iqa6SwKAev4Z
	 CfdqTMU+v0F7g+zTTo7u0i2YtY+e7+jH9Vxp9OpCIia9es3lubRbNagT0YmvxFHOod
	 GIih3713M8NB+v0Zt9NaQ6ulgRqEwydI+RkrbinNGq3ydKXYaAK+G+MBA4UPHwVa/N
	 EAL2cdhNgVTSE4qruTBAa3DE8hV9s43++kZhcVn7dPB1et191p/fa4LVEhiaXT0/vD
	 nKELDhw/m7g3w==
From: Christian Brauner <brauner@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: mc: fix potential use-after-free in media_request_alloc()
Date: Mon, 15 Dec 2025 15:13:24 +0100
Message-ID: <20251215-zugeparkt-umsonst-2b5755c0bece@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209210903.603958-1-minipli@grsecurity.net>
References: <20251209210903.603958-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=brauner@kernel.org; h=from:subject:message-id; bh=m3i3iwxp5OsOcI8oD68UsVKqQyef/36yw8egizy9blw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ6iE9f6qNz58P2r61Rcv/afhisTpwf/HOigntGEWPAU wnX2u1zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS8Jbhn22uk0L/zF8ts3JC 781LXLGdq0V0BidrzLvc/LTNS7Wc1zIyNK3SFWZ2afq8z1YgQrLP27c953bBG74ps9Yt67fJcJP jAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Dec 2025 22:09:03 +0100, Mathias Krause wrote:
> Commit 6f504cbf108a ("media: convert media_request_alloc() to
> FD_PREPARE()") moved the call to fd_install() (now hidden in
> fd_publish()) before the snprintf(), making the later write to
> potentially already freed memory, as userland is free to call
> close() concurrently right after the call to fd_install() which
> may end up in the request_fops.release() handler freeing 'req'.
> 
> [...]

Thanks for spotting this, Mathias.

---

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

[1/1] media: mc: fix potential use-after-free in media_request_alloc()
      https://git.kernel.org/vfs/vfs/c/a260bd22a355

