Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63A5F6ED1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJFUTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFUTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:19:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EA9646F;
        Thu,  6 Oct 2022 13:19:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x59so4403541ede.7;
        Thu, 06 Oct 2022 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQXEwyZOAQoIktw9AzUUz6hKteDe+hT/LCfTM1GZpBk=;
        b=H87b+tJCOwZEl9adqtmMM2c56FUJPM3f6+XT4E3+R3cqkCgaEAjE8hitEgQiNQqEB6
         MjvlWkwR6GhDOcAWPckoGP7nRREn4KB1UVi9kbeu/5Vi4F+NiXMnewD+Adc/bjfgT+ZB
         Vko+Mt0hW/S1R1yEPeO/7bvf2L21F7Uo352PvaXpd8sbIBvreRFjMbYCsM2FLw10XABi
         1qQzFUMn5nvMmcupuL9vjY+U2Z6cLfD7Iq8aKOu2/B/ODrpsYENa82mIRw495OMKwLA2
         pOzZF7c+IiKKTmbILHc3GA7GlNE7w30UNQusVtgt8NESoUitz3QZ2bliPUexpZdDBIc4
         kNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQXEwyZOAQoIktw9AzUUz6hKteDe+hT/LCfTM1GZpBk=;
        b=XIKce87ZJuzE7RTEbmqqO+1VtDxPfBFPSSTHvhmhi8zJ7+oSRNRdqCC67PaQVB4hxB
         D3wIp8nJKz55fMtsKEcJSj2ujBQWw6T5COPnQ8GRAEA4FTZePg/5hQR+sZ6YWjCHYRnX
         vo8Bq/1rFXhn42RjzaUN1PHvAp0aTIGf8zQF76wHNcy33YGNSNtAPL8E985Ri47AUQwl
         pkNqR7+fKz70Ku4rjbjEBnZmMP726CnWstVBmkuAeHnRQPSE5m7uk9Ep7oeIMsPbdUQz
         ITpDGf+CbPunGK7sWPmDXD6tfpha+Yej0WCUk8FFFd2Sz5ToOQNaIiOBdpiMc70wO7MI
         e2iA==
X-Gm-Message-State: ACrzQf2+Zpp3f3tWf0Swc4N/y5mNjFRtdq6bLqyCH30gPo9btuJNhTC5
        7y+sNepzzAJN+tx6lqn4aeBX1s+YWOA=
X-Google-Smtp-Source: AMsMyM4q03okKEhXxdIj6EPKlrau+t/XMmKKCP1nKSz2L/w1IWQO62k7quLEZOXdiXmrd6qIhxnsLw==
X-Received: by 2002:a05:6402:2994:b0:453:4c5c:d31c with SMTP id eq20-20020a056402299400b004534c5cd31cmr1472869edb.412.1665087578744;
        Thu, 06 Oct 2022 13:19:38 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073c10031dc9sm170022eja.80.2022.10.06.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:19:37 -0700 (PDT)
Date:   Thu, 6 Oct 2022 22:19:36 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 4/9] landlock: Support file truncation
Message-ID: <Yz84WNvpFxSYiCVb@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-5-gnoack3000@gmail.com>
 <YzyQASSaeVqRlTsO@dev-arch.thelio-3990X>
 <cdfdedad-a162-6608-a86e-8b2d47d6d8d8@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdfdedad-a162-6608-a86e-8b2d47d6d8d8@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:52:41PM +0200, Mickaël Salaün wrote:
