Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652655C4C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiF0XfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 19:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiF0XfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:35:19 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DFADF8B;
        Mon, 27 Jun 2022 16:35:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3767D5ED512;
        Tue, 28 Jun 2022 09:35:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o5yGB-00BrO7-Sf; Tue, 28 Jun 2022 09:35:15 +1000
Date:   Tue, 28 Jun 2022 09:35:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 25/25] xfs: Support large folios
Message-ID: <20220627233515.GG227878@dread.disaster.area>
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
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62ba3eb5
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=Tx_KuMWrBpQ_Xf1fj60A:9 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
> 
> - Neutering vfs_dedupe_file_range_compare by replacing it with an -EBADE
>   return doesn't affect the reproducibility, so it's not the comparison
>   function misbehaving.
> - I modified fsx.c so that when there's file corruption, it'll report
>   both the first 16 bytes of corruption as well as every corruption that
>   happens on a page boundary.
> 
> - I also modified run_fsx() to diff the good and junk files, and
>   complain about any corruption happening on a page boundary.  Now I see
>   things like this:
> 
> 2153984(  0 mod 256): SKIPPED (no operation)
> 2153985(  1 mod 256): DEDUPE 0xf000 thru 0x23fff        (0x15000 bytes) to 0x2a000 thru 0x3efff ******BBBB
> 2153986(  2 mod 256): COPY 0xe794 thru 0x2ae41  (0x1c6ae bytes) to 0x60ac4 thru 0x7d171
> 2153987(  3 mod 256): TRUNCATE DOWN     from 0x7d172 to 0x535da
> 2153988(  4 mod 256): SKIPPED (no operation)
> 2153989(  5 mod 256): MAPREAD  0x40b93 thru 0x535d9     (0x12a47 bytes)
> 2153990(  6 mod 256): COPY 0x5edd thru 0x20282  (0x1a3a6 bytes) to 0x3a9aa thru 0x54d4f
> 2153991(  7 mod 256): SKIPPED (no operation)
> 2153992(  8 mod 256): SKIPPED (no operation)
> 2153993(  9 mod 256): ZERO     0x542d3 thru 0x67006     (0x12d34 bytes)
> 2153994( 10 mod 256): COPY 0x42cf6 thru 0x538a7 (0x10bb2 bytes) to 0x23fe7 thru 0x34b98 ******EEEE
> 2153995( 11 mod 256): MAPWRITE 0x5a1fc thru 0x6b067     (0x10e6c bytes)
> 2153996( 12 mod 256): SKIPPED (no operation)
> 2153997( 13 mod 256): CLONE 0x38000 thru 0x38fff        (0x1000 bytes) to 0x77000 thru 0x77fff
> 2153998( 14 mod 256): FALLOC   0x49bdd thru 0x62a55     (0x18e78 bytes) INTERIOR
> 2153999( 15 mod 256): CLONE 0xf000 thru 0x1bfff (0xd000 bytes) to 0x2c000 thru 0x38fff  ******JJJJ
> Log of operations saved to "/mnt/junk.fsxops"; replay with --replay-ops
> Correct content saved for comparison
> (maybe hexdump "/mnt/junk" vs "/mnt/junk.fsxgood")
> junk file 177
> -02e000  ec  20  ec  5a  ec  78  ec  b2  ec  e6  ec  1e  ec  43  ec  0f
> -02f000  ec  30  ec  32  ec  4c  ec  ac  ec  5c  ec  d2  ec  62  ec  d3
> -030000  ec  73  ec  ce  ec  8c  ec  cb  ec  94  ec  59  ec  81  ec  34
> +02e000  77  db  f1  db  ba  db  01  db  d5  db  9c  db  4d  db  de  db
> +02f000  b3  d8  35  d8  e2  d8  bb  d8  a4  d8  c8  d8  5b  d8  83  d8
> +030000  23  d8  c8  d8  22  d8  da  d8  97  d8  e0  d8  7e  d8  61  d8
> 
> When I remount the test filesystem, I see further corruption:
> 
> $ diff -Naurp <(od -tx1 -Ax -c $TEST_DIR/junk.fsxgood) <(od -tx1 -Ax -c $TEST_DIR/junk) | grep '^[+-]0..000'
> -011000  ec  20  ec  5a  ec  78  ec  b2  ec  e6  ec  1e  ec  43  ec  0f
> -012000  ec  30  ec  32  ec  4c  ec  ac  ec  5c  ec  d2  ec  62  ec  d3
> -013000  ec  73  ec  ce  ec  8c  ec  cb  ec  94  ec  59  ec  81  ec  34
> +011000  77  db  f1  db  ba  db  01  db  d5  db  9c  db  4d  db  de  db
> +012000  b3  d8  35  d8  e2  d8  bb  d8  a4  d8  c8  d8  5b  d8  83  d8
> +013000  23  d8  c8  d8  22  d8  da  d8  97  d8  e0  d8  7e  d8  61  d8
> -02e000  ec  20  ec  5a  ec  78  ec  b2  ec  e6  ec  1e  ec  43  ec  0f
> -02f000  ec  30  ec  32  ec  4c  ec  ac  ec  5c  ec  d2  ec  62  ec  d3
> -030000  ec  73  ec  ce  ec  8c  ec  cb  ec  94  ec  59  ec  81  ec  34
> +02e000  77  db  f1  db  ba  db  01  db  d5  db  9c  db  4d  db  de  db
> +02f000  b3  d8  35  d8  e2  d8  bb  d8  a4  d8  c8  d8  5b  d8  83  d8
> +030000  23  d8  c8  d8  22  d8  da  d8  97  d8  e0  d8  7e  d8  61  d8
> 
> This is really quite strange!  The same corruption patterns we saw at
> pages 0x2e - 0x30 now appear at 0x11-0x13 after the remount!

