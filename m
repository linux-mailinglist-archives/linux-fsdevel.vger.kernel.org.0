Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0815E7828EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHUMXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjHUMXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:23:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE597BC;
        Mon, 21 Aug 2023 05:23:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 972DF22B9D;
        Mon, 21 Aug 2023 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692620629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FL+hOekgWlsfYhwkVqGAvkXV6wNwAXOp3N3s7yBnuOg=;
        b=cej71uktqCwuzPoFRggNs8qGosHX7eSWOr7NRKX458f/lYwUJSCE/LT9+qk2LmcT/c8rgM
        wjfeLzuZhNbdEPi8PZEXhrTRYEjJWpWlmrzV5mZr0xjri4xy2TyPcWw7eH1n3Rk8VWcjG9
        RW4ar+6dHKVEBELuc1FqcO9Ie4FHptM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692620629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FL+hOekgWlsfYhwkVqGAvkXV6wNwAXOp3N3s7yBnuOg=;
        b=Fy9y+RL7W3tYu0pNtp/wmeTJHs9lqQei6z4vSOGDdQyXyCLeSHiS5VraMvdA6SuSsSBLbt
        TBzx/5JAITS+cfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 826521330D;
        Mon, 21 Aug 2023 12:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8UpgH1VX42SqOgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 12:23:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DFAFAA0774; Mon, 21 Aug 2023 14:23:48 +0200 (CEST)
Date:   Mon, 21 Aug 2023 14:23:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in
 udf_process_sequence
Message-ID: <20230821122348.p3nrq4ezfc5vk5ff@quack3>
References: <0000000000000fdc630601cd9825@google.com>
 <000000000000ba9f2406035b8927@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ba9f2406035b8927@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 20-08-23 07:25:47, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9e6c269de404 Merge tag 'i2c-for-6.5-rc7' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=139aa5efa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ed6bba80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c8923a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d01305b8482/disk-9e6c269d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7317878934a/vmlinux-9e6c269d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a7333ff86494/bzImage-9e6c269d.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2ad8331a86f3/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/049e481cc897/mount_8.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com
> 
> UBSAN: array-index-out-of-bounds in fs/udf/super.c:1365:9
> index 4 is out of range for type '__le32[4]' (aka 'unsigned int[4]')

Frankly, the report doesn't make sense to me. The code looks like:

if (spm->numSparingTables > 4) {
	bail out
}

for (i = 0; i < spm->numSparingTables; i++) {
	loc = le32_to_cpu(spm->locSparingTable[i]);
...
}

and UBSAN complains when i == 4 which should not be possible. The only way
how I see this could be possible is when syzbot somehow manages to corrupt
the buffer 'spm' is stored in after we check it but so far I don't
see that in the reproducer and if that would really happen this would not
be anything to fix in UDF...

								Honza

> CPU: 0 PID: 6060 Comm: syz-executor319 Not tainted 6.5.0-rc6-syzkaller-00253-g9e6c269de404 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
>  udf_load_sparable_map fs/udf/super.c:1365 [inline]
>  udf_load_logicalvol fs/udf/super.c:1457 [inline]
>  udf_process_sequence+0x300d/0x4e70 fs/udf/super.c:1773
>  udf_load_sequence fs/udf/super.c:1820 [inline]
>  udf_check_anchor_block+0x2a6/0x550 fs/udf/super.c:1855
>  udf_scan_anchors fs/udf/super.c:1888 [inline]
>  udf_load_vrs+0x5ca/0x1100 fs/udf/super.c:1969
>  udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2147
>  mount_bdev+0x276/0x3b0 fs/super.c:1391
>  legacy_get_tree+0xef/0x190 fs/fs_context.c:611
>  vfs_get_tree+0x8c/0x270 fs/super.c:1519
>  do_new_mount+0x28f/0xae0 fs/namespace.c:3335
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f363cae1c8a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 07 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe6eac67a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f363cae1c8a
> RDX: 0000000020000100 RSI: 0000000020000340 RDI: 00007ffe6eac6800
> RBP: 00007ffe6eac6840 R08: 00007ffe6eac6840 R09: 0000000000000c35
> R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000340
> R13: 0000000020000100 R14: 0000000000000c3b R15: 0000000020020500
>  </TASK>
> ================================================================================
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
