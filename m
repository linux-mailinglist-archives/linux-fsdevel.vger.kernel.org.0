Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE472AEC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFJUlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFJUli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:41:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B863A96;
        Sat, 10 Jun 2023 13:41:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso30644695e9.2;
        Sat, 10 Jun 2023 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429681; x=1689021681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYcznHcgZcUJ3O5V1OxrWcqLYBG0CpO8YVWYlCq5q0A=;
        b=HUIKYoL3yr6fod/28Dh1j32TCUlpNnIHT7wvP0COEt25yFlt54oB6WMSLydlfFeR9F
         8GVj1GKnjpdH867aurWnlQ8T7+je9EbXbP0z4L8t+X3LGdZ0EHbQOOucU61FwcQNgCWU
         5rSZBvSRcpPo21+GiTYQjavQ3jt0t8I+Dp5HQ14v6/7UhVR1uWiCCNRretFP9pml4Seq
         2HMLq5hZuYIHo7x0AesY8sa/MUHq018Sx+tytgp6AcvXnhiAG6PDr3TAIhWxcb7ikbd/
         P+lYtWW9YSp9ZrBL5C073eB9HHtdsv10EdvX4Laqcyy0jBI/H6MjPbV3qswUptKO3dF0
         AINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429681; x=1689021681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYcznHcgZcUJ3O5V1OxrWcqLYBG0CpO8YVWYlCq5q0A=;
        b=gdHyB4N89r+b5bJV9sNwd9FGG3pJg3Ml6iI8Z8+5LQX4xhMpgghAieUA+43TE/lg6S
         ZIOiuzjx21butbiQN5ZZqAUr5OEAFy1LROBiS5ZHBC7F386MIcafTMZd4sUAmgO8OxoF
         vEzlLI1FongVi3uzVN0ghuzQdvkMjWKxnKw5GCsNN4/dS5ubturCNeASL8UIlkzncH8S
         L7MjO78VkApOqMDQy2bM1IGii3lM03DAbgcdgPZUN0qvPd9kj9lzZlng/9x2bIvhg13s
         EEaYGbxxQNvBkG4ubO1W+ht7hjmTQxUH0q+eR7BLXT/NAGmvVfBVD3W0J0s8SZ/wS9R5
         QsPQ==
X-Gm-Message-State: AC+VfDyjrxoDVMNbVU3SWArcp8CCNT6VvFFnS5EM0KrH+0v85/osmfxA
        9IdphOQ1NZRHhRVJABpTyCE=
X-Google-Smtp-Source: ACHHUZ4gqAtOTgdt+7EtQhllxT46bfuZVPWwXVBhOMxXklo8Uy//cUS4CQIwZtV2btI+y98G/PfKYQ==
X-Received: by 2002:a5d:4441:0:b0:307:8651:258e with SMTP id x1-20020a5d4441000000b003078651258emr1994920wrr.21.1686429680956;
        Sat, 10 Jun 2023 13:41:20 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b0030497b3224bsm7877081wry.64.2023.06.10.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:41:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Cc:     syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid context in
 ext4_update_super