Hmmmm - look at what the last operation before failure
does - it clones 0xf000-0x1bfff to 0x2c000-0x38fff. IOWs, those
ranges *should* be identical and the the corruption is actually
occuring at 0x11000-0x13fff. It's not until that range gets cloned
to 0x2e000-0x30fff that the corruption is detected.

So we're looking in the wrong spot for the page cache corruption -
we need to be looking at operations over the range 0x11000-0x13fff
for misbehaviour, not where fsx detected the corrupt data.

> By comparison, the junk.fsxgood file only contains this 77/db/f1
> sequence at:
> 
> $ od -tx1 -Ax -c $TEST_DIR/junk.fsxgood | grep '77  db  f1'
> 008530  db  34  db  77  db  f1  db  ba  db  01  db  d5  db  9c  db  4d
> 03d000  77  db  f1  db  ba  db  01  db  d5  db  9c  db  4d  db  de  db
> 
> Curiously, the same byte trios at 0x2f000 and 0x30000 have similar
> repetitions at similar looking offsets:
> 
> $ od -tx1 -Ax -c $TEST_DIR/junk.fsxgood | grep 'b3  d8  35'
> 009530  d8  bb  d8  b3  d8  35  d8  e2  d8  bb  d8  a4  d8  c8  d8  5b
> 03e000  b3  d8  35  d8  e2  d8  bb  d8  a4  d8  c8  d8  5b  d8  83  d8
> $ od -tx1 -Ax -c $TEST_DIR/junk.fsxgood | grep '23  d8  c8'
> 00a530  d8  f5  d8  23  d8  c8  d8  22  d8  da  d8  97  d8  e0  d8  7e
> 03f000  23  d8  c8  d8  22  d8  da  d8  97  d8  e0  d8  7e  d8  61  d8
> 
> Though the only pattern that happens consistently is that garbage bytes
> end up at the reflink dest, and later at the reflink source.  I never
> see any VM_BUG_ON_FOLIO asserts, nor does KASAN report anything.

