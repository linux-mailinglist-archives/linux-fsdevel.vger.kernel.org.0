Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE56582A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiG0P5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiG0P5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:57:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D6549B7F;
        Wed, 27 Jul 2022 08:57:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19D0D386D1;
        Wed, 27 Jul 2022 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658937436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxKUWqT5iUKpLFp0v3fyVcuCKX1YUSv6OOnP7DffHnU=;
        b=vRq6rRctcntgJX+78LKvNMxGp8+q4X7/M2xMs8IOCC49Q6afgcWeMI3LuNOUiGwfUEmp86
        QgkeNwBBGmx6KTjluXYGsnFodZymh24y4MLwJ5/8cn2IQTUhN8ECNu3bbwlEYy5OSKfQ2l
        CWpiMPLckttapxU/D1R0wVFG1Ukbmm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658937436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxKUWqT5iUKpLFp0v3fyVcuCKX1YUSv6OOnP7DffHnU=;
        b=iRLLh8GC/SbrHyQlUuwcEOk6/sbFC0ZDxpC3rHTW4sSkPEFX47M0CoZ9Ugo9Ax0JhjFlUy
        iqdr8bxYs6/3gSDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4F862C141;
        Wed, 27 Jul 2022 15:57:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17704A0662; Wed, 27 Jul 2022 17:57:10 +0200 (CEST)
Date:   Wed, 27 Jul 2022 17:57:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: try to flush inline data before calling BUG in
 writepages
Message-ID: <20220727155710.7ihvytqzmebcwquy@quack3>
References: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
 <20220726224428.407887-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726224428.407887-1-tadeusz.struk@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-07-22 15:44:28, Tadeusz Struk wrote:
> Fix a syzbot issue, which triggers a BUG in ext4_writepags.
> The syzbot creates and monuts an ext4 fs image on /dev/loop0.
> The image is corrupted, which is probably the source of the
> problems, but the mount operation finishes successfully.
> Then the repro program creates a file on the mounted fs, and
> eventually it writes a buff of 22 zero bytes to it as below:
> 
> memfd_create("syzkaller", 0) = 3
> ftruncate(3, 2097152)       = 0
> pwrite64(3, " \0\0\0\0\2\0\0\31\0\0\0\220\1\0\0\17\0\0\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 102, 1024) = 102
> pwrite64(3, "\0\0\0\0\0\0\0\0\0\0\0\0\202\343g$\306\363L\252\204n\322\345'p3x\1\0@", 31, 1248) = 31
> pwrite64(3, "\2\0\0\0\3\0\0\0\4\0\0\0\31\0\17\0\3\0\4\0\0\0\0\0\0\0\0\0\17\0.i", 32, 4096) = 32
> pwrite64(3, "\177\0\0\0\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"..., 4098, 8192) = 4098
> pwrite64(3, "\355A\0\0\20\0\0\0\332\364e_\333\364e_\333\364e_\0\0\0\0\0\0\4\0\200\0\0\0"..., 61, 17408) = 61
> openat(AT_FDCWD, "/dev/loop0", O_RDWR) = 4
> ioctl(4, LOOP_SET_FD, 3)    = 0
> mkdir("./file0", 0777)      = -1 EEXIST (File exists)
> mount("/dev/loop0", "./file0", "ext4", 0, ",errors=continue") = 0
> openat(AT_FDCWD, "./file0", O_RDONLY|O_DIRECTORY) = 5
> ioctl(4, LOOP_CLR_FD)       = 0
> close(4)                    = 0
> close(3)                    = 0
> chdir("./file0")            = 0
> creat("./bus", 000)         = 3
> open("./bus", O_RDWR|O_CREAT|O_NONBLOCK|O_SYNC|O_DIRECT|O_LARGEFILE|O_NOATIME, 000) = 4
> openat(AT_FDCWD, "/proc/self/exe", O_RDONLY) = 6
> sendfile(4, 6, NULL, 2147483663) = 1638400
> open("./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME, 000) = 7
> write(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 22) <unfinished ...>
> 
> This triggers a BUG in ext4_writepages(), where it checks if
> the inode has inline data, just before deleting it:

Thanks for your persistence looking into this! :) I'll note that you
actually miss one important call in the trace: ftruncate(3, 1)

With that I can indeed reproduce the crash (after some more tweaking
because for me /proc/self/exe does not have size which is multiple of 4k
and so sendfile() was failing for me initially).

> kernel BUG at fs/ext4/inode.c:2721!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 359 Comm: repro Not tainted 5.19.0-rc8-00001-g31ba1e3b8305-dirty #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> RIP: 0010:ext4_writepages+0x363d/0x3660
> RSP: 0018:ffffc90000ccf260 EFLAGS: 00010293
> RAX: ffffffff81e1abcd RBX: 0000008000000000 RCX: ffff88810842a180
> RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
> RBP: ffffc90000ccf650 R08: ffffffff81e17d58 R09: ffffed10222c680b
> R10: dfffe910222c680c R11: 1ffff110222c680a R12: ffff888111634128
> R13: ffffc90000ccf880 R14: 0000008410000000 R15: 0000000000000001
> FS:  00007f72635d2640(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000565243379180 CR3: 000000010aa74000 CR4: 0000000000150eb0
> Call Trace:
>  <TASK>
>  do_writepages+0x397/0x640
>  filemap_fdatawrite_wbc+0x151/0x1b0
>  file_write_and_wait_range+0x1c9/0x2b0
>  ext4_sync_file+0x19e/0xa00
>  vfs_fsync_range+0x17b/0x190
>  ext4_buffered_write_iter+0x488/0x530
>  ext4_file_write_iter+0x449/0x1b90
>  vfs_write+0xbcd/0xf40
>  ksys_write+0x198/0x2c0
>  __x64_sys_write+0x7b/0x90
>  do_syscall_64+0x3d/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
> 
> This can be prevented by forcing the inline data to be converted
> and/or flushed beforehand.
> This patch adds a call to ext4_convert_inline_data() just before
> the BUG, which fixes the issue.

This is just papering over the real problem, which is that direct IO that
allocated blocks to the file did not clear EXT4_STATE_MAY_INLINE_DATA. I'll
send a better fix.

								Honza

> 
> Link: https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
> Reported-by: syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..de2aa2e79052 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2717,6 +2717,10 @@ static int ext4_writepages(struct address_space *mapping,
>  			ret = PTR_ERR(handle);
>  			goto out_writepages;
>  		}
> +
> +		if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +			WARN_ON(ext4_convert_inline_data(inode));
> +
>  		BUG_ON(ext4_test_inode_state(inode,
>  				EXT4_STATE_MAY_INLINE_DATA));
>  		ext4_destroy_inline_data(handle, inode);
> -- 
> 2.37.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
