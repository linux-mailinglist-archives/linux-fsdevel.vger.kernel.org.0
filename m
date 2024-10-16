Return-Path: <linux-fsdevel+bounces-32114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DE49A0B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C957A1C2240A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A720969A;
	Wed, 16 Oct 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfLCClE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F579208D99;
	Wed, 16 Oct 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084255; cv=none; b=Y9g0pc61QmsAHCGmztxzmLiVGHReRzcjs2G+RWefCiQYR9dbJuCBbxmlPcKAeU0Po2J0ouaYzzcdPeEi8z9UyoSpWokDZRFp/8W48hgLNlMOgS/svTbUt1ktl9QBCq0HYBrxHQH9APDyb/zd7hE2aMiwSxj1sok2EZYhNYrx5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084255; c=relaxed/simple;
	bh=i7m7YD1wK6+S6TgnBhGJ8wqXu+spFj7YDBSGfm8ESOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeXAQW74+XXZftqZ9J9QyPVE0Gf+ib/pVBWc352P0pRzYK2UBe6Hc9B/zTEEfu0dKapzBLta+PVRXdpyfo6zaBgjU05V6JOAclNOgFGMQggOC+b9whHs8dXh6pcvitoTSg+60HPfrsprabUDZb5HOf9fFsFX3mHuHZTqwZLsVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfLCClE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8ECC4CEC5;
	Wed, 16 Oct 2024 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729084255;
	bh=i7m7YD1wK6+S6TgnBhGJ8wqXu+spFj7YDBSGfm8ESOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfLCClE0jYbSlwXkEnr/yd1JOFozQ+7tvQnVG3OlI1MNMbkHsDq33Muk1sx7juWW/
	 kIyI6145rBX12LaxU1IlQRcoGIN2uFx4dpY2cIz85JPSySNPc8GiPWRGIVTUlt7NV9
	 THfzLMzzSl61qLpEb/s2GvdDPsAJeScOeBXdheXlqHJh6/6MiLMASd1gEMbJYTIs0/
	 KUfEqGCoB9NU/u8Y7Mvk9HFXh0OdBrJWPKehrym4mwwRYMFu/kVVi5VLd4teKrgXuI
	 BXf24qTb9c3eFUd57ylYlRBYWvBfdJDA3tABSLbS2qqzg9vB/1LBZRALaw90Pn05A+
	 AD32Ds+QgTIqA==
From: Christian Brauner <brauner@kernel.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	cmllamas@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com,
	jing.xia@unisoc.com,
	xuewen.yan94@gmail.com,
	viro@zeniv.linux.org.uk,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Wed, 16 Oct 2024 15:10:34 +0200
Message-ID: <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240426080548.8203-1-xuewen.yan@unisoc.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=brauner@kernel.org; h=from:subject:message-id; bh=i7m7YD1wK6+S6TgnBhGJ8wqXu+spFj7YDBSGfm8ESOk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTz7w5JuCC9td4t49DrP0wHNX6vc+atFUjMD1TZPkvl1 AT205t/dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE6Rgjw52Z+cJLnk37nHHx VrdtocK/qT/UHvSuWb77R6vj2vv7C7QZGU4f7Szbu1ar8m45c1eJpmrpX/0FVbyrMzgb992VWN8 QxAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> Now, the epoll only use wake_up() interface to wake up task.
> However, sometimes, there are epoll users which want to use
> the synchronous wakeup flag to hint the scheduler, such as
> Android binder driver.
> So add a wake_up_sync() define, and use the wake_up_sync()
> when the sync is true in ep_poll_callback().
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

[1/1] epoll: Add synchronous wakeup support for ep_poll_callback
      https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

