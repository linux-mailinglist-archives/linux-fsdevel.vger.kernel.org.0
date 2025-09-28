Return-Path: <linux-fsdevel+bounces-62940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB52BA688A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 07:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80093BC951
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F67299959;
	Sun, 28 Sep 2025 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="InQTdMkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ua2mpK3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989E225D6;
	Sun, 28 Sep 2025 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759038842; cv=none; b=iNXefb895Q5d8BCTphkanFtPJ4cn9mcELTGCQJahpImkMtSM++ezE1d1dS7+nN3LlxqLfeYxoFrkpm1ZXw2fgSP+OudOnu/SIiX59rxu72BVD5WHzw02p0BAerMkVRaA9AzyTlMqnEx6AYoB5mMN4nXlZVSygfpek4g9Ro3FJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759038842; c=relaxed/simple;
	bh=RV7UUxE3eONXcB+jGAWhF21Z4WROF8EZVEg8GBp4Pck=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=KO2Wa7IPSP0Oet1ENJ7/QVrIPD614+Sg8p7epnF3jOR60vPDL6KbULK+hXj31Gkjk+ntVicyo+SxfYQrmISQj2C0PmNleYHzGvIRYEYADGaL1ZVOwdPV6igVJDf2Rac9BjiN41px/s19o0HyfRRCYulnr1xOVdU81YLEXNZFjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=InQTdMkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ua2mpK3d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BAE4EC0093;
	Sun, 28 Sep 2025 01:53:58 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 28 Sep 2025 01:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1759038838; x=1759125238; bh=/VOtEuTIBBW1xoXMsAv+hocbkxswPJuzL4+
	qj5SBN0Y=; b=InQTdMkBhNi8fU9QioMxaekGHU94RHLcG8j3mSfnMbuSc2SuwHA
	uLT2RpWi1Xkkc/yNvl3k4qOJwYDvNC+UPPPimlbER9kojcahG96PaYoBAxhmWoL0
	wVZVgcWgGi4AyWJAtIFlt8r06HRzqLLC6mTMNfkQ/35u0vUHUtB89D6MIh34Gw5O
	2HUqT0EI1HnCnFKaYIcv+ynAk406+Trh0WvzFeB63bayttRklqeEOWpJge5qPNcG
	f3toK/3VgtUUtMvtWpsf/Edu5/cJxbFldWhAhdnvCTA9uKak9tYc0MoiZcrAEYpl
	PIuo3zCISKtc1LtOOnKUUMUYSzEabh5OtZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759038838; x=1759125238; bh=/VOtEuTIBBW1xoXMsAv+hocbkxswPJuzL4+
	qj5SBN0Y=; b=Ua2mpK3ddYkHhtIL3qUEczM9qG6xGSP1SYZRWotqrB2RWSqWLd5
	UleZgdXOJYRe9k+qGgqWn9zzyuyTb9rBw4Pfbu6jG6WBwiN6Ya8mWrPAdbxX1tkN
	IQ3bf1Gu9BdYvfFOJIb702p/ssvtVxdK+fsf7X99yBYwx9xGdyOeIRYK6WqIcS6L
	wpepD0aeuod4nAgTn4WpugkADyPV3aqcvD8mvKLyDMPoSaeF/YU0IGhCp1rZFgYC
	4Nqypmhp/JApuha0DwpExcyw2EFjpiTcUjT+Sj2w9/ghIDZKajOXfEk5ip8L+oUX
	BqJryWObAlny9Q3FK2bTU2FJb2CAM38WsZQ==
X-ME-Sender: <xms:ds3YaElRe0k5B_iiONpg5P5WqecnormVLKzJm1mq7UbwpWJt5J1sfg>
    <xme:ds3YaOoFZC1GVRy3sOQ5DuMI7hrHtrCkmjCcr9wBvw5BKvw8Ku4k2C-3bORNt2QEL
    s6YResbQLYQuWTLRDwVwYJpL8zmRVF654owMSetiYpdq-GMIPC9SyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcuofhu
    rhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgfffggefhfeekfeefhfejueevtdeikeehfefhfedvgffhtdfgudev
    gfdvgeelueenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghm
    vgguihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ds3YaIYtd-U47_yTsIpmfSsJ4iG76pwmJpmp5tyJlninFl-clB8rww>
    <xmx:ds3YaHuxxI9ZPZahFj0BkEPrFFKdf7k9FbSo3i1ogDtsy8qEncqZ5A>
    <xmx:ds3YaCHGLBHyaxY7PdexMumspak6UxH3iq4CQl3kO8W2-IKhg_xZZA>
    <xmx:ds3YaKz5T4BBuSndydOe-WONpfpfKwF_ASC6G0ELAjDrA3KnUW0fkQ>
    <xmx:ds3YaNrNHP8COur6SS-R3dFRHrceuquZ_0U0v1qShvGaxgP1YdciB_i7>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3179618C0067; Sun, 28 Sep 2025 01:53:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 28 Sep 2025 01:53:37 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
 "Linux Devel" <linux-fsdevel@vger.kernel.org>
