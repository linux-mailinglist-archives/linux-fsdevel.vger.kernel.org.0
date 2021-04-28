Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9436D744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhD1M1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhD1M1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:27:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27AC06138E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b17so7571800pgh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+P2aXNH0eb9nbOwC+3ZSOJGpMrFmuqGvb3tBbYkL2iQ=;
        b=FRQdO2BRAjmVaxozzsFaMH5w5WmPmW++6UYQNvgpLchYx5YlmtVqSpkOZ0slWc1kZe
         BUbA3xGOtAbwHzcGVfh4UrBd79skqZNFT7PqLQ+MdhbSv/mWKJiQmVx1KgE9Pj4WK5vF
         Knxq+XSQ1HXR8xXI5SHvu3VXfVxP8PseOkZctqlDQ9aGbogxDI/r/PrKQleP9iBM649m
         TjoEr/h5jAC5SGOEOvgTaFj1cY2co6xa9dd80lf6pm8nEG8rKmehNUCqLlId/dY2vHSW
         Q02H5uyaOsUZUFLqxyYmppPLzmsshujUFl76Th6/sULiTV5KeS8MKwj741ZT7FzldbYE
         6fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+P2aXNH0eb9nbOwC+3ZSOJGpMrFmuqGvb3tBbYkL2iQ=;
        b=E7X8ToRhNcLyf1rvvAOkhrDXYX6pqs4vzb4InKGSdxYvcHHyQ/5bSrpe+4GVNkeYRH
         828/gnKOvtcnrZD/asPpV7juFlnZVplIc8E3/w7kXtrXsIYdBbRermbb527KulOslWLp
         R2VbsMJhtfmyEt8xNhDJ9Mo7Rg3eD27mKkN0JKeCbKperBmgC/mh9CJJcp2WqU2Utl46
         9/XEpeiv1uRj1ZRrVxTsdm/Spz2abTI+mJRnpWQ4rSHtmejP60ZvWAdWE5oyZy3p8vjt
         s3acDPGqVcD+kff4sagMw7o7w0wrLsW4YVXLkBJ7B2fv7YUssLHKuBQJ6K9gB6AFjuFv
         pX4Q==
X-Gm-Message-State: AOAM533E//9krOFxWUpEKEFav0x9vyaPrgEZ5I3qcJg2UxdZUl4cCAeb
        d6rSba8LhnetfddmTKe4Yu5uBVkmDqg3RG31bNB8GQ==
X-Google-Smtp-Source: ABdhPJwhscR8kLfuTEGvTn/4O/MIAvSqb0LqqMK+CTgRMvudUl9u7J3Z3wLQdtDH766kaIw7iNgL+A97OnQLvYmBbBo=
X-Received: by 2002:aa7:9af7:0:b029:264:b19e:ac9c with SMTP id
 y23-20020aa79af70000b0290264b19eac9cmr27715798pfp.59.1619612818360; Wed, 28
 Apr 2021 05:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210425070752.17783-1-songmuchun@bytedance.com> <ee3903ae-7033-7608-c7ed-1f16f0359663@oracle.com>
In-Reply-To: <ee3903ae-7033-7608-c7ed-1f16f0359663@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 28 Apr 2021 20:26:21 +0800
Message-ID: <CAMZfGtVbB6YwUMg2ECpdmniQ_vt_3AwdVAuu0GdUJfzWZgQpyg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v21 0/9] Free some vmemmap pages of HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 7:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> Thanks!  I will take a look at the modifications soon.
>
> I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests =
and
> got the following warning.  We may need to special case that call to
> __prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_=
page
> as it is holding hugetlb lock with IRQs disabled.

Good catch. Thanks Mike. I will fix it in the next version. How about this:

