Return-Path: <linux-fsdevel+bounces-34216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D939C3D62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C51F267DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02118990D;
	Mon, 11 Nov 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKZG7oTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012E139578;
	Mon, 11 Nov 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324831; cv=none; b=ngpCUkeqmgAFhloEC97TYHCRtHLEXcNwtU/Op7rnz1TqxKmMXSNeBjpTgj9lOUZHi0MNvjXfwV+KoXodw8iOdPSib/KtlLRGJKHcoKzYWbPeUUtJ8x0t2IHmaUB5Dc4Izj/8rqluhif/386sIfHwKG2IDQ8USdCYdjdr2HYsSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324831; c=relaxed/simple;
	bh=ykZQH5VbdujAJrOFHP+G49/xP/6A09GupDXNuDZK4fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBOJZ+fvvHE0Svlzft3cGvp4d2Zd7XC38ldnlZfIcc3zDRm/FtDddGnTvWxStG8PMcISYwka/Rp3S/B/YCqFh+E0+/And4yS06AW38ex2gT1wZqLSoBFHVpjG813LspjR54KfLk/4E7fZyZWaBRatULnZEmc1vejUqP1274lKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKZG7oTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE50C4CECF;
	Mon, 11 Nov 2024 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731324830;
	bh=ykZQH5VbdujAJrOFHP+G49/xP/6A09GupDXNuDZK4fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKZG7oTqQCLuJh+FMFDBetvW8vOirsihp5x4ZVOdurOzqy5XwChse15QgEXeaQzJx
	 r/GnRycfiyEVQCkcIASg2vebK5zFt1KsF3d5vbpu7e5SF45SYYXpW0lR/4vB1ieqCx
	 Z0hdi+Av5K3X2p9lUYWQf+3RNd7v41n4tNm/4Z1yBMtDS6QXajFmSYmc3YtHAzduGS
	 1Esabn8cn9B6Br+RurBiDACQoWsFX0SI4OCROBfv5p0kH9ZHydLc20CGVSBevSgV6S
	 7mlqnj/DnNSTk2qEwvMoblG78qasp5s1wHlpZFgq18qp0QiJWzJ6Tnk1M1gean+4vB
	 LchdL864Tbh0A==
From: Christian Brauner <brauner@kernel.org>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	Gao Xiang <xiang@kernel.org>,
	netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Subject: Re: [PATCH v2 0/5] fscache/cachefiles: Some bugfixes
Date: Mon, 11 Nov 2024 12:33:36 +0100
Message-ID: <20241111-helft-lachs-9d6ff31e2549@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=brauner@kernel.org; h=from:subject:message-id; bh=ykZQH5VbdujAJrOFHP+G49/xP/6A09GupDXNuDZK4fc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbvp6+tOSEbuPnvSLHst6msK/KXXFCkbdgf8h3bf8I0 Y4s2WkHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS9oGR4ZHwI+Hse9nPvOf+ vyf7XiR/CU87w9n5+SZaq2cmNVYX32L4w1F+f8XNsx5Pbz1O8LSx+36wQTdeoO6UW1WAZuf2sLW rmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 19:06:44 +0800, Zizhi Wo wrote:
> Changes since V1[1]:
>  - Removed some incorrect patches.
>  - Modified the description of the first patch.
>  - Modified the fourth patch to move fput out of lock execution.
> 
> Recently, I sent the first version of the patch series. After some
> discussions, I made modifications to a few patches and have now officially
> sent this second version.
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/5] cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
      https://git.kernel.org/vfs/vfs/c/544e429e5bc6
[2/5] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      https://git.kernel.org/vfs/vfs/c/a89ef3809efd
[3/5] cachefiles: Clean up in cachefiles_commit_tmpfile()
      https://git.kernel.org/vfs/vfs/c/d76293bc8658
[4/5] cachefiles: Fix NULL pointer dereference in object->file
      https://git.kernel.org/vfs/vfs/c/53260e5cb920
[5/5] netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
      https://git.kernel.org/vfs/vfs/c/37e1f64cbc1b

