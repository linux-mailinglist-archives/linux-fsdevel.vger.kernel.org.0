Return-Path: <linux-fsdevel+bounces-58023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DAB28155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB2C16DCB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887C1DEFF5;
	Fri, 15 Aug 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaacuJaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309A1C8631;
	Fri, 15 Aug 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267076; cv=none; b=Ltc1TGNEodnj2WWfOC0xrvW69U0WDBxfkdE5+xHG0guYBasJRlTJPxxRnnRS/HQR47Ojy5Ir2iWFC1iZpyn4nDJ8ywfh0lHOUoDg8cfeKHAFtoPhRARM+v8riuZ8qDQeh5RE76mJ7Ru0d+1ap3wA0fpYzTpM2o1ONb5v7wGIw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267076; c=relaxed/simple;
	bh=OtCqmz400JW1LXPKPB63v1Co1OIWV0q/WvIHMpYS9vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+tdNJOiKGJvMxLB/ECf4/XG4044YvUeWz3jqaZCcLohBFTcWKmC9dal8Hyu4sCORYdOm8lZwa4KExHEu2FhngKqJJXEfP+QHr4mhj+xlLbwfmIpFLDX16Ll2mRsWGky8vI0/XpjEZqElbu2/NNdr7Lo1V5xehV5dVkrt2dBZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaacuJaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD6C4CEEB;
	Fri, 15 Aug 2025 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267076;
	bh=OtCqmz400JW1LXPKPB63v1Co1OIWV0q/WvIHMpYS9vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaacuJaEj9rY5QRIklO3nzpD/AVM+K8X1Z5ZDaBqawuvI7aTZsvBl9VYQkKE8THmp
	 86jOb1JhB6Y16fzYIxYMOqoMGpb8Iq0RibCwwHT+beJj5JxgeE5kfXKOylrhHeDu7/
	 t14AibxzyDmdU2I5tGQMrCy4A3Y97Bof0AVFiYsgEvOK+XBGGQyLTpel76+2k6HqdS
	 3kg978Y26VX9Qcw12bzguf4j/6w+m6ODMURSQcUUbjt3ri2WW5aRHp9WPuJfy+82jr
	 hYdCPqlr4DG807jWCrOuanqKE9np1FvoxrV4733F9sMopg2OH6aT40MUEzDtvYCJFA
	 idmg46g7iyQUg==
From: Christian Brauner <brauner@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/1] pidfs: Fix memory leak in pidfd_info()
Date: Fri, 15 Aug 2025 16:11:00 +0200
Message-ID: <20250815-avocado-schalldicht-f3c2c0720bcc@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814094453.15232-1-adrianhuang0701@gmail.com>
References: <20250814094453.15232-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=brauner@kernel.org; h=from:subject:message-id; bh=OtCqmz400JW1LXPKPB63v1Co1OIWV0q/WvIHMpYS9vs=; b=kA0DAAoWkcYbwGV43KIByyZiAGifP/+ieKJMzvCGgMqs6SaDz5YXsfAL26q03/+wPWTwspBlk 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmifP/8ACgkQkcYbwGV43KKcXwD+PuSM ldEABph929HKwJuzVWAoqxHlctswjdkr9F/uOOQBAIQAdeTLOavxwIBePElAGNDKRV1OILsFuQI ZHs3N23QP
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 17:44:53 +0800, Adrian Huang (Lenovo) wrote:
> After running the program 'ioctl_pidfd03' of Linux Test Project (LTP) or
> the program 'pidfd_info_test' in 'tools/testing/selftests/pidfd' of the
> kernel source, kmemleak reports the following memory leaks:
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xff110020e5988000 (size 8216):
>     comm "ioctl_pidfd03", pid 10853, jiffies 4294800031
>     hex dump (first 32 bytes):
>       02 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
>       00 00 00 00 af 01 00 00 80 00 00 00 00 00 00 00  ................
>     backtrace (crc 69483047):
>       kmem_cache_alloc_node_noprof+0x2fb/0x410
>       copy_process+0x178/0x1740
>       kernel_clone+0x99/0x3b0
>       __do_sys_clone3+0xbe/0x100
>       do_syscall_64+0x7b/0x2c0
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ...
>   unreferenced object 0xff11002097b70000 (size 8216):
>   comm "pidfd_info_test", pid 11840, jiffies 4294889165
>   hex dump (first 32 bytes):
>     06 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
>     00 00 00 00 b5 00 00 00 80 00 00 00 00 00 00 00  ................
>   backtrace (crc a6286bb7):
>     kmem_cache_alloc_node_noprof+0x2fb/0x410
>     copy_process+0x178/0x1740
>     kernel_clone+0x99/0x3b0
>     __do_sys_clone3+0xbe/0x100
>     do_syscall_64+0x7b/0x2c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ...
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

[1/1] pidfs: Fix memory leak in pidfd_info()
      https://git.kernel.org/vfs/vfs/c/0b2d71a7c826