@@ -1618,7 +1617,8 @@ static void __prep_new_huge_page(struct hstate
*h, struct page *page)

 static void prep_new_huge_page(struct hstate *h, struct page *page, int ni=
d)
 {
+       free_huge_page_vmemmap(h, page);
        __prep_new_huge_page(page);
        spin_lock_irq(&hugetlb_lock);
        __prep_account_new_huge_page(h, nid);
        spin_unlock_irq(&hugetlb_lock);
@@ -2429,6 +2429,7 @@ static int alloc_and_dissolve_huge_page(struct
hstate *h, struct page *old_page,
        if (!new_page)
                return -ENOMEM;

+       free_huge_page_vmemmap(h, new_page);
 retry:
        spin_lock_irq(&hugetlb_lock);
        if (!PageHuge(old_page)) {
@@ -2489,7 +2490,7 @@ static int alloc_and_dissolve_huge_page(struct
hstate *h, struct page *old_page,

 free_new:
        spin_unlock_irq(&hugetlb_lock);
-       __free_pages(new_page, huge_page_order(h));
+       update_and_free_page(h, new_page, false);

        return ret;
 }


>
> Sorry I missed that previously.
> --
> Mike Kravetz
>
> [ 1521.579890] ------------[ cut here ]------------
> [ 1521.581309] WARNING: CPU: 1 PID: 1046 at kernel/smp.c:884 smp_call_fun=
ction_many_cond+0x1bb/0x390
> [ 1521.583895] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv=
6 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw ip6tab=
le_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ebtable_filter ebtables 9=
p ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd=
_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq joydev crct10dif=
_pclmul snd_seq_device crc32_pclmul snd_pcm ghash_clmulni_intel snd_timer 9=
pnet_virtio snd 9pnet virtio_balloon soundcore i2c_piix4 virtio_net virtio_=
console net_failover virtio_blk failover 8139too qxl drm_ttm_helper ttm drm=
_kms_helper drm crc32c_intel serio_raw virtio_pci virtio_pci_modern_dev 813=
9cp virtio_ring mii ata_generic virtio pata_acpi
> [ 1521.598644] CPU: 1 PID: 1046 Comm: bash Not tainted 5.12.0-rc8-mm1+ #2
> [ 1521.599787] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.14.0-1.fc33 04/01/2014
> [ 1521.601259] RIP: 0010:smp_call_function_many_cond+0x1bb/0x390
> [ 1521.602232] Code: 87 75 71 01 85 d2 0f 84 c8 fe ff ff 65 8b 05 94 3d e=
9 7e 85 c0 0f 85 b9 fe ff ff 65 8b 05 f9 3a e8 7e 85 c0 0f 85 aa fe ff ff <=
0f> 0b e9 a3 fe ff ff 65 8b 05 47 33 e8 7e a9 ff ff ff 7f 0f 85 75
> [ 1521.605167] RSP: 0018:ffffc90001fcb928 EFLAGS: 00010046
> [ 1521.606049] RAX: 0000000000000000 RBX: ffffffff828a85d0 RCX: 000000000=
0000001
> [ 1521.607103] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000=
0000001
> [ 1521.608127] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffea000=
8fa6f88
> [ 1521.609144] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88823=
7d3bfc0
> [ 1521.610112] R13: dead000000000122 R14: dead000000000100 R15: ffffea000=
7bb8000
> [ 1521.611106] FS:  00007f8a11223740(0000) GS:ffff888237d00000(0000) knlG=
S:0000000000000000
> [ 1521.612231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1521.612952] CR2: 0000555e1d00a430 CR3: 000000019ef5a005 CR4: 000000000=
0370ee0
> [ 1521.614295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 1521.615539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 1521.616814] Call Trace:
> [ 1521.617241]  ? flush_tlb_one_kernel+0x20/0x20
> [ 1521.618041]  on_each_cpu_cond_mask+0x25/0x30
> [ 1521.618797]  flush_tlb_kernel_range+0xa5/0xc0
> [ 1521.619577]  vmemmap_remap_free+0x7d/0x150
> [ 1521.620319]  ? sparse_remove_section+0x80/0x80
> [ 1521.621120]  free_huge_page_vmemmap+0x2f/0x40
> [ 1521.621898]  __prep_new_huge_page+0xe/0xd0
> [ 1521.622633]  isolate_or_dissolve_huge_page+0x300/0x360
> [ 1521.623559]  isolate_migratepages_block+0x4c4/0xe20
> [ 1521.624430]  ? verify_cpu+0x100/0x100
> [ 1521.625096]  isolate_migratepages_range+0x6b/0xc0
> [ 1521.625936]  alloc_contig_range+0x220/0x3d0
> [ 1521.626729]  cma_alloc+0x1ae/0x5f0
> [ 1521.627333]  alloc_fresh_huge_page+0x67/0x190
> [ 1521.628054]  alloc_pool_huge_page+0x72/0xf0
> [ 1521.628769]  set_max_huge_pages+0x128/0x2c0
> [ 1521.629540]  __nr_hugepages_store_common+0x3d/0xb0
> [ 1521.630457]  ? _kstrtoull+0x35/0xd0
> [ 1521.631182]  nr_hugepages_store+0x73/0x80
> [ 1521.631903]  kernfs_fop_write_iter+0x127/0x1c0
> [ 1521.632698]  new_sync_write+0x11f/0x1b0
> [ 1521.633408]  vfs_write+0x26f/0x380
> [ 1521.633946]  ksys_write+0x68/0xe0
> [ 1521.634444]  do_syscall_64+0x40/0x80
> [ 1521.634914]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1521.635669] RIP: 0033:0x7f8a11313ff8
> [ 1521.636251] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 0=
0 f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [ 1521.639758] RSP: 002b:00007ffd26f79b18 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [ 1521.641118] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8a1=
1313ff8
> [ 1521.642425] RDX: 0000000000000002 RSI: 0000555e1cf94960 RDI: 000000000=
0000001
> [ 1521.643644] RBP: 0000555e1cf94960 R08: 000000000000000a R09: 00007f8a1=
13a5e80
> [ 1521.644904] R10: 000000000000000a R11: 0000000000000246 R12: 00007f8a1=
13e7780
> [ 1521.646177] R13: 0000000000000002 R14: 00007f8a113e2740 R15: 000000000=
0000002
> [ 1521.647450] irq event stamp: 10006640
> [ 1521.648103] hardirqs last  enabled at (10006639): [<ffffffff812ad02b>]=
 bad_range+0x15b/0x180
> [ 1521.649577] hardirqs last disabled at (10006640): [<ffffffff81abcea1>]=
 _raw_spin_lock_irq+0x51/0x60
> [ 1521.651194] softirqs last  enabled at (10006630): [<ffffffff810da5e2>]=
 __irq_exit_rcu+0xd2/0x100
> [ 1521.652763] softirqs last disabled at (10006625): [<ffffffff810da5e2>]=
 __irq_exit_rcu+0xd2/0x100
> [ 1521.654251] ---[ end trace 561fa19f90280f2f ]---
