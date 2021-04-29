Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F100136E3F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 06:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhD2EHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 00:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbhD2EHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:07:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC8C06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:06:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lp8so3878635pjb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tByVU2/u0h5B8qFDAlBKuUrFE57FCfDg0qzGQJyDGCk=;
        b=GzEwdUmvXMwlwPe4n+RRXiW6S75PfXanXmS5RZr+Djwzs3iXyqB2CzJvSTq4dTEg0y
         MEXb31oD4DLJrkGpBwsQ7Rk77tvJoOrqVA86Isgy7+Ba04lzqFc3SVy6J06vc4HHw5kK
         +vpn3/LBw82XnoSH5lgZCNudVDvdyROEqCtV+zmZwvDvCQ5Q3PVe61gIuUyLBQTa9gXO
         HoxLWUWsnymTKtkgBJoA2EDky9A5dY2W+lhNKU46E4mNh0y0MSsyWGkokaEpYkrias3W
         VSOtks6XHn/o8Wl89hp44JdQNessSDTCWNAcHdutfb/ZxTHSHxb+ICBI+Ii1cX9MizRp
         jBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tByVU2/u0h5B8qFDAlBKuUrFE57FCfDg0qzGQJyDGCk=;
        b=TvjYEDxWj9YhPFdPWSaXhdqk1id3k2aPSa3SRyigG/LsWAwZb/g4m87/Uu3nWgoixl
         bV9pQNtnqduQ6SxI9KWw8oJmy20+7eWrT6Cqj1OtQLL4COrjQdJLyIAF5bvzMRiDDBmm
         ZnKd/K4YsfkDDrmqGDkFU+JO87Ob9iBSSShedKFRz+1oIuNgWMvz6glFnA91xD4xuQEq
         Ve4mP2VbmP6EOqYLNQluBA3Ct8L57GxQ1gHcM8NJ3iKBe9gwN6gU62hbt+jbIy4C7NrM
         +X3lfdKmzZ4lMdHI+JzregGbxFA9hsQwc0F7jNOYUcaCTEDglwcx9MQiXHkFzvAsoqjh
         xqKw==
X-Gm-Message-State: AOAM531Zc4klRLPM+3QNojo0AhUstKQ3nPCdd7bRR2Y+gQyd9UZOEc6Q
        JsNz8e8ht7+dD2sAtVM2r4r3nElgsCRjzlLdRs2KWQ==
X-Google-Smtp-Source: ABdhPJzwQqZEhz6DE4p8vebSqPKCh6VGsrj5psCRE74y5y2SZWeln8KUIISMU/TpN/mzJr5bG4J06esgubysvxWXkTo=
X-Received: by 2002:a17:902:e54e:b029:ed:6ed2:d0ab with SMTP id
 n14-20020a170902e54eb02900ed6ed2d0abmr8026963plf.24.1619669186522; Wed, 28
 Apr 2021 21:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210425070752.17783-1-songmuchun@bytedance.com>
 <20210425070752.17783-7-songmuchun@bytedance.com> <956a52e4-3a2c-b0dc-3b5d-dd651a4aa54a@oracle.com>
In-Reply-To: <956a52e4-3a2c-b0dc-3b5d-dd651a4aa54a@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Apr 2021 12:05:49 +0800
Message-ID: <CAMZfGtVOOBWeQ0yfZikYdW_Bt1Dd+1ZR13UZK6VDnaaDAOzhkw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v21 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
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

On Thu, Apr 29, 2021 at 10:43 AM Mike Kravetz <mike.kravetz@oracle.com> wro=
te:
>
> On 4/25/21 12:07 AM, Muchun Song wrote:
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index d523a345dc86..d3abaaec2a22 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file=
 *file, unsigned long addr,
