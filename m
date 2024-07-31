Return-Path: <linux-fsdevel+bounces-24690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE99431D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C568A1C23FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA61AE873;
	Wed, 31 Jul 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAFWlT38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAD1E487
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435412; cv=none; b=g0g8t4OgEkewsnZaejGak9JeCdFjFJeQ6NuhwzU3lb4pH8WqSqLOZTgtNQy5sDkRfBYQGoG31bi/NOwpWKv+VJWsrRmKQdwa+DxWtIUj5fDVfgilw67K4tHwiP5W7qsFHs5AEpumIfDP/Q8JBwCfjiYeQjOwseNWhh8RwP8BO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435412; c=relaxed/simple;
	bh=DU6S62z+u1Pn9/P/RJpE2/No5dTMVYRqd+P4mbPQmcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUQH+Z++ict1womMz8CTROQCyC/bifCdGn2Yi2rT7z/MiVEskSeqdeDt1Y79wNNluZ5UV8vS8AUBWBS8FKSNwz1fj0cxngg9qfa8WvR42X4gIQs8CLYnXeSqqOaEtQuJhvp8fof1/LDR1GaKjvFT6JFmGBpJTuVHVGpgNzzeRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAFWlT38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1DAC116B1;
	Wed, 31 Jul 2024 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722435411;
	bh=DU6S62z+u1Pn9/P/RJpE2/No5dTMVYRqd+P4mbPQmcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAFWlT38h0aoE8K+kg8hQgeZShue2N2s3C1trQ4Eg4BHb6+e6n2XDDFTA5ujxdnYU
	 jZwuZJT948BJN409ctKPiQGJhBtxTU75DaFzLcOte3zYs3Kk4OIava/RbGpTfYcbZY
	 eTLoBki+4fTFZCbbsR2ju+3rMRDBWGEPNtO6dSDBwJyIuc4dBGS9klAsU1QWnFUtR0
	 6p7osFEb//+DgZ1C5U0/sVv7MRuE0ZExbDiGsLKRr+0NsEHFB6+yp1+OvLusPHA0v/
	 FjCE6b7UWQTYVbqFxysHPOL8gmhkPMmtUux+vtoP1TFys8EUWcOgkCYRtUKyTkcupV
	 zCjGIhzwI2L+Q==
From: Christian Brauner <brauner@kernel.org>
To: chuck.lever@oracle.com,
	jack@suse.cz,
	yangerkun <yangerkun@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	hughd@google.com,
	zlang@kernel.org,
	fdmanana@suse.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yangerkun@huaweicloud.com,
	hch@infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Date: Wed, 31 Jul 2024 16:16:42 +0200
Message-ID: <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731043835.1828697-1-yangerkun@huawei.com>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=brauner@kernel.org; h=from:subject:message-id; bh=DU6S62z+u1Pn9/P/RJpE2/No5dTMVYRqd+P4mbPQmcU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStcvf2nVW3JPtUpgv7Hff7u2b7Cri/Fjtp63t7tbvup prlZ7LvdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkii7DX1mz8JCwm7f4TuyU 0l57mGFmWfXnjc9/rbv659ku/T1L1vMzMhxQuMa3M+z8j6vM1j+t/j5Q1uV7XPnl9G8Trx7W6iM 5K3kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jul 2024 12:38:35 +0800, yangerkun wrote:
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> [...]

@Chuck, @Jan I did the requested change directly. Please check!

---

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

[1/1] libfs: fix infinite directory reads for offset dir
      https://git.kernel.org/vfs/vfs/c/fad90bfe412e

