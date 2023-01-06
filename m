Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA52F660412
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAFQPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 11:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjAFQPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:15:46 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3276219
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 08:15:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso1020982iow.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 08:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNRYTiAron3sOqUpJ4KY77PVeml0gjHFzZsHxgV0AOw=;
        b=FICOO9/oRFJTpdQxrOzuq7x1Hn57tNI/AC/TI+E7sWosDTC/AmCRcijyAWM/QgJrEN
         n2vVh4Ku87DPlet0V/lPcLCxwraMZlu6TzP4nQ0ie7bg7rxN9lW3FLFNgv1rJF7XbgaC
         weCCqrQ4U4/3Vrd4Eum1SJqK5NctVEFxzg92wSimX/+kFRsdnSMhtDXOBFdk3KtsB5m4
         wspHYH5GCyu62NcupDBUl6hom0nOM33z1lOlb3zSnyuAvUvg74uxI2sodpBwdPt+8ltu
         nZReH4RShLHOXSoLjaqD7pnh+HiiyvZ43HrbAava16sea3rVZzS1rtIvM+Fk8ExTTLVV
         q12A==
X-Gm-Message-State: AFqh2kqRugadwA+T5VL2TJ4Vn8NxArU1MSazS/mKPMmfwXoPzBRtmTcZ
        k1aedEN+3aMsCFb8NoBjplx7AXXJjnWMoT9OocV7Xo2F+h96
X-Google-Smtp-Source: AMrXdXvVvhoHVE3I5wZ5bk8vuHXbnqPkZRWPGd+DQI0jEuAuia7zdBysgwK4Q/e0aLDS5CAtqfWlHrgRsDXT9ZqkBcqkh1oi5xO/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c71:b0:30d:87b7:cfb2 with SMTP id
 f17-20020a056e020c7100b0030d87b7cfb2mr595870ilj.228.1673021741666; Fri, 06
 Jan 2023 08:15:41 -0800 (PST)
Date:   Fri, 06 Jan 2023 08:15:41 -0800
In-Reply-To: <000000000000fd3bbe05efb0d1fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d209d05f19abaed@google.com>
Subject: Re: [syzbot] [vfs?] [ntfs3?] [tmpfs?] WARNING in walk_component
From:   syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1f5abbd77e2c Merge tag 'thermal-6.2-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113cc806480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=eba014ac93ef29f83dc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f5d83a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1727f4b4480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c5b2e8c2c94/disk-1f5abbd7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8956b2eee8db/vmlinux-1f5abbd7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3464b3b12f5/bzImage-1f5abbd7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6acfd5ce1186/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem)): count = 0x0, magic = 0xffff8880708871d0, owner = 0x0, curr 0xffff8880279e1d40, list empty
WARNING: CPU: 1 PID: 5194 at kernel/locking/rwsem.c:1336 __up_read+0x5c0/0x720 kernel/locking/rwsem.c:1336
Modules linked in:
CPU: 1 PID: 5194 Comm: syz-executor234 Not tainted 6.2.0-rc2-syzkaller-00203-g1f5abbd77e2c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_read+0x5c0/0x720 kernel/locking/rwsem.c:1336
Code: 03 80 3c 02 00 0f 85 35 01 00 00 49 8b 17 4d 89 f1 4c 89 e9 48 c7 c6 80 44 4c 8a ff 34 24 48 c7 c7 c0 41 4c 8a e8 70 b8 5c 08 <0f> 0b 5e e9 38 fb ff ff 48 89 df e8 e0 8a 6c 00 e9 b2 fa ff ff 48
RSP: 0018:ffffc90003f4fb58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8e730c28 RCX: 0000000000000000
RDX: ffff8880279e1d40 RSI: ffffffff8166721c RDI: fffff520007e9f5d
RBP: ffff8880708871d8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff920007e9f6f
R13: ffff8880708871d0 R14: ffff8880279e1d40 R15: ffff8880708871d0
FS:  00007f022ae3c700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f02330f3120 CR3: 000000001d72a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 inode_unlock_shared include/linux/fs.h:771 [inline]
 lookup_slow fs/namei.c:1703 [inline]
 walk_component+0x34a/0x5a0 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x1ba/0x840 fs/namei.c:2474
 filename_lookup+0x1d2/0x590 fs/namei.c:2503
 user_path_at_empty+0x46/0x60 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 __do_sys_chdir fs/open.c:514 [inline]
 __se_sys_chdir fs/open.c:508 [inline]
 __x64_sys_chdir+0xbb/0x240 fs/open.c:508
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f02330b1a19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f022ae3c2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000050
RAX: ffffffffffffffda RBX: 0000000000000029 RCX: 00007f02330b1a19
RDX: 00007f02330b1a19 RSI: ffffffffffffffb8 RDI: 0000000020000380
RBP: 00007f0233155798 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0233155790
R13: 00007f023315579c R14: 6573726168636f69 R15: 0030656c69662f2e
 </TASK>