> >   *   code knows it has only reference.  All other examinations and
> >   *   modifications require hugetlb_lock.
> >   * HPG_freed - Set when page is on the free lists.
> > + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are =
freed.
> >   *   Synchronization: hugetlb_lock held for examination and modificati=
on.
> >   */
> >  enum hugetlb_page_flags {
> > @@ -532,6 +533,7 @@ enum hugetlb_page_flags {
> >       HPG_migratable,
> >       HPG_temporary,
> >       HPG_freed,
> > +     HPG_vmemmap_optimized,
> >       __NR_HPAGEFLAGS,
> >  };
> >
> > @@ -577,6 +579,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
> >  HPAGEFLAG(Migratable, migratable)
> >  HPAGEFLAG(Temporary, temporary)
> >  HPAGEFLAG(Freed, freed)
> > +HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
> >
> >  #ifdef CONFIG_HUGETLB_PAGE
> >
>
> During migration, the page->private field of the original page may be
> cleared.  This will clear all hugetlb specific flags.  Prior to this
> new flag that was OK, as the only flag which could be set during migratio=
n
> was the Temporary flag and that is transfered to the target page.

I didn't realize this when I introduce the VmemmapOptimized.
Anyway, thanks for you pointed out this. I will fix this.

>
> If VmemmapOptimized optimized flag is cleared in the original page, we
> will get an addressing exception as shown below.

Thanks for your test.

>
> We should preserve page->private with something like this:
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..128e3e4126a2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -625,7 +625,9 @@ void migrate_page_states(struct page *newpage, struct=
 page *page)
>         if (PageSwapCache(page))
>                 ClearPageSwapCache(page);
>         ClearPagePrivate(page);
> -       set_page_private(page, 0);
> +       /* page->private contains hugetlb specific flags */
> +       if (!PageHuge(page))
> +               set_page_private(page, 0);
>
>         /*
>          * If any waiters have accumulated on the new page then
>
> --
> Mike Kravetz
>
>
> [  209.568110] BUG: unable to handle page fault for address: ffffea0004a5=
a000
> [  209.569417] #PF: supervisor write access in kernel mode
> [  209.570932] #PF: error_code(0x0003) - permissions violation
> [  209.572059] PGD 23fff8067 P4D 23fff8067 PUD 23fff7067 PMD 23ffd9067 PT=
E 800000021c98e061
> [  209.573679] Oops: 0003 [#1] SMP PTI
> [  209.574410] CPU: 1 PID: 1011 Comm: bash Not tainted 5.12.0-rc8-mm1+ #3
> [  209.575730] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.14.0-1.fc33 04/01/2014
> [  209.577530] RIP: 0010:__update_and_free_page+0x58/0x2c0
> [  209.578618] Code: a3 01 00 00 49 b8 00 00 00 00 00 16 00 00 4c 89 e0 b=
f 01 00 00 00 49 b9 00 00 00 00 00 ea ff ff 4d 01 e0 49 c1 f8 06 83 c2 01 <=
48> 81 20 d4 5e ff ff 48 83 c0 40 f7 c2 ff 03 00 00 0f 84 f3 00 00
> [  209.582603] RSP: 0018:ffffc90001fdfa60 EFLAGS: 00010206
> [  209.583629] RAX: ffffea0004a5a000 RBX: 0000000000000000 RCX: 000000000=
0000009
> [  209.585148] RDX: 0000000000000081 RSI: 0000000000000200 RDI: 000000000=
0000001
> [  209.586649] RBP: ffffffff839ada30 R08: 0000000000129600 R09: ffffea000=
0000000
> [  209.588096] R10: 0000000000000001 R11: 0000000000000001 R12: ffffea000=
4a58000
> [  209.589643] R13: 0000000000000200 R14: ffffea0005ff8000 R15: ffffc9000=
1fdfba0
> [  209.591194] FS:  00007f1e50065740(0000) GS:ffff888237d00000(0000) knlG=
S:0000000000000000
> [  209.592989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  209.594222] CR2: ffffea0004a5a000 CR3: 000000018cd46004 CR4: 000000000=
0370ee0
> [  209.595762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  209.597302] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  209.598925] Call Trace:
> [  209.599496]  migrate_pages+0xd8f/0x1030
> [  209.600372]  ? trace_event_raw_event_mm_migrate_pages_start+0xa0/0xa0
> [  209.601745]  ? alloc_migration_target+0x1c0/0x1c0
> [  209.602787]  alloc_contig_range+0x1e3/0x3d0
> [  209.603718]  cma_alloc+0x1ae/0x5f0
> [  209.604486]  alloc_fresh_huge_page+0x67/0x190
> [  209.605481]  alloc_pool_huge_page+0x72/0xf0
> [  209.606423]  set_max_huge_pages+0x128/0x2c0
> [  209.607369]  __nr_hugepages_store_common+0x3d/0xb0
> [  209.608442]  ? _kstrtoull+0x35/0xd0
> [  209.609225]  nr_hugepages_store+0x73/0x80
> [  209.610140]  kernfs_fop_write_iter+0x127/0x1c0
> [  209.611162]  new_sync_write+0x11f/0x1b0
> [  209.612069]  vfs_write+0x26f/0x380
> [  209.612880]  ksys_write+0x68/0xe0
> [  209.613628]  do_syscall_64+0x40/0x80
> [  209.614456]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  209.615589] RIP: 0033:0x7f1e50155ff8
> [  209.616474] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 0=
0 f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [  209.620629] RSP: 002b:00007ffd7e3f97c8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [  209.622319] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1e5=
0155ff8
> [  209.623966] RDX: 0000000000000002 RSI: 00005585ef557960 RDI: 000000000=
0000001
> [  209.625568] RBP: 00005585ef557960 R08: 000000000000000a R09: 00007f1e5=
01e7e80
> [  209.627262] R10: 000000000000000a R11: 0000000000000246 R12: 00007f1e5=
0229780
> [  209.628916] R13: 0000000000000002 R14: 00007f1e50224740 R15: 000000000=
0000002
> [  209.630457] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv=
6 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw ip6tab=
le_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security =
nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables 9=
p ip6table_filter ip6_tables sunrpc snd_hda_codec_generic crct10dif_pclmul =
crc32_pclmul snd_hda_intel snd_intel_dspcfg ghash_clmulni_intel snd_hda_cod=
ec snd_hwdep joydev snd_hda_core snd_seq snd_seq_device snd_pcm virtio_ball=
oon snd_timer snd soundcore 9pnet_virtio i2c_piix4 9pnet virtio_blk virtio_=
console virtio_net net_failover failover 8139too qxl drm_ttm_helper ttm drm=
_kms_helper crc32c_intel serio_raw drm 8139cp mii ata_generic virtio_pci vi=
rtio_pci_modern_dev virtio_ring pata_acpi virtio
> [  209.647105] CR2: ffffea0004a5a000
> [  209.647913] ---[ end trace 48e9b007521233a7 ]---
