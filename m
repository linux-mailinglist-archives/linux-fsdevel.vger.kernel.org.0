Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC3D3689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfJKAvq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:51:46 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:39064 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfJKAvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:51:46 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9B0pBnx016584
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Oct 2019 09:51:11 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B0pBfK003066;
        Fri, 11 Oct 2019 09:51:11 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B0lS0v017680;
        Fri, 11 Oct 2019 09:51:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9357223; Fri, 11 Oct 2019 09:50:44 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Fri,
 11 Oct 2019 09:50:43 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@kernel.org>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
Thread-Topic: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
Thread-Index: AQHVfoGmAHSAUTUjNku3uhYTH+YfcKdRe/+AgAFpK4CAARfIAIAACvsA
Date:   Fri, 11 Oct 2019 00:50:42 +0000
Message-ID: <20191011005042.GB18881@hori.linux.bs1.fc.nec.co.jp>
References: <20191009091205.11753-1-david@redhat.com>
 <20191009095721.GC20971@hori.linux.bs1.fc.nec.co.jp>
 <f0fcdacc-814b-49d6-78da-beeb1fa6b67a@redhat.com>
 <20191011001124.GA17127@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20191011001124.GA17127@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <C906FA97E3E9614092242F83586789D8@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:11:25AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> On Thu, Oct 10, 2019 at 09:30:01AM +0200, David Hildenbrand wrote:
> > On 09.10.19 11:57, Naoya Horiguchi wrote:
> > > Hi David,
> > > 
> > > On Wed, Oct 09, 2019 at 11:12:04AM +0200, David Hildenbrand wrote:
> > >> There are various places where we access uninitialized memmaps, namely:
> > >> - /proc/kpagecount
> > >> - /proc/kpageflags
> > >> - /proc/kpagecgroup
> > >> - memory_failure() - which reuses stable_page_flags() from fs/proc/page.c
> > > 
> > > Ah right, memory_failure is another victim of this bug.
> > > 
> > >>
> > >> We have initialized memmaps either when the section is online or when
> > >> the page was initialized to the ZONE_DEVICE. Uninitialized memmaps contain
> > >> garbage and in the worst case trigger kernel BUGs, especially with
> > >> CONFIG_PAGE_POISONING.
> > >>
> > >> For example, not onlining a DIMM during boot and calling /proc/kpagecount
> > >> with CONFIG_PAGE_POISONING:
> > >> :/# cat /proc/kpagecount > tmp.test
> > >> [   95.600592] BUG: unable to handle page fault for address: fffffffffffffffe
> > >> [   95.601238] #PF: supervisor read access in kernel mode
> > >> [   95.601675] #PF: error_code(0x0000) - not-present page
> > >> [   95.602116] PGD 114616067 P4D 114616067 PUD 114618067 PMD 0
> > >> [   95.602596] Oops: 0000 [#1] SMP NOPTI
> > >> [   95.602920] CPU: 0 PID: 469 Comm: cat Not tainted 5.4.0-rc1-next-20191004+ #11
> > >> [   95.603547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
> > >> [   95.604521] RIP: 0010:kpagecount_read+0xce/0x1e0
> > >> [   95.604917] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 e7 48 c1 e7 06 48 03 3d ab 51 01 01 74 1d 48 8b 57 08 480
> > >> [   95.606450] RSP: 0018:ffffa14e409b7e78 EFLAGS: 00010202
> > >> [   95.606904] RAX: fffffffffffffffe RBX: 0000000000020000 RCX: 0000000000000000
> > >> [   95.607519] RDX: 0000000000000001 RSI: 00007f76b5595000 RDI: fffff35645000000
> > >> [   95.608128] RBP: 00007f76b5595000 R08: 0000000000000001 R09: 0000000000000000
> > >> [   95.608731] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
> > >> [   95.609327] R13: 0000000000020000 R14: 00007f76b5595000 R15: ffffa14e409b7f08
> > >> [   95.609924] FS:  00007f76b577d580(0000) GS:ffff8f41bd400000(0000) knlGS:0000000000000000
> > >> [   95.610599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> [   95.611083] CR2: fffffffffffffffe CR3: 0000000078960000 CR4: 00000000000006f0
> > >> [   95.611686] Call Trace:
> > >> [   95.611906]  proc_reg_read+0x3c/0x60
> > >> [   95.612228]  vfs_read+0xc5/0x180
> > >> [   95.612505]  ksys_read+0x68/0xe0
> > >> [   95.612785]  do_syscall_64+0x5c/0xa0
> > >> [   95.613092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >>
> > >> Note that there are still two possible races as far as I can see:
> > >> - pfn_to_online_page() succeeding but the memory getting offlined and
> > >>   removed. get_online_mems() could help once we run into this.
> > >> - pfn_zone_device() succeeding but the memmap not being fully
> > >>   initialized yet. As the memmap is initialized outside of the memory
> > >>   hoptlug lock, get_online_mems() can't help.
> > >>
> > >> Let's keep the existing interfaces working with ZONE_DEVICE memory. We
> > >> can later come back and fix these rare races and eventually speed-up the
> > >> ZONE_DEVICE detection.
> > > 
> > > Actually, Toshiki is writing code to refactor and optimize the pfn walking
> > > part, where we find the pfn ranges covered by zone devices by running over
> > > xarray pgmap_array and use the range info to reduce pointer dereferences
> > > to speed up pfn walk. I hope he will share it soon.
> > 
> > AFAIKT, Michal is not a friend of special-casing PFN walkers in that
> > way. We should have a mechanism to detect if a memmap was initialized
> > without having to go via pgmap, special-casing. See my other mail where
> > I draft one basic approach.
> 
> OK, so considering your v2 approach, we could have another pfn_to_page()
> variant like pfn_to_zone_device_page(), where we check that a given pfn
> belongs to the memory section backed by zone memory, then another check if
> the pfn has initialized memmap or not, and return NULL if memmap not
> initialied.  We'll try this approach then, but if you find problems/concerns,
> please let me know.

Sorry, you already mentioned detail here,
https://lore.kernel.org/lkml/c6198acd-8ff7-c40c-cb4e-f0f12f841b38@redhat.com/
