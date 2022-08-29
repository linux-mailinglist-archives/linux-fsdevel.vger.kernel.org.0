Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C095A53FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH2SeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiH2SeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002B7B289;
        Mon, 29 Aug 2022 11:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C2406130E;
        Mon, 29 Aug 2022 18:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1970BC433B5;
        Mon, 29 Aug 2022 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661798056;
        bh=zhm95cok2WKuPGTcOLYqozQIGbOcYROaqVASpobqVOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3Y5fnNI7VcvF87gvAddr1EYic37Qv3YZ0hpDMdPiKqMuOtMe3Vo4FMvBD1KLyjpA
         3GHgdvzzsVVIgOcOFyd55aFYOETHZdSVPBtc8vdqBmudW5EzSAJ1V9rYWg5aJem3He
         FBdbpa1Xm0PbMJvfMq4UsWJm3BYbCZZ0PsM01BKXpBj9+KzWhXhcDYR0ZWfnVh5zJl
         OGRdMx9/Ss8M9q91ON+rnShQXvhNhc+ciSZo/3xkM7EO+myrhp4B/XvkzFgo8eSn4Q
         jb8Ue1VYyAyl2TtQkcyCKqFY+DDcbghNi4jjiUY4ijBzp+Ac7bcXT4ZtN1jc76qX+L
         4iqyhKiIQ+uqw==
Date:   Mon, 29 Aug 2022 11:34:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference
 in set_page_dirty
Message-ID: <Yw0Gpn8D3cWr/U95@google.com>
References: <000000000000d5b4fe05e7127662@google.com>
 <20220825183734.0b08ae10a2e9e1bd156a19cd@linux-foundation.org>
 <Ywz8+WUhypEiUfvk@google.com>
 <Ywz/ZLYqoq85Yrhc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywz/ZLYqoq85Yrhc@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/29, Matthew Wilcox wrote:
> On Mon, Aug 29, 2022 at 10:52:57AM -0700, Jaegeuk Kim wrote:
> > On 08/25, Andrew Morton wrote:
> > > (cc fsf2 developers)
> > > 
> > > On Thu, 25 Aug 2022 08:29:32 -0700 syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=175def47080000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=775a3440817f74fddb8c
> > > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > userspace arch: arm64
> > > > 
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com
> > > > 
> > > > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > > > Mem abort info:
> > > >   ESR = 0x0000000086000005
> > > >   EC = 0x21: IABT (current EL), IL = 32 bits
> > > >   SET = 0, FnV = 0
> > > >   EA = 0, S1PTW = 0
> > > >   FSC = 0x05: level 1 translation fault
> > > > user pgtable: 4k pages, 48-bit VAs, pgdp=00000001249cc000
> > > > [0000000000000000] pgd=080000012ee65003, p4d=080000012ee65003, pud=0000000000000000
> > > > Internal error: Oops: 86000005 [#1] PREEMPT SMP
> > > > Modules linked in:
> > > > CPU: 0 PID: 3044 Comm: syz-executor.0 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
> > > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > pc : 0x0
> > > > lr : folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
> > > > sp : ffff800012803830
> > > > x29: ffff800012803830 x28: ffff0000d02c8000 x27: 0000000000000009
> > > > x26: 0000000000000001 x25: 0000000000000a00 x24: 0000000000000080
> > > > x23: 0000000000000000 x22: ffff0000ef276c00 x21: 05ffc00000000007
> > > > x20: ffff0000f14b83b8 x19: fffffc00036409c0 x18: fffffffffffffff5
> > > > x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: 0000000000000000
> > > > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > > x11: ff808000083e9814 x10: 0000000000000000 x9 : ffff8000083e9814
> > > > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > x5 : ffff0000d9028000 x4 : ffff0000d5c31000 x3 : ffff0000d9027f80
> > > > x2 : fffffffffffffff0 x1 : fffffc00036409c0 x0 : ffff0000f14b83b8
> > > > Call trace:
> > > >  0x0
> > > >  set_page_dirty+0x38/0xbc mm/folio-compat.c:62
> > 
> > 2363 void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
> > 2364                                         void *src, block_t blk_addr)
> > 2365 {       
> > 2366         struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
> > 
> > --> f2fs_grab_meta_page() gives a locked page by grab_cache_page().
> > 
> > 2367                                                         
> > 2368         memcpy(page_address(page), src, PAGE_SIZE);
> > 2369         set_page_dirty(page);
> > 2370         f2fs_put_page(page, 1);
> > 2371 } 
> > 
> > Is there a change in folio?
> 
> Not directly, but there was a related change, 0af573780b0b which
> requires aops->set_page_dirty to be set; is that perhaps missing?
> I don't see one in the f2fs_compress_aops, for example.

Do you mean dirty_folio? I think all aops have it except the compressed one
that we don't make it dirty.

> 
> The other possibiity is that it's a mapping that is missing an ->a_ops.
> Is that something f2fs ever does?

Hmm, no, I haven't seen this before, and we set aops when mounting the
file system. Ah, if this happens on the corrupted image, yeah, maybe.. I need
to check the error path in f2fs_fill_super.

> 
> I only managed to narrow down the crash to the line:
>                 return mapping->a_ops->dirty_folio(mapping, folio);
> so either mapping->a_ops is NULL or mapping->a_ops->dirty_folio is
> NULL.  The reproducer was on ARM and ARM doesn't emit a 'Code:' line,
> unlike x86.
