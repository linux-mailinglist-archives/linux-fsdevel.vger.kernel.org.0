Return-Path: <linux-fsdevel+bounces-52376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293EAE2795
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AD65A3554
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEDA1A00FA;
	Sat, 21 Jun 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUKu3lLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D51917ED
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jun 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750486141; cv=none; b=W3xeBMQJMzeR6DCn3NEuZ27kd0WSslR+UuFErnxMSsKr4eeGo5ON/6lSsL1FXPD3iHeT5u3vvxK2DNNsxQuaS//yKGKE5E6kgBROqM9EEx7Hjo0Wo9q7xZJFBOYTlBhtebXdyHAqsd+lomiPHL4+BDlGq1UiUbB0zcCQ4sn8gMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750486141; c=relaxed/simple;
	bh=H5TZ2/yxYZP3oSZxiSV6KJv3Y+I2Wa2DX/w3wTurgGc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ae7BsMaeqFJKEGdlXNthR3G7qTPfAC8tIOlHPWWAyzk/OnHRSb4o/2CtwAu+BVZWcpD+U12UARrOWwqzrhDhTeKNsdxL60N0JfYx3JtKS/8cCG+ec4B01qHnwA+QNCW8nla5nPhlY8sAyV6MLhH+JSkZZoP13EeKzWXfgqf61cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUKu3lLi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750486138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=K52vtEFucQLGuMYKPj05GF3xHKKk00K2SQIo3fmgfSg=;
	b=YUKu3lLiNzeE/VdF5fvNp3SFNISk2zJrwSm8pD/ia2R3skqCP0cufJhU+L/1Pe4EYtrwwE
	+10yjaOup5UPnWiUUphaeG8eLQRX9j1Y8dF6AMPl62y1mMukHCobeJjnHthKMhLbTNA/ts
	hAVbAaWrjhtEVD59a/zXEf2+A0HP6oQ=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-CSwUwJHyMRuyg9zf29MqWg-1; Sat, 21 Jun 2025 02:08:56 -0400
X-MC-Unique: CSwUwJHyMRuyg9zf29MqWg-1
X-Mimecast-MFC-AGG-ID: CSwUwJHyMRuyg9zf29MqWg_1750486136
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5316174e3ccso661827e0c.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 23:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750486136; x=1751090936;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K52vtEFucQLGuMYKPj05GF3xHKKk00K2SQIo3fmgfSg=;
        b=GTucKcWYXOkiVbzNdlTqdQwbEQaxJgOPnYag/pguVRn5+YjChAWAs1VYVe8EYUdTQw
         zW0CUExsUYooRMMk5QVN9TUkqzjlc7Wsj+zEAZZ399k2FkDfix5kRpSIzIJ5ql449gsL
         XRm4wLBSmvB6Lw8VIerGnuHlWDfOsBf4sl4T5J2/OMR45eJboi+io+16XUtjdi1N09N7
         7bGNN+gy4AGIsfVVs+MHgYWeOo5pehI1bQgoBh4KLQUVF4Ue47Teo3JE2h5H6RljJCW3
         D5tqEzU2nLb7fXanWlNF4tiMOESoffTAVzHM7NnP1DfmMIlP6JPGpUSxKXj4bV3GD6+G
         emYw==
X-Forwarded-Encrypted: i=1; AJvYcCXibtpMBBRrK6mSUnN4jlZCHJzFF99PVKfZbqFrOk5aPlvYX/V3eVs6VAX5zDSxCqX0cZYwcCCzraOdC0Wl@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1CZ5i+W36EpAUTOw/jSiHKgzKbHWMB/5Q9JKoH4KhffvzZhH
	A6XZzvBTw4rjOeUbQ5RhkFwp2x1TqJ53NGsWQenpzK1iCocpmXxpeVkw4UHFLFkytqmKCJ8Ntsa
	cvNs81Vtjtsvhb9RWqcDTbZE47vbAAPcGzpUXcWDjCI0pIzKPHNQ8kkGudFQncRqXCe5rtSWbZz
	g5opY5XLpdQp4a8rqDOiK5WC2WVQbs7zhG4ywryDo1Aw==
X-Gm-Gg: ASbGncvr2Dwf2SXkkipX6A1wGWjHk4QanmdbXC5ogIr7vt3xKgEqr6384CkXoWRInc4
	/IvbnVH90H2OVStuQAJZ48ROVR3DLgm6EA6VRPhzzhfiG3dj/jZhqo8XHSmKjPMAWUH2kbzZVdF
	RMJAyz
X-Received: by 2002:a05:6122:ca8:b0:530:7e05:3839 with SMTP id 71dfb90a1353d-531ad7b2082mr3595211e0c.11.1750486135676;
        Fri, 20 Jun 2025 23:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsHUaRWc2NcM9Iqj58DIfeKtW/k58h/kPWizo7tsvDaVv46Vjv8vidCt+94KkPp1WvqaYnP6K+S0vIDIN99aE=
X-Received: by 2002:a05:6122:ca8:b0:530:7e05:3839 with SMTP id
 71dfb90a1353d-531ad7b2082mr3595208e0c.11.1750486135330; Fri, 20 Jun 2025
 23:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 21 Jun 2025 14:08:44 +0800
X-Gm-Features: Ac12FXwu1_xOHn-k9ps5wWmOA0_RKeWo_S7_wOTUx3GDXOQVZ2GLfnGfNFK8GQM
Message-ID: <CAFj5m9KOjqYmUOYM4EgDBrJ-rQxEgOhm+pokmdAE6w+bCGrhSg@mail.gmail.com>
Subject: [v6.16-rc2+ Bug] panic in inode_doinit_with_dentry during booting
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

