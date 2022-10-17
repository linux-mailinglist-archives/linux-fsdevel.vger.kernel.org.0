Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E26600A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJQJTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJQJSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:18:36 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295F399E7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 02:18:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MrWZZ5MwgzMqFnL;
        Mon, 17 Oct 2022 11:16:22 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MrWZX1sY7zxr;
        Mon, 17 Oct 2022 11:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665998182;
        bh=AgL8ZCn8UlnqprA4WMAu+0H0v+107PtIvpKJsxVAjhE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EW0pmJDsM7ku5gDeMR17n8Vpfj4pgzhxSsfxzI997lG+IjKxYPWV5Bbq9ZkXWlMu+
         y3oL/D811VsiUVCpOF3miEvd36wafJ5rR2LERC5+uw5KLEfMbMM9OAgY/KGZuPIY9i
         zYcT1/hxrqoQ9kIusyiKBSlzIqtpXstb1J5Dxy88=
Message-ID: <ea8117e5-7f5c-7598-5d6a-868184a6e4ae@digikod.net>
Date:   Mon, 17 Oct 2022 11:16:19 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v9 00/11] landlock: truncate support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
 <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
 <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X> <Y0xJUy3igQXWPAeq@nuc>
 <Y0xkZqKoE3rRJefh@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y0xkZqKoE3rRJefh@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 16/10/2022 22:07, Günther Noack wrote:
> On Sun, Oct 16, 2022 at 08:11:31PM +0200, Günther Noack wrote:
>> On Thu, Oct 13, 2022 at 09:35:24AM -0700, Nathan Chancellor wrote:
>>> Hi Mickaël and Günther,
>>>
>>> On Mon, Oct 10, 2022 at 12:35:31PM +0200, Mickaël Salaün wrote:
>>>> Thanks Günther! This series looks good and is now in -next with some minor
>>>> cosmetic comment changes.
>>>>
>>>> Nathan, could you please confirm that this series work for you?
>>>
>>> First of all, let me apologize for the delay in response. I am just now
>>> getting back online after a week long vacation, which was definitely
>>> poorly timed with the merge window :/
>>>
>>> Unfortunately, with this series applied on top of commit e8bc52cb8df8
>>> ("Merge tag 'driver-core-6.1-rc1' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core") as
>>> indicated by the base commit information at the bottom of the cover
>>> letter, I can still reproduce the original crash I reported. What is
>>> even more odd is that I should be using the exact same tool versions
>>> that Günther is, as I am also using Arch Linux as my distribution.
>>>
>>> I have attached the exact .config that the build system produced after
>>> my build, just in case there is something else in our environment that
>>> could be causing difficulties in reproducing.
>>>
>>> For what it is worth, I can reproduce this in a fresh Arch Linux
>>> container, which should hopefully remove most environment concerns.
>>>
>>> $ podman run \
>>>      --interactive \
>>>      --tty \
>>>      --rm
>>>      --volume .../linux-next:/linux-next \
>>>      --workdir /linux-next \
>>>      docker.io/archlinux:base-devel
>>> # pacman -Syyu --noconfirm \
>>>      aarch64-linux-gnu-gcc \
>>>      bc \
>>>      git \
>>>      pahole \
>>>      python3 \
>>>      qemu-system-aarch64
>>> ...
>>>
>>> # aarch64-linux-gnu-gcc --version | head -1
>>> aarch64-linux-gnu-gcc (GCC) 12.2.0
>>>
>>> # aarch64-linux-gnu-as --version | head -1
>>> GNU assembler (GNU Binutils) 2.39
>>>
>>> # qemu-system-aarch64 --version | head -1
>>> QEMU emulator version 7.1.0
>>>
>>> # git log --first-parent --oneline e8bc52cb8df8^..
>>> 5622ae16a601 landlock: Document Landlock's file truncation support
>>> 6c8a1dadeae1 samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
>>> d19c9ba61c75 selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
>>> bf5e5018edb5 selftests/landlock: Test FD passing from restricted to unrestricted processes
>>> 4a7f660a22b2 selftests/landlock: Locally define __maybe_unused
>>> 1a9015ef7014 selftests/landlock: Test open() and ftruncate() in multiple scenarios
>>> 79bb219d0b7c selftests/landlock: Test file truncation support
>>> dd3d0e23543e landlock: Support file truncation
>>> dcade986e070 landlock: Document init_layer_masks() helper
>>> 873afb813b11 landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
>>> cdda4d440c96 security: Create file_truncate hook from path_truncate hook
>>> e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>>>
>>> # mkdir build
>>>
>>> # mv .config build
>>>
>>> # mv rootfs.cpio build
>>>
>>> # make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build Image.gz
>>>
>>> # qemu-system-aarch64 \
>>>      -machine virt,gic-version=max,virtualization=true \
>>>      -cpu max,pauth-impdef=true \
>>>      -kernel build/arch/arm64/boot/Image.gz \
>>>      -append "console=ttyAMA0 earlycon" \
>>>      -display none \
>>>      -initrd build/rootfs.cpio \
>>>      -m 512m \
>>>      -nodefaults \
>>>      -no-reboot \
>>>      -serial mon:stdio
>>> ...
>>> [    0.000000] Linux version 6.0.0-08005-g5622ae16a601 (root@82bc572c5e5f) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Thu Oct 13 16:30:30 UTC 2022
>>> ...
>>> [    0.491767] Trying to unpack rootfs image as initramfs...
>>> [    0.494156] Unable to handle kernel paging request at virtual address ffff00000851036a
>>> [    0.494389] Mem abort info:
>>> [    0.494466]   ESR = 0x0000000097c0c061
>>> [    0.494601]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [    0.494756]   SET = 0, FnV = 0
>>> [    0.494957]   EA = 0, S1PTW = 0
>>> [    0.495070]   FSC = 0x21: alignment fault
>                                   ^^^^^^^^^^^^^^^
> 
> It's a memory alignment bug:
> 
> Problem
> -------
> 
> When the LSM framework determines the positions of the security blobs
> from their sizes, is just concatenates the blobs directly, which can
> lead to later blobs being misaligned if an earlier security blob has a
> misaligned size.
> 
> In this patch set, we introduced a pretty short (u16) file security
> blob, and that shifted the alignment of the AppArmor blob to an
> unaligned address, causing this Oops. (The other existing LSM blobs
> just happen to have sizes where it was not a problem before.)

