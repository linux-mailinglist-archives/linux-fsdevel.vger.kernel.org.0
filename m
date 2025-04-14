Return-Path: <linux-fsdevel+bounces-46350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A8A87CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E9C3B7632
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4392673B7;
	Mon, 14 Apr 2025 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1VMecFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB325DAE8;
	Mon, 14 Apr 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625093; cv=none; b=DAejPPqUvoLaBNXnBfTu/07Qb3SAhI/hZoiBKu5EjZCHWvRbCUGkDO94jSVD6PjzdIbmaXtTdDJpmEoJYFpqjqRpJOaFG0Nk6mB9P1ir1VFp00kdi1B3YaTCrFaBiqD/WyptlpRNDoOeKTOH0x29fkwePernfielYqY9iKwHd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625093; c=relaxed/simple;
	bh=gruAiv2P1YYiqXyfzoaPnkaggXJ0sX1fRdxIf7A/6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn26GLjunbNfgJN65P/25cb2sXQTNWc7kgKqr+l4UUHnNwh4sG1hosj18dnJjForlZzqoj0/XmTgOvzsC7661z7fAepRgkPGSycJ85qPxWgRZSQddNZX9Ub0RfgnKKCjucavYFHT/ZEE5n1EMqDGR7zqzJbHddbmuxJDVSWFSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1VMecFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C60C4CEE2;
	Mon, 14 Apr 2025 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625092;
	bh=gruAiv2P1YYiqXyfzoaPnkaggXJ0sX1fRdxIf7A/6lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1VMecFNtXrF88nRgXzVAyFg4aQtUR59dLErSB+wh/LhZIkUrnAZeZ4erzWDsUTyX
	 RK0SrkNv8HeXjH3ClYkMftKNWOKrwk/DUtBTJAmLza3t57tO+XqzChyXhDrmT1yBgJ
	 K130eGDBwRmA7/uZaxe31sux+jQCH63dobjzQGxIYIl2ec4ctcLDaBoWxoRLM2Hluk
	 CeA8C338DNSS+KGZ0Xg1i8KBErRjZQ26dqDGVyjOChHFx8E+dO45LwfNZdM9Q3csMc
	 rL1Dz95EeCfmH03S3c7zzayBGG0jSbDj2ekt11yuNvFK9C4w/5OMaHUJixqOlQdTl4
	 7CHXczIaooKEg==
From: Christian Brauner <brauner@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] select: core_sys_select add unlikely branch hint on return path
Date: Mon, 14 Apr 2025 12:04:41 +0200
Message-ID: <20250414-desolat-bauindustrie-7a705d36a1d0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414092426.53529-1-colin.i.king@gmail.com>
References: <20250414092426.53529-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=brauner@kernel.org; h=from:subject:message-id; bh=gruAiv2P1YYiqXyfzoaPnkaggXJ0sX1fRdxIf7A/6lQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/ubt/5+wLtzXP67C8uFznMLduzuvtls8VYtIZvxz+c Il/j0Xyx45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJuMYy/LP1+6vx/41eg5zI 5s9LO91aV0SUzDrvfnjzHruH+yJX+ysxMtzb0Zo7r8nTqTTOZsGHh7Ieho3mnpPXzJuZOPnQEVu JZC4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 14 Apr 2025 10:24:26 +0100, Colin Ian King wrote:
> Adding an unlikely() hint on the n < 0 comparison return path improves
> run-time performance of the select() system call, the negative
> value of n is very uncommon in normal select usage.
> 
> Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
> a 6.15-rc1 kernel built with 14.2.0 using a select of 1000 file
> descriptors with zero timeout shows a consistent call reduction from
> 258 ns down to 254 ns, which is a ~1.5% performance improvement.
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] select: core_sys_select add unlikely branch hint on return path
      https://git.kernel.org/vfs/vfs/c/7732f21402b5

