Return-Path: <linux-fsdevel+bounces-70457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58221C9BAA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0E73A80F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA731ED8B;
	Tue,  2 Dec 2025 13:47:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC242D3233
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683227; cv=none; b=InVDlmlyL1gki6edR4XpfvAEMaAjkGCx9XI5JbSROXiO5BuJL2hgEOwLEV8SY04um/iWbFv/Y9TaTysFASPOfGHifuPgkB7OfI8wvWHZdTqhNW+4lA7O9oKL2KS3oEq2K0DYDIV4jLV0EgsfB9bOvCDWBvO0xlaHvCbPchE03h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683227; c=relaxed/simple;
	bh=gq4RH7/rXPBc848MQObPZFz2syRF52XAl2b3tQIWS+Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZvLopCfbfLP8yvN4wheVWUyHzq4NwFMcyy4xTzTJ6xxRnrf0NVjexI8E44xCqcZd652ld7it1lSZNU4x2BA6vtrJhmuRRLXVn2uDVSvcz9EdShNi+eDyxhyGCXlOY8snVKy2F6iKRiZ0aI+HrvjXtPYEsEQwaemL0zUQJCCPqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4512e9f2f82so4588366b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 05:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764683223; x=1765288023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFFITXgcbn3BF5XGL3IGOv0vn/QQzSLXJ0ctS9VxMf4=;
        b=EoaJTB0QtoeGCz00QBJPKp/b9HjvUUx78STUuOKSq5v8QwSvVjUZamNRHRvTSfUANE
         fUREZADe7EU1hvNbTETEjXGBlG7THo2JKF9coaUo7eTSocTvo4/jnO9D08MeFsOkoDJA
         RTRL+LGHimftJeaKBrnQGcyvCWiVdI+elmAdtX7gJe1WEJAbD/OHXTnDJXkPkBc0TnAq
         QGV7lU7QAut535koCoyzbvc7Tdtum/gEksO39fTzoZPZEZwZiH5b/5KfzG76xrxDCnkx
         OmNy/N7BLWq4Pz4iipxSZvb3/GQy50fmCbJ2jtIlaRh8lgdMPrkYOfj+6ASysatNmaKh
         gz9g==
X-Forwarded-Encrypted: i=1; AJvYcCVa48/LOlIY34z0OQk2U8SvvSwi8ydi2tHYSFhP3f3qYi0vlIds8qKxW2MFLJ/t+OBNUv99v86muzsLj48S@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwp0hxpS/km70Pzw8ntOvZngB+hFZ4bBQPOmWmZZUXTtfAEzdX
	my3RPhAD8j4YbiGd/8dz1DyWuDZ3ZuUtg4fcdrkyYT8c2Rwl0BCebMnYtHHLYklYEx6hXZEreit
	hYucAwfRWzyTYZRIbgxpWFxeMjh+zh2rVUuPx3VDTsEGO3QoSs1vT90rN438=
X-Google-Smtp-Source: AGHT+IH7K/LOkJUjlG3rKR7P/dRxolDR4iQGe2TKbFAebnEenAr/rpGcGAnpJoEc4BiGxFc8dUSs0azB+1dptAF2mz5PbyKwGhNN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6787:b0:450:d558:76f5 with SMTP id
 5614622812f47-4511290cecemr19418847b6e.13.1764683223510; Tue, 02 Dec 2025
 05:47:03 -0800 (PST)
Date: Tue, 02 Dec 2025 05:47:03 -0800
In-Reply-To: <20251202132545.GA86223@macsyma.lan>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692eedd7.a70a0220.2ea503.00c5.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __folio_mark_dirty (3)
From: syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __folio_mark_dirty

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6740 at mm/page-writeback.c:2716 __folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
Modules linked in:
CPU: 1 UID: 0 PID: 6740 Comm: syz.0.31 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
Code: 3c 38 00 74 08 48 89 df e8 d2 a1 26 00 4c 8b 33 4c 89 f6 48 83 e6 08 31 ff e8 71 ef c4 ff 49 83 e6 08 75 1c e8 06 ea c4 ff 90 <0f> 0b 90 eb 16 e8 fb e9 c4 ff e9 7e 07 00 00 e8 f1 e9 c4 ff eb 05
RSP: 0018:ffffc90003a979d0 EFLAGS: 00010293
RAX: ffffffff81f9d61a RBX: ffffea0001056b40 RCX: ffff888020775a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff9400020ad69 R12: ffff88805b014d00
R13: ffff88805b014cf8 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555575052500(0000) GS:ffff888126ef6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000440 CR3: 0000000036d66000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 block_dirty_folio+0x17a/0x1d0 fs/buffer.c:754
 fault_dirty_shared_page+0x103/0x570 mm/memory.c:3518
 wp_page_shared mm/memory.c:3905 [inline]
 do_wp_page+0x263e/0x4930 mm/memory.c:4108
 handle_pte_fault mm/memory.c:6193 [inline]
 __handle_mm_fault mm/memory.c:6318 [inline]
 handle_mm_fault+0x97c/0x3400 mm/memory.c:6487
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f1eba837398
Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
RSP: 002b:00007ffd39d5fc68 EFLAGS: 00010246
RAX: 0000200000000440 RBX: 0000000000000004 RCX: 0030656c69662f2e
RDX: 0000000000000008 RSI: 0030656c69662f2e RDI: 0000200000000440
RBP: 00007f1ebaac7da0 R08: 0000001b2cc20000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 00007f1ebaac5fac
R13: 00007f1ebaac5fa0 R14: fffffffffffffffe R15: 00007ffd39d5fd80
 </TASK>


Tested on:

commit:         6fb67ac8 ext4: drop the TODO comment in ext4_es_insert..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=16156192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

