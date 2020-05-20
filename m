Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D501DB9D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETQj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETQj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 12:39:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D41C061A0E;
        Wed, 20 May 2020 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=AnGXWlpEOu4iqWXGhr7iWfL5p65eGbwcAaVhmmCOm0U=; b=lS/OubPCMJGTT8oh1axlCTHnDs
        Ihm0CtyV7yRVusP4pNf4C2LpVNTuFo5cJ7Quhr/2Dz46tiXw1xLyoqHA5NrSYYPmnLvoUAkQ09hWa
        Jdol0k1UXDfosww1ICtI1jSi2TvkNW0v6Mg5GU+mfdOQGdvv46MsSs1BpN4OFKkxI5Z0KttgNs7fZ
        Z864lDjMJ508imL6bRCTASR2nL8AQjmKojA178Lwi3oC5mkjgwDJtWbzfEfkn71NI9U19s3VeyTEk
        myb2n4kG8ocUil2HSPUzVnmRoEY0VrQbj01l9rYyvRP6Si1OcIy2fVwNOBOEcNAVXWenkJ7beFwI/
        A/fPVung==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbRl4-0003rI-1L; Wed, 20 May 2020 16:39:54 +0000
Subject: Re: kernel BUG at fs/inode.c:531!
To:     nirinA raseliarison <nirina.raseliarison@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>
References: <CANsGL8Mb31NWVSgj=B2fNtT3x4oYm3tDKYZxpBCKfNC9ROLcGA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29a960db-734a-a5bc-1f4c-1833bd9eb1d8@infradead.org>
Date:   Wed, 20 May 2020 09:39:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CANsGL8Mb31NWVSgj=B2fNtT3x4oYm3tDKYZxpBCKfNC9ROLcGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding Cc:s]

Kernel is 5.7.0-rc6.20200519.


