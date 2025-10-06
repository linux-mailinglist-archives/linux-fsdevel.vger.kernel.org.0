Return-Path: <linux-fsdevel+bounces-63479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D4BBDE19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B481892D46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEB26B2AD;
	Mon,  6 Oct 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/PZnMcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310EA2561AE;
	Mon,  6 Oct 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750621; cv=none; b=qyKOrIvtvaKiAGl7ta5GmkiimUHDW3h10r9oDP6F6bWhMiiAWPMX8wyke2MnJ3JKaSICpoPR0seTmKQUR3jGCOW0Xs6P5S6TvxacntjV+q0SXNUDdkPfZKQGn6QvM2Zth4BEMVoz39h0e0os5pW6LkkC93NOBUBnTDCXzxAtm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750621; c=relaxed/simple;
	bh=xj3imUq0uiwpSSqW131Kx0ylJoE4IO4LheKHnFFEkpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IemUPLVHXWLlj5RcrohDdhnC3N9p+rJb8rb+i7n5g4FX4pSrQH5rcujDAU+BjoUb6P8ONSxeGJEzmw93IgKkFjK3bT1Nc0RXMOzBmvBFBIULAV1j2C9NOqfnW+MKzHDDrcCgQh2YjVscPDgFLODwXViiGrxvukQzldvBj0gspRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/PZnMcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33353C4CEF5;
	Mon,  6 Oct 2025 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759750619;
	bh=xj3imUq0uiwpSSqW131Kx0ylJoE4IO4LheKHnFFEkpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/PZnMcD9T6qr/bM1P0ivloKxplhc02wco6MN+YSyi255bt/DnUCVJUDAw4JPv1tw
	 sMASsVKSfRXQXPtgMnK+/6K5RUkJxyQtjoVAntnY573zITtH41fbeVizdMkNghhhvy
	 Mz32xEpVWf6MmSjenTn3ZVqG+Eno/qVjRBoMEpltE2NEFx9Kvls2sk/zSRZ8ZRihCc
	 /NKgD2LNZrA/9FnYGI6geRuVxdlfoE1TgscMPf2FieeHMEPQSfQPjQwmOXYPbzwcEs
	 mA0jj3tKMP9tGtasjm94gyThBJ7Xif/OktqK9wsy6aKFsQvId9PvVYLGGRUhOmQ5Cp
	 WZPCnNyQyz6xg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
Date: Mon,  6 Oct 2025 13:36:54 +0200
Message-ID: <20251006-schokolade-handpuppen-aeb639d3d4c6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001010010.9967-1-mjguzik@gmail.com>
References: <20251001010010.9967-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=brauner@kernel.org; h=from:subject:message-id; bh=xj3imUq0uiwpSSqW131Kx0ylJoE4IO4LheKHnFFEkpc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8Xnm9hilhItMm1e/vpconKdz7NSPvEVvG0pzMc2ejt My+d7hGdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkKIORoeHcFn85c6aPR5Jq In/dU6+1e7yiROqx15YdG8x3RSWf2s/I8HPyzEMuny68N0ya7VR5aUXagu/T/7+5vEfmQN/REze vHuMFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Oct 2025 03:00:10 +0200, Mateusz Guzik wrote:
> Notably make sure the count is 0 after the return from ->drop_inode(),
> provided we are going to drop.
> 
> Inspired by suspicious games played by f2fs.
> 
> 

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

[1/1] fs: assert on ->i_count in iput_final()
      https://git.kernel.org/vfs/vfs/c/655c4a4f00fc

