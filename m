Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF505F49EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJDT45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDT44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:56:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239969F57;
        Tue,  4 Oct 2022 12:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9472FCE1130;
        Tue,  4 Oct 2022 19:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4A3C433D6;
        Tue,  4 Oct 2022 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664913411;
        bh=GfL4r5h9LYSL1i5p8SAT7q2qLfvRM5YkSsR0KjXVu+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBUNsZ9hVYedW7xKP9DiO2+4sPO6Q61rlPFC/mcSTbnb0ioBzyG6DS0lCI0PWqQrE
         7XbHJYYH43giSEv0RtYgqqFxQSdieZVXiZc+GVveL8Fx1Us3QxODQw74yRqsMBn1bE
         umvSorfHBTcucEbFqGmtNWcksXrTAU90HrDKJNWe9qAuvt2CN6vMEdpdSB852MsKJF
         5jgkyN/8JQZSleBVu9NueFpwyHbuLPp6jo8OD/gJv39dL6l7ex6ZXotAg+hhszr3YM
         IF17xttGdStUMZg/DdG99YyYhF+vDpP90ZQh4j3OqRanTMou/PKtubN9qIif8CVLau
         YPYsLJJtGGGiQ==
Date:   Tue, 4 Oct 2022 12:56:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 4/9] landlock: Support file truncation
Message-ID: <YzyQASSaeVqRlTsO@dev-arch.thelio-3990X>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-5-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221001154908.49665-5-gnoack3000@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Günther,

On Sat, Oct 01, 2022 at 05:49:03PM +0200, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> 
> This flag hooks into the path_truncate LSM hook and covers file
> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> well as creat().
> 
> This change also increments the Landlock ABI version, updates
> corresponding selftests, and updates code documentation to document
> the flag.
> 
> The following operations are restricted:
> 
> open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
> implicitly truncated as part of the open() (e.g. using O_TRUNC).
> 
> Notable special cases:
> * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
> * open() with O_TRUNC does *not* need the TRUNCATE right when it
>   creates a new file.
> 
> truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
> right.
> 
> ftruncate() (on a file): requires that the file had the TRUNCATE right
> when it was previously opened.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>

I just bisected a crash in QEMU with Debian's arm64 configuration to
this change in -next as commit b40deebe7679 ("landlock: Support file
truncation"), which I was able to reproduce like so:

$ mkdir -p build/deb

$ cd build/deb

$ curl -LSsO http://ftp.us.debian.org/debian/pool/main/l/linux-signed-arm64/linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb

$ ar x linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb

$ tar xJf data.tar.xz

$ cp boot/config-5.19.0-2-arm64 ../.config

$ cd ../..

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build olddefconfig Image.gz

$ qemu-system-aarch64 \
-machine virt,gic-version=max,virtualization=true \
-cpu max,pauth-impdef=true \
-kernel build/arch/arm64/boot/Image.gz \
-append "console=ttyAMA0 earlycon" \
-display none \
-initrd .../rootfs.cpio \
-m 512m \
-nodefaults \
-no-reboot \
-serial mon:stdio
...
[    0.000000] Linux version 6.0.0-rc7+ (nathan@dev-arch.thelio-3990X) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Tue Oct 4 12:48:50 MST 2022
...
[    0.518570] Unable to handle kernel paging request at virtual address ffff00000851ff8a
[    0.518785] Mem abort info:
[    0.518867]   ESR = 0x0000000097c0c061
[    0.519001]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.519155]   SET = 0, FnV = 0
[    0.519267]   EA = 0, S1PTW = 0
[    0.519386]   FSC = 0x21: alignment fault
[    0.519524] Data abort info:
[    0.519615]   Access size = 8 byte(s)
[    0.519722]   SSE = 0, SRT = 0
[    0.519817]   SF = 1, AR = 1
[    0.519920]   CM = 0, WnR = 1
[    0.520040] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041711000
[    0.520225] [ffff00000851ff8a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=006800004851ff07
[    0.521121] Internal error: Oops: 97c0c061 [#1] SMP
[    0.521364] Modules linked in:
[    0.521592] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-rc7+ #1
[    0.521863] Hardware name: linux,dummy-virt (DT)
[    0.522325] Workqueue: events_unbound async_run_entry_fn
[    0.522973] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.523193] pc : apparmor_file_alloc_security+0x98/0x1e0
[    0.523431] lr : apparmor_file_alloc_security+0x48/0x1e0
[    0.523594] sp : ffff800008093960
[    0.523708] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002602600
[    0.523978] x26: ffffd79796ecf8c0 x25: ffff00000241e705 x24: ffffd79797d98068
[    0.524199] x23: ffff00000851ff82 x22: ffff00000851ff80 x21: 0000000000000002
[    0.524431] x20: ffffd79796ff5000 x19: ffff00000241ceb0 x18: ffffffffffffffff
[    0.524647] x17: 000000000000003f x16: ffffd79797678008 x15: 0000000000000000
[    0.524850] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000006
[    0.525087] x11: ffff00001feef940 x10: ffffd7979768f8a0 x9 : ffffd79796c1e51c
[    0.525325] x8 : ffff00000851ffa0 x7 : 0000000000000000 x6 : 0000000000001e0b
[    0.525531] x5 : ffff00000851ff80 x4 : ffff800008093990 x3 : ffff000002419700
[    0.525745] x2 : 0000000000000001 x1 : ffff00000851ff8a x0 : ffff00000241ceb0
[    0.526034] Call trace:
[    0.526166]  apparmor_file_alloc_security+0x98/0x1e0
[    0.526424]  security_file_alloc+0x6c/0xf0
[    0.526570]  __alloc_file+0x5c/0xf0
[    0.526699]  alloc_empty_file+0x68/0x10c
[    0.526816]  path_openat+0x50/0x106c
[    0.526929]  do_filp_open+0x88/0x13c
[    0.527041]  filp_open+0x110/0x1b0
[    0.527143]  do_name+0xbc/0x230
[    0.527256]  write_buffer+0x40/0x60
[    0.527359]  unpack_to_rootfs+0x100/0x2bc
[    0.527479]  do_populate_rootfs+0x70/0x134
[    0.527602]  async_run_entry_fn+0x40/0x1c0
[    0.527723]  process_one_work+0x1f4/0x450
[    0.527851]  worker_thread+0x188/0x4c0
[    0.527980]  kthread+0xe0/0xe4
[    0.528066]  ret_from_fork+0x10/0x20
[    0.528317] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
[    0.528736] ---[ end trace 0000000000000000 ]---
...

A rootfs is available at [1] but I don't think it should be necessary
for reproducing this. If there is any additional information I can
provide or patches I can test, I am more than happy to do so!

[1]: https://github.com/ClangBuiltLinux/boot-utils/raw/bf2fd3500d87f78a914bfc3769b2240f5632e5b9/images/arm64/rootfs.cpio.zst

Cheers,
Nathan
