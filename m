Return-Path: <linux-fsdevel+bounces-53483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A109BAEF7C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB201C047C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3471272811;
	Tue,  1 Jul 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEeP5CN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7725D1EE;
	Tue,  1 Jul 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371295; cv=none; b=CoJsZxmoPGwGKntqLwDvD8iOVzuWouQZlBTN0MD4ww5yQwEA9+g9PmQyfqrB7r9JpFy/6AFxobtt7sDT5KwRzj2dUsLdpD+K8tRqOEgLfwcQcFdF70HD2Pel8Yscwc9W6SMVG2vqIvh5eFAeh0JQSTC07IaNNpH1eqOSjrNDxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371295; c=relaxed/simple;
	bh=Ve2jWkUY7Kco8qr8eXLeveQqpfYfuVWQzfdfLKDRfSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgh8PhwRaTv5Rgq8FvL4knbMF65tYvdksVOdneE6g5d8g9YWFpVcZCGXe5DCOSeU//nTI2pE3ZT/dbXSg6TEP8PTC0ZSJ7aCGR61ZXYHeRAJ44Tgr58LxZ5zjELeSDK8nymWDcIb9fZWCYD/xYMG9nCJbRnWVARYSe3WpXyvWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEeP5CN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4647C4CEEB;
	Tue,  1 Jul 2025 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371294;
	bh=Ve2jWkUY7Kco8qr8eXLeveQqpfYfuVWQzfdfLKDRfSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEeP5CN4D96Xof3lUeWOZq5kQVZ7As6qgXQJ+ZVOWulMkKg1SsV7pEcbmA40Q+3Cf
	 0kM710txoJdS2GTbF+7CWVJOzBREkzgDya6XBMBUQ5Sd2wcowJtnGQJcB42WwFgYc2
	 9OnkmabB6qG7uKK/PG3jU0ecNGZh6KSAQMa6/hWoiJnYrVXLZAOiX05cJSJBAzEJSQ
	 gRG9W3sdo/A7Z1TRijbJ49SJk6U9SGZz1sNAIakruHpAbHjzCKJrgFNsr1aWKa0z9H
	 xoODuRK3rSU+3W7fF5pnIuwZwyHu4qVVmDClkSXfnC6fRlP/Iup5YOBkz2dVpS4F1c
	 cyvilMj4huWcQ==
From: Christian Brauner <brauner@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	gost.dev@samsung.com,
	vincent.fu@samsung.com,
	jack@suse.cz,
	anuj1072538@gmail.com,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	martin.petersen@oracle.com,
	ebiggers@kernel.org,
	adilger@dilger.ca
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and protection info capabilities
Date: Tue,  1 Jul 2025 14:01:17 +0200
Message-ID: <20250701-abreden-rohkost-a0c293481b42@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
References: <20250630090548.3317-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=brauner@kernel.org; h=from:subject:message-id; bh=Ve2jWkUY7Kco8qr8eXLeveQqpfYfuVWQzfdfLKDRfSM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQknxN75MRyd/PiQ5JXj/wQbuLSu2fukbHgvmHLC/8Fx w+t3D2/rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAid48xMqyzkzDW3sER9D89 SPm21bwpawozbEPuMy969V6FLSlrITsjw2ot+bUZNcv9avvZ703+8bGnrjlII9OyWpBl6wIR/uT fHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 14:35:44 +0530, Anuj Gupta wrote:
> This patch series adds a new ioctl to query metadata and integrity
> capability.
> 
> Patch 1 renames tuple_size field to metadata_size
> Patch 2 adds a pi_tuple_size field in blk_integrity struct which is later
> used to export this value to the user as well.
> Patch 3 allows computing right pi_offset value.
> Patch 4 introduces a new ioctl to query integrity capability.
> 
> [...]

Applied to the vfs-6.17.integrity branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.integrity branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.integrity

[1/4] block: rename tuple_size field in blk_integrity to metadata_size
      https://git.kernel.org/vfs/vfs/c/c6603b1d6556
[2/4] block: introduce pi_tuple_size field in blk_integrity
      https://git.kernel.org/vfs/vfs/c/76e45252a4ce
[3/4] nvme: set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
      https://git.kernel.org/vfs/vfs/c/f3ee50659148
[4/4] fs: add ioctl to query metadata and protection info capabilities
      https://git.kernel.org/vfs/vfs/c/9eb22f7fedfc

