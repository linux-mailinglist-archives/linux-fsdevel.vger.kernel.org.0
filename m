Return-Path: <linux-fsdevel+bounces-12275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8A85E140
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A4D1C22AE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66380BFE;
	Wed, 21 Feb 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4tne/0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7E80BEB;
	Wed, 21 Feb 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529573; cv=none; b=gAWsoWpmE29LFqoUcTupjnbbEirRSkpXpVudwwC8KVNJBUfLE/+11hWqOQo6jmU2n/BhkYrB3plSpN01pPf4ZZATIu8mntpP8g+dTyGU5ka+A80VgXPrnvL6/iCma9L52Dp3AJ1y+gKe0XgO9L4kY8G4+5mUDHyS//lrH2/Iy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529573; c=relaxed/simple;
	bh=ini15tE19mitrKkG+HJLkGZ4AXHSX+Bhi6ca/Nfuh/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEwfBc6vaCEgYkGbPBKPNI5MMkJKoRNVp8q914Bn/ejdE7NN+ClfsryDii38R5E7Nl7JDyOWvqvBEfIK63jtsCpJxLIOpnkCdrIvkwZ7ZErk1gA29FbbrJVNIyA67BiNKVY5jt0sCLLDECnw3ysxWl/w4mTG5Mhf6FX5/8w3rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4tne/0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3E9C43390;
	Wed, 21 Feb 2024 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708529573;
	bh=ini15tE19mitrKkG+HJLkGZ4AXHSX+Bhi6ca/Nfuh/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4tne/0o3ReHxJpYIG981esY1f85ra9Flh/637W4yf8qYLkVxCP3vVmGuAPCZE3e1
	 d23jzgdy2MOsW0HaeTnOExIW4sEH6fbsa9F5sLkAlLxiGhgqijGL/Vs6SjZ46YsqGz
	 p/dlhP1gnkuhKYG19eCZlUFpwr+zdjBVlQw2l56g9t4YJ8UnLSgXha2jMgcUorotG/
	 1BER956nu3JXKrFHWsMlVceoWrepBJ1m+setcDEVljJwLahZV4bq8DeBQBHxGNK3cK
	 F0l07N17Hkiboqw+p6EMVDJ2etau/kwDGGZogJYnvtPwf614d7GMkw9NnW+o9NISAc
	 jk4LjWAG1AUDA==
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
Date: Wed, 21 Feb 2024 16:32:19 +0100
Message-ID: <20240221-postleitzahl-flanieren-799c28d3ad95@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215204739.2677806-2-bvanassche@acm.org>
References: <20240215204739.2677806-1-bvanassche@acm.org> <20240215204739.2677806-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=brauner@kernel.org; h=from:subject:message-id; bh=ini15tE19mitrKkG+HJLkGZ4AXHSX+Bhi6ca/Nfuh/0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReE5/7gaHDuGIbMyOTeuQaGTnlZ4/WSvFIF6aev2+yc +/Tg8+FOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSs5LhN1tdzvr97M/rj959 4atT93117vEri6KFlSo5pXILXaRl/jEybJ7FbCAduU+o+qrVR9mvXr5ru6x8rLdmJPxs+hgsVl/ DBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 12:47:38 -0800, Bart Van Assche wrote:
> If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
> following kernel warning appears:
> 
> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
> Call trace:
>  kiocb_set_cancel_fn+0x9c/0xa8
>  ffs_epfile_read_iter+0x144/0x1d0
>  io_read+0x19c/0x498
>  io_issue_sqe+0x118/0x27c
>  io_submit_sqes+0x25c/0x5fc
>  __arm64_sys_io_uring_enter+0x104/0xab0
>  invoke_syscall+0x58/0x11c
>  el0_svc_common+0xb4/0xf4
>  do_el0_svc+0x2c/0xb0
>  el0_svc+0x2c/0xa4
>  el0t_64_sync_handler+0x68/0xb4
>  el0t_64_sync+0x1a4/0x1a8
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

[1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
      https://git.kernel.org/vfs/vfs/c/b820de741ae4

