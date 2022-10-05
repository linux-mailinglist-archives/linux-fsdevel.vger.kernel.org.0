Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BA5F5A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJESw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiJESwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:52:51 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C26B8E5
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 11:52:47 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjNx70T3gzMqHF5;
        Wed,  5 Oct 2022 20:52:43 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjNx601B0zMppDP;
        Wed,  5 Oct 2022 20:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664995963;
        bh=vZn9Z/mB+kBdgt4mEB6Y23TDD4U+fH6qbo78+xWpuYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pEz4oN7sUYON0JpZHpTERU4Ltbl/WtGBHNpSqWjGPVK8l8YNdVyMRIeRTo1hpURaB
         VngmfhSZ5C0BY6zGw5Eoca9x5O7vdLovAgH6sZ8LuU6nvDQ3A8rk71zAUt2ztKhd+s
         JcjdxFQp7+EnVRDjPnd2fSRcqxp57V/gSdfOfun4=
Message-ID: <cdfdedad-a162-6608-a86e-8b2d47d6d8d8@digikod.net>
Date:   Wed, 5 Oct 2022 20:52:41 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 4/9] landlock: Support file truncation
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-5-gnoack3000@gmail.com>
 <YzyQASSaeVqRlTsO@dev-arch.thelio-3990X>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <YzyQASSaeVqRlTsO@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 04/10/2022 21:56, Nathan Chancellor wrote:
> Hi Günther,
> 
> On Sat, Oct 01, 2022 at 05:49:03PM +0200, Günther Noack wrote:
>> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
>>
>> This flag hooks into the path_truncate LSM hook and covers file
>> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
>> well as creat().
>>
>> This change also increments the Landlock ABI version, updates
>> corresponding selftests, and updates code documentation to document
>> the flag.
>>
>> The following operations are restricted:
>>
>> open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
>> implicitly truncated as part of the open() (e.g. using O_TRUNC).
>>
>> Notable special cases:
>> * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
>> * open() with O_TRUNC does *not* need the TRUNCATE right when it
>>    creates a new file.
>>
>> truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
>> right.
>>
>> ftruncate() (on a file): requires that the file had the TRUNCATE right
>> when it was previously opened.
>>
>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> 
> I just bisected a crash in QEMU with Debian's arm64 configuration to
> this change in -next as commit b40deebe7679 ("landlock: Support file
> truncation"), which I was able to reproduce like so:

Thanks for the report Nathan. I've found an issue in this patch and 
fixed it in -next with this (rebased) commit: 
https://git.kernel.org/mic/c/b40deebe7679b05d4852488ef531e189a9621f2e
You should already have this update since I pushed it Monday.
Please let us know if this fixed the issue.


> 
> $ mkdir -p build/deb
> 
> $ cd build/deb
> 
> $ curl -LSsO http://ftp.us.debian.org/debian/pool/main/l/linux-signed-arm64/linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb
> 
> $ ar x linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb
> 
> $ tar xJf data.tar.xz
> 
> $ cp boot/config-5.19.0-2-arm64 ../.config
> 
> $ cd ../..
> 
> $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build olddefconfig Image.gz
> 
> $ qemu-system-aarch64 \
> -machine virt,gic-version=max,virtualization=true \
> -cpu max,pauth-impdef=true \
> -kernel build/arch/arm64/boot/Image.gz \
> -append "console=ttyAMA0 earlycon" \
> -display none \
> -initrd .../rootfs.cpio \
> -m 512m \
> -nodefaults \
> -no-reboot \
> -serial mon:stdio
> ...
> [    0.000000] Linux version 6.0.0-rc7+ (nathan@dev-arch.thelio-3990X) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Tue Oct 4 12:48:50 MST 2022
> ...
> [    0.518570] Unable to handle kernel paging request at virtual address ffff00000851ff8a
> [    0.518785] Mem abort info:
> [    0.518867]   ESR = 0x0000000097c0c061
> [    0.519001]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.519155]   SET = 0, FnV = 0
> [    0.519267]   EA = 0, S1PTW = 0
> [    0.519386]   FSC = 0x21: alignment fault
> [    0.519524] Data abort info:
> [    0.519615]   Access size = 8 byte(s)
> [    0.519722]   SSE = 0, SRT = 0
> [    0.519817]   SF = 1, AR = 1
> [    0.519920]   CM = 0, WnR = 1
> [    0.520040] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041711000
> [    0.520225] [ffff00000851ff8a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=006800004851ff07
> [    0.521121] Internal error: Oops: 97c0c061 [#1] SMP
> [    0.521364] Modules linked in:
> [    0.521592] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-rc7+ #1
> [    0.521863] Hardware name: linux,dummy-virt (DT)
> [    0.522325] Workqueue: events_unbound async_run_entry_fn
> [    0.522973] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.523193] pc : apparmor_file_alloc_security+0x98/0x1e0
> [    0.523431] lr : apparmor_file_alloc_security+0x48/0x1e0
> [    0.523594] sp : ffff800008093960
> [    0.523708] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002602600
> [    0.523978] x26: ffffd79796ecf8c0 x25: ffff00000241e705 x24: ffffd79797d98068
> [    0.524199] x23: ffff00000851ff82 x22: ffff00000851ff80 x21: 0000000000000002
> [    0.524431] x20: ffffd79796ff5000 x19: ffff00000241ceb0 x18: ffffffffffffffff
> [    0.524647] x17: 000000000000003f x16: ffffd79797678008 x15: 0000000000000000
> [    0.524850] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000006
> [    0.525087] x11: ffff00001feef940 x10: ffffd7979768f8a0 x9 : ffffd79796c1e51c
> [    0.525325] x8 : ffff00000851ffa0 x7 : 0000000000000000 x6 : 0000000000001e0b
> [    0.525531] x5 : ffff00000851ff80 x4 : ffff800008093990 x3 : ffff000002419700
> [    0.525745] x2 : 0000000000000001 x1 : ffff00000851ff8a x0 : ffff00000241ceb0
> [    0.526034] Call trace:
> [    0.526166]  apparmor_file_alloc_security+0x98/0x1e0
> [    0.526424]  security_file_alloc+0x6c/0xf0
> [    0.526570]  __alloc_file+0x5c/0xf0
> [    0.526699]  alloc_empty_file+0x68/0x10c
> [    0.526816]  path_openat+0x50/0x106c
> [    0.526929]  do_filp_open+0x88/0x13c
> [    0.527041]  filp_open+0x110/0x1b0
> [    0.527143]  do_name+0xbc/0x230
> [    0.527256]  write_buffer+0x40/0x60
> [    0.527359]  unpack_to_rootfs+0x100/0x2bc
> [    0.527479]  do_populate_rootfs+0x70/0x134
> [    0.527602]  async_run_entry_fn+0x40/0x1c0
> [    0.527723]  process_one_work+0x1f4/0x450
> [    0.527851]  worker_thread+0x188/0x4c0
> [    0.527980]  kthread+0xe0/0xe4
> [    0.528066]  ret_from_fork+0x10/0x20
> [    0.528317] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
> [    0.528736] ---[ end trace 0000000000000000 ]---
> ...
> 
> A rootfs is available at [1] but I don't think it should be necessary
> for reproducing this. If there is any additional information I can
> provide or patches I can test, I am more than happy to do so!
> 
> [1]: https://github.com/ClangBuiltLinux/boot-utils/raw/bf2fd3500d87f78a914bfc3769b2240f5632e5b9/images/arm64/rootfs.cpio.zst
> 
> Cheers,
> Nathan
