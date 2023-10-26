Return-Path: <linux-fsdevel+bounces-1237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE737D8202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245F2281F39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF92D79A;
	Thu, 26 Oct 2023 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuTZA6gK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6A2D05F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAEAC433C9;
	Thu, 26 Oct 2023 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698321016;
	bh=QqApcCyBy9sylIEqYf+EoO/spsxFc9PNtDnelM7DtiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuTZA6gKVWbOrB+CTg8KSYzxG0ehUQnIbo3KGOK4qVYUhfLihUgDw6hPy4ayegA0X
	 lIMJEU90fA0e1+5o1jVbUPyvN/l3mirDy+dms8Y5Wf/c+ZoudR8bfEf/B9t2xsaQtZ
	 t8HCrwgnHgLjDj0l5GJNvByjTOo2yymCh4T/wDMLlpaJC+07/bfsuD8QxtXq0B0IAk
	 sbDU9CTaonQbJlVRS4FiwM1WuzWvPfAGRr9qpHDJ2ryu7ls1vOs0NuExQqJvmNisrN
	 axBpSLT5Fd37ZkeFsvu311wZIAlz9+plE2IEHcm3bh4YJzB5PqicCjE0+Ce+YnpUVi
	 GjmQLHqIHrJGQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH RFC 0/6] fs,block: yield devices
Date: Thu, 26 Oct 2023 13:50:11 +0200
Message-Id: <20231026-abarbeiten-bojen-dcda0bf990d5@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=brauner@kernel.org; h=from:subject:message-id; bh=QqApcCyBy9sylIEqYf+EoO/spsxFc9PNtDnelM7DtiI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRaBeXxnzp+b5dsZoPfrrnaFyod95ZoHE1La3u27m19nojO 4lfHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiW8XwV8RsdnVdq/w70+cGkRK/pk nYm+zZfuRKiYLCvZ1yCbEHKxgZTh99FCmxRX5P77TLT78qHamKXK+vWzDxb4Rkn4eKaXYPAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Oct 2023 16:53:38 +0200, Christian Brauner wrote:
> Hey,
> 
> This is a mechanism that allows the holder of a block device to yield
> device access before actually closing the block device.
> 
> If a someone yields a device then any concurrent opener claiming the
> device exclusively with the same blk_holder_ops as the current owner can
> wait for the device to be given up. Filesystems by default use
> fs_holder_ps and so can wait on each other.
> 
> [...]

for v6.8

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

[1/6] fs: simplify setup_bdev_super() calls
      https://git.kernel.org/vfs/vfs/c/f15112134111
[2/6] xfs: simplify device handling
      https://git.kernel.org/vfs/vfs/c/cbded4a095bd
[3/6] ext4: simplify device handling
      https://git.kernel.org/vfs/vfs/c/ac85cf49ed93

