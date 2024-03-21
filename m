Return-Path: <linux-fsdevel+bounces-14961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66E885645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BBD1C21198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD143D0C6;
	Thu, 21 Mar 2024 09:15:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F756883C;
	Thu, 21 Mar 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012532; cv=none; b=asKNnE2SuoxLd8RmREd4luL3KqUjputuAz7YjKrfR01m+SgS5tqOVcm9N4Ia91TmzqD7Ss08xtTdlXAWOcMQxGspI4KMcszVsaJVISiyfxpZ2p6SAlmkp6h2m9LvTsxzwgSWOSnYbP0qiKLQ/2qCoTd5GLu0IBWlHrUasCUOYfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012532; c=relaxed/simple;
	bh=7mZ+Ap7YfWnxtKv8WqQRdUUF6tDAryF5ikk9T8xbk1E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n/A+F1PirkPd1+Mq1A5hFTJgd1Wd1rv8aqA+73776Yju7pTa8bPvCiuQBH4q8CWx0GbGQqeyUXhnLYQ5NBxShl4yBm6tdwFJ9CB1vbhLeB0/Nuo5Zmm0XsrsK5gI0qmzEF0sFsHT+AWXuLjuiU+A+kutRjslR24FwzdyFBgDafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7E94061E5FE0A;
	Thu, 21 Mar 2024 10:15:05 +0100 (CET)
Message-ID: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>
Date: Thu, 21 Mar 2024 10:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, it+linux@molgen.mpg.de
From: Donald Buczek <buczek@molgen.mpg.de>
Subject: possible 6.6 regression: Deadlock involving super_lock()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

we have a set of 6 systems with similar usage patterns which ran on 5.15 kernels for over a year.  Only two weeks after we've switched one of the systems from a 5.15 kernel to a 6.6 kernel, it went into a deadlock. I'm aware that I don't have enough information that this could be analyzed, but I though I drop it here anyway, because the deadlock seems to involve the locking of a superblock and I've seen that some changes in that area went into 6.6. Maybe someone has an idea or suggestions for further inspection if this happens the next time.

These systems

- use automounter a lot (many mount/umount events)
- use nfs a lot (most data is on remote filesystems over nfs)
- are used interactively (users occasionally overload any resource like memory, cores or network)

When we've noticed the problem, several processes were blocked, including the automounter which waited for a mount that didn't complete:

# # /proc/73777/task/73777: mount.nfs : /sbin/mount.nfs rabies:/amd/rabies/M/MG009/project/avitidata /project/avitidata -s -o rw,nosuid,sec=mariux
# cat /proc/73777/task/73777/stack

[<0>] super_lock+0x40/0x140
[<0>] grab_super+0x29/0xc0
[<0>] grab_super_dead+0x2e/0x140
[<0>] sget_fc+0x1e1/0x2d0
[<0>] nfs_get_tree_common+0x86/0x520 [nfs]
[<0>] vfs_get_tree+0x21/0xb0
[<0>] nfs_do_submount+0x128/0x180 [nfs]
[<0>] nfs4_submount+0x566/0x6d0 [nfsv4]
[<0>] nfs_d_automount+0x16b/0x230 [nfs]
[<0>] __traverse_mounts+0x8f/0x210
[<0>] step_into+0x32a/0x740
[<0>] link_path_walk.part.0.constprop.0+0x246/0x380
[<0>] path_lookupat+0x3e/0x190
[<0>] filename_lookup+0xe8/0x1f0
[<0>] vfs_path_lookup+0x52/0x80
[<0>] mount_subtree+0xa0/0x150
[<0>] do_nfs4_mount+0x269/0x360 [nfsv4]
[<0>] nfs4_try_get_tree+0x48/0xd0 [nfsv4]
[<0>] vfs_get_tree+0x21/0xb0
[<0>] path_mount+0x79e/0xa50
[<0>] __x64_sys_mount+0x11a/0x150
[<0>] do_syscall_64+0x46/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8


Also, one writeback thread was blocked. I mention that, because I don't get how these these two threads could depend on each other:

# # /proc/39359/task/39359: kworker/u268:5+flush-0:58 : 
# cat /proc/39359/task/39359/stack

[<0>] folio_wait_bit_common+0x135/0x350
[<0>] write_cache_pages+0x1a0/0x3a0
[<0>] nfs_writepages+0x12a/0x1e0 [nfs]
[<0>] do_writepages+0xcf/0x1e0
[<0>] __writeback_single_inode+0x46/0x3a0
[<0>] writeback_sb_inodes+0x1f5/0x4d0
[<0>] __writeback_inodes_wb+0x4c/0xf0
[<0>] wb_writeback+0x1f5/0x320
[<0>] wb_workfn+0x350/0x4f0
[<0>] process_one_work+0x142/0x300
[<0>] worker_thread+0x2f5/0x410
[<0>] kthread+0xe8/0x120
[<0>] ret_from_fork+0x34/0x50
[<0>] ret_from_fork_asm+0x1b/0x30

As a result, of course, more and more processes were blocked. A full list of all stack traces and some more info from the system in the blocked state is at https://owww.molgen.mpg.de/~buczek/2024-03-18_mount/info.log

dmesg not included in that file, but I've reviewed it and there was nothing unusual in it.


Thanks

  Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 14  

