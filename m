Return-Path: <linux-fsdevel+bounces-20831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA38D846B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3631F227CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371F12E1DE;
	Mon,  3 Jun 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTEgNAXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4512E1D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422762; cv=none; b=HDP6Xy+cRTOUsFhDcW+DnYXZE7kERoOTXers1RiY51LpbCN8DueqTukvhhT3YhPylp9wI6n2326fEpxH/UhJMY4EKstx3m00148zAU6i4LhlrrQOEu1bnXC+/5UpWu+W0JILZS79tH5k9lodovTZcfu9JJ/DdWgQtU7kbtKzHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422762; c=relaxed/simple;
	bh=aRTEJPua0TVAxoHlVq/mpvFaY70e4bRglzv1MxsutUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLIn/zzoJbvBGHLEM7VB2anfFH+QXo/2yXjwJMsRdQsgz+YDIdxO3XXWfVc1cyNl/0PQ7KH5TX0dHOCSq4CzLLe7eX8nz97r0DZCY4JhOmcqEzvaWqQo8tUii/T73rJBb7p3eIh+vqYEs9ktTEeUx892iayvmABIsiH1sFyaIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTEgNAXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FBC4AF0B;
	Mon,  3 Jun 2024 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422762;
	bh=aRTEJPua0TVAxoHlVq/mpvFaY70e4bRglzv1MxsutUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTEgNAXuPV+b5l3ugRGoKnr479AgIjmtfyjGXuHDUEzp21GWv8xnQtUo4/H8DYwMJ
	 X81fZd5Qb9f0X4lymMwln7rlGZVgY17MifiWyXOY9VmYgaEUfjq3bjC+t85PJv/kYZ
	 RkZQP7aCS1XCIn2MP4f+5rIE9yLeFJDvSuIk6reexA/81oAH69oBgn7s0o+/gbThYg
	 aJzK2bo+k81SFZxF+grVqbqAuSzmcYUWnS5haNe4ZRZ47Vg0L1ID5QFjCHDszHTXIB
	 mWcbOrRPVnQWJcNsaEwF64jZPmeYtt7/9Wshdsl4edUo2bdULrUSMf0hlTL62orDDU
	 LB04IBl/V40oA==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	david@fromorbit.com,
	hch@lst.de,
	Josef Bacik <josef@toxicpanda.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	amir73il@gmail.com
Subject: Re: (subset) [PATCH] fs: don't block i_writecount during exec
Date: Mon,  3 Jun 2024 15:52:25 +0200
Message-ID: <20240603-gewand-dezember-07697c3252d2@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner> <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=brauner@kernel.org; h=from:subject:message-id; bh=aRTEJPua0TVAxoHlVq/mpvFaY70e4bRglzv1MxsutUE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFnlp4/XTqnAaHpZXGE6es/hov0PnOVsY+QPSQW8sex Qz3KXVSHcUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhiWR4Z674u8qYb+UBQ1PF yRevP/y+y5k1/KBxORvPyomRRz8x/LPnir/55WDO99/Koqr7/fYeeKnwMV9ZQFBlklrzM3WmaEY A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 31 May 2024 15:01:43 +0200, Christian Brauner wrote:
> Back in 2021 we already discussed removing deny_write_access() for
> executables. Back then I was hesistant because I thought that this might
> cause issues in userspace. But even back then I had started taking some
> notes on what could potentially depend on this and I didn't come up with
> a lot so I've changed my mind and I would like to try this.
> 
> Here are some of the notes that I took:
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

[1/1] fs: don't block i_writecount during exec
      https://git.kernel.org/vfs/vfs/c/244ebddd34a0