Interesting

> 
> Proposed fix
> ------------
> 
> I think the LSM framework should ensure that security blobs are
> pointer-aligned.
> 
> The LSM framework takes the role of a memory allocator here, and
> memory allocators should normally return aligned addresses, in my
> understanding. -- It seems reasonable for AppArmor to make that
> assumption.
> 
> The proposed one-line fix is: Change lsm_set_blob_size() in
> security/security.c, where the positions of the individual security
> blobs are calculated, so that each allocated blob is aligned to a
> pointer size boundary.
> 
> if (*need > 0) {
>    *lbs = ALIGN(*lbs, sizeof(void *));   // NEW
> 
>    offset = *lbs;
>    *lbs += *need;
>    *need = offset;
> }

This looks good to me. This fix should be part of patch 4/11 since it 
only affects Landlock for now.


> 
> Alternatives considered
> -----------------------
> 
> The obvious alternative fix would be to fix it locally to Landlock and
> pad struct landlock_file_security to have the multiple of a pointer
> size.
> 
> Tradeoffs:
> 
>   + This approach would also fix the Oops
>   - Problem could happen again with another security blob in the
>     future, and the fact that is happens only with multiple LSMs
>     enabled makes that problem difficult to spot during LSM
>     development.
> 
> 
> Paul, does that proposed fix (to make lsm_set_blob_size() calculate
> aligned offsets) make sense to you?
> 
> (Also +CC: Thomas Gleixner, FYI, because you have authored
> lsm_set_blob_size() originally - do you have opinions on this?)
> 
> Thanks,
> —Günther
> 
>>> [    0.495214] Data abort info:
>>> [    0.495298]   Access size = 8 byte(s)
>>> [    0.495408]   SSE = 0, SRT = 0
>>> [    0.495519]   SF = 1, AR = 1
>>> [    0.495636]   CM = 0, WnR = 1
>>> [    0.495759] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041645000
>>> [    0.495938] [ffff00000851036a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=0068000048510f07
>>> [    0.496779] Internal error: Oops: 0000000097c0c061 [#1] SMP
>>> [    0.497081] Modules linked in:
>>> [    0.497341] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-08005-g5622ae16a601 #1
>>> [    0.497643] Hardware name: linux,dummy-virt (DT)
>>> [    0.497987] Workqueue: events_unbound async_run_entry_fn
>>> [    0.498635] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    0.498882] pc : apparmor_file_alloc_security+0x98/0x210
>>> [    0.499132] lr : apparmor_file_alloc_security+0x48/0x210
>>> [    0.499297] sp : ffff800008093960
>>> [    0.499403] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002201500
>>> [    0.499679] x26: ffffa4c2a0e55de0 x25: ffff00000201cd05 x24: ffffa4c2a1cd0068
>>> [    0.499901] x23: ffff000008510362 x22: ffff000008510360 x21: 0000000000000002
>>> [    0.500153] x20: ffffa4c2a0f72000 x19: ffff00000201b2b0 x18: ffffffffffffffff
>>> [    0.500375] x17: 000000000000003f x16: ffffa4c2a15d5008 x15: 0000000000000000
>>> [    0.500606] x14: 0000000000000001 x13: 0000000000002578 x12: ffff00001fef1eb8
>>> [    0.500830] x11: ffffa4c2a15ec860 x10: 0000000000000007 x9 : ffffa4c2a0bce9ec
>>> [    0.501061] x8 : ffff000008510380 x7 : 0000000000000000 x6 : 0000000000001e23
>>> [    0.501284] x5 : ffff000008510360 x4 : ffff800008093990 x3 : ffff000002017d80
>>> [    0.501500] x2 : 0000000000000001 x1 : ffff00000851036a x0 : ffff00000201b2b0
>>> [    0.501800] Call trace:
>>> [    0.501957]  apparmor_file_alloc_security+0x98/0x210
>>> [    0.502241]  security_file_alloc+0x6c/0xf0
>>> [    0.502401]  __alloc_file+0x5c/0x100
>>> [    0.502520]  alloc_empty_file+0x68/0x110
>>> [    0.502630]  path_openat+0x50/0x1090
>>> [    0.502743]  do_filp_open+0x88/0x13c
>>> [    0.502858]  filp_open+0x110/0x1b0
>>> [    0.502961]  do_name+0xbc/0x230
>>> [    0.503105]  write_buffer+0x40/0x60
>>> [    0.503234]  unpack_to_rootfs+0x100/0x2bc
>>> [    0.503375]  do_populate_rootfs+0x70/0x134
>>> [    0.503516]  async_run_entry_fn+0x40/0x1e0
>>> [    0.503653]  process_one_work+0x1f4/0x460
>>> [    0.503783]  worker_thread+0x188/0x4e0
>>> [    0.503902]  kthread+0xe0/0xe4
>>> [    0.503999]  ret_from_fork+0x10/0x20
>>> [    0.504279] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
>>> [    0.504647] ---[ end trace 0000000000000000 ]---
>>> ...
>>>
>>> I am not sure what else I can provide in order to reproduce this but I
>>> am happy to do whatever is needed to get to the bottom of this.
>>
>> Thank you Nathan! I am able to reproduce this now with the .config you
>> provided and will have a look.
>>
>> —Günther
>>
>> -- 
> 
