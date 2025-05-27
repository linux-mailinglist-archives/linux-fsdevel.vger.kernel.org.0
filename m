Return-Path: <linux-fsdevel+bounces-49884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B9AC4726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 06:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB33B43B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 04:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F991BD9C9;
	Tue, 27 May 2025 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNqhxPWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FBB652
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318851; cv=none; b=dYWxVUjcgVjcrZNckXfQq7YmNuTZQUNG3AJiGz8+VQQVWqFV3C+hpkXPpJzyeFzZy9gplpwbPzAOzrdtIEWsoDySk5EL5StXfGQNODnyjVu+Cbr7qAJ1y11oKHhgD9MlbspVzo6mQ7W4NJxWazOJpng6xB8fvZkwmHUIMbrz3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318851; c=relaxed/simple;
	bh=AUEyQQQyqgLUdPXBur2ZHltsHPkma0X7HyCGHD0SgYo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Oy+y8OmxqrtFUcUuM0HyOqAk6MsK38DSCMhRlZUn6geXxBqkFIjpcME9rNtnxh07dURzrBf799CfgxZOYjCVoU7QTFUcLcSafP9HDgBcJpOMZLL3RiZ9Z/4fnV0kgpcB3004xCKUMg4ZazOmjizNr8pfRvcTZsBEeO5HZDl+Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNqhxPWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748318847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=YLO49BBVfv2dLLPNONoP9dM7xhb3SydtgrIyljAGfZE=;
	b=GNqhxPWmiyqqMN+oLX2t/xzLBKfuxaiN51ETAyU6Gp3y3e6hvKuoU2YLRj6Ro7KrY3hKQ9
	SDSXpYpP+NxQawiGovfONTa03ERdxKjNvhVSbGPGCGH1jsa7sSIB1OnWK320rGKN5SjGX6
	m4e4nv3mNAAKz9zyG/a2VFEo5f0RWTo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-8jM0WCNlOFW7zbfTlKs0Xw-1; Tue, 27 May 2025 00:07:25 -0400
X-MC-Unique: 8jM0WCNlOFW7zbfTlKs0Xw-1
X-Mimecast-MFC-AGG-ID: 8jM0WCNlOFW7zbfTlKs0Xw_1748318845
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6faad1f2b69so17419356d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 21:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748318844; x=1748923644;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLO49BBVfv2dLLPNONoP9dM7xhb3SydtgrIyljAGfZE=;
        b=Pd7Za3Epjd8dVkq+42zDWpkEn+SNf6ab0QtKivMY74BG+sx4j2BnHvQKHz/l2P0bvm
         UEXLrHC92gftRJYmIyeMzLyxuOEqFER4uBCBOX9TyTMh42yg807AkmSCZPBA48boZyDn
         OTIo4Df9Eb4ulPOgUXkToWcFD8Yyfz1V9Y9OH9bTwfoUVh/cGsuVp8wZhXV9UKw0P3eO
         l2TcBC4ujyO5jbBEm/k5QFSKDE8h0zvXQLOWVyItTenQOcBkc7+x99AW+wARPkIoLjXL
         ZJLQh7E1Uq+GCX2io02VvsjgK52NDwGAmQgU8KX6SW8b/Aev5j8eS4VtHF4lJ4a6mS00
         UBKg==
X-Forwarded-Encrypted: i=1; AJvYcCW3mLoOTOSJKTsCtgF4i8ofeztUjy5UK2gLVdSJnxR9G6MmRnb84cfNR7pENtCUa8n7Alquwcww//+e6B/9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9uMg4fgSmJUsLKpQmXDVQOrpvf950NgRsTHz7yAY7LgIlozz
	JbbieyOiVKbF1lvlSrEdJeB2TQq965iuLXWU9rv1ZjLZ95tHctDbzeCfMWLeiMnU9moxRNHkrye
	3rlvBlSGpEBVxuOYt3htjZriFk+y2zv8u8s7NPfkb37zYDhDog7GF7od4QTg7z2wD+zWOy5cj1P
	skbhVQiw3hKONgmx/J6CiHEp1BvKadRvlr2sULmCnzC7vYMxpImLJf
