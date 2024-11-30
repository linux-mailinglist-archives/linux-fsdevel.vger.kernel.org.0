Return-Path: <linux-fsdevel+bounces-36170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C469DEE64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 02:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0320B22EC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 01:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651478C76;
	Sat, 30 Nov 2024 01:51:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0964595B
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931466; cv=none; b=ASAm1d0rbr71j/a7V054ttEazDsbdb3B107SvJw1LOUT2WIR+adu5Sj0g4nCzGqr7GuR2IeVhpcBbBZB5R94wUoMM0RRC8+QJvbnECodIEXZKzfRW1+zzfFVaOgXFgNtgw55ad1qRJAMT+U2KD67oMmJGFWBQG8MlaUvbF66bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931466; c=relaxed/simple;
	bh=NUbjVQgGoFqAnXA/IchsC9G2+649iBaX9zpc6YKoK04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X3eJsKMQeH96hpcjJXSjNBzoOb+zDbQm1/w6W4Z5ZBtK3XdR/6oRgWhzCRwhPM7Kf4WPUswfBxceZIEmm4jS994DZoGZCH6584aqjLZbLrMZ9gT6YCVSIjfZI/gzAln1FBHh/G8tDrksMs74cTfpuaTcU8CfFLpB9dnhRezg8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso27924715ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 17:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931464; x=1733536264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRP17he4fRD3Fi6XiiwKiBdoJ3HW7GQoqniKTEAxDI=;
        b=pmA6y5hNSGJv4ytKW3ZDPisjmkLZXBTOvbzYZ4AJx9XsYq2tIeM6LyH5xodSSoMild
         vnfxFsxW7ahvg9k9+e+Sa8HHAv6ndgkQyBXl3mgcq8MOYDmCcxYUpI/vaKsrxG4YkisQ
         1e2P2wCZO0EXdTarrJCAEz2gvwAPmexJtclVOs/O6/PBqv1YQPvlqaK7LV4HWr1HDWKK
         KlqT0a/ZlTC0AqUw3+84xNhDFT5e4KhR6HRCilSsG/yER+K3qr1/hTh2stSP351paPj2
         jYUANJrWrmGuYjj0DL3wjE7vpllDu61hwH4hxwmJNs8QkvoZEPsUkYFliLhiquIF6u4e
         Sx5g==
X-Forwarded-Encrypted: i=1; AJvYcCUoG2s/HqHkphHbUrYDaZZMCwDatnU6/OF2rJNBHD7C6yXXRLvUFq4qHBXf4DIooQlKZKfVS/GpEkk+KJH6@vger.kernel.org
X-Gm-Message-State: AOJu0YyywILAj7j/JmZ2MoClkRzR6M2lJZYh4DQ0Pe5u9C6bW0t1i/Ar
	DrXcSa2bH/IAFX4rFZTuSqva6RPphsm3ZLbNVHgtZfd+QYCeJAtNfsAtvTy/dJt2ngZeBFEmThp
	XhP2Y1+osJCfe8vEppuOtFoWwWevMSndNwf8R0oZ5AEV4qKkJ4wNf7lM=
X-Google-Smtp-Source: AGHT+IGWvCi6MZhdxrapdtlirxLTp6zo0MxlEQi6Z6S1fxcH6GoBRYn2AapBStNo1CI/jCHuUxoGfQINBiAGJLKg1+Kar9y7JT70
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3a7c55eb884mr133715385ab.20.1732931463806; Fri, 29 Nov 2024
 17:51:03 -0800 (PST)
Date: Fri, 29 Nov 2024 17:51:03 -0800
In-Reply-To: <fcc3cf12-9ad3-49bf-9880-5e82dc7d7e99@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_KEYS too low!

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 11728 Comm: kworker/u8:10 Not tainted 6.12.0-rc7-syzkaller-00133-g17a4e91a431b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btrfs-cache btrfs_work_helper
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 register_lock_class+0x827/0x980 kernel/locking/lockdep.c:1328
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 process_one_work kernel/workqueue.c:3204 [inline]
 process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         17a4e91a btrfs: test if we need to wait the writeback ..
git tree:       https://github.com/adam900710/linux.git writeback_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=12c5ad30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

