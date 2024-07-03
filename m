Return-Path: <linux-fsdevel+bounces-23002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572DF925545
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B214B283D51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EEC136994;
	Wed,  3 Jul 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGPXMEDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414215B1E8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994943; cv=none; b=J1bM9pyh9M6x2AySiOx+n30x+Y05XkTH+kOPBi4WZiPnky/Bi4/fV6dzWnv4wL39idhQOVKE8rrj28T2ggJTb8qEBfhvCFXQRarSrjILdO8IdCydihOzlhJ7cTzvXQVPUs2aJt4ISf9j61GksSXX0GMhuvoAIt9+eoKHFFdm2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994943; c=relaxed/simple;
	bh=2zUH6uFsxSTonbxAWvu/O5yCO2NITJUBHr3/kEyTnYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM6nrq+rGY3jscB45aJ00cAAJMDG8J7saTchvZhB62VtrM+LM34bxJH/sJX2/xYohY4l+0Vf4L679OYqOo3H75pPjPcwbL6rw9uER0q0HS8EG3pZFL+F5aLnAZbt3TAisJ4r58WsSJY6C1keBSLAx3LjrH2u8A1Tu3EJFPI2liY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGPXMEDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567F9C4AF0A;
	Wed,  3 Jul 2024 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719994942;
	bh=2zUH6uFsxSTonbxAWvu/O5yCO2NITJUBHr3/kEyTnYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGPXMEDZCQo6giUT1pfHyBaacupxIuYwkg9lrPT+ifJ31jAoGoH8Ylq6AvpKqN8xY
	 BFoFZMYs8WyAhc+qvh8ATbUIYiai0jRsv51aL0utzzjcLJHNEwLQMqpV8tSo9/sLLS
	 ZsNEmu+MUn9A/JJ53/tWUEqWL06Vfee+Kq6LNIiEBr6o1ZEdrO7CBimAGqmLAi74Uq
	 YyREuh4DQ5rAToUBadSfHboDpcHsYrG6mOkWmnXoiH8Vls3cjQN9rjCcldiOXYJSsz
	 3NnBHk3QqWQpEnSb+Tclnp2WxX/BjWc2j1baqGO1RZZ/gednt5B4+lsHg1u1nGIWQd
	 uYWzZ72lxvQfw==
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>,
	Ian Kent <ikent@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker list
Date: Wed,  3 Jul 2024 10:22:14 +0200
Message-ID: <20240703-dastehen-sachlage-1df2294b820e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702170757.232130-1-bfoster@redhat.com>
References: <20240702170757.232130-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=brauner@kernel.org; h=from:subject:message-id; bh=2zUH6uFsxSTonbxAWvu/O5yCO2NITJUBHr3/kEyTnYM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1cpkz+U+76qiX+lnL9cZeRS0LllNNE7oOSkoLHTy7g /OticuEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlofmX4K6K/QOz9qqA6rzt3 r0dW/PEXO26Z/qPQ4tb9Q+lPqj2m/WRkuHi4tMApTPviP3eH+xOevTxjZ3S1hy12+aoqnejdrrJ MzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 13:07:57 -0400, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
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

[1/1] vfs: don't mod negative dentry count when on shrinker list
      https://git.kernel.org/vfs/vfs/c/e161afd05b24

