Return-Path: <linux-fsdevel+bounces-57081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E58B1E978
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7D23B99BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF025761;
	Fri,  8 Aug 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxBmKJaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E52E36EC
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660845; cv=none; b=t22EBaqehg9oEMEhn+ER1GxoBdRvZRD9Ut/DxAMVTNGPREiOYdvDzq0Tqpwc5ceWH14prYdkyPYq1xiAvyP4IqTcpNiPBJ3sFcg3NVizJ8IrK/u22z9oO59GAOSwHwx4u2latrxbCkXPiul26NCxQ2z7S/3feUTklYcbdMEfS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660845; c=relaxed/simple;
	bh=Q2ctPsk96bN1yeFFrO6XqqE/+Ygg13VrH42gmMss1cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoVOQREs9/7QA7MK01cdBoKV3iInpOEE6Sf5N9eVozTPz2OqLFjALxRg4IFAQTbzqz9J1+kvxLTA6RcpWWNoTc1/3HyHuijLp2gw6+Ly/VDe13EuTsnYjZy0xGqcVA42vmlLjoy8I8spcJyUoO7VS1jkK8PJp4wqhtZfiaNzrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxBmKJaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B62C4CEED;
	Fri,  8 Aug 2025 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660844;
	bh=Q2ctPsk96bN1yeFFrO6XqqE/+Ygg13VrH42gmMss1cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxBmKJaB1qQ5dHsuYqemh1MR0blcSdFqXRH9t82AWBPDvwKujer8c56rBUHFYzvtI
	 tUDH6Zh6qVpTL4iO89lJ5medO6C8iIZEIHaDNjwHLaVUfJHm6atPfcYi4mt1XOtSdA
	 m2eO1JMYZmWcvKU48f0qryagNXSRE47s5uTov8U4ZII3sltqd843RYTlBYRwA1g6bM
	 5Gpz08fhKnPsxSra+VeQa+Nxk0rCIAMALB9ntY9JooXGdTW7uJgwxtM94BJhhpl+Gj
	 jRKusvJS5mYPUZDEJgdOAjchqqUEGzqMPkOxCnOlGDWMIijanrX3UdAHQdBu4kFn1y
	 3axQB1Ord1Quw==
From: Christian Brauner <brauner@kernel.org>
To: miklos@szeredi.hu,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
Date: Fri,  8 Aug 2025 15:47:17 +0200
Message-ID: <20250808-abzug-neudefinition-4b3bc8fa13b7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807175015.515192-1-joannelkoong@gmail.com>
References: <20250807175015.515192-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=brauner@kernel.org; h=from:subject:message-id; bh=Q2ctPsk96bN1yeFFrO6XqqE/+Ygg13VrH42gmMss1cc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRM/f9c77TVmvMbJr88Vi7BymRz52FUZJjJoodX/zG49 d1MScz41FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARoZkM/0NzHpQKGT5K4Pos IPr9oYmC071fn883LbDNmOat5/Pl0kmGfyruoXkCsQs+zl3Pcm6pztabivnu9z/YsO4v2bT03+6 cZZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 10:50:15 -0700, Joanne Koong wrote:
> With fuse now using iomap for writeback handling, inode blkbits changes
> are problematic because iomap relies on inode->i_blkbits for its
> internal bitmap logic. Currently we change inode->i_blkbits in fuse to
> match the attr->blksize value passed in by the server.
> 
> This commit keeps inode->i_blkbits constant in fuse. Any attr->blksize
> values passed in by the server will not update inode->i_blkbits. The
> client-side behavior for stat is unaffected, stat will still reflect the
> blocksize passed in by the server.
> 
> [...]

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

[1/1] fuse: keep inode->i_blkbits constant
      https://git.kernel.org/vfs/vfs/c/0110b6d5545d

