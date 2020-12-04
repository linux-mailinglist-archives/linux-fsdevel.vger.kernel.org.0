Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBF2CEECE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 14:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgLDNey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 08:34:54 -0500
Received: from simcoe209srvr.owm.bell.net ([184.150.200.209]:40029 "EHLO
        torfep08.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728781AbgLDNey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:34:54 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 08:34:53 EST
Received: from bell.net torfep01 184.150.200.158 by torfep01.bell.net
          with ESMTP
          id <20201204132847.RSVT6892.torfep01.bell.net@torspm01.bell.net>;
          Fri, 4 Dec 2020 08:28:47 -0500
Received: from [192.168.2.49] (really [67.70.16.145]) by torspm01.bell.net
          with ESMTP
          id <20201204132847.HJEQ29322.torspm01.bell.net@[192.168.2.49]>;
          Fri, 4 Dec 2020 08:28:47 -0500
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
To:     Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm@lists.01.org
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
 <20201204034843.GM11935@casper.infradead.org>
 <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
 <20201204124402.GN11935@casper.infradead.org>
From:   John David Anglin <dave.anglin@bell.net>
Message-ID: <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
Date:   Fri, 4 Dec 2020 08:28:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204124402.GN11935@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=ZryT1OzG c=1 sm=1 tr=0 a=ch4VMz8uGZlcRCFa+4Q1bQ==:117 a=ch4VMz8uGZlcRCFa+4Q1bQ==:17 a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=FBHGMhGWAAAA:8 a=ybeIS4x6i_o_-C6kCnkA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfKtNUfRu/DXyTZPn7Pfd4YNoPaiTiBDkNP5Ayf+Vk7AF/O6TOTxeU/Kkq3dDtqHlLw5SfwdBEGtzfi1ydnG/NlGna3I0WQGkBu/HR1Z1quyVYE9sP7uO HQSDprhtoujUIHlBE3sVHIYiDcd8Vh5sQq8RAzLu9Tv1lOC53OeT5jXvEjSQL5s5CY01vITkQu/jsf1uc8aIIuPDbHAAg+kZla+Egk9JWOtBgkh2vuAkz7Vu
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-12-04 7:44 a.m., Matthew Wilcox wrote:
> You'll
> still need to allocate them separately if various debugging options
> are enabled (see the ALLOC_SPLIT_PTLOCKS for details), but usually
> this will save you a lot of memory.
We need all we can get:
(.mlocate): page allocation failure: order:5, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
CPU: 2 PID: 28271 Comm: (.mlocate) Not tainted 5.9.11+ #1
Hardware name: 9000/800/rp3440
Backtrace:
 [<000000004018d050>] show_stack+0x50/0x70
 [<0000000040826354>] dump_stack+0xbc/0x130
 [<000000004033dc14>] warn_alloc+0x144/0x1e0
 [<000000004033e930>] __alloc_pages_slowpath.constprop.0+0xc80/0xcf8
 [<000000004033ec48>] __alloc_pages_nodemask+0x2a0/0x2f0
 [<0000000040351a2c>] cache_alloc_refill+0x6b4/0xe50
 [<000000004035416c>] __kmalloc+0x5e4/0x740
 [<00000000040ddbe8>] nfsd_reply_cache_init+0x1d0/0x360 [nfsd]
 [<00000000040d1118>] nfsd_init_net+0xb0/0x1c0 [nfsd]
 [<00000000406a5860>] ops_init+0x68/0x178
 [<00000000406a5b24>] setup_net+0x1b4/0x348
 [<00000000406a6e20>] copy_net_ns+0x1f0/0x450
 [<00000000401e6578>] create_new_namespaces+0x1b0/0x418
 [<00000000401e72ac>] unshare_nsproxy_namespaces+0x8c/0xf0
 [<00000000401b6acc>] ksys_unshare+0x1bc/0x440
 [<00000000401b6d70>] sys_unshare+0x20/0x38
 [<0000000040188018>] syscall_exit+0x0/0x14

Mem-Info:
active_anon:1209957 inactive_anon:438171 isolated_anon:0
 active_file:38971 inactive_file:21741 isolated_file:0
 unevictable:4662 dirty:144 writeback:0
 slab_reclaimable:45748 slab_unreclaimable:51548
 mapped:34940 shmem:1471859 pagetables:5429 bounce:0
 free:213676 free_pcp:317 free_cma:0
Node 0 active_anon:4839828kB inactive_anon:1753200kB active_file:155884kB inactive_file:86964kB unevictable:18648kB isolated(anon):0kB
isolated(file):0kB mapped:139760kB dirty:576kB writeback:0kB shmem:5887436kB writeback_tmp:0kB kernel_stack:6032kB all_unreclaimable? no
Normal free:853948kB min:11448kB low:19636kB high:27824kB reserved_highatomic:0KB active_anon:4839828kB inactive_anon:1753544kB
active_file:155884kB inactive_file:86964kB unevictable:18648kB writepending:576kB present:8386560kB managed:8211756kB mlocked:18648kB
pagetables:21716kB bounce:0kB free_pcp:1168kB local_pcp:352kB free_cma:0kB
lowmem_reserve[]: 0 0
Normal: 58860*4kB (UME) 48155*8kB (UME) 11414*16kB (UME) 1291*32kB (UME) 134*64kB (UME) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
853192kB
1607717 total pagecache pages
73822 pages in swap cache
Swap cache stats: add 21252454, delete 21178083, find 5702723/6815498
Free swap  = 33742652kB
Total swap = 49758652kB
2096640 pages RAM
0 pages HighMem/MovableOnly
43701 pages reserved

Cheers,
Dave

-- 
John David Anglin  dave.anglin@bell.net

