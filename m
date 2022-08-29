Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37305A53B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiH2SDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2SDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:03:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098698CB9;
        Mon, 29 Aug 2022 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=857Rky5sRC+XTJoK32c3SmZHdQxHs6Z39DSeLz0jxjw=; b=ie/PIbDnder97CFfOvA/bS9aHh
        Shut/yjGXNOA1Hi1Gl0G4CZlaeev5yYp4xcxHiYj/B+OQ6wPzmElZcuYZLVCkN5Yd0dCqLlfbPKBy
        35f9iyyq5D67aolPfBKc3yj1R6ZiOZF1OtE/KzqrXoWZCVNFS7CcBFcMRMHrHy6J3i1PPiKcVRq8B
        TAQ8kCI0evozqY805wDkhrP6B6WQcKz0J+u6frrMfCRhdxBedhbSRdHZF1r0vYN+FWmRIUMADH9/E
        Vla1+a/2b0dfqBGfS3n11MPhT/lR8x2E/n180bGVpgYVSThMJT5gjdzBHKhgwCOyDF6yqdhMmxOyp
        bbNinWjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSj6S-003Hxz-Ia; Mon, 29 Aug 2022 18:03:16 +0000
Date:   Mon, 29 Aug 2022 19:03:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference
 in set_page_dirty
Message-ID: <Ywz/ZLYqoq85Yrhc@casper.infradead.org>
References: <000000000000d5b4fe05e7127662@google.com>
 <20220825183734.0b08ae10a2e9e1bd156a19cd@linux-foundation.org>
 <Ywz8+WUhypEiUfvk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywz8+WUhypEiUfvk@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:52:57AM -0700, Jaegeuk Kim wrote:
> On 08/25, Andrew Morton wrote:
> > (cc fsf2 developers)
> > 
> > On Thu, 25 Aug 2022 08:29:32 -0700 syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=175def47080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=775a3440817f74fddb8c
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm64
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com
> > > 
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > > Mem abort info:
> > >   ESR = 0x0000000086000005
> > >   EC = 0x21: IABT (current EL), IL = 32 bits
> > >   SET = 0, FnV = 0
> > >   EA = 0, S1PTW = 0
> > >   FSC = 0x05: level 1 translation fault
> > > user pgtable: 4k pages, 48-bit VAs, pgdp=00000001249cc000
> > > [0000000000000000] pgd=080000012ee65003, p4d=080000012ee65003, pud=0000000000000000
> > > Internal error: Oops: 86000005 [#1] PREEMPT SMP
> > > Modules linked in:
> > > CPU: 0 PID: 3044 Comm: syz-executor.0 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
> > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : 0x0
> > > lr : folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
> > > sp : ffff800012803830
> > > x29: ffff800012803830 x28: ffff0000d02c8000 x27: 0000000000000009
> > > x26: 0000000000000001 x25: 0000000000000a00 x24: 0000000000000080
> > > x23: 0000000000000000 x22: ffff0000ef276c00 x21: 05ffc00000000007
> > > x20: ffff0000f14b83b8 x19: fffffc00036409c0 x18: fffffffffffffff5
> > > x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: 0000000000000000
> > > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > x11: ff808000083e9814 x10: 0000000000000000 x9 : ffff8000083e9814
> > > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > x5 : ffff0000d9028000 x4 : ffff0000d5c31000 x3 : ffff0000d9027f80
> > > x2 : fffffffffffffff0 x1 : fffffc00036409c0 x0 : ffff0000f14b83b8
> > > Call trace:
> > >  0x0
> > >  set_page_dirty+0x38/0xbc mm/folio-compat.c:62
> 
> 2363 void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
> 2364                                         void *src, block_t blk_addr)
> 2365 {       
> 2366         struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
> 
> --> f2fs_grab_meta_page() gives a locked page by grab_cache_page().
> 
> 2367                                                         
> 2368         memcpy(page_address(page), src, PAGE_SIZE);
> 2369         set_page_dirty(page);
> 2370         f2fs_put_page(page, 1);
> 2371 } 
> 
> Is there a change in folio?

Not directly, but there was a related change, 0af573780b0b which
requires aops->set_page_dirty to be set; is that perhaps missing?
I don't see one in the f2fs_compress_aops, for example.

The other possibiity is that it's a mapping that is missing an ->a_ops.
Is that something f2fs ever does?

I only managed to narrow down the crash to the line:
                return mapping->a_ops->dirty_folio(mapping, folio);
so either mapping->a_ops is NULL or mapping->a_ops->dirty_folio is
NULL.  The reproducer was on ARM and ARM doesn't emit a 'Code:' line,
unlike x86.
