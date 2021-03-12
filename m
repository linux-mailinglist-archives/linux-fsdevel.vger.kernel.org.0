Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD9338923
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhCLJtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhCLJsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:53 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F2C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:52 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id p8so1110538vki.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Op4aLOwVkmUYOQGECqQb7yWvOLD8mCrlIC68jUd+E+Q=;
        b=RX9nfSoAMjg4s8sLth6UavMguLSk4OewVwd4bygyJyvM/XVdiJQLmJe3KFsjHeQE+b
         /x2z0yDpkFrHXAzrDNwymQTseYW3falSjxeO5kyPMZmuC9EJJY9fZ/2xpYEBMUMOExsq
         vDUZOo/Snv2BiZhPlm2nIMRbwDDTe+TSPGAtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Op4aLOwVkmUYOQGECqQb7yWvOLD8mCrlIC68jUd+E+Q=;
        b=lb2Z825kKwQTTWK9OXmrfH7hWRHBulyQpawWKsAiQkUVT3nXT+jA/zWooTZrKCMov1
         t/DHili84+XFhXOt2AtiucJuQOIL9ynrYxQ6gNZ1S6KZPaN3G7fwGlV6U85KUp8XA7q+
         UzeW8gmNcTy3Uda7R74O96v1OqpNLadnxe/jPwrEUo2GHia5WSIdxq/OMuYR5/rYszGA
         FWpc27vEXYCeV3HUcxqH2HjecpIylqBUnCKyWlRu0ZW0zwLVXsdPsUCQXd3MDLudsaXH
         0dirpKG0gcA6R5WKVBggcXjNvxvgJCcrnV/RDwi7EcRNvjqibSgbSBNoI+Ioe4Wk+NrW
         zMNg==
X-Gm-Message-State: AOAM532BJouBjB8OtFvhIj2Za1hUMJDw68AVHyz59lF1cyvrWlua6Jm1
        2JFNr8yh7klM/NdAfUQYmvO1xW2HfZy6nTjRs6fR2A==
X-Google-Smtp-Source: ABdhPJwPYkJt/f9giqohQNKE031iQ6ZOLHDbkiJRmKkC92+LFsQww+w4YT/abqMaBheonI13AasfTX37DEkRt2LG6UA=
X-Received: by 2002:a1f:99c2:: with SMTP id b185mr7199848vke.3.1615542531553;
 Fri, 12 Mar 2021 01:48:51 -0800 (PST)
MIME-Version: 1.0
References: <YEsryBEFq4HuLKBs@suse.de>
In-Reply-To: <YEsryBEFq4HuLKBs@suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 12 Mar 2021 10:48:40 +0100
Message-ID: <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
To:     Luis Henriques <lhenriques@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 9:51 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> Hi Miklos,
>
> I've seen a bug report (5.10.16 kernel splat below) that seems to be
> reproducible in kernels as early as 5.4.
>
> The commit that caught my attention when looking at what was merged in 5.=
4
> was e4648309b85a ("fuse: truncate pending writes on O_TRUNC") but I didn'=
t
> went too deeper on that -- I was wondering if you have seen something
> similar before.

Don't remember seeing this.

Excerpt from invalidate_inode_pages2_range():

        lock_page(page);
        [...]
        if (page_mapped(page)) {
             [...]
                        unmap_mapping_pages(mapping, index,
                                                1, false);
                }
        }
        BUG_ON(page_mapped(page));

Page fault locks the page before installing a new pte, at least
AFAICS, so the BUG looks impossible.  The referenced commits only
touch very high level control of writeback, so they may well increase
the chance of a bug triggering, but very unlikely to be the actual
cause of the bug.   I'm guessing this to be an MM issue.

Is this reproducible on vanilla, or just openSUSE kernels?

Thanks,
Miklos



