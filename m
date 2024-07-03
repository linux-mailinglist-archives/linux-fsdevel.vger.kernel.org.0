Return-Path: <linux-fsdevel+bounces-23004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B9592557F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DF21C22585
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B313B298;
	Wed,  3 Jul 2024 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYIXoNSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6724D584;
	Wed,  3 Jul 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995857; cv=none; b=L+/2MKsKDw3Tt1+rbpbdr0pyjXGKEtu+ngKx3l2l14KgrYeWaGral+sNg9MSdjdwgn4F1GxhFZ2nzkmoSiGC9xu8W6Hh3pHNix4b0nk12NM1XRarQkCbQbJ0xCmuwOhjM2Q6szec1ZDWx7VIuPPitFWhBx+X0c05HLQi/yBskao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995857; c=relaxed/simple;
	bh=sJN+MwV5sUnjoxSQ5dfAVt8zKfWkamWIkI8xHG1+5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFOm6OJWh2rpRe/UH48/xqZnfH20K58Md7lY0wNxoN68gTMJ87WtiRNR9QFRgRlCaot4KxxtdCTJIUDSQN41Lqk/46oy3Hpndr1Df4Y2RKEJlwigdnoXMSOAEcOnblkeCiXJAxUId2iVUjYfJfUZZ88V4F/z7uKZo/Q1hSBLzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYIXoNSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FEAC2BD10;
	Wed,  3 Jul 2024 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995856;
	bh=sJN+MwV5sUnjoxSQ5dfAVt8zKfWkamWIkI8xHG1+5/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYIXoNSnDnTODvPBZ2lWNiOAhSRpc/Ft1dVV3BiFipzKHxsDmrIByL4EAO+3IQ0+m
	 U0dVB539ht4XH4U9PYqwTkeAPNdPW3m2vl0OfRnSrtf8QJwapI5epMUx1kGzzocRNe
	 +r0bKbP84mX1sXSFxMJ8y90kIQx/iolbmU29SIjmKFX1yUCkHGhhVaCeB1ZlyDQDVl
	 oqFjDHqBjkcro6AyOgpUDFjb1WOUGt4kTGI3pjFK0V7k4B7HNnXmYH60gb9cL20l3k
	 9nEusexxMFMacoQCtSHIBl/x6rPyPoNBc43Mrpr/ASYn8CoWuEGyEc7J0TkELnNwaS
	 xQRvrXMCXj+zw==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Cc: Christian Brauner <brauner@kernel.org>,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v3 0/9] cachefiles: random bugfixes
Date: Wed,  3 Jul 2024 10:37:24 +0200
Message-ID: <20240703-beweis-glimpflich-439d10d8ea13@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=brauner@kernel.org; h=from:subject:message-id; bh=sJN+MwV5sUnjoxSQ5dfAVt8zKfWkamWIkI8xHG1+5/E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS18h5fzfvjj8+mIIHXTK3+lpoZn/JX77N5alJzQZJXM cEgvEigo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL+EQz/U/PmMhQcv9nvURe/ brVqbY2D5b2lTOrvorf8U9dP3qzWyPBX+pN+nderS4Kne03ZZ65S5HAV31vu/PaN2hn9RJuQ/yt ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 14:29:21 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series, in which another patch set
> is subsumed into this one to avoid confusing the two patch sets.
> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
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

[1/9] netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
      https://git.kernel.org/vfs/vfs/c/857edaec7e8b
[2/9] cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
      https://git.kernel.org/vfs/vfs/c/6438822b8978
[3/9] cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
      https://git.kernel.org/vfs/vfs/c/ba71b9fbe167
[4/9] cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      https://git.kernel.org/vfs/vfs/c/389332dcf4ea
[5/9] cachefiles: stop sending new request when dropping object
      https://git.kernel.org/vfs/vfs/c/6091d755c681
[6/9] cachefiles: cancel all requests for the object that is being dropped
      https://git.kernel.org/vfs/vfs/c/f4648f418a04
[7/9] cachefiles: wait for ondemand_object_worker to finish when dropping object
      https://git.kernel.org/vfs/vfs/c/9659aaa5c58b
[8/9] cachefiles: cyclic allocation of msg_id to avoid reuse
      https://git.kernel.org/vfs/vfs/c/1a95962625e1
[9/9] cachefiles: add missing lock protection when polling
      https://git.kernel.org/vfs/vfs/c/6cc42ff0f5c9