X-Gm-Gg: ASbGncuWy4E4OQpOzFwXe5StnZEfRaXEAjiKM454EgRlGtu6ZczbEsk7frA2XzAfWN2
	xb69DeFFZB0wfWndHDarw40+5Wtgbc9ozI0/Ln2OxAq5VZZoK6oAP5370+3dJPGXSDV4SDg==
X-Received: by 2002:a05:6602:399c:b0:869:d4df:c2a6 with SMTP id ca18e2360f4ac-86cbb8cd7fbmr1347143139f.14.1748318834319;
        Mon, 26 May 2025 21:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPwP4hw52btz22YSfS0zaEmMTkCfoI+WLVUUQnouFLlq9+hsTSEq0/4BhU/7QlCZQVu0FRQx7ku5kMdUR/A8=
X-Received: by 2002:a05:6102:dd0:b0:4e4:1d6c:a808 with SMTP id
 ada2fe7eead31-4e4240613c9mr8134202137.5.1748318823634; Mon, 26 May 2025
 21:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 27 May 2025 12:06:52 +0800
X-Gm-Features: AX0GCFvaQllsn909fbL_wB84PEHmHDumj7cL3yF_2z3lw2wcX7xFjpX3jKEvDH0
Message-ID: <CAFj5m9LWYk4OX8UijOutKFV-Hgga_w7KPT=MRLLyOscKBwCA-g@mail.gmail.com>
Subject: [Bug] v6.15+: kernel panic when mount & umount btrfs
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Just try the latest linus tree by running `rublk` builtin test on
Fedora, and found
the following panic:

git clone https://github.com/ublk-org/rublk
cd rublk
cargo test


