Return-Path: <linux-fsdevel+bounces-32124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3529A0D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FB9286FCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E020F5B7;
	Wed, 16 Oct 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjAo4+PJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F420F5AE;
	Wed, 16 Oct 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090439; cv=none; b=un+RVmoLni3aZ534GQPGqD98xmv8Jpf2OHpd7tKWkszVz8lv/EmRv67bVDY6opZ6ux1UfBoordjbFwkKLUv6uTNzwyWTK5w6JmdUhn/tABM9XPZSH8BnvBgTbbn9KmXA0kJ1ptE3H7liVtcrVIlmbYTMv60QTWzPQFDvSgtfGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090439; c=relaxed/simple;
	bh=30rE6efOoF/qr6wkKdMnEi82qUo60ReIqblq6jhOy9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mscgvh8uIpjbDx3z8iyBT8Xvip3V2HJoedq9Y8A1BEMyJoGMUhL+gzx8o72HjAwp2X38tIGlgCQbqDv3J2UFzv/AXPUiCJdmHtx2JhD/BNdEWyMKTxMEOAvdIA+9XxWww2MPwxCuSRRMBhzyUaS8afRIXEsA24wCMaal5zxc8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjAo4+PJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91736C4CEC5;
	Wed, 16 Oct 2024 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090439;
	bh=30rE6efOoF/qr6wkKdMnEi82qUo60ReIqblq6jhOy9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjAo4+PJzvNlCimyqhtonmMT9daWmwMt6HPVL4D/lbe6b656Zb7U1F6Ey6gOLKLSL
	 sGt01b7LN+m6PYbZnE9swc3VUoKtJru7xv/G2G7U4S9mohVeqfOFK0TXezVb+UgyQc
	 ok2upR/ltvvZl6iXV3SCNTYaPKmBtI29Ho7BjASYg2wpiEgm7CJFAqRwPgUO2x3mpt
	 QSqifwlqGmqRwbDTkXuT0BBDGMmYQxnPrM6OSaPQoBg8aYM2vgiWpNv1vQOwvPYKZf
	 A49PhGHeup2X80+itZeUrfjMpuXiESSSI+0VfgmO/HosLDhLPM9I3rt2JAHWypEDTw
	 L9ngEqD0tdUwQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix lock recursion
Date: Wed, 16 Oct 2024 16:53:53 +0200
Message-ID: <20241016-klebt-kontinental-a976b274f90c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1114103.1729083271@warthog.procyon.org.uk>
References: <1114103.1729083271@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=brauner@kernel.org; h=from:subject:message-id; bh=30rE6efOoF/qr6wkKdMnEi82qUo60ReIqblq6jhOy9E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzX26y+D3h1qGjK79mWPY9YxCrC3ugH5WS31Cqv+pXz LSnQs+3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkyA9Ghq/1n95v9p2xecdk wWuBofdn/ZlTr7ZfiLHo7sLWWk+mFXaMDFtuFc8U2WwhNvPRXk2nYOE5qj9Fy5gFA8+tl6vl+PV tEi8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 13:54:31 +0100, David Howells wrote:
> afs_wake_up_async_call() can incur lock recursion.  The problem is that it
> is called from AF_RXRPC whilst holding the ->notify_lock, but it tries to
> take a ref on the afs_call struct in order to pass it to a work queue - but
> if the afs_call is already queued, we then have an extraneous ref that must
> be put... calling afs_put_call() may call back down into AF_RXRPC through
> rxrpc_kernel_shutdown_call(), however, which might try taking the
> ->notify_lock again.
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

[1/1] afs: Fix lock recursion
      https://git.kernel.org/vfs/vfs/c/dabae7218d1c

