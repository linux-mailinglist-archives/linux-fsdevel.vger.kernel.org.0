Return-Path: <linux-fsdevel+bounces-24082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FC939140
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBE1F221BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DB16DC3A;
	Mon, 22 Jul 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlIjsqkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37216D9AE;
	Mon, 22 Jul 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660534; cv=none; b=VG40/3vnsF9PVVrrQtEqwz9DhiU2WF+mM0+qtAXNaFyn9FKYsiuYPL160Pk80kalQej1it8/8qaS9SSzOvMT9aS/ALjgbkq6wlfT0hwAYfLGMgzAG4nNxv15qZasjqsmTKcq/JiNrm7bOIJuIo/TL5ICOJI7mWsMK44H+dOTaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660534; c=relaxed/simple;
	bh=yLj2P/sMrlD0MoAduPVz+cSWroJAsId42YUiPFDzwpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXnKSJFXNLNd7YROzF5PMmlE6sfACATgdBghEG1OaGD8hM6vdWgIunqt2g3v5KjHkiRW0NPbqewtVncHmTIbvI/+iR5DTo6vLYwYbUdjbBCAhlfLcy8f9td/VZ+HbGNAQC6xpJuUeRDd8LTyP5Cn/+L6wnc9yYoFOcS63qX+oaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlIjsqkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C97C4AF0F;
	Mon, 22 Jul 2024 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660533;
	bh=yLj2P/sMrlD0MoAduPVz+cSWroJAsId42YUiPFDzwpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlIjsqkLQlIzTAM9g6223xNmcORQuigK58+aT0FtUsaNxFT6C+UnLHpZd1J3ZtUya
	 mKhQBYYGLtn/HG4pF8QoTaAkPv3lln9s67/aAu8oI/Lg/H/yJLBmOKuqY8kMBrXHrp
	 s8FaMktN4PHjqIgOnwHvc3WHP8H34yeTX1o9MsFQBuLRF5/SgWCzpJs+tmTYUpRI4o
	 7pdnkKx8N+2f3oEvfGyZESM2ph84Kuxtdu+21GXmsBQld3Zk9fYOiIxxQGLMO9DsfO
	 /jxzyKnuLwprIDeATBiiNlPpzyXMP9vydh0naEsExpbsDy59l+IRX+wEfrKIsTMwg7
	 MhmLMHZQv+73Q==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com,
	Yu Ma <yu.ma@intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/3] fs/file.c: optimize the critical section of file_lock in
Date: Mon, 22 Jul 2024 17:02:04 +0200
Message-ID: <20240722-geliebt-feiern-9b2ab7126d85@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717145018.3972922-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com> <20240717145018.3972922-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=brauner@kernel.org; h=from:subject:message-id; bh=yLj2P/sMrlD0MoAduPVz+cSWroJAsId42YUiPFDzwpo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNK8k9mpHziEl9bgyPnf696sVPXf+qRPSUHrjO8zrz+ 3llS7uLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZdIORYeMN4fl8ufrWmj5v Op39dqosl2qNuyd2N0xvikYu/4u3hxj+u98rZUrVfuTZmW6/Lnat4p25me+u1N9dvW+18d1nfyN 2cQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 17 Jul 2024 10:50:15 -0400, Yu Ma wrote:
> pts/blogbench-1.1.0 is a benchmark designed to replicate the
> load of a real-world busy file server by multiple threads of
> random reads, writes, and rewrites. When running default configuration
> with multiple parallel threads, hot spin lock contention is observed
> from alloc_fd(), file_closed_fd() and put_unused_fd() around file_lock.
> 
> These 3 patches are created to reduce the critical section of file_lock
> in alloc_fd() and close_fd(). As a result, on top of patch 1,
> pts/blogbench-1.1.0 has been improved by 22% for read and 8% for write
> on Intel ICX 160 cores configuration with v6.10-rc7.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
      https://git.kernel.org/vfs/vfs/c/19f4a3f5712a
[2/3] fs/file.c: conditionally clear full_fds
      https://git.kernel.org/vfs/vfs/c/b483266658a8
[3/3] fs/file.c: add fast path in find_next_fd()
      https://git.kernel.org/vfs/vfs/c/3603a42c8c03

