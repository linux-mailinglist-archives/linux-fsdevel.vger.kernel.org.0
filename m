Return-Path: <linux-fsdevel+bounces-49945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A81AC6183
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463FB1BA628C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB320E700;
	Wed, 28 May 2025 06:02:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D9946C;
	Wed, 28 May 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412164; cv=none; b=H6v6Jd/j3Ylhs0YIYRwKF4fjHVfsO7q2iFcQBocrmXtnz4T9EtPrmdFjsEENCi8ptM/UaUecSx2P6pKjgZVWyukzBy6w2Mb/8IA+9v1MVrMS7ZHZMZMzf2CYK92A0EQAi+ZC2r1zwgKkbnIri4ABsFpyh2eI7xGLjCaz8Exj/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412164; c=relaxed/simple;
	bh=g+ZXM88JGqJF3j2j/6W/3xccEWWCQ5wx+u00mjIwc1E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OnKfhqY3UEF9COHHOxLiofb16zGZoOUNunHw/r3iXBMMF8i0pVKpEZZn+VILbtQMgUL5XxySSlS+TAcXs3uIB+wyoem8C+yVQITG9dddGUx7RG5TiemSdna/bQDF9eHU2iJPK2hWyo/LImxJtM8ZWy8N5AD/03mCTsyh52U/qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8559.dip0.t-ipconnect.de [91.46.133.89])
	by mail.itouring.de (Postfix) with ESMTPSA id 82921C939;
	Wed, 28 May 2025 07:57:26 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 26B8360191E20;
	Wed, 28 May 2025 07:57:26 +0200 (CEST)
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
To: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Jens Axboe <axboe@kernel.dk>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250523061104.3490066-1-namcao@linutronix.de>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>
Date: Wed, 28 May 2025 07:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250523061104.3490066-1-namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello,

I have been running with v2 on 6.15.0 without any issues so far, but just
found this in my server's kern.log:

May 27 22:02:12 tux kernel: ------------[ cut here ]------------
May 27 22:02:12 tux kernel: WARNING: CPU: 2 PID: 3011 at fs/eventpoll.c:850 __ep_remove+0x137/0x250
May 27 22:02:12 tux kernel: Modules linked in: loop nfsd auth_rpcgss oid_registry lockd grace sunrpc sch_fq_codel btrfs nct6775 blake2b_generic nct6775_core xor lzo_compress hwmon_vid i915 raid6_pq zstd_compress x86_pkg_temp_thermal drivetemp lzo_decompress coretemp i2c_algo_bit sha512_ssse3 drm_buddy sha512_generic intel_gtt sha256_ssse3 drm_client_lib sha256_generic libsha256 sha1_ssse3 drm_display_helper sha1_generic wmi_bmof drm_kms_helper aesni_intel mq_deadline ttm usbhid gf128mul libaes drm crypto_simd cryptd i2c_i801 video atlantic i2c_smbus drm_panel_orientation_quirks zlib_deflate i2c_core wmi backlight
May 27 22:02:12 tux kernel: CPU: 2 UID: 996 PID: 3011 Comm: chrony_exporter Not tainted 6.15.0 #1 PREEMPTLAZY
May 27 22:02:12 tux kernel: Hardware name: System manufacturer System Product Name/P8Z68-V LX, BIOS 4105 07/01/2013
May 27 22:02:12 tux kernel: RIP: 0010:__ep_remove+0x137/0x250
May 27 22:02:12 tux kernel: Code: 48 89 c7 48 85 c0 74 22 48 8d 54 24 08 48 89 fe e8 3e 1c 24 00 48 89 df e8 56 1c 24 00 48 89 c7 4c 39 e8 74 07 48 85 ff 75 de <0f> 0b 4d 85 f6 74 10 48 8b 7c 24 08 48 89 da 4c 89 f6 e8 12 1c 24
May 27 22:02:12 tux kernel: RSP: 0018:ffffc90002a4be40 EFLAGS: 00010246
May 27 22:02:12 tux kernel: RAX: 0000000000000000 RBX: ffff888104361710 RCX: ffff8881100f2d00
May 27 22:02:12 tux kernel: RDX: 0000000000000000 RSI: ffff888100e04800 RDI: 0000000000000000
May 27 22:02:12 tux kernel: RBP: ffff888367929080 R08: ffff888104361718 R09: ffffffff81575c7b
May 27 22:02:12 tux kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881043616c0
May 27 22:02:12 tux kernel: R13: ffff8883679290a0 R14: 0000000000000000 R15: 0000000000000002
May 27 22:02:12 tux kernel: FS:  00007fee87df5740(0000) GS:ffff88887c9c4000(0000) knlGS:0000000000000000
May 27 22:02:12 tux kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 27 22:02:12 tux kernel: CR2: 000000c002a33000 CR3: 00000001076f1003 CR4: 00000000000606f0
May 27 22:02:12 tux kernel: Call Trace:
May 27 22:02:12 tux kernel:  <TASK>
May 27 22:02:12 tux kernel:  do_epoll_ctl+0x6ee/0xcf0
May 27 22:02:12 tux kernel:  ? kmem_cache_free+0x2c5/0x3b0
May 27 22:02:12 tux kernel:  __x64_sys_epoll_ctl+0x53/0x70
May 27 22:02:12 tux kernel:  do_syscall_64+0x47/0x100
May 27 22:02:12 tux kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
May 27 22:02:12 tux kernel: RIP: 0033:0x55a289d4952e
May 27 22:02:12 tux kernel: Code: 24 28 44 8b 44 24 2c e9 70 ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
May 27 22:02:12 tux kernel: RSP: 002b:000000c0000584d0 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
May 27 22:02:12 tux kernel: RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000055a289d4952e
May 27 22:02:12 tux kernel: RDX: 0000000000000008 RSI: 0000000000000002 RDI: 0000000000000004
May 27 22:02:12 tux kernel: RBP: 000000c000058528 R08: 0000000000000000 R09: 0000000000000000
May 27 22:02:12 tux kernel: R10: 000000c000058514 R11: 0000000000000246 R12: 000000c000058578
May 27 22:02:12 tux kernel: R13: 000000c00015e000 R14: 000000c000005a40 R15: 0000000000000000
May 27 22:02:12 tux kernel:  </TASK>
May 27 22:02:12 tux kernel: ---[ end trace 0000000000000000 ]---

It seems the condition (!n) in __ep_remove is not always true and the WARN_ON triggers.
This is the first and only time I've seen this. Currently rebuilding with v3.

cheers
Holger


