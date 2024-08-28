Return-Path: <linux-fsdevel+bounces-27557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216779625DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779B3B211B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4D16D334;
	Wed, 28 Aug 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1iaXbrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA32166312
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844035; cv=none; b=fmzSrVpC3L4So1Ngrq9L56qOOlSzuUxqsD7ww7IIPPx7l98c4mJ+wB+6QhNa8V6rP4vXxnC3rZc0p2yyn+cAPR06xU6HXQZYcOt6PlhZZbZ596p5Mc85rS+KunUt8NDr4yUpEXvmNRsdAAEPlgHaCqTRyJqR7oz9oVyzGbhF2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844035; c=relaxed/simple;
	bh=4h9yFEvEJEN69S+oO7sMpVgTxYDXbGuqxsjDa/VxnbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZsG30N8uHpmgt1QFcPsMvFOWIkyg/rNdrv2UJQfs5gnrw51twZQPFROm0CMAgwpzf9TNTv0Cjhy65kB8CHN/mrV8XIxwknwqsNcGutPhF8g9+DDJCoiDKNs3+U8OSEHQBtviYlQHkRVj2Dnm+PzU4y0CI7cCXdm01DeMB/lhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1iaXbrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369E2C98EC1;
	Wed, 28 Aug 2024 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724844034;
	bh=4h9yFEvEJEN69S+oO7sMpVgTxYDXbGuqxsjDa/VxnbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1iaXbrY40kknoZDmlH40cdyo361cfGx17p8YK79r2nOr4FCa0lBEssLleeTzT4kb
	 UwdL+bI0aIGk2b/rwGoPNzMCQxjpSoMNz2alCc5dB1CKgqqefdddDyVlB6OFs71nHx
	 uyLk8ce08+7OYiE1ZFnqCwelRCK/wEijuYSrcUT7c5dsgWtymesxooWPYVJE0raD63
	 pL0KYpzV8r0MlxyDm1NgHAlXcARF+4qeqi/zcc8T1Lk0VoBKiYRlxM6CFT1ny8isJ4
	 GJyGk3hzVOUOVvmlCAHt4d/KsuP5TG/IVWr+suj4LjBBUZTPEQF82TXe4+bLhca8Fi
	 OMyeqQCMSGdHQ==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH -next] fs: use LIST_HEAD() to simplify code
Date: Wed, 28 Aug 2024 13:20:19 +0200
Message-ID: <20240828-ungelegen-skript-419cc0c898de@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821065456.2294216-1-lihongbo22@huawei.com>
References: <20240821065456.2294216-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=brauner@kernel.org; h=from:subject:message-id; bh=4h9yFEvEJEN69S+oO7sMpVgTxYDXbGuqxsjDa/VxnbY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdZ//FcbBIRs3jjoZc2oX/r4pmF15WDGX2fM5yMPyU+ aWXW2Mfd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkkQUjw2qbA7eTghX95x7e wDT7xxPFbTtuhwbvqYoUz85Tk9nrcIWRoW3N89150hE9fUv8WPJWdHpLigkz8H843yfAVf5bxdi FCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 14:54:56 +0800, Hongbo Li wrote:
> list_head can be initialized automatically with LIST_HEAD()
> instead of calling INIT_LIST_HEAD().
> 
> 

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

[1/1] fs: use LIST_HEAD() to simplify code
      https://git.kernel.org/vfs/vfs/c/c594d308f43f

