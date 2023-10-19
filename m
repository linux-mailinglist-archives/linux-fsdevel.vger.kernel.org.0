Return-Path: <linux-fsdevel+bounces-722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A27CF23E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC16B2122B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CE14F8E;
	Thu, 19 Oct 2023 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCJu8YsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075FDF42
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A89C433C8;
	Thu, 19 Oct 2023 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697703418;
	bh=KoPOEv3TLEtJeiwOPb/kRjSE6RR3q8fabseskuKoq0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCJu8YsMXNG8CnhGKzAi2g/dhtwDrZdnmQHJPZ+F+HYath++Z9l1yb0ZaPwhLaHJs
	 p7VDuJCxPI/H/CR65Sq1BsxrHjhH1iCuAiRg6a1cZa9QUDzY9m+aniWKibh1fIxOKq
	 d7Ii5s6+f5AeoDCItPyIyhHIks06Zd3dwplSfIUEZ9xcJe/QSm9dPDGrbQs8S0aYfr
	 Dhi6g/AH/Eae/FbTVKwQgiSmpquqTUoF5DRuMQUUDH104YowefFUO3lUZCClYopjur
	 1PCtA8kIjm1OXNU4clgDNaslC6xuj1CvBq1U20OCJ4I1N2UTE9m0DDm0+pRC2EYQ7c
	 2KBtnkAXhs6fg==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
Date: Thu, 19 Oct 2023 10:16:48 +0200
Message-Id: <20231019-kontinental-gutgesinnt-8fe10612026e@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018152924.3858-1-jack@suse.cz>
References: <20231018152924.3858-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=brauner@kernel.org; h=from:subject:message-id; bh=KoPOEv3TLEtJeiwOPb/kRjSE6RR3q8fabseskuKoq0Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQaPH2VntWmIRAlPstakr/hxfZqbZnUf5fKVzx52ZJyY479 XUnDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYnmZk+LHlX+PuGWvumcxxvHTfji vsR67w7Ju2JmGeLAEG1dMaeBkZ3kpstG1KM2+ewfUvdUlQ2zaxfxumHXjasanb2z+3aZk7FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Oct 2023 17:29:24 +0200, Jan Kara wrote:
> The implementation of bdev holder operations such as fs_bdev_mark_dead()
> and fs_bdev_sync() grab sb->s_umount semaphore under
> bdev->bd_holder_lock. This is problematic because it leads to
> disk->open_mutex -> sb->s_umount lock ordering which is counterintuitive
> (usually we grab higher level (e.g. filesystem) locks first and lower
> level (e.g. block layer) locks later) and indeed makes lockdep complain
> about possible locking cycles whenever we open a block device while
> holding sb->s_umount semaphore. Implement a function
> bdev_super_lock_shared() which safely transitions from holding
> bdev->bd_holder_lock to holding sb->s_umount on alive superblock without
> introducing the problematic lock dependency. We use this function
> fs_bdev_sync() and fs_bdev_mark_dead().
> 
> [...]

Thanks!

---

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/1] fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
      https://git.kernel.org/vfs/vfs/c/4f4f1b3da625

