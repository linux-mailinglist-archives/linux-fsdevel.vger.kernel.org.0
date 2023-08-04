Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A086D770208
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjHDNle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHDNla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC59139
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691156443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUPc7Rn4TDQivp2Oj2ImBO3WPO+Bbn7EVCGBmROvMxM=;
        b=Ej1Ui0GaYkiO5UBIhSaH00S77yKhcckSJTnzZpoTvQ6sUHA6KaWZRYqCBCWxeb44bLlGjn
        vQ3uF1EfGGrKyXQk5JPD0953vhwoRuuCy27NP6j7hKI1F6hSsULT3qGkQ5sVPtzdvnpmsN
        k7Wq9fz+q67OXAXUXPUqQ54oVq/zsh4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-sxRXfKy5PJOdSyImVfCy2w-1; Fri, 04 Aug 2023 09:40:41 -0400
X-MC-Unique: sxRXfKy5PJOdSyImVfCy2w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d0c38e986so19271966d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 06:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156441; x=1691761241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUPc7Rn4TDQivp2Oj2ImBO3WPO+Bbn7EVCGBmROvMxM=;
        b=j9iE/gEJOn/Q7vAmcuV89ds+7n0tzN+9B8MFSJndvonvu0aYiugVWhiujETDHtIX8w
         +ffnobX6DeIeCOsxYX+85Lt1oh1+GZF0wMY52Z5j/il9LiLANbxJJOJ39QirvmKhUE5P
         MQqN2DbVTpRhBw2wcXGdjkmF1hWWk0khQWdDnmul+luZHj2n7kAYpgJAEWt6cBNkBcUk
         j1gBchZ7P+Jec92FtuQIGCL5ek6XQpj8HjxVAIgTG252K0Skhl9oTc18mE5Xm1n9zVhI
         Z7yQhaWkWYNVqudRzlOkkAGW49h7PDcMPJS6u3UcpEte9uIMVLMvddNNxWr804cz/iFG
         7GSg==
X-Gm-Message-State: AOJu0YwrlCFuHwtmcv7+LFL9zTwu/nVu8AomLXyWf2y9SAWX8wob7mmA
        AbmToFwYXpNV2bm7dya5FI3jawI01FZuwQCmxCW38Cbkc8Oc8niFAFbBgDN840ay8Vm/l51fltV
        AAzQMFMFyUhLGt0Hi3NxgSavT6g==
X-Received: by 2002:a05:622a:342:b0:40f:d72b:9816 with SMTP id r2-20020a05622a034200b0040fd72b9816mr1092736qtw.39.1691156440687;
        Fri, 04 Aug 2023 06:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVvhdndmtY713dJbCV+tITc2CZr6YbmcRr0wEpYXfJXBdkCgd9WYUg+TlEnXy0HNcz8laLwA==
X-Received: by 2002:a05:622a:342:b0:40f:d72b:9816 with SMTP id r2-20020a05622a034200b0040fd72b9816mr1092718qtw.39.1691156440394;
        Fri, 04 Aug 2023 06:40:40 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id g22-20020ac870d6000000b004054b435f8csm642935qtp.65.2023.08.04.06.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:40:40 -0700 (PDT)
Date:   Fri, 4 Aug 2023 09:43:43 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, heng.su@intel.com
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
Message-ID: <ZM0Aj6sBk/5TPdLS@bfoster>
References: <0000000000007faf0005fe4f14b9@google.com>
 <000000000000a3f45805ffcbb21f@google.com>
 <ZMsE2q9VX2sQFh/g@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMsE2q9VX2sQFh/g@xpf.sh.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:37:30AM +0800, Pengfei Xu wrote:
