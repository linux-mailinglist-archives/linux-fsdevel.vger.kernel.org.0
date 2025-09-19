Return-Path: <linux-fsdevel+bounces-62223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF2B89659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA59C5860B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030330F7FA;
	Fri, 19 Sep 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAwI2HSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7713101BB;
	Fri, 19 Sep 2025 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284119; cv=none; b=OLTC+8665ADejB/8MbSNW09jUQO4nuHBeLVmmULjY4vDsELmvCPlFkY8MOExZXZJGKO+ZFVZMPmcQ1GydBqWfInslae0iHYKsV+EbCqo0kc1nScel/cGQBAW9WVgrLTIBMH6YVHmQeKpAtgFrmKXdywRfsWJOVxBoFQpEM4kvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284119; c=relaxed/simple;
	bh=rp2xQFUJfJ+ExiBl7itF5T5i2YWJ2EFn0MVZJbBYNfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnavAHUFGXjs8UxvEcO29OMJjEy4yNhaRR5HkjGpTveahmY7Lu/7LbvpAERYFWDWOkhsv84Wj4CqtjUSBh2GMTN6bE0J3CGXoUMaplSeAW7OEniGXJQrJCa+YsJhfayVyw6/48VMTO8mvVYpmkLZWI5U/vwopF07IbfE9V3URNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAwI2HSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADDFC4CEF1;
	Fri, 19 Sep 2025 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284117;
	bh=rp2xQFUJfJ+ExiBl7itF5T5i2YWJ2EFn0MVZJbBYNfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAwI2HSW+pHwoY6rtzTuqEtr+TkoectxvJ7SkUbL2SUuNEyc1XOxm3WHlu6z2Ft+E
	 DWwp1iDE+08CdXxZwBQ9ctZ4ZkOLRFlev0yl7wzJAqDM2vFQiTR83yYH/eRY+9VU1H
	 iva85USxaA4vTi0ab6tx7VWAtCIl4gMaH+kwP+eocOGxPLuP9mz7qJQ6fBWq7IHPXI
	 lSCaWJYWvpG7NzdY0HFXqDc946u9BK+OlH/oue+js5lj3l3X3cCAYYSHOvaOA0LI/R
	 3IcePujCv/NcyOhzBUhn1Ha/qI1ElmiPn0glh/pNOoBd/7d8/oZD187rNJgulsl3qe
	 qf9h7N0XWt6xg==
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: add might_sleep() annotation to iput() and more
Date: Fri, 19 Sep 2025 14:15:07 +0200
Message-ID: <20250919-willkommen-seefahrt-df4b03ade004@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917153632.2228828-1-max.kellermann@ionos.com>
References: <20250917153632.2228828-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=brauner@kernel.org; h=from:subject:message-id; bh=rp2xQFUJfJ+ExiBl7itF5T5i2YWJ2EFn0MVZJbBYNfk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc9Qw47rR6SVaikW5rRvvpDu8H6cpmvGyLftZvt/68k O2Rp49mRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESU2hkZlhhsiFvU6FOV4Jn8 bpLN3cbJF82jUxobJr1ae0XP5fKUAob/1fstKk7O1N5VPWV35F4rVc0KfgZns2NCDFksGWzvj0u zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 17:36:31 +0200, Max Kellermann wrote:
> When iput() drops the reference counter to zero, it may sleep via
> inode_wait_for_writeback().  This happens rarely because it's usually
> the dcache which evicts inodes, but really iput() should only ever be
> called in contexts where sleeping is allowed.  This annotation allows
> finding buggy callers.
> 
> Additionally, this patch annotates a few low-level functions that can
> call iput() conditionally.
> 
> [...]

Applied to the vfs-6.18.inode.refcount.preliminaries branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.inode.refcount.preliminaries branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.inode.refcount.preliminaries

[1/1] fs: add might_sleep() annotation to iput() and more
      https://git.kernel.org/vfs/vfs/c/2ef435a872ab

