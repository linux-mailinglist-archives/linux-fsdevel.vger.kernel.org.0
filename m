Return-Path: <linux-fsdevel+bounces-32112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A949A0AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31425281D96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743A209F5A;
	Wed, 16 Oct 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad5gA8s4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77C208D99;
	Wed, 16 Oct 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083957; cv=none; b=tlGEhkoU1OFqRUnCzw0EiNBBdmqDypLzuAZbMyEXwmAMv2JHKFSGuqqa0YI2Z5qlvuvdHqgBI6XdhrxhQfV0E/ADlRzG/Wza5rS+i7crzPZq3NrRDudEQkY6PPdy/yjBizTt3M5pnw0RDN32GTLN8WlgOivObs5MT1BOAZ8ZZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083957; c=relaxed/simple;
	bh=fft/pJsETeg9caTaRxKFCq/djw1/xF5qXNnUEu1uXsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIoBKPrPqDueuc/IbSjp8eufln6AzJQyfbkLDTZXMCEA8ZFkrjzP+6YdNz329LmDqUPp78NQx0XbRgW0X3VtSgeQcZlDzd16RwOxUz0WLYH3yJTfhzFufQbbxgMeNC6sq5b6+VT9rmQoQIGsPXJCGU3WjRuzCjWr0pNMUb2J+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad5gA8s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BDAC4CEC5;
	Wed, 16 Oct 2024 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729083956;
	bh=fft/pJsETeg9caTaRxKFCq/djw1/xF5qXNnUEu1uXsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad5gA8s4/j3KUQc1MIB3l+kq0Dl1b+MpFdyZP/Y/W6oSwbPr/A/cvALObpSyq2iVk
	 HTbF9fyCnCX37TAR9soqNzM22tkJUCMB1OKtlObllm2VTGwdG5wvemre2vs7aEYFrw
	 l4sxy0CcOMVzYnTXIgnKUSF7ImqYBzqn78hZSsyErPtUBUWU7K9HxM848C7h0iAbDF
	 6EPOO1Jq5+22dM02zRU7rTDo+qv/eWtnxUGzoCgEoyG6MkSTPLGJaRikKG2qrUpz0m
	 IvDvtmu5Cmr7Tp7zevgUBPnTBB0jNhZR+PRIsqUB4l7xKJPf7USB8CeeaaNlVVWo/2
	 22HhpB+q99E8Q==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: fix kernel bug due to missing clearing of buffer delay flag
Date: Wed, 16 Oct 2024 15:05:45 +0200
Message-ID: <20241016-dreiviertel-erzittern-f8742ac9db30@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015213300.7114-1-konishi.ryusuke@gmail.com>
References: <670cb3f6.050a0220.3e960.0052.GAE@google.com> <20241015213300.7114-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=brauner@kernel.org; h=from:subject:message-id; bh=fft/pJsETeg9caTaRxKFCq/djw1/xF5qXNnUEu1uXsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTz79Lt2KVjLO886y3TmZpX1m7TArS2bGpZwuW6v7+8X eH2rZWuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZF8nwP3LfBt2uxnV12stL D6qyvS/pjW7X/FCrNZdJ9tAE5XVcSowM8/7NMq/SPJDPOCFiyZ2XCw18TvMr2artqFl41FLc5/N KXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 06:32:07 +0900, Ryusuke Konishi wrote:
> Syzbot reported that after nilfs2 reads a corrupted file system image
> and degrades to read-only, the BUG_ON check for the buffer delay flag
> in submit_bh_wbc() may fail, causing a kernel bug.
> 
> This is because the buffer delay flag is not cleared when clearing the
> buffer state flags to discard a page/folio or a buffer head. So, fix
> this.
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

[1/1] nilfs2: fix kernel bug due to missing clearing of buffer delay flag
      https://git.kernel.org/vfs/vfs/c/6ed469df0bfb

