Return-Path: <linux-fsdevel+bounces-7791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B598D82AC5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590EAB26E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A4D14F92;
	Thu, 11 Jan 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9MTSYZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCA14A92;
	Thu, 11 Jan 2024 10:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6257EC433F1;
	Thu, 11 Jan 2024 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704969889;
	bh=MkfpGu6l9ADn2nlPggcEFJsCzQPflgnuS7MP7E2NhSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9MTSYZNdG9ABC2W/Gdht+BhYZksFbTIHrGZn8riR0oj7siTlJ5pS1rfJpV4YcPZS
	 etjAR61A7MAxWMimuqLHXBfQ58Z82PyrcYqMeMzHfeFbD7uTUrDHZq3IkbD4InKDsW
	 43De4+0PltBflqE63wKYQ2rfRtvrJTPN6LA3qcQ7DuXbCSYJw/Qa6Qc5KFFgGhvwsA
	 lJyatUxz9UfvzUDduL0vNXB4H5VMmSpJJnYcyz90WnzLHLk6GJlaN3RGv0aHbpD4eA
	 g9OyzgXGmFnwV5mbLmUPlsGO3m8t5gcfB00v7zMcaB5AWTTDPPnD0tgZS75mBOKggb
	 lpWSnaEUjlGUw==
From: Christian Brauner <brauner@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] eventfd: add a BUILD_BUG_ON() to ensure consistency between EFD_SEMAPHORE and the uapi
Date: Thu, 11 Jan 2024 11:43:58 +0100
Message-ID: <20240111-museen-heiter-39f9dd68229a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_0BAA2DEAF9208D49987457E6583F9BE79507@qq.com>
References: <tencent_0BAA2DEAF9208D49987457E6583F9BE79507@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=brauner@kernel.org; h=from:subject:message-id; bh=MkfpGu6l9ADn2nlPggcEFJsCzQPflgnuS7MP7E2NhSE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTOP9ZxtuAP+5JVbyewrjiY+fG0VJEXS+hhtjcTbTJyS 6Tk3aQ2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEfB7D/6DLi2dah625tvpi 6IasPPudj8/Mu/Zigk1J3vt5cWvEpkQw/C/kOPXr6SSBh6z5lYznPVqXLOX96fF6J5P1yvO3jV7 kvGMEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 23:47:40 +0800, wenyang.linux@foxmail.com wrote:
> introduce a BUILD_BUG_ON to check that the EFD_SEMAPHORE is equal to its
> definition in the uapi file, just like EFD_CLOEXEC and EFD_NONBLOCK.
> 
> 

This isn't hugely useful tbh but it's not terrible either.

---

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

[1/1] eventfd: add a BUILD_BUG_ON() to ensure consistency between EFD_SEMAPHORE and the uapi
      https://git.kernel.org/vfs/vfs/c/c3d48db389b7