On 5/20/20 5:57 AM, nirinA raseliarison wrote:
> hello ,
> 
> i repeatedly hit this bug since gcc-10.1.0:
> 
> May 20 05:06:25 supernova kernel: [16312.604136] ------------[ cut
> here ]------------
> May 20 05:06:25 supernova kernel: [16312.604139] kernel BUG at fs/inode.c:531!
> May 20 05:06:25 supernova kernel: [16312.604145] invalid opcode: 0000
> [#1] SMP PTI
> May 20 05:06:25 supernova kernel: [16312.604148] CPU: 1 PID: 149 Comm:
> kswapd0 Not tainted 5.7.0-rc6.20200519 #1
> May 20 05:06:25 supernova kernel: [16312.604150] Hardware name: To be
> filled by O.E.M. To be filled by O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5
> 01/07/2013
> May 20 05:06:25 supernova kernel: [16312.604155] RIP: 0010:clear_inode+0x75/0x80
> May 20 05:06:25 supernova kernel: [16312.604157] Code: a8 20 74 2a a8
> 40 75 28 48 8b 83 28 01 00 00 48 8d 93 28 01 00 00 48 39 c2 75 17 48
> c7 83 98 00 00 00 60 00 00 00 5b c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f
> 0b 90 0f 1f 44 00 00 53 ba 48 02 00 00
> May 20 05:06:25 supernova kernel: [16312.604158] RSP:
> 0000:ffffc9000048fb50 EFLAGS: 00010006
> May 20 05:06:25 supernova kernel: [16312.604160] RAX: 0000000000000000
> RBX: ffff88808c5f9e38 RCX: 0000000000000000
> May 20 05:06:25 supernova kernel: [16312.604161] RDX: 0000000000000001
> RSI: 0000000000000000 RDI: ffff88808c5f9fb8
> May 20 05:06:25 supernova kernel: [16312.604162] RBP: ffff88808c5f9e38
> R08: ffffffffffffffff R09: ffffc9000048fcd8
> May 20 05:06:25 supernova kernel: [16312.604163] R10: 0000000000000000
> R11: 0000000000000520 R12: ffff88808c5f9fb0
> May 20 05:06:25 supernova kernel: [16312.604164] R13: ffff88820f14d000
> R14: ffff88820f14d070 R15: 0000000000000122
> May 20 05:06:25 supernova kernel: [16312.604166] FS:
> 0000000000000000(0000) GS:ffff888217700000(0000)
> knlGS:0000000000000000
> May 20 05:06:25 supernova kernel: [16312.604167] CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033
> May 20 05:06:25 supernova kernel: [16312.604168] CR2: 00007f7849e58000
> CR3: 000000001e676006 CR4: 00000000001606e0
> May 20 05:06:25 supernova kernel: [16312.604169] Call Trace:
> May 20 05:06:25 supernova kernel: [16312.604174]  ext4_clear_inode+0x16/0x80
> May 20 05:06:25 supernova kernel: [16312.604177]  ext4_evict_inode+0x58/0x4c0
> May 20 05:06:25 supernova kernel: [16312.604180]  evict+0xbf/0x180
> May 20 05:06:25 supernova kernel: [16312.604183]  prune_icache_sb+0x7e/0xb0
> May 20 05:06:25 supernova kernel: [16312.604186]  super_cache_scan+0x161/0x1e0
> May 20 05:06:25 supernova kernel: [16312.604189]  do_shrink_slab+0x146/0x290
> May 20 05:06:25 supernova kernel: [16312.604191]  shrink_slab+0xac/0x2a0
> May 20 05:06:25 supernova kernel: [16312.604194]  ? __switch_to_asm+0x40/0x70
> May 20 05:06:25 supernova kernel: [16312.604196]  shrink_node+0x16f/0x660
> May 20 05:06:25 supernova kernel: [16312.604199]  balance_pgdat+0x2cf/0x5b0
> May 20 05:06:25 supernova kernel: [16312.604201]  kswapd+0x1dc/0x3a0
> May 20 05:06:25 supernova kernel: [16312.604204]  ? __schedule+0x217/0x710
> May 20 05:06:25 supernova kernel: [16312.604206]  ? wait_woken+0x80/0x80
> May 20 05:06:25 supernova kernel: [16312.604208]  ? balance_pgdat+0x5b0/0x5b0
> May 20 05:06:25 supernova kernel: [16312.604210]  kthread+0x118/0x130
> May 20 05:06:25 supernova kernel: [16312.604212]  ?
> kthread_create_worker_on_cpu+0x70/0x70
> May 20 05:06:25 supernova kernel: [16312.604214]  ret_from_fork+0x35/0x40
> May 20 05:06:25 supernova kernel: [16312.604215] Modules linked in:
> nct6775 hwmon_vid rfkill ipv6 nf_defrag_ipv6 snd_pcm_oss snd_mixer_oss
> fuse hid_generic usbhid hid i2c_dev snd_hda_codec_hdmi
> snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon
> x86_pkg_temp_thermal intel_powerclamp i915 kvm_intel kvm irqbypass
> evdev crc32_pclmul serio_raw r8169 drm_kms_helper snd_hda_intel
> snd_intel_dspcfg realtek snd_hda_codec libphy snd_hwdep syscopyarea
> sysfillrect sysimgblt snd_hda_core fan fb_sys_fops thermal snd_pcm drm
> 8250 mei_me snd_timer drm_panel_orientation_quirks 8250_base
> serial_core intel_gtt video snd ehci_pci lpc_ich ehci_hcd mei agpgart
> soundcore button i2c_algo_bit i2c_i801 loop
> May 20 05:06:25 supernova kernel: [16312.604237] ---[ end trace
> 6d45434b7eb1e097 ]---
> May 20 05:06:25 supernova kernel: [16312.604240] RIP: 0010:clear_inode+0x75/0x80
> May 20 05:06:25 supernova kernel: [16312.604241] Code: a8 20 74 2a a8
> 40 75 28 48 8b 83 28 01 00 00 48 8d 93 28 01 00 00 48 39 c2 75 17 48
> c7 83 98 00 00 00 60 00 00 00 5b c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f
> 0b 90 0f 1f 44 00 00 53 ba 48 02 00 00
> May 20 05:06:25 supernova kernel: [16312.604242] RSP:
> 0000:ffffc9000048fb50 EFLAGS: 00010006
> May 20 05:06:25 supernova kernel: [16312.604244] RAX: 0000000000000000
> RBX: ffff88808c5f9e38 RCX: 0000000000000000
> May 20 05:06:25 supernova kernel: [16312.604245] RDX: 0000000000000001
> RSI: 0000000000000000 RDI: ffff88808c5f9fb8
> May 20 05:06:25 supernova kernel: [16312.604246] RBP: ffff88808c5f9e38
> R08: ffffffffffffffff R09: ffffc9000048fcd8
> May 20 05:06:25 supernova kernel: [16312.604246] R10: 0000000000000000
> R11: 0000000000000520 R12: ffff88808c5f9fb0
> May 20 05:06:25 supernova kernel: [16312.604247] R13: ffff88820f14d000
> R14: ffff88820f14d070 R15: 0000000000000122
> May 20 05:06:25 supernova kernel: [16312.604249] FS:
> 0000000000000000(0000) GS:ffff888217700000(0000)
> knlGS:0000000000000000
> May 20 05:06:25 supernova kernel: [16312.604250] CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033
> May 20 05:06:25 supernova kernel: [16312.604251] CR2: 00007f7849e58000
> CR3: 000000001e676006 CR4: 00000000001606e0
> 
> --
> nirinA
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