Message-Id: <cd1ab2d8-35af-4707-8eee-ced3141d1126@app.fastmail.com>
Subject: [BUG] 6.17.0, mount: /mnt/0: fsconfig() failed: File exists.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel-6.17.0-0.rc7.56.fc43.x86_64
btrfs-progs-6.16.1-1.fc43.x86_64

Downstream bug includes full dmesg attached:
https://bugzilla.redhat.com/show_bug.cgi?id=2399959

File system is already mounted, but I need access to the top-level of the file system.

$ sudo mount /dev/dm-0 /mnt/0
mount: /mnt/0: fsconfig() failed: File exists.
       dmesg(1) may have more information after failed mount system call.

dmesg

[  670.350492] BTRFS: device fsid 958beb6e-eadb-469f-9b33-a06db5a014e7 devid 1 transid 1512 /dev/mapper/luks-32d2f2ad-a545-4aba-b5c7-3fa9135d12bf (252:0) scanned by mount (1324)
[  670.352174] BTRFS info (device dm-0): first mount of filesystem 958beb6e-eadb-469f-9b33-a06db5a014e7
[  670.352302] BTRFS info (device dm-0): using crc32c (crc32c-lib) checksum algorithm
[  670.361200] sysfs: cannot create duplicate filename '/fs/btrfs/958beb6e-eadb-469f-9b33-a06db5a014e7'
[  670.361294] CPU: 3 UID: 0 PID: 1324 Comm: mount Not tainted 6.17.0-0.rc7.56.fc43.x86_64 #1 PREEMPT(full) 
[  670.361300] Hardware name:  /NUC5PPYB, BIOS PYBSWCEL.86A.0081.2022.0823.1419 08/23/2022
[  670.361303] Call Trace:
[  670.361309]  <TASK>
[  670.361314]  dump_stack_lvl+0x5d/0x80
[  670.361324]  sysfs_warn_dup.cold+0x17/0x23
[  670.361331]  sysfs_create_dir_ns+0xcc/0xe0
[  670.361341]  kobject_add_internal+0xbc/0x260
[  670.361347]  kobject_init_and_add+0x8e/0xc0
[  670.361352]  ? btrfs_init_dev_replace+0x176/0x5c0
[  670.361357]  btrfs_sysfs_add_fsid+0x5e/0x120
[  670.361363]  open_ctree+0x71c/0xb30
[  670.361369]  btrfs_get_tree_super.cold+0xb/0xac
[  670.361372]  ? security_fs_context_dup+0x52/0x100
[  670.361378]  btrfs_get_tree_subvol+0xfe/0x1f0
[  670.361383]  vfs_get_tree+0x26/0xd0
[  670.361389]  vfs_cmd_create+0x57/0xd0
[  670.361395]  __do_sys_fsconfig+0x4b6/0x650
[  670.361401]  do_syscall_64+0x7e/0x250
[  670.361406]  ? do_syscall_64+0xb6/0x250
[  670.361410]  ? do_faccessat+0x1d7/0x2d0
[  670.361414]  ? do_syscall_64+0xb6/0x250
[  670.361418]  ? __x64_sys_fsopen+0xb9/0x110
[  670.361422]  ? do_syscall_64+0xb6/0x250
[  670.361426]  ? arch_exit_to_user_mode_prepare.isra.0+0x6a/0xa0
[  670.361431]  ? irqentry_exit_to_user_mode+0x2c/0x1c0
[  670.361436]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  670.361441] RIP: 0033:0x7f95ef1cd3ce
[  670.361470] Code: 73 01 c3 48 8b 0d 32 3a 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 3a 0f 00 f7 d8 64 89 01 48
[  670.361473] RSP: 002b:00007ffee85650d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
[  670.361478] RAX: ffffffffffffffda RBX: 00005621c0d2b710 RCX: 00007f95ef1cd3ce
[  670.361480] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[  670.361482] RBP: 00007ffee8565220 R08: 0000000000000000 R09: 0000000000000000
[  670.361484] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  670.361486] R13: 00005621c0d2d4e0 R14: 00007f95ef34ea60 R15: 00005621c0d2d578
[  670.361491]  </TASK>
[  670.361494] kobject: kobject_add_internal failed for 958beb6e-eadb-469f-9b33-a06db5a014e7 with -EEXIST, don't try to register things with the same name in the same directory.
[  670.362231] BTRFS error (device dm-0): failed to init sysfs fsid interface: -17
[  670.365833] BTRFS error (device dm-0): open_ctree failed: -17


This doesn't always happen. I'm not sure what the pattern is yet.

--
Chris Murphy

