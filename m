Return-Path: <linux-fsdevel+bounces-8939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CC83C7CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B7AB22091
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91F129A6F;
	Thu, 25 Jan 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbesHY24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144E73177;
	Thu, 25 Jan 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199923; cv=none; b=Vk3cCi8eK9oojYZBdGVuCEuUtFikyvvzup3WzuCwKAZ+CtRLnH+6CHPuO/jwE9I2tNP+x6Z/zXi2AWvL8CbMAYrtyMSw9UGix7Amb7tv/79AF6fFz0FUVrl1rtVk9mFwL2UZb9799POPTSzpR55i7jQsF2ylksYGFsrYxn5mkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199923; c=relaxed/simple;
	bh=wJc8Jxeo78IzspCnw256X6rE5YyddHMgrBAd0+d3SoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKceyANua+iiLToIo21cEdemxMcdl3q6i7TJqZD/eI2Oq+opt3YOnGbYtRhuAzrVHsuutAegH9yGhIYFaoe4CydANeysgGG6HDc974a0XUh06bm+ivhQOuVz4uTGQCxCa7DVOs32aPMGk05O1lSBpsbEyBB8DomLCyyPHU0W09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbesHY24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B491C433F1;
	Thu, 25 Jan 2024 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706199922;
	bh=wJc8Jxeo78IzspCnw256X6rE5YyddHMgrBAd0+d3SoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbesHY24ONOYobqOsuPiCJOmEuLcJwgj2DKyliEWdjXRD5sbQ2IxkRweXKrW6dUWU
	 Dghz52Z7SFJr7DnoBLbEXzZyYO2LV1SnTxfetu08y0nmrDYrwgGS1NUioXSaeArR/x
	 lxmzmND9jEZlukdxywtNOrcYq0/Tt8n2AeBXpkr6mRb8FVqxt8B8KuMAid+hKReG0c
	 Mxk/oa3jwa7Cel5znPnJPJiEqpNak9fExYmhaKKP1xzMVTcbpdOhweK0X6WWVYWF4M
	 NhAU/aUhmXGGI0JABrbvfKlV/OtBfwm8b8Qle80jkUqstk9GhVJ5xdXcQXM0sJdWPC
	 HUxI6UHWtIKBg==
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	willy@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
Date: Thu, 25 Jan 2024 17:25:07 +0100
Message-ID: <20240125-leihgabe-enkel-403d0d728714@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142857.4146716-1-libaokun1@huawei.com>
References: <20240124142857.4146716-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=brauner@kernel.org; h=from:subject:message-id; bh=wJc8Jxeo78IzspCnw256X6rE5YyddHMgrBAd0+d3SoA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRu6s6wYfA9ezPHb+Ee/ll/A98p/+8/4e0xn9vzoGNwm w/f9ne/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS9Ifhf6SP7+c5Tk7Zz91O yjx4pSRZZ7qKT/Ob8CEP9vo13x7vLmX477XC6XjnWj1h5oLu/Dvbt+mpGad56bUbG7s1OE66oT+ HFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 22:28:54 +0800, Baokun Li wrote:
> V1->V2:
>   Add patch 3 to fix an error when compiling code for 32-bit architectures
>   without CONFIG_SMP enabled.
> 
> This patchset follows the Linus suggestion to make the i_size_read/write
> helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
> in filemap_read() is no longer needed, so it is removed. And remove the
> extra type checking in smp_load_acquire/smp_store_release under the
> !CONFIG_SMP case to avoid compilation errors.
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

[1/3] fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
      https://git.kernel.org/vfs/vfs/c/6238fe4d7cad
[2/3] Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
      https://git.kernel.org/vfs/vfs/c/bf7aad3980da
[3/3] asm-generic: remove extra type checking in acquire/release for non-SMP case
      https://git.kernel.org/vfs/vfs/c/e9cbdca0a243

