Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C16A33F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjBZUiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZUiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:38:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949786EAA;
        Sun, 26 Feb 2023 12:38:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECCCCB80B86;
        Sun, 26 Feb 2023 20:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A9C433D2;
        Sun, 26 Feb 2023 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677443895;
        bh=FqOwZ1KiLarzLNaFojBpikgn+mbiZr/mALVgv4DFdxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YWEJ8gUmujjdLDytk9zdHMjmjeElCaeHmxsa12Koi3PGWUd2pB3DTQqVapa0ss+rQ
         h1p412xVL07fLn/3Hcm3vLAX+7psysGjtNt9ABHd7ZUKGBLPykcXskslx3GP/gIwCN
         y4g1uH+SD8bOvR1QkjuQntUt06Y94C/t2+72WYvY=
Date:   Sun, 26 Feb 2023 12:38:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com>
Cc:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [syzbot] [fs?] [mm?] KMSAN: uninit-value in ondemand_readahead
Message-Id: <20230226123814.1d9afb8c3de438155593c378@linux-foundation.org>
In-Reply-To: <0000000000008f74e905f56df987@google.com>
References: <0000000000007dcc0b05e91943c2@google.com>
        <0000000000008f74e905f56df987@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Feb 2023 00:32:50 -0800 syzbot <syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    97e36f4aa06f Revert "sched/core: kmsan: do not instrument ..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e46944c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ce7f8308d91e6b8bbe2
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143b8650c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a22f2cc80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9931a9627dc6/disk-97e36f4a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1aafdb2fd6dc/vmlinux-97e36f4a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/90df5872c7ff/bzImage-97e36f4a.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/ea75a01297dd/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 16
> =====================================================
> BUG: KMSAN: uninit-value in ondemand_readahead+0xddf/0x1720 mm/readahead.c:596
>  ondemand_readahead+0xddf/0x1720 mm/readahead.c:596
>  page_cache_sync_ra+0x72b/0x760 mm/readahead.c:709
>  page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
>  cramfs_blkdev_read fs/cramfs/inode.c:217 [inline]
>  cramfs_read+0x611/0x1280 fs/cramfs/inode.c:278
>  cramfs_lookup+0x1b8/0x870 fs/cramfs/inode.c:767

Thanks.

file_ra_state_init() says "Assumes that the caller has memset *ra to
zero".  This should fix:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: fs/cramfs/inode.c: initialize file_ra_state
Date: Sun Feb 26 12:31:11 PM PST 2023

file_ra_state_init() assumes that the file_ra_state has been zeroed out. 
Fixes a KMSAN used-unintialized issue (at least).

Fixes: cf948cbc35e80 ("cramfs: read_mapping_page() is synchronous")
Reported-by: syzbot <syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com>
  Link: https://lkml.kernel.org/r/0000000000008f74e905f56df987@google.com
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/fs/cramfs/inode.c~a
+++ b/fs/cramfs/inode.c
@@ -183,7 +183,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 				unsigned int len)
 {
 	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
-	struct file_ra_state ra;
+	struct file_ra_state ra = {};
 	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
 	unsigned long devsize;
_

