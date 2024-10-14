Return-Path: <linux-fsdevel+bounces-31900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCC99D01D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B422C285B52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB571B85EB;
	Mon, 14 Oct 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnL1L2qa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C40487A7;
	Mon, 14 Oct 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917955; cv=none; b=mQhriZffJwMpILkeE23T2mD4fa52Vikb8ICSJQTm51JPK+eABIkYfKjeWo37YiI97TVW6kZdLvH8QF6K4UuhR60DEmZmorXgwX5RBGhjcbJPv4hhfXc51UwiXGLemN18ugzoLy/0LjfVZJskh0Avl1Na+gZfltSNm1YnkpX12Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917955; c=relaxed/simple;
	bh=QMxEa9KS91llBNuBhYxvltZz8R0h14m+FTfLKJRC7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMyjCsbUp9mn0bMz00EpRC75JTkVS2WtEx00/L7frCIEA0xfcmR1ayKHkOfoSnbnNwAuJlftOUh1gdRBKqVrHimE6KXvVri+avuIsPxVrPiKPvtVOKXiNHyzYL6SS9c8iAzthcZZKu5rdchGXaEVJI/x9x9IRxaeL4Gkp0PtB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnL1L2qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B15C4CEC3;
	Mon, 14 Oct 2024 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728917955;
	bh=QMxEa9KS91llBNuBhYxvltZz8R0h14m+FTfLKJRC7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnL1L2qa90JvfcbUJ+Am75lhuDhToGbuHKxT0u64Bu3Ey7pDnYzJ6O7xgjuqiNAwO
	 7Ft2SF5QPFJgGEh6P74IZoUEc28tj3xDo2fUOq9pz3S5qa7utVeCji4Ws80MHkAogy
	 w1qVcft9ubrFyUeTG6LCUPYNsPqRl9dXUGiAJCT+ZApwuK7Q5SY2iGNor4j2KfX1OU
	 X0Y8tJBKghJ1cyku1ph61qmKaDLP7kNKfD1uH9eg1VkxP+AZTzMd/xDM2B2s6Ysol9
	 zwdywYR/jhdXO1BkPFmkmFnkq+Pi+PH4ogCesRkOinI40X4faUXF6ewUlU37pu2zMS
	 ihRAhAaRyOPQA==
From: Christian Brauner <brauner@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] coredump: add cond_resched() to dump_user_range
Date: Mon, 14 Oct 2024 16:59:07 +0200
Message-ID: <20241014-ortung-brombeeren-5793cd93604e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010113651.50cb0366@imladris.surriel.com>
References: <20241010113651.50cb0366@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org; h=from:subject:message-id; bh=QMxEa9KS91llBNuBhYxvltZz8R0h14m+FTfLKJRC7Bo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzGu6x4hDlv2qx++1be/c1i57P/Gbkksc4xZzvo5Fqy Z2DRSfXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE+wEjw9/CT6e/eKbcXxY5 S+J/za55eskp7/6vCGHL4ln19fKfK0qMDJdEheLW75MJ7926Z1efMf/OGx1VmnsqzRzf7Ws15Cx bzgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 11:36:51 -0400, Rik van Riel wrote:
> The loop between elf_core_dump() and dump_user_range() can run for
> so long that the system shows softlockup messages, with side effects
> like workqueues and RCU getting stuck on the core dumping CPU.
> 
> Add a cond_resched() in dump_user_range() to avoid that softlockup.
> 
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

[1/1] coredump: add cond_resched() to dump_user_range
      https://git.kernel.org/vfs/vfs/c/89be051f0724

