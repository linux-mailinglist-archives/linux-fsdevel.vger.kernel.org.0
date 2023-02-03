Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A0689F26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjBCQZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCQZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D4A6B83;
        Fri,  3 Feb 2023 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6lRIbhPzQuIL2SGlYUOzucIta/07gS2qJTu6Ydnp+I4=; b=cOJChj2tCVNGyMfW7z+nRkoCDA
        zhQD9XMTXWTBG5P4yfImxcaYHKWfZrcUIQPdIcaF3FdTHauyn+LC11B3smx07Hzn5lU9d7IHMkqhR
        L/5kAGhzx33jb2ZJKmTp0QMDne84Ox0FQURrukie/3tsoG6SudojkvrePz2YuSWEDqkVleu3HDmz1
        8MtVYySM0ufDW5vx07B9Cgts6bHkQpnzGXp5FV1Y8viy1E8KHo9xgfn9KA7H/mn+n9Rx79Owif1g5
        /gdDU9vS2xasJ8BTw+R3yDiPY4mA6IOJISBxDSdlVzsb1gxfjUmucn8WJC9JeJoBT1ntsL/WHnFBF
        5/IMcMWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNysW-002uPE-Ge; Fri, 03 Feb 2023 16:25:32 +0000
Date:   Fri, 3 Feb 2023 08:25:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+401145a9a237779feb26@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, clm@fb.com,
        djwong@kernel.org, dsterba@suse.com, hch@infradead.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, linux-ext4@vger.kernel.org
Subject: Re: [syzbot] [ntfs3?] [btrfs?] BUG: unable to handle kernel paging
 request in clear_user_rep_good
Message-ID: <Y901fMtPYrWXYINI@infradead.org>
References: <000000000000de34bd05f3c6fe19@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000de34bd05f3c6fe19@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Where are the ntfs3 and btrfs tags coming from?  This seems to clearly
be about ext4 in the call stack.

On Thu, Feb 02, 2023 at 11:54:48PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ab072681eabe Merge tag 'irq_urgent_for_v6.2_rc6' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15933749480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23330449ad10b66f
> dashboard link: https://syzkaller.appspot.com/bug?extid=401145a9a237779feb26
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b3ba9e480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a43bbc272cf3/disk-ab072681.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fec05f5bcfa7/vmlinux-ab072681.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/00b9b0dd9801/bzImage-ab072681.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f7ef8856a9ce/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/79f8035a08dd/mount_4.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+401145a9a237779feb26@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: 0000000020081000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 1c9cc067 P4D 1c9cc067 PUD 280e9067 PMD 2a76b067 PTE 0
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5441 Comm: syz-executor.1 Not tainted 6.2.0-rc5-syzkaller-00221-gab072681eabe #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> RIP: 0010:clear_user_rep_good+0x1c/0x30 arch/x86/lib/clear_page_64.S:147
> Code: 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 83 f9 40 72 a6 89 ca 48 c1 e9 03 74 03 f3 48 ab 83 e2 07 74 04 89 d1 <f3> aa 31 c0 c3 48 c1 e1 03 83 e2 07 48 01 d1 eb f1 0f 1f 00 f3 0f
> RSP: 0018:ffffc900056f76d8 EFLAGS: 00050202
> RAX: 0000000000000000 RBX: 0000000000081002 RCX: 0000000000000002
> RDX: 0000000000000002 RSI: ffffffff84098c49 RDI: 0000000020081000
> RBP: 0000000000081002 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000094001 R12: ffffc900056f7d70
> R13: 0000000020000000 R14: 000000007ffff000 R15: 0000000000000000
> FS:  00007fc1837f1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020081000 CR3: 000000002b26e000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __clear_user arch/x86/include/asm/uaccess_64.h:103 [inline]
>  clear_user arch/x86/include/asm/uaccess_64.h:124 [inline]
>  iov_iter_zero+0x709/0x1290 lib/iov_iter.c:800
>  iomap_dio_hole_iter fs/iomap/direct-io.c:389 [inline]
>  iomap_dio_iter fs/iomap/direct-io.c:440 [inline]
>  __iomap_dio_rw+0xe3d/0x1cd0 fs/iomap/direct-io.c:601
>  iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:689
>  ext4_dio_read_iter fs/ext4/file.c:94 [inline]
>  ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
>  call_read_iter include/linux/fs.h:2183 [inline]
>  do_iter_readv_writev+0x2e0/0x3b0 fs/read_write.c:733
>  do_iter_read+0x2f2/0x750 fs/read_write.c:796
>  vfs_readv+0xe5/0x150 fs/read_write.c:916
>  do_preadv+0x1b6/0x270 fs/read_write.c:1008
>  __do_sys_preadv2 fs/read_write.c:1070 [inline]
>  __se_sys_preadv2 fs/read_write.c:1061 [inline]
>  __x64_sys_preadv2+0xef/0x150 fs/read_write.c:1061
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fc182a8c0c9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc1837f1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000147
> RAX: ffffffffffffffda RBX: 00007fc182babf80 RCX: 00007fc182a8c0c9
> RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007fc182ae7ae9 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000007fffe R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffefd64d1ef R14: 00007fc1837f1300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> CR2: 0000000020081000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:clear_user_rep_good+0x1c/0x30 arch/x86/lib/clear_page_64.S:147
> Code: 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 83 f9 40 72 a6 89 ca 48 c1 e9 03 74 03 f3 48 ab 83 e2 07 74 04 89 d1 <f3> aa 31 c0 c3 48 c1 e1 03 83 e2 07 48 01 d1 eb f1 0f 1f 00 f3 0f
> RSP: 0018:ffffc900056f76d8 EFLAGS: 00050202
> RAX: 0000000000000000 RBX: 0000000000081002 RCX: 0000000000000002
> RDX: 0000000000000002 RSI: ffffffff84098c49 RDI: 0000000020081000
> RBP: 0000000000081002 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000094001 R12: ffffc900056f7d70
> R13: 0000000020000000 R14: 000000007ffff000 R15: 0000000000000000
> FS:  00007fc1837f1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8294a2a000 CR3: 000000002b26e000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>    7:	00 00 00 00
>    b:	0f 1f 00             	nopl   (%rax)
>    e:	f3 0f 1e fa          	endbr64
>   12:	48 83 f9 40          	cmp    $0x40,%rcx
>   16:	72 a6                	jb     0xffffffbe
>   18:	89 ca                	mov    %ecx,%edx
>   1a:	48 c1 e9 03          	shr    $0x3,%rcx
>   1e:	74 03                	je     0x23
>   20:	f3 48 ab             	rep stos %rax,%es:(%rdi)
>   23:	83 e2 07             	and    $0x7,%edx
>   26:	74 04                	je     0x2c
>   28:	89 d1                	mov    %edx,%ecx
> * 2a:	f3 aa                	rep stos %al,%es:(%rdi) <-- trapping instruction
>   2c:	31 c0                	xor    %eax,%eax
>   2e:	c3                   	retq
>   2f:	48 c1 e1 03          	shl    $0x3,%rcx
>   33:	83 e2 07             	and    $0x7,%edx
>   36:	48 01 d1             	add    %rdx,%rcx
>   39:	eb f1                	jmp    0x2c
>   3b:	0f 1f 00             	nopl   (%rax)
>   3e:	f3                   	repz
>   3f:	0f                   	.byte 0xf
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
---end quoted text---
