Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AE5831F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiG0S1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiG0S0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DDFD5F9B5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658942734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xI0tNVEQ4QF856krL574dmH7GWXh+Ia0PGG2VcgVgaA=;
        b=SLdvHojSg70zObt5Rci6dlQvXF+RdF/lKhpUDrr4BkfOhgKeHTRkVAm3RYGFlLoQnoFeSQ
        ZX+V9qyIKU8QhBO+kxANMVG7i9vkGaopbzKfHGYVULt8rBSuZWwYxMKiael3hg0ir1FQM8
        f6NjzlW6HJv2mTEDduFMb5pkzJ2Z0i8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-KGze-vjcM3CPjB45oqV-HA-1; Wed, 27 Jul 2022 13:25:21 -0400
X-MC-Unique: KGze-vjcM3CPjB45oqV-HA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CE085A586;
        Wed, 27 Jul 2022 17:25:20 +0000 (UTC)
Received: from fedora (unknown [10.40.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE1840315E;
        Wed, 27 Jul 2022 17:25:19 +0000 (UTC)
Date:   Wed, 27 Jul 2022 19:25:17 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: try to flush inline data before calling BUG in
 writepages
Message-ID: <20220727172517.bv2bflydy2urqttv@fedora>
References: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
 <20220726224428.407887-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726224428.407887-1-tadeusz.struk@linaro.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:44:28PM -0700, Tadeusz Struk wrote:
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
> 
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

Hi Tadeusz,

I don't think this is the right fix. We're in ext4_writepages, so at
this point I don't think an inode should have any actual inline data in
it. If it does it's a bug and the question is how did this get here?

The inode is likely corrupted and it should have been noticed earliler
and it should never get here.

-Lukas

>  		BUG_ON(ext4_test_inode_state(inode,
>  				EXT4_STATE_MAY_INLINE_DATA));
>  		ext4_destroy_inline_data(handle, inode);
> -- 
> 2.37.1
> 

