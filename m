Return-Path: <linux-fsdevel+bounces-57355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420FAB20AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40ED3A9067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E451DF27F;
	Mon, 11 Aug 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYjARFsX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A819DF5F;
	Mon, 11 Aug 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920272; cv=none; b=jPEe1FVpU9xsKfOt9T5O1dYU9XNRz4v5q0BOwHver+M5WYqgycJWlpmVRjFwPmhXvFlPn76z21u37gIiJJsou9vZsqAr8M7KlZ/E5urTxlUKUsgM7hVfXcB3855DODRHyDf2262YLYIQy5YOHVJFfJO4u3u+USkh7E+LBulo5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920272; c=relaxed/simple;
	bh=+F8d3/5en9MycyzN7vz0cV8gLmAzIUKKReiksPPHZzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDyI+8yqgbqUTynwS4HUkU/UGz/zr+go9X6kw7B7Wz5fwSMUihcUB7QqMpLa4Motl8FtvmTlXcGJGMMjqOgulfZH3aP9XLI61zSHNx4RZg2b3juUBv9g3smQUr1XC3s6xYy8wjExwXElAT/+G/mtXGDhXsClishL2cJSmMdMTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYjARFsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602EDC4CEED;
	Mon, 11 Aug 2025 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754920272;
	bh=+F8d3/5en9MycyzN7vz0cV8gLmAzIUKKReiksPPHZzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYjARFsXODuGMN1Qd4Tn2sKFg/PKfwVQa1+wwG6g7GO6ASjgncsVtSRBK8u6VHj/j
	 8KqZeIfgBj8JZVBDuIutA09QBTxwPniCqFNCU6xGIPjCyoWr5HQ93kLp2mo/yRhvAy
	 T1KJ3yFYuerDgGqgkXcG1Qo6LdIO32/ByLamlfuOqIoFVHMRdIEv3BtAQ5q0a/n7fX
	 H3nzxDJU6ekch8YClEiTEjVEEkOraZbOSwx7Ls4RV2oH+jp0Rg5Go8P8FzBpGSbvkT
	 9S7t3lGcfVJEDClCEMcJVWsqHskkHpHfXVk8NqbWjLT3nlLiGHyYz6/B+FYFCHAaUG
	 oHRkZb9RwV0Hg==
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] vfs: show filesystem name at dump_inode()
Date: Mon, 11 Aug 2025 15:51:01 +0200
Message-ID: <20250811-bahnhof-paare-593afaae19b5@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
References: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=brauner@kernel.org; h=from:subject:message-id; bh=+F8d3/5en9MycyzN7vz0cV8gLmAzIUKKReiksPPHZzI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTM/Op9cOFRI/UzrxZHFWh7Wq+ZPasiYtLtk3vOrXgcc PqWdNmzuI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ8Nxn+Ke6esMK6/ubytVN rGLKyg50mVVP9PqW8PNrq1T0kwXr3OYyMpzpmjvlXJHBdpul7+z92zxVzv8V2/hGKpFHSD1+jvH vRG4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 15:50:28 +0900, Tetsuo Handa wrote:
> Commit 8b17e540969a ("vfs: add initial support for CONFIG_DEBUG_VFS") added
> dump_inode(), but dump_inode() currently reports only raw pointer address.
> Comment says that adding a proper inode dumping routine is a TODO.
> 
> However, syzkaller concurrently tests multiple filesystems, and several
> filesystems started calling dump_inode() due to hitting VFS_BUG_ON_INODE()
> added by commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> before a proper inode dumping routine is implemented.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] vfs: show filesystem name at dump_inode()
      https://git.kernel.org/vfs/vfs/c/ecb060536446

