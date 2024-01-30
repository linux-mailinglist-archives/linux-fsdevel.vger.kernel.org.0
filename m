Return-Path: <linux-fsdevel+bounces-9509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8F841FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BE41C24E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C922604C5;
	Tue, 30 Jan 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdM2ZVdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF06088E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607382; cv=none; b=GIY1pmrwPjoxRN4+DoQgBPvZbEuJYGpIkCzKDF+gkCeZ6L3Nxp8x/cqW2TkLJSL2DNBWIegt1UOMRF9go8KB3eQTIdpM8+wSAuZEwtClGViT0GW05AwDyXFmoCjQXN1SBBqG6Li42HL0aLc/Np9A9ELuudre8OmlK2+bavqfZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607382; c=relaxed/simple;
	bh=pf18sntPGN4N2O1F0aivlRRCykqRbhA5NNK7Hzt2eOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNq2JfoqiLMky+DxxklWaB60NKGRLvHq458PP3i+HpGLFQeF2sR+4H/2AzzVXanCmKLhPfBFdnnfnnway/6HqMN9WTSBMe5RnVfV7N7COv61A631X/lXKoeCJPQpItRW7+8xTGt9+B2Ir3Mzq3p2ARDmo6od+l14ObD9xIYivFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdM2ZVdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68182C43390;
	Tue, 30 Jan 2024 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706607381;
	bh=pf18sntPGN4N2O1F0aivlRRCykqRbhA5NNK7Hzt2eOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdM2ZVdRfZLGwBA+35WiRdeFTkD/yeoszZbL2oS42fvTU7j8zrF6S+lr+EYz6ZaVG
	 anhL9K1UyXQ51J+94HPLxwrzy9lnO6aU3tXbKs9hDothuquTjdACTkMiloMHFPEeIJ
	 6+m+eI9ofxZ+ATc7WJnwiwerPguF4/F6JwK88WgGHZww33IOGkdO7DxciBAys5ry4n
	 ATHaLvfw3ogTdwV+4PJmIwu+HgbNSDd7K5pSqg19PIhQHcMcbVWCpgKyEOvHXiCeYj
	 0toUJaB3m5GRjGho3jLSI1UpX3yhICIXg/9Uux1lWP8HGsk1fQef189VwisZi7QTu7
	 Jrj+RAVl1kR7Q==
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	hch@infradead.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: don't call sb_bread() with pointers_lock held
Date: Tue, 30 Jan 2024 10:36:03 +0100
Message-ID: <20240130-sucht-lufttemperatur-4911ff76679d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0d195f93-a22a-49a2-0020-103534d6f7f6@I-love.SAKURA.ne.jp>
References: <0000000000000ccf9a05ee84f5b0@google.com> <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp> <20230327000440.GF3390869@ZenIV> <0d195f93-a22a-49a2-0020-103534d6f7f6@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=brauner@kernel.org; h=from:subject:message-id; bh=pf18sntPGN4N2O1F0aivlRRCykqRbhA5NNK7Hzt2eOs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuOMyr9/mTnvrHdpF3wlLcdv+vBxR2fNB0Ld4+1XRj6 fXQaWtPdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkXZ3hn12gOds042Vp5wWO My9LLNn5qPiRSPV/NvkADg422//1tYwMTzY8lJX4yXlwslHv+fC4g+xXI5RSdBVdvXc2/zi7Y3I HKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 10 Apr 2023 21:04:50 +0900, Tetsuo Handa wrote:
> syzbot is reporting sleep in atomic context in SysV filesystem [1], for
> sb_bread() is called with rw_spinlock held.
> 
> A "write_lock(&pointers_lock) => read_lock(&pointers_lock) deadlock" bug
> and a "sb_bread() with write_lock(&pointers_lock)" bug were introduced by
> "Replace BKL for chain locking with sysvfs-private rwlock" in Linux 2.5.12.
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

[1/1] sysv: don't call sb_bread() with pointers_lock held
      https://git.kernel.org/vfs/vfs/c/763f9ba5d63f

