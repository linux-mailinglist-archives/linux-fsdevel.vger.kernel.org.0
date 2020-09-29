Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2576927C03B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 10:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgI2I62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2I61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:58:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCCC061755;
        Tue, 29 Sep 2020 01:58:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u21so3348791ljl.6;
        Tue, 29 Sep 2020 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0zBr7rwUnSApw+xeuuXKjxi2DqhntGUX6NwDcSVTSP4=;
        b=TdP329uMGNiYMCvAVgrGW1puWhYZdPxdwfxqylSQuqfP62QTDNG0mEpBgTbgV5hz5A
         3Por1zOy+ISPwcRmoSVzN24jp14oOVGcqjq7kENc3LLLNgFoJVr5zI9+5TuWQvAiLjL7
         Qm/U+Cnu+MO7WN8V9yy7epsGmEZDAXjar7lKgY7HGcT5ntm6xWqz8QT0ziEog1Z3c/hy
         Vgse6+FXUi/+7G905A51A5W0hX53fUiCiZB8AjTQQHOQPDDXPDP4iOADgnJCw5ikKKoP
         vqxoZ828GhkigQmSlpU/UKBBUTKcLxAN2FFp6s5w79H9g0Mn42vZNt804AKFmaDgNal8
         SKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0zBr7rwUnSApw+xeuuXKjxi2DqhntGUX6NwDcSVTSP4=;
        b=gCfTCig4TLeMzve25CId9tEqh2Ki4V1tqDFMjc+E55JHHNe4F4yXUx7u+0MdHFFV+Q
         HOFWuVyt6VEMjEN21pu5z95VoVZ2/G+ODx1psvpCvLrqrpJvHMgm/2Ftcqx+ZZJJGuds
         UtesxxPgq8F2vlYAzpvzKRpY/9la77CBOoQq1C6LEcp7ecdC/ufSuBfWYuz/IOd2rGpA
         SFBGaXHATH0VmXI5kPXf3tkdi4hqOWXrJAldcPoo3gj7VPn8VJVOwdWL9InOAcDxLiuf
         EyY76hrBF8FMpnlbMqwsJL0jXSHudXleRcP2Nr+ARfve0jiMFrTM+MHLmGaLFC1JOTEr
         nWCg==
X-Gm-Message-State: AOAM531VcfR62wPy1RSJ8iw+p+uLDkmOBqQY7NynXEWvJuW54h5obvvr
        y45I5MIdM1pUSYbPPVZTrh04ADYHqJMSai14HRL/idoDD54=
X-Google-Smtp-Source: ABdhPJwSkLeByJEAdpmXiurVAZcbG+LrGSQrU7Zy0uUZCrKgeu4jfpJOsrcN7xKuNSs718reur9sus9Tb7pjWc0vjDk=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr913125ljl.406.1601369905660;
 Tue, 29 Sep 2020 01:58:25 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 29 Sep 2020 16:58:14 +0800
Message-ID: <CAFcO6XM4UC9rwrAjpjAhKfwgu0iZh3bjPopueGM=yzx2HahSEQ@mail.gmail.com>
Subject: null-ptr-deref in exfat_cache_inval_inode
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I report a null pointer deref bug (in linux-5.9.0-rc6) found by kernel fuzz.

kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.9.0-rc6-config

and can reproduce. the crash log is asblow:


RBP: 0000000020000000 R08: 00007f5988f22b00 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000100
R13: 0000000020000200 R14: 00007f5988f22ac0 R15: 0000000020013b00
general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 11738 Comm: syz-executor.3 Not tainted 5.9.0-rc6+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
RIP: 0010:__list_del_entry_valid+0x1d/0xef lib/list_debug.c:42
Code: 48 8b 34 24 eb b4 0f 1f 80 00 00 00 00 48 b8 00 00 00 00 00 fc
ff df 41 55 41 54 55 48 89 fd 48 83 c7 08 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 a0 00 00 00 48 89 ea 4c 8b 65 08 48 b8 00 00 00
RSP: 0018:ffffc90004137a98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffc90007b41000
RDX: 0000000000000001 RSI: ffffffff82245325 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000826f49 R11: 0000000000000001 R12: ffffed1004cde473
R13: ffff8880266f2498 R14: 0000000000000008 R15: 0000000000000000
FS:  00007f5988f23700(0000) GS:ffff88806c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000768000 CR3: 0000000069d71003 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000886c DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 __exfat_cache_inval_inode fs/exfat/cache.c:212 [inline]
 exfat_cache_inval_inode+0xb3/0x310 fs/exfat/cache.c:227
 exfat_evict_inode+0x76/0x33e fs/exfat/inode.c:660
 evict+0x2ed/0x750 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 exfat_fill_super.cold+0x32/0x65a fs/exfat/super.c:681
 get_tree_bdev+0x421/0x740 fs/super.c:1342
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46acda
Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5988f22a68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5988f22b00 RCX: 000000000046acda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5988f22ac0
RBP: 0000000020000000 R08: 00007f5988f22b00 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000100
R13: 0000000020000200 R14: 00007f5988f22ac0 R15: 0000000020013b00
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 4c5231563b9b92e6 ]---
RIP: 0010:__list_del_entry_valid+0x1d/0xef lib/list_debug.c:42
Code: 48 8b 34 24 eb b4 0f 1f 80 00 00 00 00 48 b8 00 00 00 00 00 fc
ff df 41 55 41 54 55 48 89 fd 48 83 c7 08 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 a0 00 00 00 48 89 ea 4c 8b 65 08 48 b8 00 00 00
RSP: 0018:ffffc90004137a98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffc90007b41000
RDX: 0000000000000001 RSI: ffffffff82245325 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000826f49 R11: 0000000000000001 R12: ffffed1004cde473
R13: ffff8880266f2498 R14: 0000000000000008 R15: 0000000000000000
FS:  00007f5988f23700(0000) GS:ffff88806c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000768000 CR3: 0000000069d71003 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000886c DR6: 00000000ffff0ff0 DR7: 0000000000000400

Regard,
 butt3rflyh4ck
