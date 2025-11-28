Return-Path: <linux-fsdevel+bounces-70125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350EC91740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 887103488DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA25B302174;
	Fri, 28 Nov 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMh9zGdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2781F9F47;
	Fri, 28 Nov 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322335; cv=none; b=jX8B5m0+OaNUdaGac8TDtYbuBtI/GyGhipEsH6wlaxZ7++vThAJl8ev+//DVxYWpkvELzVWBGC0a8BFGPOMuGK0+tCfQ7sB3gXYJfFhtp2gReiIjEaeW+6ADiNfgUs52fPGLtNeg13XQitu4O3ixVw6DdX1Wz/dm858pi5lJvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322335; c=relaxed/simple;
	bh=YjUBeN2vABSl0jpHGvvyfif2KOLnq/uDzZ6pXUv2Wa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfwzW4G1iXwv1f+SgjH7Os1Wsc4xEUNVPx/zsXdKwr04cPDjjrRmE4xMBn+Oq1pS/BFWfJvVhq9OaLE60My4Y3tpfJ9zQDH2h2zf/c370Bm1KB3JAheUANwRoEHbstA6CRQKO+JjNt6GoeBCWCBDder+P6T4WozT11L7Wr/QRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMh9zGdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007F9C2BD00;
	Fri, 28 Nov 2025 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764322334;
	bh=YjUBeN2vABSl0jpHGvvyfif2KOLnq/uDzZ6pXUv2Wa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMh9zGdwQyc4CMba1/aRhDCSuvGC8VvcqWKl2zVsMc14g6W/YLldRku+9JjDT+JgH
	 dnfWIzULs+z77XbLbq58eV1irD0iUd1J6vjm4DL+SlIRAE4s5gk3d5vtsVnaBz3608
	 QXd+lV4+WRo3dfQkhV2U72dlI3reek7+wuXAbAi5bhMNw/nKHruZroe20WTJrhLWUO
	 NPiU6IQO7oymXVYwtHUx1yWGV1xaCrgc5VyBUPd3O4meSyNwqqO0IXCk0fQapHJ9pa
	 XT+lOT0YCaHNyNEwWWn0aOlY8TcqmSOOYNsHNn4HFKHRb5j5ezolv0GZqf6nxHpQ2v
	 0KPoX/nwN6UEA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] dcache: touch up predicts in __d_lookup_rcu()
Date: Fri, 28 Nov 2025 10:32:09 +0100
Message-ID: <20251128-hinblick-heimfahren-c73d29b4c5ab@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127131526.4137768-1-mjguzik@gmail.com>
References: <20251127131526.4137768-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=brauner@kernel.org; h=from:subject:message-id; bh=YjUBeN2vABSl0jpHGvvyfif2KOLnq/uDzZ6pXUv2Wa0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRq5khpzHhc2B4ycVahc/kXlgVvRRT3OeodeVN7ub1z0 b54+xuBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRZGf471MnJXli/8qjBeWl GnLRuzj7Jcsyy8xuONX1ivoWHgrIZ/jvFPywjf+bl+6HGY1pMvk7Zhl/yvrOHPX36Pbl7Hc/VPg zAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 14:15:26 +0100, Mateusz Guzik wrote:
> Rationale is that if the parent dentry is the same and the length is the
> same, then you have to be unlucky for the name to not match.
> 
> At the same time the dentry was literally just found on the hash, so you
> have to be even more unlucky to determine it is unhashed.
> 
> While here add commentary while d_unhashed() is necessary. It was
> already removed once and brought back in:
> 2e321806b681b192 ("Revert "vfs: remove unnecessary d_unhashed() check from __d_lookup_rcu"")
> 
> [...]

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

[1/1] dcache: touch up predicts in __d_lookup_rcu()
      https://git.kernel.org/vfs/vfs/c/ca0d620b0afa

