Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842C52BB5B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgKTTmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 14:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgKTTmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:42:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D5C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 11:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=pc5JHr5XViQgJhZ2Q+GMcSbygnjQNhEQI01odQwCc00=; b=qJcjGF0AivFpflSbwYgUeBYw0L
        bZ4NxehXGUpvB6SxjLhEQXMKmSafWMDerwjwR7GrrQMVcJw1qEhf4w2xvVIM7jQJVp0Ts6NYXcj9N
        Haooroj3l7WAy/CvvL/qyckQda5wJ8cSV/f/exDM4j/55ofPosheKGvZEhIt83Yy2eRGM0rKEbHif
        rGGaRtJTe4kV0uOjB15wKTaBvETig+nT+bJEU3fsw0eRIr+ubImDmjNDchN2xodzuAGMeUzcoz9pB
        mY3u7bFwkXY7QYQZm5tRyz3cNaE82+lthZ3S/YW1vlzUBviTpaQojAY5GLsEfHYrkn9iW/kZZTBI3
        Nfg0nWMg==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgCJ1-00033D-Fp; Fri, 20 Nov 2020 19:42:51 +0000
Subject: Re: BUG triggers running lsof
To:     "K.R. Foley" <kr@cybsft.com>, linux-fsdevel@vger.kernel.org
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
Date:   Fri, 20 Nov 2020 11:42:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/20 11:16 AM, K.R. Foley wrote:
> I have found an issue that triggers by running lsof. The problem is reproducible, but not consistently. I have seen this issue occur on multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It looks like it could be a race condition or the file pointer is being corrupted. Any pointers on how to track this down? What additional information can I provide?

Hi,

2 things in general:

a) Can you test with a more recent kernel?

b) Can you reproduce this without loading the proprietary & out-of-tree
kernel modules?  They should never have been loaded after bootup.
I.e., don't just unload them -- that could leave something bad behind.

> [ 8057.297159] BUG: unable to handle page fault for address: 31376f63
> [ 8057.297163] #PF: supervisor read access in kernel mode
> [ 8057.297164] #PF: error_code(0x0000) - not-present page
> [ 8057.297166] *pde = 00000000
> [ 8057.297168] Oops: 0000 [#1] SMP
> [ 8057.297171] CPU: 1 PID: 461 Comm: lsof Tainted: P           O      5.4.77-PRD.1.5 #3
> [ 8057.297172] Hardware name: Incredible Technologies Inc. Nighthawk/IMBM-B75A-A20-IT01, BIOS 0404 03/14/2014
> [ 8057.297175] EIP: 0x31376f63
> [ 8057.297176] Code: Bad RIP value.
> [ 8057.297177] EAX: f55962d0 EBX: f55962d0 ECX: 31376f63 EDX: f69ddd80
> [ 8057.297179] ESI: f69ddd80 EDI: f6899b00 EBP: c2621e88 ESP: c2621e5c
> [ 8057.297180] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
> [ 8057.297182] CR0: 80050033 CR2: 31376f59 CR3: 046e1000 CR4: 000406d0
> [ 8057.297183] Call Trace:
> [ 8057.297189]  ? seq_show+0xfe/0x138
> [ 8057.297191]  seq_read+0x144/0x3da
> [ 8057.297193]  ? seq_lseek+0x171/0x171
> [ 8057.297196]  __vfs_read+0x2d/0x1ba
> [ 8057.297198]  ? __do_sys_fstat64+0x49/0x50
> [ 8057.297200]  vfs_read+0x7a/0xfc
> [ 8057.297203]  ksys_read+0x4c/0xb0
> [ 8057.297203]  ksys_read+0x4c/0xb0
> [ 8057.297205]  sys_read+0x11/0x13
> [ 8057.297207]  do_fast_syscall_32+0x8f/0x1de
> [ 8057.297210]  entry_SYSENTER_32+0xa2/0xf5
> [ 8057.297211] EIP: 0xb7f578e5
> [ 8057.297213] Code: d9 89 da 89 f3 e8 17 00 00 00 89 d3 eb dd b8 40 42 0f 00 eb c7 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [ 8057.297215] EAX: ffffffda EBX: 00000007 ECX: 09e54490 EDX: 00000400
> [ 8057.297216] ESI: 09e36a90 EDI: b7f43000 EBP: bf9fde18 ESP: bf9fddb0
> [ 8057.297217] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> [ 8057.297219] Modules linked in: ITXico7100Module(O) ITDongle1Module(O) ITIOBoard2BootLoaderModule(O) ITIOBoard1Module(O) ITBiosWormModule(O) it87 hwmon_vid ipv6 cfg80211 evdev snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi fuse ledtrig_audio snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm_oss nvidia_drm(PO) snd_pcm nvidia_modeset(PO) nvidia(PO) snd_mixer_oss ti_usb_3410_5052 snd_timer iTCO_wdt realtek usbserial iTCO_vendor_support snd sg r8169 serio_raw lpc_ich x86_pkg_temp_thermal i2c_i801 coretemp libphy mii xhci_pci xhci_hcd ehci_pci ext4 jbd2 ext2 mbcache uhci_hcd ehci_hcd sd_mod ata_piix [last unloaded: ITXico7100Module]
> [ 8057.297241] CR2: 0000000031376f63
> [ 8057.297244] ---[ end trace 455c8cdc1bacfeda ]---
> [ 8057.297245] EIP: 0x31376f63
> [ 8057.297246] Code: Bad RIP value.
> [ 8057.297247] EAX: f55962d0 EBX: f55962d0 ECX: 31376f63 EDX: f69ddd80
> [ 8057.297248] ESI: f69ddd80 EDI: f6899b00 EBP: c2621e88 ESP: c2621e5c
> [ 8057.297250] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
> [ 8057.297251] CR0: 80050033 CR2: 31376f59 CR3: 046e1000 CR4: 000406d0
> 
> 


-- 
~Randy