[   24.153674] BTRFS: device fsid b99703ee-349d-40fa-b3d6-b5b451f979ab
devid 1 transid 8 /dev/ublkb1 (259:3) scanned by moun)
[   24.154624] BTRFS info (device ublkb1): first mount of filesystem
b99703ee-349d-40fa-b3d6-b5b451f979ab
[   24.155123] BTRFS info (device ublkb1): using crc32c (crc32c-x86)
checksum algorithm
[   24.155777] BTRFS info (device ublkb1): using free-space-tree
[   24.157502] BTRFS info (device ublkb1): host-managed zoned block
device /dev/ublkb1, 256 zones of 4194304 bytes
[   24.158503] BTRFS info (device ublkb1): zoned mode enabled with
zone size 4194304
[   24.159541] BTRFS info (device ublkb1): checking UUID tree
[   24.166324] EXT4-fs (ublkb5): mounted filesystem
ae8f9776-4cb7-4edd-9acd-44291433e146 r/w with ordered data mode. Quota
mode: none.
[   24.169139] EXT4-fs (ublkb8): mounted filesystem
4beadbbc-d9c3-484d-b37b-8ea7ceb4cade r/w with ordered data mode. Quota
mode: none.
[   24.171259] EXT4-fs (ublkb5): unmounting filesystem
ae8f9776-4cb7-4edd-9acd-44291433e146.
[   24.173862] EXT4-fs (ublkb8): unmounting filesystem
4beadbbc-d9c3-484d-b37b-8ea7ceb4cade.
[   24.336068] ------------[ cut here ]------------
[   24.336449] kernel BUG at fs/btrfs/extent_io.c:2776!
[   24.336786] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   24.337064] CPU: 7 UID: 0 PID: 119 Comm: kworker/u64:2 Not tainted
6.15.0+ #279 PREEMPT(full)
[   24.337530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-1.fc39 04/01/2014
[   24.337985] Workqueue: writeback wb_workfn (flush-btrfs-2)
[   24.338293] RIP: 0010:detach_extent_buffer_folio+0xca/0xd0
[   24.338595] Code: 4d 34 74 18 84 db 74 96 4d 8d 75 7c 5b 4c 89 f7
5d 41 5c 41 5d 41 5e e9 54 f7 aa 00 48 89 ef e8 8c 48 d0 ff eb de 0f
0b0
[   24.339599] RSP: 0018:ffffd34500477880 EFLAGS: 00010202
[   24.339887] RAX: 0017ffffc000400a RBX: 0000000000000001 RCX: ffffd34500477838
[   24.340280] RDX: 0000000000000001 RSI: fffff5a2442fb280 RDI: ffff8bf88590ef74
[   24.340697] RBP: fffff5a2442fb280 R08: 0000000000000024 R09: 0000000000000000
[   24.341143] R10: 0000000000000001 R11: ffff8bf896b39500 R12: ffff8bf88de8cd20
[   24.341597] R13: ffff8bf88590eef8 R14: ffff8bf88590ef74 R15: ffffd34500477970
[   24.342106] FS:  0000000000000000(0000) GS:ffff8bfd3ffb6000(0000)
knlGS:0000000000000000
[   24.342739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.343087] CR2: 00007f55e0cdff10 CR3: 00000002af824002 CR4: 0000000000772ef0
[   24.343504] PKRU: 55555554
[   24.343667] Call Trace:
[   24.343823]  <TASK>
[   24.343956]  release_extent_buffer+0x9b/0xd0
[   24.344209]  btree_write_cache_pages+0x1de/0x590
[   24.344486]  do_writepages+0xc8/0x170
[   24.344707]  __writeback_single_inode+0x41/0x340
[   24.344979]  writeback_sb_inodes+0x21b/0x4e0
[   24.345234]  wb_writeback+0x98/0x330
[   24.345449]  wb_workfn+0xc2/0x450
[   24.345648]  ? try_to_wake_up+0x308/0x740
[   24.346052]  process_one_work+0x188/0x340
[   24.346445]  worker_thread+0x257/0x3a0
[   24.346811]  ? __pfx_worker_thread+0x10/0x10
[   24.347206]  kthread+0xfc/0x240
[   24.347560]  ? __pfx_kthread+0x10/0x10
[   24.347924]  ret_from_fork+0x34/0x50
[   24.348284]  ? __pfx_kthread+0x10/0x10
[   24.348672]  ret_from_fork_asm+0x1a/0x30
[   24.349046]  </TASK>
[   24.349344] Modules linked in: iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi target_core_pscsi target_core_file
target_core_iblockg
[   24.353785] Dumping ftrace buffer:
[   24.354170]    (ftrace buffer empty)
[   24.354584] ---[ end trace 0000000000000000 ]---
[   24.355021] RIP: 0010:detach_extent_buffer_folio+0xca/0xd0
[   24.355525] Code: 4d 34 74 18 84 db 74 96 4d 8d 75 7c 5b 4c 89 f7
5d 41 5c 41 5d 41 5e e9 54 f7 aa 00 48 89 ef e8 8c 48 d0 ff eb de 0f
0b0
[   24.357039] RSP: 0018:ffffd34500477880 EFLAGS: 00010202
[   24.357571] RAX: 0017ffffc000400a RBX: 0000000000000001 RCX: ffffd34500477838
[   24.358183] RDX: 0000000000000001 RSI: fffff5a2442fb280 RDI: ffff8bf88590ef74
[   24.358807] RBP: fffff5a2442fb280 R08: 0000000000000024 R09: 0000000000000000
[   24.359443] R10: 0000000000000001 R11: ffff8bf896b39500 R12: ffff8bf88de8cd20
[   24.360070] R13: ffff8bf88590eef8 R14: ffff8bf88590ef74 R15: ffffd34500477970
[   24.360746] FS:  0000000000000000(0000) GS:ffff8bfd3ffb6000(0000)
knlGS:0000000000000000
[   24.361451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.362055] CR2: 00007f55e0cdff10 CR3: 00000002af824002 CR4: 0000000000772ef0
[   24.362812] PKRU: 55555554
[   24.363145] Kernel panic - not syncing: Fatal exception
[   24.363845] Dumping ftrace buffer:
[   24.364213]    (ftrace buffer empty)
[   24.364602] Kernel Offset: 0x27000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.365385] ---[ end Kernel panic - not syncing: Fatal exception ]---

Thanks,


