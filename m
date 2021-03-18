Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208F0340415
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCRLAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCRLAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:00:11 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124EFC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 04:00:11 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id v2so1292431vsq.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yza6FhjNdtmeV50aIjvxI7XnHlJa+t3SPqBpsPkBArg=;
        b=qMdONW3XH7Q+PKUbYV5kPXZIzM9BLr+uLmU1rnIN9fR4ucvPh6fi27TMS33kbtKGJy
         WF2vyMVKy0Z6G/nxBEFErH2cKpvEnt3BUqOc552dwd5EboYhvTKNyD7frzllyjQGOlK1
         xvl9ECmICc33TbGJx36d4t9t9xNnWzgNwnfMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yza6FhjNdtmeV50aIjvxI7XnHlJa+t3SPqBpsPkBArg=;
        b=Kv24GM9dZsTouvt1V2594IfYF2Kty4E0LMqDuor0heHdA824rAhmGKkudb5RuCPg78
         VcW5880dw5TZRfRN9Oh0WzJWINIFohqiJFwR9G7Ehd3fwL5rS+ivh0fdwL1wLEv94pFD
         9/VWEHY31msKkiUHIkgBaeN83/VkH9xA8Gkxsd3Hsujvge3crfY8JJamPbbiyGGc5naD
         VD0D2ZjP4tdHLkHS8vOJ/g9an2LIjMUzi315lPYXjzCpm4RXtgrSl2wzdIHmJ9lHSe/Z
         4c/xTHNE3QF8WMmfe665EkfwvSuzzd8EODhqmxIBgZCeTBOupc8qdrY+zONK87V3+Elr
         +Vew==
X-Gm-Message-State: AOAM533s2F+030rb/4p2FVC04+o3nDs+tT0zYEAab1qRJdmsKe3GAyOI
        e2xv7CwqUqll2mzGaFOVGQ3llBepn13F4m+S4A4LqAoxpUE=
X-Google-Smtp-Source: ABdhPJxkpf2q3FFx52kdJiktteKxgcl5EQXZK6JKdjqihQT42eN2qmc5Ne+m7hPqfMNR1a05XzdfVfKjXwtifBD+dzw=
X-Received: by 2002:a67:8793:: with SMTP id j141mr6614191vsd.7.1616065210164;
 Thu, 18 Mar 2021 04:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <YEsryBEFq4HuLKBs@suse.de> <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de> <20210312131123.GZ3479805@casper.infradead.org>
 <YE8tQc66C6MW7EqY@suse.de> <20210315110659.GT2577561@casper.infradead.org> <YFMct4z1gEa8tXkh@suse.de>
In-Reply-To: <YFMct4z1gEa8tXkh@suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Mar 2021 11:59:59 +0100
Message-ID: <CAJfpeguX7NrdTH4JLbCtkQ1u7TFvUh+8s7RmwB_wmuPHJsQyiA@mail.gmail.com>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC linux-mm]

