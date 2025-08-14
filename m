Return-Path: <linux-fsdevel+bounces-57906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB50B26A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F331C5E5CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA71220CCCA;
	Thu, 14 Aug 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WRL+0zRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042021767D
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182973; cv=none; b=V7EXU+fpkcXmcrmwo0KVJRsMw7O8QgdmCnS2u6Y5tGITnDcJBbke1DCN6xsHVfW8r859PDcgB4oSsc/mUou0vfxa3Qna5S2MPdLoBafhvn1oLy6GjTPvJGlhUBqaa7Nufg0HD8XUhb4M/FSqZ7U47Y31vgp901XrxnvKkZsH5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182973; c=relaxed/simple;
	bh=e1V9BgrfW6RyU0+oK0JnO7jkbtdIVoNNVz8oXqpBAdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1gWnFlsdUyCGs4AxRqmxUYa2AVHzDFtWyZ0dmKSiCjXCdLwBDBsmE22WQh0ss7nldHlNi/1wWK3hIhRbo4fJl36jDS9Td/MONMXgEl2yuSm3omz+0GrSXp86Pbs32bKKEaxG71rwnZ5hVsqzUIa8BfP7aAqxmLCsZ+8VZ1qtW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WRL+0zRS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmpgp028603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182934; bh=igsjnNeFFRYJYvTLHCKqhYGxPF7o0ec5Al7arDZAOiQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WRL+0zRSnGh7rzPG49rekKflytLOe7O/nRLB+ahY04kDR1cPUhMGJtJfzuJ2OUHR6
	 vzHk0S+Ye39QZVncBwMRTw3PsDLu6elSdY9ifa9mmghK934oZLgZKF8JtjvIrCqaQB
	 dkM4+zD3xZhj6clOF0ZoEtj4TAx3/QN0gdgPB1UMobcXYCK1qf4EIIpuQekRU/wxcR
	 bjnid33V/G3iWmr7c4l0IkSXa4uZ4OSdGuzSibVteFwmVuUWYh7jpi+CD8lIgZsA4H
	 6tcVZQZhEEJ6WfKJDGFx6WPP8QScA9cBnwO4jysQB2uCxU8kKcwnhhkScXfaht82iT
	 v/Axcl4kOTM4g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DA9DD2E00E0; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix hole length calculation overflow in non-extent inodes
Date: Thu, 14 Aug 2025 10:48:47 -0400
Message-ID: <175518289076.1126827.12676708912922845605.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811064532.1788289-1-yi.zhang@huaweicloud.com>
References: <20250811064532.1788289-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Aug 2025 14:45:32 +0800, Zhang Yi wrote:
> In a filesystem with a block size larger than 4KB, the hole length
> calculation for a non-extent inode in ext4_ind_map_blocks() can easily
> exceed INT_MAX. Then it could return a zero length hole and trigger the
> following waring and infinite in the iomap infrastructure.
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 3 PID: 434101 at fs/iomap/iter.c:34 iomap_iter_done+0x148/0x190
>   CPU: 3 UID: 0 PID: 434101 Comm: fsstress Not tainted 6.16.0-rc7+ #128 PREEMPT(voluntary)
>   Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : iomap_iter_done+0x148/0x190
>   lr : iomap_iter+0x174/0x230
>   sp : ffff8000880af740
>   x29: ffff8000880af740 x28: ffff0000db8e6840 x27: 0000000000000000
>   x26: 0000000000000000 x25: ffff8000880af830 x24: 0000004000000000
>   x23: 0000000000000002 x22: 000001bfdbfa8000 x21: ffffa6a41c002e48
>   x20: 0000000000000001 x19: ffff8000880af808 x18: 0000000000000000
>   x17: 0000000000000000 x16: ffffa6a495ee6cd0 x15: 0000000000000000
>   x14: 00000000000003d4 x13: 00000000fa83b2da x12: 0000b236fc95f18c
>   x11: ffffa6a4978b9c08 x10: 0000000000001da0 x9 : ffffa6a41c1a2a44
>   x8 : ffff8000880af5c8 x7 : 0000000001000000 x6 : 0000000000000000
>   x5 : 0000000000000004 x4 : 000001bfdbfa8000 x3 : 0000000000000000
>   x2 : 0000000000000000 x1 : 0000004004030000 x0 : 0000000000000000
>   Call trace:
>    iomap_iter_done+0x148/0x190 (P)
>    iomap_iter+0x174/0x230
>    iomap_fiemap+0x154/0x1d8
>    ext4_fiemap+0x110/0x140 [ext4]
>    do_vfs_ioctl+0x4b8/0xbc0
>    __arm64_sys_ioctl+0x8c/0x120
>    invoke_syscall+0x6c/0x100
>    el0_svc_common.constprop.0+0x48/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x38/0x120
>    el0t_64_sync_handler+0x10c/0x138
>    el0t_64_sync+0x198/0x1a0
>   ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] ext4: fix hole length calculation overflow in non-extent inodes
      commit: 02c7f7219ac0e2277b3379a3a0e9841ef464b6d4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

