Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1155DF5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242303AbiF1Hb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 03:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiF1Hb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:31:26 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CAE42CDF4;
        Tue, 28 Jun 2022 00:31:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E8F3910E79AD;
        Tue, 28 Jun 2022 17:31:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o65gu-00BzSu-Sj; Tue, 28 Jun 2022 17:31:20 +1000
Date:   Tue, 28 Jun 2022 17:31:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <20220628073120.GI227878@dread.disaster.area>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrosM1+yvMYliw2l@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62baae4b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=37rDS-QxAAAA:8 a=JfrnYn6hAAAA:8
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=dHUVQ1lqhIn89_lOHA8A:9
        a=CjuIK1q_8ugA:10 a=k1Nq6YrhK2t884LQW06G:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-mm@kvack.org]

On Mon, Jun 27, 2022 at 03:16:19PM -0700, Darrick J. Wong wrote:
> On Mon, Jun 27, 2022 at 03:10:40PM +0100, Matthew Wilcox wrote:
> > On Sun, Jun 26, 2022 at 09:15:27PM -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 22, 2022 at 05:42:11PM -0700, Darrick J. Wong wrote:
> > > > [resend with shorter 522.out file to keep us under the 300k maximum]
> > > > 
> > > > On Thu, Dec 16, 2021 at 09:07:15PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > > Now that iomap has been converted, XFS is large folio safe.
> > > > > Indicate to the VFS that it can now create large folios for XFS.
> > > > > 
> > > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > >  fs/xfs/xfs_icache.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > > > > index da4af2142a2b..cdc39f576ca1 100644
> > > > > --- a/fs/xfs/xfs_icache.c
> > > > > +++ b/fs/xfs/xfs_icache.c
> > > > > @@ -87,6 +87,7 @@ xfs_inode_alloc(
> > > > >  	/* VFS doesn't initialise i_mode or i_state! */
> > > > >  	VFS_I(ip)->i_mode = 0;
> > > > >  	VFS_I(ip)->i_state = 0;
> > > > > +	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > > > >  
> > > > >  	XFS_STATS_INC(mp, vn_active);
> > > > >  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> > > > > @@ -320,6 +321,7 @@ xfs_reinit_inode(
> > > > >  	inode->i_rdev = dev;
> > > > >  	inode->i_uid = uid;
> > > > >  	inode->i_gid = gid;
> > > > > +	mapping_set_large_folios(inode->i_mapping);
> > > > 
> > > > Hmm.  Ever since 5.19-rc1, I've noticed that fsx in generic/522 now
> > > > reports file corruption after 20 minutes of runtime.  The corruption is
> > > > surprisingly reproducible (522.out.bad attached below) in that I ran it
> > > > three times and always got the same bad offset (0x6e000) and always the
> > > > same opcode (6213798(166 mod 256) MAPREAD).
> > > > 
> > > > I turned off multipage folios and now 522 has run for over an hour
> > > > without problems, so before I go do more debugging, does this ring a
> > > > bell to anyone?
> > > 
> > > I tried bisecting, but that didn't yield anything productive and
> > > 5.19-rc4 still fails after 25 minutes; however, it seems that g/522 will
> > > run without problems for at least 3-4 days after reverting this patch
> > > from -rc3.
> > > 
> > > So I guess I have a blunt force fix if we can't figure this one out
> > > before 5.19 final, but I'd really rather not.  Will keep trying this
> > > week.
> > 
> > I'm on holiday for the next week, so I'm not going to be able to spend
> > any time on this until then.  I have a suspicion that this may be the
> > same bug Zorro is seeing here:
> > 
> > https://lore.kernel.org/linux-mm/20220613010850.6kmpenitmuct2osb@zlang-mailbox/
> > 
> > At least I hope it is, and finding a folio that has been freed would
> > explain (apparent) file corruption.
> 
> Hm.  I suppose it /could/ be a lost folio getting into the works
> somewhere.
> 
> Today I remembered fsx -X, which makes this reproduce a bit faster (~3-8
> minutes instead of 20-25).  That has helped me to narrow things down a
> little more:
> 
> - Turning off INSERT/COLLAPSE_RANGE doesn't make the problem go away,
>   but it does make reading the fsx log much easier.
> 
> - Turning off clone/dedupe (either via -J -B or formatting with -m
>   reflink=0) makes the problem go away completely.  If you define
>   letting fsx run for 90 minutes as "completely".

So using this technique, I've discovered that there's a dirty page
accounting leak that eventually results in fsx hanging in
balance_dirty_pages().

[15300.670773] sysrq: Show Blocked State
[15300.672712] task:fsx             state:D stack:11600 pid: 5607 ppid:  5601 flags:0x00004004
[15300.676785] Call Trace:
[15300.678061]  <TASK>
[15300.679171]  __schedule+0x310/0x9f0
[15300.681096]  schedule+0x4b/0xb0
[15300.683385]  schedule_timeout+0x88/0x160
[15300.685407]  ? do_raw_spin_unlock+0x4b/0xa0
[15300.687567]  ? timer_migration_handler+0x90/0x90
[15300.690277]  io_schedule_timeout+0x4c/0x70
[15300.692346]  balance_dirty_pages_ratelimited+0x259/0xb60
[15300.695205]  fault_dirty_shared_page+0xef/0x100
[15300.697650]  do_wp_page+0x414/0x760
[15300.699819]  __handle_mm_fault+0xc59/0x1730
[15300.702226]  ? do_mmap+0x348/0x540
[15300.704418]  handle_mm_fault+0x7a/0x1c0
[15300.706658]  exc_page_fault+0x1da/0x780
[15300.709020]  asm_exc_page_fault+0x27/0x30

# cat /proc/meminfo
MemTotal:       16292348 kB
MemFree:        15298308 kB
MemAvailable:   15219180 kB
Buffers:           71336 kB
Cached:           209288 kB
SwapCached:            0 kB
Active:           141840 kB
Inactive:         254748 kB
Active(anon):        572 kB
Inactive(anon):   128000 kB
Active(file):     141268 kB
Inactive(file):   126748 kB
Unevictable:       12344 kB
Mlocked:           12344 kB
SwapTotal:        497976 kB
SwapFree:         497976 kB
Dirty:           2825676 kB	<<<<<<<<<
Writeback:             0 kB
AnonPages:        125072 kB
Mapped:            65592 kB
Shmem:              2128 kB
KReclaimable:      49424 kB
Slab:             110992 kB
SReclaimable:      49424 kB
SUnreclaim:        61568 kB
KernelStack:        4720 kB
PageTables:         4000 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     8644148 kB
Committed_AS:     277864 kB
VmallocTotal:   34359738367 kB
VmallocUsed:       46604 kB
VmallocChunk:          0 kB
Percpu:             5376 kB
AnonHugePages:     30720 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:       61276 kB
DirectMap2M:     6230016 kB
DirectMap1G:    29360128 kB

As you can see, the system only has 1GB of 16GB of memory used, but
it's got 2.8GB of dirty pages accounted and so any write that is
done will now hang on the dirty page throttle.

sysrq-m shows:

[15443.617242] sysrq: Show Memory
[15443.618465] Mem-Info:
[15443.619428] active_anon:143 inactive_anon:32000 isolated_anon:0
[15443.619428]  active_file:35317 inactive_file:31687 isolated_file:0
[15443.619428]  unevictable:3086 dirty:706420 writeback:0
[15443.619428]  slab_reclaimable:12356 slab_unreclaimable:15392
[15443.619428]  mapped:16398 shmem:532 pagetables:1000 bounce:0
[15443.619428]  kernel_misc_reclaimable:0
[15443.619428]  free:3825037 free_pcp:34496 free_cma:0
[15443.632592] Node 0 active_anon:152kB inactive_anon:17812kB active_file:27304kB inactive_file:19200kB unevictable:832kB isolated(anon
):0kB isolated(file):0kB mapped:8820kB dirty:632kB writeback:0kB shmem:224kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writebac
k_tmp:0kB kernel_stack:1332kB pagetables:812kB all_unreclaimable? no
[15443.643111] Node 1 active_anon:168kB inactive_anon:54348kB active_file:52160kB inactive_file:19808kB unevictable:6932kB isolated(ano
n):0kB isolated(file):0kB mapped:29512kB dirty:0kB writeback:0kB shmem:596kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 14336kB writ
eback_tmp:0kB kernel_stack:836kB pagetables:1212kB all_unreclaimable? no
[15443.653719] Node 2 active_anon:152kB inactive_anon:31780kB active_file:32604kB inactive_file:62196kB unevictable:3324kB isolated(ano
n):0kB isolated(file):0kB mapped:11560kB dirty:0kB writeback:0kB shmem:216kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 8192kB write
back_tmp:0kB kernel_stack:1268kB pagetables:1084kB all_unreclaimable? no
[15443.664282] Node 3 active_anon:100kB inactive_anon:24060kB active_file:29200kB inactive_file:25544kB unevictable:1256kB isolated(ano
n):0kB isolated(file):0kB mapped:15700kB dirty:2825048kB writeback:0kB shmem:1092kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 10240
kB writeback_tmp:0kB kernel_stack:1268kB pagetables:892kB all_unreclaimable? no
[15443.673605] Node 0 DMA free:15360kB boost:0kB min:124kB low:152kB high:180kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0
kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0
kB local_pcp:0kB free_cma:0kB
[15443.680976] lowmem_reserve[]: 0 2911 7902 7902 7902
[15443.682360] Node 0 DMA32 free:2981444kB boost:0kB min:24744kB low:30928kB high:37112kB reserved_highatomic:0KB active_anon:0kB inact
ive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129180kB managed:2986368kB mlocked:0kB bounce:
0kB free_pcp:4916kB local_pcp:0kB free_cma:0kB
[15443.689280] lowmem_reserve[]: 0 0 4990 4990 4990
[15443.690450] Node 0 Normal free:4968904kB boost:0kB min:42412kB low:53012kB high:63612kB reserved_highatomic:0KB active_anon:152kB in
active_anon:17812kB active_file:27304kB inactive_file:19200kB unevictable:832kB writepending:632kB present:5242880kB managed:5110756kB 
mlocked:832kB bounce:0kB free_pcp:41008kB local_pcp:5944kB free_cma:0kB
[15443.697102] lowmem_reserve[]: 0 0 0 0 0
[15443.697986] Node 1 Normal free:5806356kB boost:0kB min:51384kB low:64228kB high:77072kB reserved_highatomic:0KB active_anon:168kB in
active_anon:54348kB active_file:52160kB inactive_file:19808kB unevictable:6932kB writepending:0kB present:6291456kB managed:6192112kB m
locked:6932kB bounce:0kB free_pcp:68644kB local_pcp:15328kB free_cma:0kB
[15443.704154] lowmem_reserve[]: 0 0 0 0 0
[15443.705005] Node 2 Normal free:714616kB boost:0kB min:8556kB low:10692kB high:12828kB reserved_highatomic:0KB active_anon:152kB inac
tive_anon:31780kB active_file:32604kB inactive_file:62196kB unevictable:3324kB writepending:0kB present:1048576kB managed:1031152kB mlo
cked:3324kB bounce:0kB free_pcp:10904kB local_pcp:0kB free_cma:0kB
[15443.712094] lowmem_reserve[]: 0 0 0 0 0
[15443.713270] Node 3 Normal free:813468kB boost:0kB min:7936kB low:9920kB high:11904kB reserved_highatomic:0KB active_anon:100kB inact
ive_anon:24060kB active_file:29200kB inactive_file:25544kB unevictable:1256kB writepending:2825212kB present:1048576kB managed:956600kB
 mlocked:1256kB bounce:0kB free_pcp:12508kB local_pcp:388kB free_cma:0kB
[15443.721013] lowmem_reserve[]: 0 0 0 0 0
[15443.721958] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
[15443.725048] Node 0 DMA32: 3*4kB (UM) 1*8kB (M) 1*16kB (M) 1*32kB (M) 2*64kB (M) 1*128kB (M) 3*256kB (UM) 3*512kB (UM) 3*1024kB (UM) 
3*2048kB (UM) 725*4096kB (M) = 2981444kB
[15443.729512] Node 0 Normal: 1714*4kB (UME) 1504*8kB (UME) 988*16kB (UME) 562*32kB (UME) 268*64kB (UME) 96*128kB (UME) 27*256kB (UME) 
5*512kB (UM) 1*1024kB (E) 5*2048kB (UME) 1188*4096kB (M) = 4968904kB
[15443.734684] Node 1 Normal: 977*4kB (UM) 1086*8kB (UME) 406*16kB (UME) 210*32kB (UM) 133*64kB (UME) 116*128kB (UME) 37*256kB (UM) 18*
512kB (UM) 12*1024kB (UME) 2*2048kB (UM) 1397*4096kB (M) = 5806356kB
[15443.739997] Node 2 Normal: 456*4kB (UME) 307*8kB (UM) 136*16kB (UME) 138*32kB (UME) 44*64kB (UME) 10*128kB (UE) 21*256kB (UM) 12*512
kB (UM) 6*1024kB (UM) 7*2048kB (UME) 163*4096kB (UM) = 714616kB
[15443.745261] Node 3 Normal: 463*4kB (UM) 940*8kB (UM) 392*16kB (UME) 210*32kB (UME) 121*64kB (UME) 40*128kB (UME) 2*256kB (ME) 1*512k
B (U) 1*1024kB (E) 3*2048kB (UME) 188*4096kB (M) = 813468kB
[15443.750265] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[15443.752776] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[15443.755614] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[15443.758256] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[15443.761168] Node 2 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[15443.763996] Node 2 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[15443.766634] Node 3 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[15443.769423] Node 3 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[15443.772050] 70156 total pagecache pages
[15443.773364] 0 pages in swap cache
[15443.774535] Swap cache stats: add 0, delete 0, find 0/0
[15443.776213] Free swap  = 497976kB
[15443.777394] Total swap = 497976kB
[15443.778606] 4194165 pages RAM
[15443.779551] 0 pages HighMem/MovableOnly
[15443.780705] 121078 pages reserved

It is node 3 that fsx has been running on and it's the only
node that has been leaking dirty pages. Node 3 only
has 1GB of pages present, so having 2.8GB of dirty pages on the node
is just a little wrong. ZONE_NR_WRITE_PENDING, NR_FILE_DIRTY and
NR_DIRTY all match in terms of leaking dirty pages.

The reproducer for 5.19-rc4 is running fsx from fstests like so:

<create 8GB pmem/ramdisk>
mkfs.xfs -f /dev/pmem0
mount /dev/pmem0 /mnt/test
src/fstests/ltp/fsx q -N 100000000 -p 1000000 -o 128000 -l 600000 -C -I -X /mnt/test/junk

And this will leak around 300-400kB of dirty pages every second.

I suspect this is the same problem as the data corruption that
Darrick is seeing - that smells of a dirty multi-page folio that
hasn't been fully written back. e.g. a multipage folio gets marked
dirty so accounts mulitple pages dirty, but only a single page of
the folio is written and marked clean, leaking both dirty page
accounting and stale data contents on disk that fsx eventually trips
over.

I can't find a likely cause through reading the code, so maybe
someone who knows the mm accounting code better than I do can spot
the problem....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