On Thu, Mar 18, 2021 at 10:25 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> (I thought Vlastimil was already on CC...)
>
> On Mon, Mar 15, 2021 at 11:06:59AM +0000, Matthew Wilcox wrote:
> > On Mon, Mar 15, 2021 at 09:47:45AM +0000, Luis Henriques wrote:
> > > On Fri, Mar 12, 2021 at 01:11:23PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Mar 12, 2021 at 12:21:59PM +0000, Luis Henriques wrote:
> > > > > > > I've seen a bug report (5.10.16 kernel splat below) that seem=
s to be
> > > > > > > reproducible in kernels as early as 5.4.
> > > >
> > > > If this is reproducible, can you turn this BUG_ON into a VM_BUG_ON_=
PAGE()
> > > > so we know what kind of problem we're dealing with?  Assuming the S=
USE
> > > > tumbleweed kernels enable CONFIG_DEBUG_VM, which I'm sure they do.
> > >
> > > Just to make sure I got this right, you want to test something like t=
his:
> > >
> > >                             }
> > >                     }
> > > -                   BUG_ON(page_mapped(page));
> > > +                   VM_BUG_ON_PAGE(page_mapped(page), page);
> > >                     ret2 =3D do_launder_page(mapping, page);
> > >                     if (ret2 =3D=3D 0) {
> > >                             if (!invalidate_complete_page2(mapping, p=
age))
> >
> > Yes, exactly.
>
> Ok, finally I got some feedback from the bug reporter.  Please see bellow
> the kernel log with the VM_BUG_ON_PAGE() in place.  Also note that this i=
s
> on a 5.12-rc3, vanilla.
>
> Cheers,
> --
> Lu=C3=ADs
>
> [16247.536348] page:00000000dfe36ab1 refcount:673 mapcount:0 mapping:0000=
0000f982a7f8 index:0x1400 pfn:0x4c65e00
> [16247.536359] head:00000000dfe36ab1 order:9 compound_mapcount:0 compound=
_pincount:0

This is a compound page alright.   Have no idea how it got into fuse's
pagecache.


> [16247.536361] memcg:ffff8e730012b000
> [16247.536364] aops:fuse_file_aops [fuse] ino:8b8 dentry name:"cc1plus"
> [16247.536379] flags: 0xaffff800010037(locked|referenced|uptodate|lru|act=
ive|head)
> [16247.536385] raw: 00affff800010037 ffffd6519ed9c448 ffffd651abea5b08 ff=
ff8eb2f9a02ef8
> [16247.536388] raw: 0000000000001400 0000000000000000 000002a1ffffffff ff=
ff8e730012b000
> [16247.536389] page dumped because: VM_BUG_ON_PAGE(page_mapped(page))
> [16247.536399] ------------[ cut here ]------------
> [16247.536400] kernel BUG at mm/truncate.c:678!
> [16247.536406] invalid opcode: 0000 [#1] SMP PTI
> [16247.536416] CPU: 42 PID: 2063761 Comm: g++ Not tainted 5.12.0-rc3-1.g0=
08d601-default #1 openSUSE Tumbleweed (unreleased)
> [16247.536423] Hardware name: Supermicro X11DPi-N(T)/X11DPi-N, BIOS 3.1a =
10/16/2019
> [16247.536427] RIP: 0010:invalidate_inode_pages2_range+0x3b4/0x550
> [16247.536436] Code: 00 00 00 4c 89 e6 e8 eb 0f 03 00 4c 89 ff e8 63 40 0=
1 00 84 c0 0f 84 23 fe ff ff 48 c7 c6 d0 1d f4 b1 4c 89 ff e8 ec 82 02 00 <=
0f> 0b 48 8b 45 78 48 8b 80 80 00 00 00 48 85 c0 0f 84 fb fe ff ff
> [16247.536444] RSP: 0000:ffffa18cb0af7a40 EFLAGS: 00010246
> [16247.536450] RAX: 0000000000000036 RBX: 000000000000000d RCX: ffff8ef13=
fc9a748
> [16247.536455] RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8ef13=
fc9a740
> [16247.536460] RBP: ffff8eb2f9a02ef8 R08: ffff8ef23ffb48a8 R09: 000000000=
004fffb
> [16247.536464] R10: 00000000ffff0000 R11: 3fffffffffffffff R12: 000000000=
0001400
> [16247.536468] R13: ffff8eb2f9a02f00 R14: 0000000000000000 R15: ffffd651b=
1978000
> [16247.536473] FS:  00007f97c1717740(0000) GS:ffff8ef13fc80000(0000) knlG=
S:0000000000000000
> [16247.536478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16247.536483] CR2: 00007fd48a25a7c0 CR3: 00000040aa3ac006 CR4: 000000000=
07706e0
> [16247.536487] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [16247.536491] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [16247.536495] PKRU: 55555554
> [16247.536498] Call Trace:
> [16247.536506]  fuse_finish_open+0x82/0x150 [fuse]
> [16247.536520]  fuse_open_common+0x1a8/0x1b0 [fuse]
> [16247.536530]  ? fuse_open_common+0x1b0/0x1b0 [fuse]
> [16247.536540]  do_dentry_open+0x14e/0x380
> [16247.536547]  path_openat+0xaf6/0x10a0
> [16247.536555]  do_filp_open+0x88/0x130
> [16247.536560]  ? security_prepare_creds+0x6d/0x90
> [16247.536566]  ? __kmalloc+0x157/0x2e0
> [16247.536575]  do_open_execat+0x6d/0x1a0
> [16247.536581]  bprm_execve+0x128/0x660
> [16247.536587]  do_execveat_common+0x192/0x1c0
> [16247.536593]  __x64_sys_execve+0x39/0x50
> [16247.536599]  do_syscall_64+0x33/0x80
> [16247.536606]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [16247.536614] RIP: 0033:0x7f97c0efec37
> [16247.536621] Code: Unable to access opcode bytes at RIP 0x7f97c0efec0d.
> [16247.536625] RSP: 002b:00007ffdc2fdea68 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000003b
> [16247.536631] RAX: ffffffffffffffda RBX: 00007f97c17176a0 RCX: 00007f97c=
0efec37
> [16247.536635] RDX: 0000000000ea42c0 RSI: 0000000000ea5848 RDI: 000000000=
0ea5d00
> [16247.536639] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000=
0000000
> [16247.536643] R10: 00007ffdc2fdde60 R11: 0000000000000202 R12: 000000000=
0000000
> [16247.536647] R13: 0000000000000001 R14: 0000000000ea5d00 R15: 000000000=
0000000
> [16247.536653] Modules linked in: overlay rpcsec_gss_krb5 nfsv4 dns_resol=
ver nfsv3 nfs fscache iscsi_ibft iscsi_boot_sysfs rfkill dmi_sysfs intel_ra=
pl_msr intel_rapl_common joydev isst_if_common ipmi_ssif i40iw ib_uverbs iT=
CO_wdt intel_pmc_bxt skx_edac ib_core hid_generic iTCO_vendor_support nfit =
libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel acpi_ipm=
i kvm usbhid i2c_i801 mei_me i40e irqbypass efi_pstore pcspkr ipmi_si ioatd=
ma i2c_smbus lpc_ich mei intel_pch_thermal dca ipmi_devintf ipmi_msghandler=
 tiny_power_button acpi_pad button nls_iso8859_1 nls_cp437 vfat fat nfsd nf=
s_acl auth_rpcgss lockd grace sunrpc fuse configfs nfs_ssc ast i2c_algo_bit=
 drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fo=
ps cec rc_core drm_ttm_helper ttm xhci_pci xhci_pci_renesas drm xhci_hcd cr=
ct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel cr=
ypto_simd cryptd usbcore wmi sg br_netfilter bridge stp llc dm_multipath dm=
_mod scsi_dh_rdac scsi_dh_emc
> [16247.536758]  scsi_dh_alua msr efivarfs
> [16247.536800] ---[ end trace e1493f55bf5b3a34 ]---
> [16247.544126] RIP: 0010:invalidate_inode_pages2_range+0x3b4/0x550
> [16247.544140] Code: 00 00 00 4c 89 e6 e8 eb 0f 03 00 4c 89 ff e8 63 40 0=
1 00 84 c0 0f 84 23 fe ff ff 48 c7 c6 d0 1d f4 b1 4c 89 ff e8 ec 82 02 00 <=
0f> 0b 48 8b 45 78 48 8b 80 80 00 00 00 48 85 c0 0f 84 fb fe ff ff
> [16247.544148] RSP: 0000:ffffa18cb0af7a40 EFLAGS: 00010246
> [16247.544153] RAX: 0000000000000036 RBX: 000000000000000d RCX: ffff8ef13=
fc9a748
> [16247.544158] RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8ef13=
fc9a740
> [16247.544162] RBP: ffff8eb2f9a02ef8 R08: ffff8ef23ffb48a8 R09: 000000000=
004fffb
> [16247.544166] R10: 00000000ffff0000 R11: 3fffffffffffffff R12: 000000000=
0001400
> [16247.544170] R13: ffff8eb2f9a02f00 R14: 0000000000000000 R15: ffffd651b=
1978000
> [16247.544175] FS:  00007f97c1717740(0000) GS:ffff8ef13fc80000(0000) knlG=
S:0000000000000000
> [16247.544180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16247.544184] CR2: 00007f97c0efec0d CR3: 00000040aa3ac006 CR4: 000000000=
07706e0
> [16247.544188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [16247.544191] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [16247.544194] PKRU: 55555554
> [16247.546763] BUG: Bad rss-counter state mm:00000000060c94f4 type:MM_ANO=
NPAGES val:8
>
>
