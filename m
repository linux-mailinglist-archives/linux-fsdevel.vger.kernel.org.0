Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97B70A85C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjETNfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETNfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 09:35:37 -0400
Received: from out28-45.mail.aliyun.com (out28-45.mail.aliyun.com [115.124.28.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2AF7;
        Sat, 20 May 2023 06:35:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436263|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.133124-1.38585e-05-0.866862;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.T7WgR4O_1684589730;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.T7WgR4O_1684589730)
          by smtp.aliyun-inc.com;
          Sat, 20 May 2023 21:35:31 +0800
Date:   Sat, 20 May 2023 21:35:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Matthew Wilcox <willy@infradead.org>
Subject: Re: Creating large folios in iomap buffered write path
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <ZGeX9Oc5vTkrceLZ@casper.infradead.org>
References: <20230519105528.1321.409509F4@e16-tech.com> <ZGeX9Oc5vTkrceLZ@casper.infradead.org>
Message-Id: <20230520213531.38CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Fri, May 19, 2023 at 10:55:29AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > On Thu, May 18, 2023 at 10:46:43PM +0100, Matthew Wilcox wrote:
> > > > -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> > > > +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
> > > >  {
> > > >  	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
> > > > +	struct folio *folio;
> > > >  
> > > >  	if (iter->flags & IOMAP_NOWAIT)
> > > >  		fgp |= FGP_NOWAIT;
> > > > +	fgp |= fgp_order(len);
> > > >  
> > > > -	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > > > +	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > > >  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> > > > +	if (!IS_ERR(folio) && folio_test_large(folio))
> > > > +		printk("index:%lu len:%zu order:%u\n", (unsigned long)(pos / PAGE_SIZE), len, folio_order(folio));
> > > > +	return folio;
> > > >  }
> > > 
> > > Forgot to take the debugging out.  This should read:
> > > 
> > > -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> > > +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
> > >  {
> > >  	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
> > >  	if (iter->flags & IOMAP_NOWAIT)
> > >  		fgp |= FGP_NOWAIT;
> > > +	fgp |= fgp_order(len);
> > >  
> > >  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > >  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> > >  }
> > 
> > I test it (attachment file) on 6.4.0-rc2.
> > fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4 -directory=/mnt/test
> > 
> > fio  WRITE: bw=2430MiB/s.
> > expected value: > 6000MiB/s
> > so yet no fio write bandwidth improvement.
> 
> That's basically unchanged.  There's no per-page or per-block work being
> done in start/end writeback, so if Dave's investigation is applicable
> to your situation, I'd expect to see an improvement.
> 
> Maybe try the second version of the patch I sent with the debug in,
> to confirm you really are seeing large folios being created (you might
> want to use printk_ratelimit() instead of printk to ensure it doesn't
> overwhelm your system)?  That fio command you were using ought to create
> them, but there's always a chance it doesn't.
> 
> Perhaps you could use perf (the command Dave used) to see where the time
> is being spent.

test result of the second version of the patch.

# dmesg |grep 'index\|suppressed'
[   89.376149] index:0 len:292 order:2
[   97.862938] index:0 len:4096 order:2
[   98.340665] index:0 len:4096 order:2
[   98.346633] index:0 len:4096 order:2
[   98.352323] index:0 len:4096 order:2
[   98.359952] index:0 len:4096 order:2
[   98.364015] index:3 len:4096 order:2
[   98.368943] index:0 len:4096 order:2
[   98.374285] index:0 len:4096 order:2
[   98.379163] index:3 len:4096 order:2
[   98.384760] index:0 len:4096 order:2
[  181.103751] iomap_get_folio: 342 callbacks suppressed
[  181.103761] index:0 len:292 order:2


'perf report -g' result:
Samples: 344K of event 'cycles', Event count (approx.): 103747884662
  Children      Self  Command          Shared Object            Symbol
+   58.73%     0.01%  fio              [kernel.kallsyms]        [k] entry_SYSCALL_64_after_hwframe
+   58.72%     0.01%  fio              [kernel.kallsyms]        [k] do_syscall_64
+   58.53%     0.00%  fio              libpthread-2.17.so       [.] 0x00007f83e400e6fd
+   58.47%     0.01%  fio              [kernel.kallsyms]        [k] ksys_write
+   58.45%     0.02%  fio              [kernel.kallsyms]        [k] vfs_write
+   58.41%     0.03%  fio              [kernel.kallsyms]        [k] xfs_file_buffered_write
+   57.96%     0.57%  fio              [kernel.kallsyms]        [k] iomap_file_buffered_write
+   27.57%     1.29%  fio              [kernel.kallsyms]        [k] iomap_write_begin
+   25.32%     0.43%  fio              [kernel.kallsyms]        [k] iomap_get_folio
+   24.84%     0.70%  fio              [kernel.kallsyms]        [k] __filemap_get_folio.part.69
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] ret_from_fork
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] kthread
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] worker_thread
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] process_one_work
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] wb_workfn
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] wb_writeback
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] __writeback_inodes_wb
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] writeback_sb_inodes
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] __writeback_single_inode
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] do_writepages
+   20.11%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] xfs_vm_writepages
+   20.10%     0.00%  kworker/u98:15-  [kernel.kallsyms]        [k] iomap_writepages
+   20.10%     0.69%  kworker/u98:15-  [kernel.kallsyms]        [k] write_cache_pages
+   16.95%     0.39%  fio              [kernel.kallsyms]        [k] copy_page_from_iter_atomic
+   16.53%     0.10%  fio              [kernel.kallsyms]        [k] copyin