>
>
> There's another splat in the bug report[1] for a 5.4.14 kernel (which may
> be for a different bug, but the traces don't look as reliable as the one
> bellow).
>
> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=3D1182929
>
> [97604.721590] kernel BUG at mm/truncate.c:763!
> [97604.721601] invalid opcode: 0000 [#1] SMP PTI
> [97604.721613] CPU: 18 PID: 1584438 Comm: g++ Tainted: P           O
>  5.10.16-1-default #1 openSUSE Tumbleweed
> [97604.721618] Hardware name: Supermicro X11DPi-N(T)/X11DPi-N, BIOS 3.1a
> 10/16/2019
> [97604.721631] RIP: 0010:invalidate_inode_pages2_range+0x366/0x4e0
> [97604.721637] Code: 0f 48 f0 e9 19 ff ff ff 31 c9 4c 89 e7 ba 01 00 00 0=
0
> 48 89 ee e8 1a c5 02 00 4c 89 ff e8 02 1b 01 00 84 c0 0f 84 ca fe ff ff <=
0f>
> 0b 49 8b 57 18 49 39 d4 0f 85 e2 fe ff ff 49 f7 07 00 60 00 00
> [97604.721645] RSP: 0018:ffffa613aa54ba40 EFLAGS: 00010202
> [97604.721651] RAX: 0000000000000001 RBX: 000000000000000a RCX:
> 0000000000000200
> [97604.721656] RDX: 0000000000000090 RSI: 00affff800010037 RDI:
> ffffd880718e0000
> [97604.721660] RBP: 0000000000001400 R08: 0000000000001400 R09:
> 0000000000001a73
> [97604.721664] R10: 0000000000000000 R11: 0000000004a684da R12:
> ffff8a28d4549d78
> [97604.721669] R13: ffffffffffffffff R14: 0000000000000000 R15:
> ffffd880718e0000
> [97604.721674] FS:  00007f9cdd7fb740(0000) GS:ffff8a5c7f980000(0000)
> knlGS:0000000000000000
> [97604.721679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [97604.721683] CR2: 00007f89d3d78d80 CR3: 0000004d8a14e005 CR4:
> 00000000007706e0
> [97604.721688] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [97604.721692] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> 97604.721696] PKRU: 55555554
> [97604.721699] Call Trace:
> [97604.721719]  ? request_wait_answer+0x11a/0x210 [fuse]
> [97604.721729]  ? fuse_dentry_delete+0xb/0x20 [fuse]
> [97604.721740]  fuse_finish_open+0x85/0x150 [fuse]
> [97604.721750]  fuse_open_common+0x1a8/0x1b0 [fuse]
> [97604.721759]  ? fuse_open_common+0x1b0/0x1b0 [fuse]
> [97604.721766]  do_dentry_open+0x14e/0x380
> [97604.721775]  path_openat+0x600/0x10d0
> [97604.721782]  ? handle_mm_fault+0x103c/0x1a00
> [97604.721791]  ? follow_page_pte+0x314/0x5f0
> [97604.721795]  do_filp_open+0x88/0x130
> [97604.721803]  ? security_prepare_creds+0x6d/0x90
> [97604.721808]  ? __kmalloc+0x11d/0x2a0
> [97604.721814]  do_open_execat+0x6d/0x1a0
> [97604.721819]  bprm_execve+0x190/0x6b0
> [97604.721825]  do_execveat_common+0x192/0x1c0
> [97604.721830]  __x64_sys_execve+0x39/0x50
> [97604.721836]  do_syscall_64+0x33/0x80
> [97604.721843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [97604.721848] RIP: 0033:0x7f9cdcfe2c37
> [97604.721853] Code: ff ff 76 df 89 c6 f7 de 64 41 89 32 eb d5 89 c6 f7 d=
e
> 64 41 89 32 eb db 66 2e 0f 1f 84 00 00 00 00 00 90 b8 3b 00 00 00 0f 05 <=
48>
> 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 08 12 30 00 f7 d8 64 89 02
> [97604.721862] RSP: 002b:00007ffe444f5758 EFLAGS: 00000202 ORIG_RAX:
> 000000000000003b
> [97604.721867] RAX: ffffffffffffffda RBX: 00007f9cdd7fb6a0 RCX:
> 00007f9cdcfe2c37
> [97604.721872] RDX: 00000000020f5300 RSI: 00000000020f3bf8 RDI:
> 00000000020f36a0
> [97604.721876] RBP: 0000000000000001 R08: 0000000000000000 R09:
> 0000000000000000
> [97604.721880] R10: 00007ffe444f4b60 R11: 0000000000000202 R12:
> 0000000000000000
> [97604.721884] R13: 0000000000000001 R14: 00000000020f36a0 R15:
> 0000000000000000
> [97604.721890] Modules linked in: overlay rpcsec_gss_krb5 nfsv4 dns_resol=
ver
> nfsv3 nfs fscache libafs(PO) iscsi_ibft iscsi_boot_sysfs rfkill
> vboxnetadp(O) vboxnetflt(O) vboxdrv(O) dmi_sysfs intel_rapl_msr
> intel_rapl_common isst_if_common joydev ipmi_ssif i40iw ib_uverbs iTCO_wd=
t
> intel_pmc_bxt ib_core hid_generic iTCO_vendor_support skx_edac nfit
> libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel acpi_i=
pmi
> usbhid kvm i40e ipmi_si ioatdma mei_me i2c_i801 irqbypass ipmi_devintf me=
i
> i2c_smbus lpc_ich dca efi_pstore pcspkr ipmi_msghandler tiny_power_button
> acpi_pad button nls_iso8859_1 nls_cp437 vfat fat nfsd nfs_acl lockd
> auth_rpcgss grace sunrpc fuse configfs nfs_ssc ast i2c_algo_bit
> drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_f=
ops
> cec rc_core drm_ttm_helper xhci_pci ttm xhci_pci_renesas xhci_hcd
> crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_inte=
l
> drm glue_helper crypto_simd cryptd usbcore wmi sg br_netfilter bridge stp
> llc
> [97604.721991]  dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> msr efivarfs
> [97604.722031] ---[ end trace edcabaccd35272e2 ]---
> [97604.727773] RIP: 0010:invalidate_inode_pages2_range+0x366/0x4e0
>
> Cheers,
> --
> Lu=C3=ADs
>
