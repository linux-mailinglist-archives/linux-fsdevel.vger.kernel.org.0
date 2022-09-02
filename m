Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5605C5AB328
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiIBOO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiIBOOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:14:03 -0400
X-Greylist: delayed 1766 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Sep 2022 06:41:46 PDT
Received: from lounge.grep.be (lounge.grep.be [IPv6:2a01:4f8:200:91e8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD238448
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=uter.be;
        s=2021.lounge; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0AIbFmmgCA7XyuNbwhdc2uTpgKLCfwyPxwWgqBffiEw=; b=K7M1ZSGeuXjeM3+yxlmquhNIwW
        YqB1u6wXBw7NdXhENERYehUvzBDVMdiXoUPznzTp9IWTCl8OMnSIolKpLZltemeGY0pH+a+kGk9h7
        jFQdsoMmVyIfjpBsiPiMpx1K64Xgsl+j7/UMfrpmeU+q3dsY+BahzM3jYYG0qfZFtZD28lq378/KD
        Mw1oOmENv3Q9xRiAzIwgt4jO4IkaeiJXxREZ7B7rWyFlmLOvhHkfOgbIsrH/1ZmtjPjqCeX5CkYf9
        TLtg6OGM5DYDu+Ps1Cn9o9zE6Uy9ZcAVShzUhs2RjBs6A5xnhabvgsOi2lviA7vYIAVKTEFI1JxLQ
        Vd9msnMQ==;
Received: from [196.251.239.242] (helo=pc220518)
        by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <w@uter.be>)
        id 1oU67V-00A9AD-Ud; Fri, 02 Sep 2022 14:50:01 +0200
Received: from wouter by pc220518 with local (Exim 4.96)
        (envelope-from <w@uter.be>)
        id 1oU67Q-000AXQ-1n;
        Fri, 02 Sep 2022 14:49:56 +0200
Date:   Fri, 2 Sep 2022 14:49:56 +0200
From:   Wouter Verhelst <w@uter.be>
To:     nbd@other.debian.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Subject: Re: Why do NBD requests prevent hibernation, and FUSE requests do
 not?
Message-ID: <YxH79CbXDUEa+r/2@pc220518.home.grep.be>
References: <87k06qb5to.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k06qb5to.fsf@vostro.rath.org>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nikolaus,

I do not know how FUSE works, so can't comment on that.

NBD, however, is a message-passing protocol: the client sends a message
to request something over a network socket, which causes the server to
do some processing, and then to send a message back. As far as the
kernel is concerned (at least outside nbd.ko), there is no connection
between the request message and the reply message.

As such, when the kernel suspends the nbd server, it has no way of
knowing that the in-kernel client is still waiting on a reply for a
message that was sent earlier.

I'm guessing that for FUSE, there is such a link?

On Tue, Aug 30, 2022 at 07:31:31AM +0100, Nikolaus Rath wrote:
> Hello,
> 
> I am comparing the behavior of FUSE and NBD when attempting to hibernate
> the system.
> 
> FUSE seems to be mostly compatible, I am able to suspend the system even
> when there is ongoing I/O on the fuse filesystem.
> 
> With NBD, on the other hand, most I/O seems to prevent hibernation the
> system. Example hibernation error:
> 
>   kernel: Freezing user space processes ... 
>   kernel: Freezing of tasks failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
>   kernel: task:rsync           state:D stack:    0 pid:348105 ppid:348104 flags:0x00004004
>   kernel: Call Trace:
>   kernel:  <TASK>
>   kernel:  __schedule+0x308/0x9e0
>   kernel:  schedule+0x4e/0xb0
>   kernel:  schedule_timeout+0x88/0x150
>   kernel:  ? __bpf_trace_tick_stop+0x10/0x10
>   kernel:  io_schedule_timeout+0x4c/0x80
>   kernel:  __cv_timedwait_common+0x129/0x160 [spl]
>   kernel:  ? dequeue_task_stop+0x70/0x70
>   kernel:  __cv_timedwait_io+0x15/0x20 [spl]
>   kernel:  zio_wait+0x129/0x2b0 [zfs]
>   kernel:  dmu_buf_hold+0x5b/0x90 [zfs]
>   kernel:  zap_lockdir+0x4e/0xb0 [zfs]
>   kernel:  zap_cursor_retrieve+0x1ae/0x320 [zfs]
>   kernel:  ? dbuf_prefetch+0xf/0x20 [zfs]
>   kernel:  ? dmu_prefetch+0xc8/0x200 [zfs]
>   kernel:  zfs_readdir+0x12a/0x440 [zfs]
>   kernel:  ? preempt_count_add+0x68/0xa0
>   kernel:  ? preempt_count_add+0x68/0xa0
>   kernel:  ? aa_file_perm+0x120/0x4c0
>   kernel:  ? rrw_exit+0x65/0x150 [zfs]
>   kernel:  ? _copy_to_user+0x21/0x30
>   kernel:  ? cp_new_stat+0x150/0x180
>   kernel:  zpl_iterate+0x4c/0x70 [zfs]
>   kernel:  iterate_dir+0x171/0x1c0
>   kernel:  __x64_sys_getdents64+0x78/0x110
>   kernel:  ? __ia32_sys_getdents64+0x110/0x110
>   kernel:  do_syscall_64+0x38/0xc0
>   kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   kernel: RIP: 0033:0x7f03c897a9c7
>   kernel: RSP: 002b:00007ffd41e3c518 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
>   kernel: RAX: ffffffffffffffda RBX: 0000561eff64dd40 RCX: 00007f03c897a9c7
>   kernel: RDX: 0000000000008000 RSI: 0000561eff64dd70 RDI: 0000000000000000
>   kernel: RBP: 0000561eff64dd70 R08: 0000000000000030 R09: 00007f03c8a72be0
>   kernel: R10: 0000000000020000 R11: 0000000000000293 R12: ffffffffffffff80
>   kernel: R13: 0000561eff64dd44 R14: 0000000000000000 R15: 0000000000000001
>   kernel:  </TASK>
> 
> (this is with ZFS on top of the NBD device).
> 
> 
> As far as I can tell, the problem is that while an NBD request is
> pending, the atsk that waits for the result (in this case *rsync*) is
> refusing to freeze. This happens even when setting a 5 minute timeout
> for freezing (which is more than enough time for the NBD request to
> complete), so I suspect that the NBD server task (in this case nbdkit)
> has already been frozen and is thus unable to make progress.
> 
> However, I do not understand why the same is not happening for FUSE
> (with FUSE requests being stuck because the FUSE daemon is already
> frozen). Was I just very lucky in my tests? Or are tasks waiting for
> FUSE request in a different kind of state? Or is NBD a red-herring here,
> and the real trouble is with ZFS?
> 
> It would be great if someone  could shed some light on what's going on.
> 
> 
> Best,
> -Nikolaus
> 
> -- 
> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
> 
>              »Time flies like an arrow, fruit flies like a Banana.«
> 
> 

-- 
     w@uter.{be,co.za}
wouter@{grep.be,fosdem.org,debian.org}

I will have a Tin-Actinium-Potassium mixture, thanks.