> On 04/10/2022 21:56, Nathan Chancellor wrote:
> > Hi Günther,
> > 
> > On Sat, Oct 01, 2022 at 05:49:03PM +0200, Günther Noack wrote:
> > > Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> > > 
> > > This flag hooks into the path_truncate LSM hook and covers file
> > > truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> > > well as creat().
> > > 
> > > This change also increments the Landlock ABI version, updates
> > > corresponding selftests, and updates code documentation to document
> > > the flag.
> > > 
> > > The following operations are restricted:
> > > 
> > > open(): requires the LANDLOCK_ACCESS_FS_TRUNCATE right if a file gets
> > > implicitly truncated as part of the open() (e.g. using O_TRUNC).
> > > 
> > > Notable special cases:
> > > * open(..., O_RDONLY|O_TRUNC) can truncate files as well in Linux
> > > * open() with O_TRUNC does *not* need the TRUNCATE right when it
> > >    creates a new file.
> > > 
> > > truncate() (on a path): requires the LANDLOCK_ACCESS_FS_TRUNCATE
> > > right.
> > > 
> > > ftruncate() (on a file): requires that the file had the TRUNCATE right
> > > when it was previously opened.
> > > 
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > 
> > I just bisected a crash in QEMU with Debian's arm64 configuration to
> > this change in -next as commit b40deebe7679 ("landlock: Support file
> > truncation"), which I was able to reproduce like so:
> 
> Thanks for the report Nathan. I've found an issue in this patch and fixed it
> in -next with this (rebased) commit:
> https://git.kernel.org/mic/c/b40deebe7679b05d4852488ef531e189a9621f2e
> You should already have this update since I pushed it Monday.
> Please let us know if this fixed the issue.

I'm afraid Nathan already tested it with the version from the mic
-next branch b40deebe7679 ("landlock: Support file truncation")

Nathan, thank you for the report and especially for the detailed step
by step instructions! I have tried to reproduce it with the steps you
suggested with the root file system you linked to, but I'm afraid I
was unable to reproduce the crash.

When I've tried it, the kernel boots up to init and shuts down again,
but does not run into the issue you're reporting:

...
[    1.165628] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: OK
Starting network: OK
Linux version 6.0.0-rc7-00004-gb40deebe7679 (gnoack@nuc) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #4 SMP PREEMPT Thu Oct 6 21:45:59 CEST 2022
Stopping network: OK
Saving random seed: OK
Stopping klogd: OK
Stopping syslogd: OK
umount: devtmpfs busy - remounted read-only
umount: can't unmount /: Invalid argument
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
[    5.303758] kvm: exiting hardware virtualization
[    5.315878] Flash device refused suspend due to active operation (state 20)
[    5.318164] Flash device refused suspend due to active operation (state 20)
[    5.322274] reboot: Power down

I've been compiling the kernel using

make -j8 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build olddefconfig Image.gz

and started the emulator using

qemu-system-aarch64 -machine virt,gic-version=max,virtualization=true \
  -cpu max,pauth-impdef=true \
  -kernel /home/gnoack/linux/build/arch/arm64/boot/Image.gz \
  -append "console=ttyAMA0 earlycon" \
  -display none -m 512m -nodefaults -no-reboot -serial mon:stdio \
  -initrd /tmp/rootfs.cpio

I have attempted it with both the commit from the mic -next branch, as
well as with my own client that is still lacking Mickaël's LSM hook
fix. The commits I've tried are:

* b40deebe7679 ("landlock: Support file truncation")
* 224e66a32f16 ("landlock: Document Landlock's file truncation support")

I've built the kernel from scratch from the config file you suggested,
to be sure.

I used the rootfs.cpio file you provided from Github, and gcc 12.2.0
and qemu 7.1.0 from the Arch Linux repositories.

At this point, I don't know what else I can try to get it to crash...
it seems to work fine for me.

—Günther

> > 
> > $ mkdir -p build/deb
> > 
> > $ cd build/deb
> > 
> > $ curl -LSsO http://ftp.us.debian.org/debian/pool/main/l/linux-signed-arm64/linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb
> > 
> > $ ar x linux-image-5.19.0-2-arm64_5.19.11-1_arm64.deb
> > 
> > $ tar xJf data.tar.xz
> > 
> > $ cp boot/config-5.19.0-2-arm64 ../.config
> > 
> > $ cd ../..
> > 
> > $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build olddefconfig Image.gz
> > 
> > $ qemu-system-aarch64 \
> > -machine virt,gic-version=max,virtualization=true \
> > -cpu max,pauth-impdef=true \
> > -kernel build/arch/arm64/boot/Image.gz \
> > -append "console=ttyAMA0 earlycon" \
> > -display none \
> > -initrd .../rootfs.cpio \
> > -m 512m \
> > -nodefaults \
> > -no-reboot \
> > -serial mon:stdio
> > ...
> > [    0.000000] Linux version 6.0.0-rc7+ (nathan@dev-arch.thelio-3990X) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Tue Oct 4 12:48:50 MST 2022
> > ...
> > [    0.518570] Unable to handle kernel paging request at virtual address ffff00000851ff8a
> > [    0.518785] Mem abort info:
> > [    0.518867]   ESR = 0x0000000097c0c061
> > [    0.519001]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    0.519155]   SET = 0, FnV = 0
> > [    0.519267]   EA = 0, S1PTW = 0
> > [    0.519386]   FSC = 0x21: alignment fault
> > [    0.519524] Data abort info:
> > [    0.519615]   Access size = 8 byte(s)
> > [    0.519722]   SSE = 0, SRT = 0
> > [    0.519817]   SF = 1, AR = 1
> > [    0.519920]   CM = 0, WnR = 1
> > [    0.520040] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041711000
> > [    0.520225] [ffff00000851ff8a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=006800004851ff07
> > [    0.521121] Internal error: Oops: 97c0c061 [#1] SMP
> > [    0.521364] Modules linked in:
> > [    0.521592] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-rc7+ #1
> > [    0.521863] Hardware name: linux,dummy-virt (DT)
> > [    0.522325] Workqueue: events_unbound async_run_entry_fn
> > [    0.522973] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    0.523193] pc : apparmor_file_alloc_security+0x98/0x1e0
> > [    0.523431] lr : apparmor_file_alloc_security+0x48/0x1e0
> > [    0.523594] sp : ffff800008093960
> > [    0.523708] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002602600
> > [    0.523978] x26: ffffd79796ecf8c0 x25: ffff00000241e705 x24: ffffd79797d98068
> > [    0.524199] x23: ffff00000851ff82 x22: ffff00000851ff80 x21: 0000000000000002
> > [    0.524431] x20: ffffd79796ff5000 x19: ffff00000241ceb0 x18: ffffffffffffffff
> > [    0.524647] x17: 000000000000003f x16: ffffd79797678008 x15: 0000000000000000
> > [    0.524850] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000006
> > [    0.525087] x11: ffff00001feef940 x10: ffffd7979768f8a0 x9 : ffffd79796c1e51c
> > [    0.525325] x8 : ffff00000851ffa0 x7 : 0000000000000000 x6 : 0000000000001e0b
> > [    0.525531] x5 : ffff00000851ff80 x4 : ffff800008093990 x3 : ffff000002419700
> > [    0.525745] x2 : 0000000000000001 x1 : ffff00000851ff8a x0 : ffff00000241ceb0
> > [    0.526034] Call trace:
> > [    0.526166]  apparmor_file_alloc_security+0x98/0x1e0
> > [    0.526424]  security_file_alloc+0x6c/0xf0
> > [    0.526570]  __alloc_file+0x5c/0xf0
> > [    0.526699]  alloc_empty_file+0x68/0x10c
> > [    0.526816]  path_openat+0x50/0x106c
> > [    0.526929]  do_filp_open+0x88/0x13c
> > [    0.527041]  filp_open+0x110/0x1b0
> > [    0.527143]  do_name+0xbc/0x230
> > [    0.527256]  write_buffer+0x40/0x60
> > [    0.527359]  unpack_to_rootfs+0x100/0x2bc
> > [    0.527479]  do_populate_rootfs+0x70/0x134
> > [    0.527602]  async_run_entry_fn+0x40/0x1c0
> > [    0.527723]  process_one_work+0x1f4/0x450
> > [    0.527851]  worker_thread+0x188/0x4c0
> > [    0.527980]  kthread+0xe0/0xe4
> > [    0.528066]  ret_from_fork+0x10/0x20
> > [    0.528317] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
> > [    0.528736] ---[ end trace 0000000000000000 ]---
> > ...
> > 
> > A rootfs is available at [1] but I don't think it should be necessary
> > for reproducing this. If there is any additional information I can
> > provide or patches I can test, I am more than happy to do so!
> > 
> > [1]: https://github.com/ClangBuiltLinux/boot-utils/raw/bf2fd3500d87f78a914bfc3769b2240f5632e5b9/images/arm64/rootfs.cpio.zst
> > 
> > Cheers,
> > Nathan

-- 