Smells like the page cache over the clone source is not getting
marked dirty and/or flushed to disk correctly before the clone is
run. It then shares the extent with stale data to the new location
(the destination) which then fails the contents validation.

Do we have a case where we are only writing back the head page of
the multipage folio?

> I also added a debug function to dump the folios it finds in the
> pagecache for the fsx junk file, but nothing looks odd:
> 
>      522-5099  [001]   491.954659: console:              [U] FSX FAILURE
>   xfs_io-5125  [002]   491.961232: console:              XFS (sda): EXPERIMENTAL online scrub feature in use. Use at your own risk!
>   xfs_io-5125  [002]   491.961238: bprint:               filemap_dump: ino 0xb1 pos 0x0 pfn 0x515cc order 0
>   xfs_io-5125  [002]   491.961238: bprint:               filemap_dump: ino 0xb1 pos 0x1000 pfn 0x515cd order 0
>   xfs_io-5125  [002]   491.961239: bprint:               filemap_dump: ino 0xb1 pos 0x2000 pfn 0x515ce order 0
>   xfs_io-5125  [002]   491.961239: bprint:               filemap_dump: ino 0xb1 pos 0x3000 pfn 0x515cf order 0
>   xfs_io-5125  [002]   491.961239: bprint:               filemap_dump: ino 0xb1 pos 0x4000 pfn 0x50c48 order 0
>   xfs_io-5125  [002]   491.961240: bprint:               filemap_dump: ino 0xb1 pos 0x5000 pfn 0x50c49 order 0
>   xfs_io-5125  [002]   491.961240: bprint:               filemap_dump: ino 0xb1 pos 0x6000 pfn 0x50c4a order 0
>   xfs_io-5125  [002]   491.961241: bprint:               filemap_dump: ino 0xb1 pos 0x7000 pfn 0xc8a8 order 0
>   xfs_io-5125  [002]   491.961241: bprint:               filemap_dump: ino 0xb1 pos 0x8000 pfn 0x50988 order 2
>   xfs_io-5125  [002]   491.961241: bprint:               filemap_dump: ino 0xb1 pos 0xc000 pfn 0x509e0 order 2
>   xfs_io-5125  [002]   491.961242: bprint:               filemap_dump: ino 0xb1 pos 0x10000 pfn 0x4db64 order 2

So this is the folio that likely has the problem (the source)...

>   xfs_io-5125  [002]   491.961242: bprint:               filemap_dump: ino 0xb1 pos 0x14000 pfn 0x50c4c order 0
>   xfs_io-5125  [002]   491.961243: bprint:               filemap_dump: ino 0xb1 pos 0x15000 pfn 0x12485 order 0
>   xfs_io-5125  [002]   491.961243: bprint:               filemap_dump: ino 0xb1 pos 0x16000 pfn 0x50c4d order 0
>   xfs_io-5125  [002]   491.961243: bprint:               filemap_dump: ino 0xb1 pos 0x17000 pfn 0x50c4e order 0
>   xfs_io-5125  [002]   491.961244: bprint:               filemap_dump: ino 0xb1 pos 0x18000 pfn 0x4eef8 order 2
>   xfs_io-5125  [002]   491.961244: bprint:               filemap_dump: ino 0xb1 pos 0x1c000 pfn 0x4eefc order 2
>   xfs_io-5125  [002]   491.961245: bprint:               filemap_dump: ino 0xb1 pos 0x20000 pfn 0x4eef0 order 2
>   xfs_io-5125  [002]   491.961245: bprint:               filemap_dump: ino 0xb1 pos 0x24000 pfn 0x50f2c order 2
>   xfs_io-5125  [002]   491.961245: bprint:               filemap_dump: ino 0xb1 pos 0x28000 pfn 0x50f28 order 2
>   xfs_io-5125  [002]   491.961246: bprint:               filemap_dump: ino 0xb1 pos 0x2c000 pfn 0x50f24 order 2

... not the one at the destination here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
