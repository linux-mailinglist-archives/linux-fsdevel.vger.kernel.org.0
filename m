Return-Path: <linux-fsdevel+bounces-66331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CBC1BFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1078033B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDDF331A6C;
	Wed, 29 Oct 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5xT2EfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4443043D1;
	Wed, 29 Oct 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753028; cv=none; b=p9pzvZ9AokmFVHX11sWlsBlwsWwxiHm2LaGzOO+HlEKTxWwf3dkS4ntCusgh9fkdPEqUKTu7WK/EuHeBeV53LCVBo5in/IFZHxjfxoyikfZkqiGeoAtxXHm2Xds3rlgd+JZzHbbmYKPN6JgMy7+9DY3VIpzYGyuOM3wYscuZ18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753028; c=relaxed/simple;
	bh=73eqOJ2QziWmVIpakG9IV6mnOlesefS7aJxiLp8hRZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTSLIreHySQELv/BFyFlOXGaZUWhEYU/F8bwC7BcoKyiwYQ8LEkwCk0Jal3FW2IA89Ow00oA00P42e856a+kIxeSFM5HBmnPivv24562b1JkBrx5mE6rUzAWPYpycRpaMS3+xmxNS52ExNscY9NCJIok7F/blYQ7VTPYZlqK/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5xT2EfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D48C4CEF7;
	Wed, 29 Oct 2025 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753028;
	bh=73eqOJ2QziWmVIpakG9IV6mnOlesefS7aJxiLp8hRZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5xT2EfCYmoll1qNwK6g2PN2r1Gbz2cBca/5kRSA2fa4oW0dxMPDCfmvPGTLnOTNT
	 nrKKv98D00dQm9PkNlzr4he5GHNMxcf2gbJ2NG+gStQlWTQI2Z36b9Kltm2QkTTbK1
	 m7St5DPrWHEehT7Xs8ur5M4670uTozWvxahd1eOGSAyOXnQCKD52bRX83cA6HgGOpk
	 fMV8GJsLXBelTkGaV2bLp8lI/DHH9ujkAFhO0LI/tWqQuSM1/Vj9/F89NsEPJJMpOE
	 rxZMDDig1nbiyLgodxx0CcqQDuLGWQJJeohnBPxCXNUaNWiPMxKYf+o/Fi8z0Dq9xo
	 cQ6TBV73RUplg==
From: Christian Brauner <brauner@kernel.org>
To: mgurtovoy@nvidia.com,
	izach@nvidia.com,
	smalin@nvidia.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu,
	eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	alok.a.tiwarilinux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: fix incorrect check for fsvq->kobj
Date: Wed, 29 Oct 2025 16:50:21 +0100
Message-ID: <20251029-zeichen-gezapft-bad398e96a70@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
References: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=brauner@kernel.org; h=from:subject:message-id; bh=73eqOJ2QziWmVIpakG9IV6mnOlesefS7aJxiLp8hRZo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyme+95GXBtO15udi1v+kqnzdwPwuc6qegXiP4bd1W+ 4SA/bbeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO59oPhn9rCBZxsUZk3XCOv V6WZHJYNkjPc/HbGhTm79+0JeKcmcZ7hf8HHZfl5xnG76tQ5k43SeM72ffnzjGGmn6P3I0mfRZo mzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 Oct 2025 03:46:47 -0700, Alok Tiwari wrote:
> In virtio_fs_add_queues_sysfs(), the code incorrectly checks fs->mqs_kobj
> after calling kobject_create_and_add(). Change the check to fsvq->kobj
> (fs->mqs_kobj -> fsvq->kobj) to ensure the per-queue kobject is
> successfully created.
> 
> 

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

[1/1] virtio-fs: fix incorrect check for fsvq->kobj
      https://git.kernel.org/vfs/vfs/c/a20432b6571d

