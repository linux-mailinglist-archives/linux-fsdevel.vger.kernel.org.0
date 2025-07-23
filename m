Return-Path: <linux-fsdevel+bounces-55822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E6B0F1B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DD3ACCF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AB2E54D6;
	Wed, 23 Jul 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIE7gWjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C092E54AB;
	Wed, 23 Jul 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271698; cv=none; b=FxpOxnhBKrbNwanBUvYtM1K1u3UCDfM4+w+4oxPXAacaNwDKU8M5XLv6gE/+rymp50sBDutVSEQ9LsZ9JqI6i4Fw17ZyWmOXGuk6oqYuz34xAYti8pT8b1Hr00d+oYsNB9Ky/vWI48aQg62wjYW2dHofnTxd3rMWK5RgB8wcC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271698; c=relaxed/simple;
	bh=WAaRmKJmN/JFaKZei/D0Z1G0VCrqAn+L0BaRZb4y7/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1tR514dN4f5xsMyfcc9fT1hDJFFikE0/uA5tse/MMsAClEJ6Ss6VSSsXlABnLeU4zDHxacYDhsRvrjE5JBigBm1eObnWii/VAR0dRxM3N/9834Hi4YroomgFsJcDlAGu5QQhscW3Kgj10zOgzpi2p/If5M1WcTgEbvP++Jii50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIE7gWjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A47C4CEE7;
	Wed, 23 Jul 2025 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271697;
	bh=WAaRmKJmN/JFaKZei/D0Z1G0VCrqAn+L0BaRZb4y7/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIE7gWjtJgK4EPSQ5Q3QlOnVs+OxTvNjVfqeKQum9Ac6RqgpiNRUye4G2qUFfOwCl
	 IeatMj78AkB1Yglb4ZBV2HRgkxUoZ2DOt2EowLjRfb0UvZZIUsReVkBkGbYFxW73Ll
	 nK2StHUf0/fVtS4eb3NqZgpicIaIWp3m1daoRJH6RENtD4fR4R73t7n9CGwAZ+Qf0V
	 FNxW+U95Ib3XPpo0Limot8mqzdvNpDVj9+tbtaWe7MWkTdoXuhlY3z7/jbsnVTA9J/
	 iNmxBjN7eeNscDTdguFxpSDHusT9Q7l6/A0o3kOQAHgxzJEZwfuLuPotgaK5TgYWfd
	 tEyWTtxpYXIVg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot+5c042fbab0b292c98fc6@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Set vllist to NULL if addr parsing fails
Date: Wed, 23 Jul 2025 13:54:51 +0200
Message-ID: <20250723-lesen-nackt-8aa8ef3d5102@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <4119365.1753108011@warthog.procyon.org.uk>
References: <4119365.1753108011@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=brauner@kernel.org; h=from:subject:message-id; bh=WAaRmKJmN/JFaKZei/D0Z1G0VCrqAn+L0BaRZb4y7/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0nO3J4vMTUfEv0m9uMt4f9mHm9PD4vBbBvDkhpl/ub VrTJ7Ooo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJndRgZzvZZZcUZ7zGe/Ubg gbSKFF8aA0fU9cvpEn9jevKaPzivYPhfcUTCm1VAvTUp72ftJ+3dN9XVsr+8+5+WP0/pyK+t5wO YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 15:26:51 +0100, David Howells wrote:
> syzbot reported a bug in in afs_put_vlserverlist.
> 
>   kAFS: bad VL server IP address
>   BUG: unable to handle page fault for address: fffffffffffffffa
>   ...
>   Oops: Oops: 0002 [#1] SMP KASAN PTI
>   ...
>   RIP: 0010:refcount_dec_and_test include/linux/refcount.h:450 [inline]
>   RIP: 0010:afs_put_vlserverlist+0x3a/0x220 fs/afs/vl_list.c:67
>   ...
>   Call Trace:
>    <TASK>
>    afs_alloc_cell fs/afs/cell.c:218 [inline]
>    afs_lookup_cell+0x12a5/0x1680 fs/afs/cell.c:264
>    afs_cell_init+0x17a/0x380 fs/afs/cell.c:386
>    afs_proc_rootcell_write+0x21f/0x290 fs/afs/proc.c:247
>    proc_simple_write+0x114/0x1b0 fs/proc/generic.c:825
>    pde_write fs/proc/inode.c:330 [inline]
>    proc_reg_write+0x23d/0x330 fs/proc/inode.c:342
>    vfs_write+0x25c/0x1180 fs/read_write.c:682
>    ksys_write+0x12a/0x240 fs/read_write.c:736
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
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

[1/1] afs: Set vllist to NULL if addr parsing fails
      https://git.kernel.org/vfs/vfs/c/8b3c655fa240

