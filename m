Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A06EA62F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDUIpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDUIpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:45:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED972B453;
        Fri, 21 Apr 2023 01:44:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 879171FDDD;
        Fri, 21 Apr 2023 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682066672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpfBfmqRRKyv8aJsshuOUoOBIKY9oBx+lkGtFjN8Ay0=;
        b=j866XPc071ijrQ3iucv97B1Px9WNR8xKur6aAfZkDoJt92c9qZ2EEG0e08Mk7l6q50IBo1
        Jbe8Ll+CgPZmcV6NAkrovPOQAiNXea0dnVUW426uRqFGBiG9baccOMvyQcS+B87SsGf2Ow
        eaVYNsbSuO8nQwiyMf0W3hmT9HLLEP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682066672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpfBfmqRRKyv8aJsshuOUoOBIKY9oBx+lkGtFjN8Ay0=;
        b=uB7DYNUNgVRAMfp3ph8fA4MdVrNC5vz2L8SkkTdSb8ZCTO1OiFG78kPdT9fz2Xdn9LUYoM
        vlGlDoqXL7+rSGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 751ED1390E;
        Fri, 21 Apr 2023 08:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oQCQHPBMQmRsOAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 08:44:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 97C7BA0729; Fri, 21 Apr 2023 10:44:31 +0200 (CEST)
Date:   Fri, 21 Apr 2023 10:44:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 get_max_inline_xattr_value_size
Message-ID: <20230421084431.ynek7epoy3mceecr@quack3>
References: <000000000000cdfab505f819529a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cdfab505f819529a@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 30-03-23 00:48:50, syzbot wrote:
> HEAD commit:    da8e7da11e4b Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=114fae51c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> dashboard link: https://syzkaller.appspot.com/bug?extid=1966db24521e5f6e23f7
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1597fd0ec80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14149471c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/62e9c5f4bead/disk-da8e7da1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c11aa933e2a7/vmlinux-da8e7da1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7a21bdd49c84/bzImage-da8e7da1.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/58216d4aadcf/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com
> 
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> EXT4-fs error (device loop0): ext4_xattr_ibody_get:669: inode #18: comm syz-executor366: corrupted in-inode xattr: bad magic number in in-inode xattr
> ==================================================================
> BUG: KASAN: slab-use-after-free in get_max_inline_xattr_value_size+0x369/0x510 fs/ext4/inline.c:62
> Read of size 4 at addr ffff88807c4ac084 by task syz-executor366/5076
> 
> CPU: 0 PID: 5076 Comm: syz-executor366 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:319 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:430
>  kasan_report+0x176/0x1b0 mm/kasan/report.c:536
>  get_max_inline_xattr_value_size+0x369/0x510 fs/ext4/inline.c:62
>  ext4_get_max_inline_size+0x141/0x200 fs/ext4/inline.c:113
>  ext4_prepare_inline_data+0x87/0x1d0 fs/ext4/inline.c:393
>  ext4_da_write_inline_data_begin+0x208/0xe40 fs/ext4/inline.c:931
>  ext4_da_write_begin+0x4da/0x960 fs/ext4/inode.c:3064
>  generic_perform_write+0x300/0x5e0 mm/filemap.c:3926
>  ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:289
>  ext4_file_write_iter+0x1d6/0x1930
>  call_write_iter include/linux/fs.h:1851 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x7b2/0xbb0 fs/read_write.c:584
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

The problem seems to be that get_max_inline_xattr_value_size() is iterating
xattr space like:

        for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
                if (!entry->e_value_inum && entry->e_value_size) {
                        size_t offs = le16_to_cpu(entry->e_value_offs);
                        if (offs < min_offs)
                                min_offs = offs;
                }
        }

without checking for validity of the structures and we can reach this path
without verifying xattrs are valid. Perhaps we should verify in-inode xattr
data as part for __ext4_iget()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
