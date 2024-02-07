Return-Path: <linux-fsdevel+bounces-10588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DAB84C823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352551C22BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF325603;
	Wed,  7 Feb 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWndsM7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5D25573;
	Wed,  7 Feb 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299894; cv=none; b=OilVH2PsXDaZnEm2c79krrE2K5g4yO+gpqeNIpF7FB4LHzIa3kKCMZXl4oemQHw6zHSX092PX4IjIctHk/HcSa3MT9nbskiumDPI48kS6tk8esrth8hqGRDPQsx3fqvrIoaLrzZxCQwG5wrBR67EV1BbB3HWmertNdmb2AjVopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299894; c=relaxed/simple;
	bh=95FAzMi8iyTuuxbAnG6slusfROgAfn26nwMc3fQaGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjp3CJ+UvD+7lE6jxtG1Jl2ylTq4MGASz2WSeBtBVM5F78K1x2tuWcCd/1Ma1MsFuH1aSkcl6TT17HKGpcP5mmuIaiD2lNxeCSOEpnl1Tc6CVQfruQWmwlf8MSdEbqXELX137SoPcgzmNujBCtzRX1Ww8qlLQjTGlr1qU9QCzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWndsM7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB6AC433C7;
	Wed,  7 Feb 2024 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299893;
	bh=95FAzMi8iyTuuxbAnG6slusfROgAfn26nwMc3fQaGPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWndsM7s9F9qWc47sgR3Kmvntf7OiDjMQNcNUjS65XLXcz7zwW7PSIAr9AntNp8DN
	 Ad+Yu/1QHhK0by/HD3XVWwL9pMR3RPGc6JCeivJl6jF8yc0yi28A5w440HfGq4xRed
	 KaO4CRCqKJCdLT/+rxdTiUoHIkohJb3Wpwcyro4Wh9d40m7Ibyg6bm4/NOkJTqshXS
	 EER28gBAlpd593QrsExKbHtjm2mSp2rsV2n65dHcs5WGtRPRML/yaVBmBX7PkyAVBF
	 h8oIpINHUs1Qb9G/RH65TmTNce7kNJ1No2KllIRfPmqoXCVatCYD6d7laUlcxswxLG
	 F9m1muFGXGtJg==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	wenyang.linux@foxmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] eventfd: strictly check the count parameter of eventfd_write to avoid inputting illegal strings
Date: Wed,  7 Feb 2024 10:56:33 +0100
Message-ID: <20240207-formgebend-ratsam-e3372573781f@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
References: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org; h=from:subject:message-id; bh=95FAzMi8iyTuuxbAnG6slusfROgAfn26nwMc3fQaGPU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeDtGNfLj0wJHmUwr6np+s8hc4/JYOeLjFX0Fz6pa6U L/JM3aFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkhzsjw/edNvPN/3xkZ9yx 4d1fyZmXswMOXVmz3U+adUK+/3qnA/yMDAu3mZ/9e7PI9lzxyUwZ7qsXHM8v0ynYKxCRWPb75V+ /qYwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 00:35:18 +0800, wenyang.linux@foxmail.com wrote:
> Since eventfd's document has clearly stated: A write(2) call adds
> the 8-byte integer value supplied in its buffer to the counter.
> 
> However, in the current implementation, the following code snippet
> did not cause an error:
> 
> 	char str[16] = "hello world";
> 	uint64_t value;
> 	ssize_t size;
> 	int fd;
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

[1/1] eventfd: strictly check the count parameter of eventfd_write to avoid inputting illegal strings
      https://git.kernel.org/vfs/vfs/c/325e56e9236e