Hello Guys,

The latest v6.16-rc2+ kernel panics during booting, commit
3f75bfff44be ("Merge tag 'mtd/fixes-for-6.16-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux"):


[  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
         Starting systemd-sysctl.service - Apply Kernel Variables...
         Starting systemd-sysusers.service - Create System Users...
[  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
[    1.851473] Oops: general protection fault, probably for
non-canonical address 0x8cbad568292ed62c: 0000 [#1] SMP NOPTI
[    1.853362] CPU: 9 UID: 0 PID: 269 Comm: systemd-sysuser Not
tainted 6.16.0-rc2+ #328 PREEMPT(full)
[    1.854923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-1.fc39 04/01/2014
[    1.856374] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
[    1.857366] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
2f9
[    1.860338] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
[    1.861244] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 0000000000000000
[    1.862439] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa5414d38d8
[    1.863622] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c0de3a20
[    1.864810] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa5414d38d8
[    1.864813] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa5414d38d0
[    1.864814] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
knlGS:0000000000000000
[    1.864816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.864818] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 0000000000770ef0
[    1.870018] PKRU: 55555554
[    1.870020] Call Trace:
[    1.870029]  <TASK>
[    1.870031]  inode_doinit_with_dentry+0x42d/0x520
[    1.870035]  security_d_instantiate+0x93/0xb0
[    1.870038]  d_instantiate+0x2e/0x60
[    1.870043]  ramfs_mknod+0x58/0xb0
[    1.870047]  path_openat+0xf53/0x1200
[    1.870050]  do_filp_open+0xd7/0x190
[    1.870053]  ? _raw_spin_unlock+0xe/0x30
[    1.870055]  do_sys_openat2+0x8a/0xe0
[    1.870058]  __x64_sys_openat+0x54/0xa0
[    1.870060]  do_syscall_64+0x84/0x2c0
[    1.870063]  ? __x64_sys_openat+0x54/0xa0
[    1.870064]  ? do_syscall_64+0x84/0x2c0
[    1.870066]  ? do_sys_openat2+0xa4/0xe0
[    1.870068]  ? __x64_sys_openat+0x54/0xa0
[    1.870069]  ? do_syscall_64+0x84/0x2c0
[    1.870070]  ? handle_mm_fault+0x1d7/0x2e0
[    1.870074]  ? do_user_addr_fault+0x211/0x680
[    1.870077]  ? clear_bhb_loop+0x50/0xa0
[    1.870079]  ? clear_bhb_loop+0x50/0xa0
[    1.870080]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.870082] RIP: 0033:0x7feebf965e63
[    1.870084] Code: 83 e2 40 75 52 89 f0 f7 d0 a9 00 00 41 00 74 47
80 3d 50 22 0e 00 00 74 62 89 da 4c 89 e6 bf 9c ff ff ff b8 01 01 00
008
[    1.870085] RSP: 002b:00007ffd85a4c5d0 EFLAGS: 00000202 ORIG_RAX:
0000000000000101
[    1.870087] RAX: ffffffffffffffda RBX: 00000000000a0141 RCX: 00007feebf965e63
[    1.870088] RDX: 00000000000a0141 RSI: 000055ed496c4f10 RDI: 00000000ffffff9c
[    1.870089] RBP: 00007ffd85a4c640 R08: 00000000ffffff9c R09: 00007ffd85a4c4f0
[    1.870090] R10: 0000000000000180 R11: 0000000000000202 R12: 000055ed496c4f10
[    1.870091] R13: 0000000000000000 R14: 00007ffd85a4c6c0 R15: 000055ed29c98940
[    1.870092]  </TASK>
[    1.870093] Modules linked in: scsi_dh_rdac scsi_dh_emc
scsi_dh_alua ip6_tables ip_tables fuse dm_multipath qemu_fw_cfg
[    1.870121] ---[ end trace 0000000000000000 ]---
[    1.870123] RIP: 0010:__list_add_valid_or_report+0x1e/0xa0
[    1.870127] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
53 48 83 ec 08 48 85 f6 0f 84 76 2f 76 ff 48 89 d3 48 85 d2 0f 84 5c
2f9
[    1.870127] RSP: 0018:ffffd152c0de3a10 EFLAGS: 00010286
[    1.870129] RAX: ffff8aa5414d38d8 RBX: 8cbad568292ed624 RCX: 0000000000000000
[    1.870130] RDX: 8cbad568292ed624 RSI: ffff8aa5401f40f0 RDI: ffff8aa5414d38d8
[    1.870130] RBP: ffff8aa5414d38f4 R08: ffffd152c0de3a7c R09: ffffd152c0de3a20
[    1.870131] R10: ffff8aa5401f40c0 R11: 0000000000000007 R12: ffff8aa5414d38d8
[    1.870132] R13: ffff8aa5401f40c0 R14: ffff8aa5401f40f0 R15: ffff8aa5414d38d0
[    1.870133] FS:  00007feebef42bc0(0000) GS:ffff8aa9ed02f000(0000)
knlGS:0000000000000000
[    1.870134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.870135] CR2: 00007feebfb58180 CR3: 0000000117f4d004 CR4: 0000000000770ef0
[    1.870137] PKRU: 55555554
[    1.870138] Kernel panic - not syncing: Fatal exception
[    1.870365] Kernel Offset: 0x3a000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.898219] ---[ end Kernel panic - not syncing: Fatal exception ]---




Thanks,


