Return-Path: <linux-fsdevel+bounces-54437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B468AFFB1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD93AFDA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61E289E31;
	Thu, 10 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubnVVTO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51D289807;
	Thu, 10 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133246; cv=none; b=rjtcUcMxQ0xb3P1FvEHy9eeIk//3Tj+dtbyZWQwffaFwNsPry+ayauKt6Oj6qFUAu9+GhlIx9kmoWLixWXc91Q8m8pO/R/j+WnyGgqmnFvKnnJK0AZg7GZaxwfc04/r0QN5xvNlascAW5hPnx6nguN7Q/eigDGMCh8mIYpdZvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133246; c=relaxed/simple;
	bh=NtjDzTU3HU8YKafAou6KA5eBqrJWEmyyffbga8G3JEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPZ5zIbpM1fvlb2QfMEvEiLQ+HxCjzf/rpGgbQtUkbwjcURbXtEMEak/H4FR42GV8jENmBNILS3akJUBDIcYzblfoYbHnBMpQWPV93ViASxJGVhGTqQ3ryfd0IlbaBzlgl1ZKPVUANfjsd1hNhNNFGbxb3ohqZM0n739HYZZTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubnVVTO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD5C4CEE3;
	Thu, 10 Jul 2025 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133245;
	bh=NtjDzTU3HU8YKafAou6KA5eBqrJWEmyyffbga8G3JEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubnVVTO8m27Thia8b0lueBUSi6VVBSeAk/oKeye3H9pQpqx1bIMhYTD117/soBAdi
	 5qLCLbE2x1FkKjM2GItvwGBMLUFXIJkIxzQ0h5ZZDvFlA8iVTGLE0vnfEXyExxLFrI
	 NWyORZSw/tLMOCHDO3PZPXvfzsyZbUa1AQ+vEk5GEJZ5qy5RJ+LIOt7vf+nZrSDW/Z
	 KZh5ykduRjj8/LuXwQjjHBX0lyNI+2+KEuAaIXKysoy2virLxYdGgyp3/1QVjHkIL5
	 H5TSmeHj/V+fK38Hyl8OSSakLCZpDihgm8DtlAi4WUSxMi8v5093QYkt19vT2EdCRS
	 gexFnroQjZ5Xg==
From: Christian Brauner <brauner@kernel.org>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wozizhi@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in __cachefiles_write()
Date: Thu, 10 Jul 2025 09:40:34 +0200
Message-ID: <20250710-nichtig-rennen-83a1033aee50@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=brauner@kernel.org; h=from:subject:message-id; bh=NtjDzTU3HU8YKafAou6KA5eBqrJWEmyyffbga8G3JEc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTk55ULCB/abrr0nOb61XGcJ7eyMS53Z+k5//eb++98m fWvDoUc6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI9j9GhkkLvWw/7Vy2Y8eu toZ3Us3zzi5QM7/9a3r/xj3TLposOGXA8D/POIvlVMQ02eIrS+TyWNj3NKc/yLa4vvvIBiHziI2 Lf7IAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 10:44:18 +0800, Zizhi Wo wrote:
> In __cachefiles_write(), if the return value of the write operation > 0, it
> is set to 0. This makes it impossible to distinguish scenarios where a
> partial write has occurred, and will affect the outer calling functions:
> 
>  1) cachefiles_write_complete() will call "term_func" such as
> netfs_write_subrequest_terminated(). When "ret" in __cachefiles_write()
> is used as the "transferred_or_error" of this function, it can not
> distinguish the amount of data written, makes the WARN meaningless.
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

[1/1] cachefiles: Fix the incorrect return value in __cachefiles_write()
      https://git.kernel.org/vfs/vfs/c/6b89819b06d8