Date:   Sat, 10 Jun 2023 22:41:18 +0200
Message-ID: <7535327.EvYhyI6sBW@suse>
In-Reply-To: <00000000000070575805fdc6cdb2@google.com>
References: <00000000000070575805fdc6cdb2@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On sabato 10 giugno 2023 15:52:55 CEST syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
> git tree:       upstream
>
> [...]
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Unfortunately :-(

> Downloadable assets:
>
> [...]
> 
> EXT4-fs error (device loop4): ext4_get_group_info:331: comm syz-executor.4:
> invalid group 4294819419 BUG: sleeping function called from invalid context
> at include/linux/buffer_head.h:404 in_atomic(): 1, irqs_disabled(): 0,
> non_block: 0, pid: 21305, name: syz-executor.4 preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 5 locks held by syz-executor.4/21305:
>  #0: ffff8880292c8460 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x5fb/
0xff0
> fs/read_write.c:1253 #1: ffff8880391da200
> (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock
> include/linux/fs.h:775 [inline] #1: ffff8880391da200
> (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at:
> ext4_buffered_write_iter+0xaf/0x3a0 fs/ext4/file.c:283 #2: ffff8880391d9ec8
> (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155
> [inline] #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at:
> ext4_convert_inline_data_to_extent fs/ext4/inline.c:584 [inline] #2:
> ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at:
> ext4_try_to_write_inline_data+0x51d/0x1360 fs/ext4/inline.c:740 #3:
> ffff8880391da088 (&ei->i_data_sem){++++}-{3:3}, at:
> ext4_map_blocks+0x980/0x1cf0 fs/ext4/inode.c:616 #4: ffff88803944f018
> (&bgl->locks[i].lock){+.+.}-{2:2}, at: spin_trylock
> include/linux/spinlock.h:360 [inline] #4: ffff88803944f018
> (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_lock_group fs/ext4/ext4.h:3407
> [inline] #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at:
> ext4_mb_try_best_found+0x1ca/0x5a0 fs/ext4/mballoc.c:2166 Preemption 
disabled
> at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 21305 Comm: syz-executor.4 Not tainted
> 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0 Hardware name: Google Google
> Compute Engine/Google Compute Engine, BIOS Google 05/25/2023 Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  __might_resched+0x5cf/0x780 kernel/sched/core.c:10153
>  lock_buffer include/linux/buffer_head.h:404 [inline]
>  ext4_update_super+0x93/0x1230 fs/ext4/super.c:6039
>  ext4_commit_super+0xd0/0x4c0 fs/ext4/super.c:6117
>  ext4_handle_error+0x5ee/0x8b0 fs/ext4/super.c:676

Well, I'm a new to filesystems. However, I'd like to test a change in 
ext4_handle_error().

Currently I see that errors are handled according to the next snippet of code 
from the above-mentioned function (please note that we are in atomic context):

if (continue_fs)
	if (continue_fs && journal)
		schedule_work(&EXT4_SB(sb)->s_error_work);
	else
		ext4_commit_super(sb);

If evaluates false, we directly call ext4_commit_super(), forgetting that, 
AFAICS we are in atomic context.

Obviously, we know that ext4_update_super() calls lock_buffer(), which 
might_sleep().

As I said I have only little experience with filesystems, so my question is: 
despite the overhead, can we delete the check and do the following?

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 05fcecc36244..574b096de059 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -662,19 +662,8 @@ static void ext4_handle_error(struct super_block *sb, 
bool force_ro, int error,
                        jbd2_journal_abort(journal, -EIO);
        }
 
-       if (!bdev_read_only(sb->s_bdev)) {
-               save_error_info(sb, error, ino, block, func, line);
-               /*
-                * In case the fs should keep running, we need to writeout
-                * superblock through the journal. Due to lock ordering
-                * constraints, it may not be safe to do it right here so we
-                * defer superblock flushing to a workqueue.
-                */
-               if (continue_fs && journal)
-                       schedule_work(&EXT4_SB(sb)->s_error_work);
-               else
-                       ext4_commit_super(sb);
-       }
+       if (!bdev_read_only(sb->s_bdev))
+               schedule_work(&EXT4_SB(sb)->s_error_work);
 
        /*
         * We force ERRORS_RO behavior when system is rebooting. Otherwise we

Am I missing something I'm not able to see here?
If not, I'll try this diff if and when Syzkaller provides a reproducer.

Thanks,

Fabio

>  __ext4_error+0x277/0x3b0 fs/ext4/super.c:776
>  ext4_get_group_info+0x382/0x3e0 fs/ext4/balloc.c:331
>  ext4_mb_new_inode_pa+0x89c/0x1300 fs/ext4/mballoc.c:4915
>  ext4_mb_try_best_found+0x3a1/0x5a0 fs/ext4/mballoc.c:2171
>  ext4_mb_regular_allocator+0x3511/0x3c20 fs/ext4/mballoc.c:2784
>  ext4_mb_new_blocks+0xe5f/0x44a0 fs/ext4/mballoc.c:5843
>  ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
>  ext4_ind_map_blocks+0x10d7/0x29e0 fs/ext4/indirect.c:635
>  ext4_map_blocks+0x9e7/0x1cf0 fs/ext4/inode.c:625
>  _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:779
>  __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
>  ext4_try_to_write_inline_data+0x7ed/0x1360 fs/ext4/inline.c:740
>  ext4_write_begin+0x290/0x10b0 fs/ext4/inode.c:1147
>  ext4_da_write_begin+0x300/0xa40 fs/ext4/inode.c:2893
>  generic_perform_write+0x300/0x5e0 mm/filemap.c:3923
>  ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:289
>  ext4_file_write_iter+0x1d6/0x1930
>  do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
>  iter_file_splice_write+0x843/0xfe0 fs/splice.c:795
>  do_splice_from fs/splice.c:873 [inline]
>  direct_splice_actor+0xe7/0x1c0 fs/splice.c:1039
>  splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:994
>  do_splice_direct+0x283/0x3d0 fs/splice.c:1082
>  do_sendfile+0x620/0xff0 fs/read_write.c:1254
>  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0ff0c8c169
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 
48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
> 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 RSP: 002b:00007f0ff1944168
> EFLAGS: 00000246 ORIG_RAX: 0000000000000028 RAX: ffffffffffffffda RBX:
> 00007f0ff0dabf80 RCX: 00007f0ff0c8c169
> RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
> RBP: 00007f0ff0ce7ca1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe35f5084f R14: 00007f0ff1944300 R15: 0000000000022000
>  </TASK>
> BUG: scheduling while atomic: syz-executor.4/21305/0x00000002
> 5 locks held by syz-executor.4/21305:
>  #0: ffff8880292c8460 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x5fb/
0xff0
> fs/read_write.c:1253 #1: ffff8880391da200
> (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock
> include/linux/fs.h:775 [inline] #1: ffff8880391da200
> (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at:
> ext4_buffered_write_iter+0xaf/0x3a0 fs/ext4/file.c:283 #2: ffff8880391d9ec8
> (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155
> [inline] #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at:
> ext4_convert_inline_data_to_extent fs/ext4/inline.c:584 [inline] #2:
> ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at:
> ext4_try_to_write_inline_data+0x51d/0x1360 fs/ext4/inline.c:740 #3:
> ffff8880391da088 (&ei->i_data_sem){++++}-{3:3}, at:
> ext4_map_blocks+0x980/0x1cf0 fs/ext4/inode.c:616 #4: ffff88803944f018
> (&bgl->locks[i].lock){+.+.}-{2:2}, at: spin_trylock
> include/linux/spinlock.h:360 [inline] #4: ffff88803944f018
> (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_lock_group fs/ext4/ext4.h:3407
> [inline] #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at:
> ext4_mb_try_best_found+0x1ca/0x5a0 fs/ext4/mballoc.c:2166 Modules linked in:
> Preemption disabled at:
> [<0000000000000000>] 0x0
> 
> 
> ---

[...]


