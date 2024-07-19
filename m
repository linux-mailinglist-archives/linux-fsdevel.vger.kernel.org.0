Return-Path: <linux-fsdevel+bounces-23997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEA93776C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E892C282ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280112BF32;
	Fri, 19 Jul 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZyZ1fcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A11E871;
	Fri, 19 Jul 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390586; cv=none; b=IZvLEAInw2jD3/R/ZCQ02Q4pF/wq17yaS5wtZ4jyUmoBamgupcgSmkAft4tFwA7+WoX+aWTAzQ/f0u8ONo2XrpaXr2Vh1UZ3b22CnLhs0nKpocZOQ5t8FhSXmamGlOEzH10m6d4/S/xfFn2KUJMLsEOx93+XVhHLeyCWEaKOWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390586; c=relaxed/simple;
	bh=KhHKzOZAwBdmMJFIhwe39lbsBUyWw429p0SplYnmO50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEdcVCLhO6EVgXyLuEHE8fTmfD2L568Xk40rlEEOobH8j/teZCZNKaT/jM87DlxP0i9bhocMp6lblmSZKsVqvt3Z252VE7L0eEy4NjyqVjGMkHVK00H5/Zebp8CkNYYJPDKzX6bYUcLgFbDgKwgOAi2nvfvmPIQDO08TzTWC/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZyZ1fcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10029C32782;
	Fri, 19 Jul 2024 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721390585;
	bh=KhHKzOZAwBdmMJFIhwe39lbsBUyWw429p0SplYnmO50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZyZ1fcJlcNkBP0Ls+TMLRtKmxblkxT31DQ3FEvMNaEKzxitPs2XcKX3Ouw9Wb178
	 nTXHK/Lg4wuAse7IuHLQWlaRaYA4qUU66tdEqJwgwqE4JX3gkjMNhS6wE76HTjOz47
	 ZngJheQ/mp7xv0UyUMeFlAyqFXIcpx8Gssal8npHm5f+RSmVo8/iMJmGGwm1kMjVP/
	 NW5dQuKU/9yeTmLYdN+ZqVe6jrQsdLssVpzzS7PhQPaiiQaPa5tQ/p5XvSDcdSK+x9
	 SydNo4O6NRQ1VfUZHsct6vQCfBfazk44v7yKg75CSMRpkBHtJFBB44/XMTHHV/ZGhy
	 9aSTj8vPUt6jw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jakub Kicinski <kuba@kernel.org>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] vfs: handle __wait_on_freeing_inode() and evict() race
Date: Fri, 19 Jul 2024 14:02:39 +0200
Message-ID: <20240719-arithmetik-feilbieten-abf21a9943e3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718151838.611807-1-mjguzik@gmail.com>
References: <20240718151838.611807-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=brauner@kernel.org; h=from:subject:message-id; bh=KhHKzOZAwBdmMJFIhwe39lbsBUyWw429p0SplYnmO50=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNCv3Y5jQz8ahKebrb5UiVC1d3ctiJbP17Vvn7+SuGF 8wsHixc1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRT6oM//REfP5kH1i/JLCn ycD529sT11dcZLkT3aq5t3eGyR9zpQRGhp5Wo/s79IqEYlfMUU50+2VtdV/kR1gMv2zS1pqp3Ye TmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 17:18:37 +0200, Mateusz Guzik wrote:
> Lockless hash lookup can find and lock the inode after it gets the
> I_FREEING flag set, at which point it blocks waiting for teardown in
> evict() to finish.
> 
> However, the flag is still set even after evict() wakes up all waiters.
> 
> This results in a race where if the inode lock is taken late enough, it
> can happen after both hash removal and wakeups, meaning there is nobody
> to wake the racing thread up.
> 
> [...]

Thanks for that and the concise explanation!

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

[1/1] vfs: handle __wait_on_freeing_inode() and evict() race
      https://git.kernel.org/vfs/vfs/c/3ba35ec4b0ed

