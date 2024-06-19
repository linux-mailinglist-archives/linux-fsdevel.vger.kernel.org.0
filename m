Return-Path: <linux-fsdevel+bounces-21924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E090EF9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32494284EF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A41509AC;
	Wed, 19 Jun 2024 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNlSj1K3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C0D26A;
	Wed, 19 Jun 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805698; cv=none; b=NrRXLixU9mQcse3gpm3JyNBV4+gsG6xwaGMHETU1a6y6f3uSZU3+DHgVw+VYybJKXgP5GaPiX+5X1CEbg8qqPaNyDR4+2toFol+ZGdntsf6VuBOiq7i6OYetInAgiwekyHyNkuoZAx5xSyomEKscNC96ytEoNxXKJizvMIilZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805698; c=relaxed/simple;
	bh=CEgOzGB7LClupNgDDq0D815zenWO1JkO/EBzHOwsrME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEyzyyjJSX2KnLmg4vw4uQFJHRcXsbca6n9mxUe2Mdc9xcNaNy+jAxrLyvLSDE6Bu0mXz/ox/BjMqrHjME0FSQL83YNbBQoxn80P0wq8jV3UzQJyiErM8TKw+PQZIWxE7GceoVx0ksrQxWJW/M/1Q2LC4dbGdSaB/m6I15DP+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNlSj1K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F4C2BBFC;
	Wed, 19 Jun 2024 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805698;
	bh=CEgOzGB7LClupNgDDq0D815zenWO1JkO/EBzHOwsrME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNlSj1K3HpYLwsgbrm7zxDdxWjqdGCVO+92QAXmVtEtZPVdLbI5ZURMT7kRT++WM/
	 hFU9sZFraYvulrCDTuKvMU1dTWfIKv3SJwG9NJOeBL+anoJwaaCOJqHlQxDE7j52kg
	 l4rzvoJuSxjqz+Cv9VwFHvIDQ9HjNCe9VU1EYqq/nmx1sJE/gFhrbHSgNnNRJmrjCv
	 DyXAR12d/ngMDKfb3x6ixX0dgm3Ip2PgLQDDbabovZL33JlHFpEcf6Ocsm4ICug1EE
	 UILSLGuL1e+wo5yBchqX4gmVdAwGpImmjxicRpEJB45SMuis0uIIxPxsf7VDyCMTj9
	 LvOzpPVPUHfdg==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next v6 0/2] iomap/xfs: fix stale data exposure when truncating realtime inodes
Date: Wed, 19 Jun 2024 16:01:29 +0200
Message-ID: <20240619-umliegenden-original-ece354ddc842@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=brauner@kernel.org; h=from:subject:message-id; bh=CEgOzGB7LClupNgDDq0D815zenWO1JkO/EBzHOwsrME=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVPdm1lFl1oua3Ewv2KilkH24Tt5r5snNvg8232Ng53 Slun/87dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEpo+RYYnq3K9f9/7Pa5j5 5q3Bj+A7PpOsWi1mv1687U7T86fpRvcZ/hf+LXBMujvNeV7ndL85YnViEdrbM3ILsu+LvP67bFs UGy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 22:21:10 +0800, Zhang Yi wrote:
> Changes since v5:
>  - Drop all the code about zeroing out the whole allocation unitsize
>    on truncate down in xfs_setattr_size() as Christoph suggested, let's
>    just fix this issue for RT file by converting tail blocks to
>    unwritten now, and we could think about forced aligned extent and
>    atomic write later until it needs, so only pick patch 6 and 8 in
>    previous version, do some minor git log changes.
> 
> [...]

I've put this into vfs.iomap for testing which should end up in fs-next asap.

---

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/2] xfs: reserve blocks for truncating large realtime inode
      https://git.kernel.org/vfs/vfs/c/d048945150b7
[2/2] iomap: don't increase i_size in iomap_write_end()
      https://git.kernel.org/vfs/vfs/c/602f09f4029c