'perf report ' result:

Samples: 335K of event 'cycles', Event count (approx.): 108508755052
Overhead  Command          Shared Object        Symbol
  17.70%  fio              [kernel.kallsyms]    [k] rep_movs_alternative
   2.89%  kworker/u98:2-e  [kernel.kallsyms]    [k] native_queued_spin_lock_slowpath
   2.88%  fio              [kernel.kallsyms]    [k] get_page_from_freelist
   2.67%  fio              [kernel.kallsyms]    [k] native_queued_spin_lock_slowpath
   2.59%  fio              [kernel.kallsyms]    [k] asm_exc_nmi
   2.25%  swapper          [kernel.kallsyms]    [k] intel_idle
   1.59%  kworker/u98:2-e  [kernel.kallsyms]    [k] __folio_start_writeback
   1.52%  fio              [kernel.kallsyms]    [k] xas_load
   1.45%  fio              [kernel.kallsyms]    [k] lru_add_fn
   1.44%  fio              [kernel.kallsyms]    [k] xas_descend
   1.32%  fio              [kernel.kallsyms]    [k] iomap_write_begin
   1.29%  fio              [kernel.kallsyms]    [k] __filemap_add_folio
   1.08%  kworker/u98:2-e  [kernel.kallsyms]    [k] folio_clear_dirty_for_io
   1.07%  fio              [kernel.kallsyms]    [k] __folio_mark_dirty
   0.94%  fio              [kernel.kallsyms]    [k] iomap_set_range_uptodate.part.24
   0.93%  fio              [kernel.kallsyms]    [k] node_dirty_ok
   0.92%  kworker/u98:2-e  [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
   0.83%  fio              [kernel.kallsyms]    [k] xas_start
   0.83%  fio              [kernel.kallsyms]    [k] __alloc_pages
   0.83%  fio              [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
   0.81%  kworker/u98:2-e  [kernel.kallsyms]    [k] asm_exc_nmi
   0.79%  fio              [kernel.kallsyms]    [k] percpu_counter_add_batch
   0.75%  kworker/u98:2-e  [kernel.kallsyms]    [k] iomap_writepage_map
   0.74%  kworker/u98:2-e  [kernel.kallsyms]    [k] __mod_lruvec_page_state
   0.70%  fio              fio                  [.] 0x000000000001b1ac
   0.70%  fio              [kernel.kallsyms]    [k] filemap_dirty_folio
   0.69%  kworker/u98:2-e  [kernel.kallsyms]    [k] write_cache_pages
   0.69%  fio              [kernel.kallsyms]    [k] __filemap_get_folio.part.69
   0.67%  kworker/1:0-eve  [kernel.kallsyms]    [k] native_queued_spin_lock_slowpath
   0.66%  fio              [kernel.kallsyms]    [k] __mod_lruvec_page_state
   0.64%  fio              [kernel.kallsyms]    [k] __mod_node_page_state
   0.64%  fio              [kernel.kallsyms]    [k] folio_add_lru
   0.64%  fio              [kernel.kallsyms]    [k] balance_dirty_pages_ratelimited_flags
   0.62%  fio              [kernel.kallsyms]    [k] __mod_memcg_lruvec_state
   0.61%  fio              [kernel.kallsyms]    [k] iomap_write_end
   0.60%  fio              [kernel.kallsyms]    [k] xas_find_conflict
   0.59%  fio              [kernel.kallsyms]    [k] bad_range
   0.58%  kworker/u98:2-e  [kernel.kallsyms]    [k] xas_load
   0.57%  fio              [kernel.kallsyms]    [k] iomap_file_buffered_write
   0.56%  kworker/u98:2-e  [kernel.kallsyms]    [k] percpu_counter_add_batch
   0.49%  fio              [kernel.kallsyms]    [k] __might_resched


'perf top -g -U' result:
Samples: 78K of event 'cycles', 4000 Hz, Event count (approx.): 29400815085 lost: 0/0 drop: 0/0
  Children      Self  Shared Object       Symbol
+   62.59%     0.03%  [kernel]            [k] entry_SYSCALL_64_after_hwframe
+   60.15%     0.02%  [kernel]            [k] do_syscall_64
+   59.45%     0.02%  [kernel]            [k] vfs_write
+   59.09%     0.54%  [kernel]            [k] iomap_file_buffered_write
+   57.41%     0.00%  [kernel]            [k] ksys_write
+   57.36%     0.01%  [kernel]            [k] xfs_file_buffered_write
+   37.82%     0.00%  libpthread-2.17.so  [.] 0x00007fce6f20e6fd
+   26.83%     1.20%  [kernel]            [k] iomap_write_begin
+   24.65%     0.45%  [kernel]            [k] iomap_get_folio
+   24.15%     0.74%  [kernel]            [k] __filemap_get_folio.part.69
+   20.17%     0.00%  [kernel]            [k] __writeback_single_inode
+   20.17%     0.65%  [kernel]            [k] write_cache_pages
+   17.66%     0.43%  [kernel]            [k] copy_page_from_iter_atomic
+   17.18%     0.12%  [kernel]            [k] copyin
+   17.08%    16.71%  [kernel]            [k] rep_movs_alternative
+   16.97%     0.00%  [kernel]            [k] ret_from_fork
+   16.97%     0.00%  [kernel]            [k] kthread
+   16.87%     0.00%  [kernel]            [k] worker_thread
+   16.84%     0.00%  [kernel]            [k] process_one_work
+   14.86%     0.17%  [kernel]            [k] filemap_add_folio
+   13.83%     0.77%  [kernel]            [k] iomap_writepage_map
+   11.90%     0.33%  [kernel]            [k] iomap_finish_ioend
+   11.57%     0.23%  [kernel]            [k] folio_end_writeback
+   11.51%     0.73%  [kernel]            [k] iomap_write_end
+   11.30%     2.14%  [kernel]            [k] __folio_end_writeback
+   10.70%     0.00%  [kernel]            [k] wb_workfn
+   10.70%     0.00%  [kernel]            [k] wb_writeback
+   10.70%     0.00%  [kernel]            [k] __writeback_inodes_wb
+   10.70%     0.00%  [kernel]            [k] writeback_sb_inodes
+   10.70%     0.00%  [kernel]            [k] do_writepages
+   10.70%     0.00%  [kernel]            [k] xfs_vm_writepages
+   10.70%     0.00%  [kernel]            [k] iomap_writepages
+   10.19%     2.68%  [kernel]            [k] _raw_spin_lock_irqsave
+   10.17%     1.35%  [kernel]            [k] __filemap_add_folio
+    9.94%     0.00%  [unknown]           [k] 0x0000000001942a70
+    9.94%     0.00%  [unknown]           [k] 0x0000000001942ac0
+    9.94%     0.00%  [unknown]           [k] 0x0000000001942b30

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/20