> On 2023-07-05 at 23:33:43 -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    6843306689af Merge tag 'net-6.5-rc1' of git://git.kernel.o..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=114522aca80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102cb190a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c49d90a80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f6adc10dbd71/disk-68433066.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5c3fa1329201/vmlinux-68433066.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/84db3452bac5/bzImage-68433066.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> > WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> > Modules linked in:
> > CPU: 1 PID: 5382 Comm: syz-executor288 Not tainted 6.4.0-syzkaller-11989-g6843306689af #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> > RIP: 0010:ext4_dio_write_iter fs/ext4/file.c:611 [inline]
> > RIP: 0010:ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
> > Code: 84 03 00 00 48 8b 04 24 31 ff 8b 40 20 89 c3 89 44 24 10 83 e3 08 89 de e8 5d 5a 5b ff 85 db 0f 85 d5 fc ff ff e8 30 5e 5b ff <0f> 0b e9 c9 fc ff ff e8 24 5e 5b ff 48 8b 4c 24 40 4c 89 fa 4c 89
> > RSP: 0018:ffffc9000522fc30 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: ffff8880277a3b80 RSI: ffffffff82298140 RDI: 0000000000000005
> > RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a832a60
> > R13: 0000000000000000 R14: 0000000000000000 R15: fffffffffffffff5
> > FS:  00007f154db95700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f154db74718 CR3: 000000006bcc7000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  call_write_iter include/linux/fs.h:1871 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x981/0xda0 fs/read_write.c:584
> >  ksys_write+0x122/0x250 fs/read_write.c:637
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f154dc094f9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f154db952f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00007f154dc924f0 RCX: 00007f154dc094f9
> > RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000006
> > RBP: 00007f154dc5f628 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 652e79726f6d656d
> > R13: 656c6c616b7a7973 R14: 6465646165726874 R15: 00007f154dc924f8
> >  </TASK>
> > 
> 
> Above issue in dmesg is:
> "WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"
> 
> I found the similar behavior issue:
> "WARNING: CPU: 0 PID: 182134 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]"
> repro.report shows similar details.
> 
> Updated the bisect info for the above similar issue:
> Bisected and the problem commit was:
> "
> 310ee0902b8d9d0a13a5a13e94688a5863fa29c2: ext4: allow concurrent unaligned dio overwrites
> "
> After reverted the commit on top of v6.5-rc3, this issue was gone.
> 

Hi Pengfei,

Thanks for narrowing this down (and sorry for missing the earlier
report). Unfortunately I've not been able to reproduce this locally
using the generated reproducer. I tried both running the test program on
a local test vm as well as booting the generated disk image directly.

That said, I have received another report of this warning that happens
to be related to io_uring. The cause in that particular case is that
io_uring sets IOCB_HIPRI, which iomap dio turns into
REQ_POLLED|REQ_NOWAIT on the bio without necessarily having IOCB_NOWAIT
set on the request. This means we can expect -EAGAIN returns from the
storage layer without necessarily passing DIO_OVERWRITE_ONLY to iomap,
which in turn basically means that the warning added by this commit is
wrong.

I did submit the test patch at the link [1] referenced below to syzbot
to see if the OVERWRITE_ONLY flag is set and the results I got this
morning only showed the original !IOCB_NOWAIT warning. So while I still
do not know the source of the -EAGAIN in the syzbot test (and I would
like to), this shows that the overwrite flag is not involved and thus
the -EAGAIN is presumably unrelated to that logic.

So in summary I think the right fix is to just remove the overwrite flag
and warning from this ext4 codepath. It was always intended as an extra
precaution to support the warning, and the latter is clearly wrong. I'll
submit another test change in a separate mail just to see if syzbot
finds anything else and plan to send a proper patch to the list. In the
meantime, if you have any suggestions to help reproduce via the
generated program, I'm still interested in trying to grok where that
particular -EAGAIN comes from.. Thanks.

Brian

[1] https://syzkaller.appspot.com/x/patch.diff?x=109a7c96a80000

> All information: https://github.com/xupengfe/syzkaller_logs/tree/main/230730_134501_ext4_file_write_iter
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.c
> repro.prog(syscall reproduced steps): https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.prog
> repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/repro.report
> Bisect log: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/bisect_info.log
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/kconfig_origin
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230730_134501_ext4_file_write_iter/6eaae198076080886b9e7d57f4ae06fa782f90ef_dmesg.log
> 
> Best Regards,
> Thanks!
> 
> > 
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> 

