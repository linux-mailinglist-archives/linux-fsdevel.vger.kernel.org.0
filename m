Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D474364D9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 00:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhDSWS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhDSWS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:18:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13367C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNLB27Gu1vWmDE+nObgUoarsxHrdBqsX3WNYP1sdBkE=; b=mWcw5aK7k4qGF0Dmbkc1AckEPd
        eCM+BZWnaW5IpZSUEZSCe84wZk/pM/EFKWmlS9GiqA3qlbZPTFs8ohM37rjfmOSBiq68XhwBmmP/p
        KimLeBONRmyJF2y0FOQVX2wQLSCAyVAHB9yqQ7mtgcE4Xp799RawE2CiW49MxDZBPyyoRK1q30wJM
        wr5crn/IfiuVuW8mEv1yHgHH3ZBRGtsuNYZ4P2PWAlJzO7hFB2/7okcMzNgmm5ViYFeRaz9gzsBC9
        dKdpmMsXZUjQUG+noLjwxW0lz0Qaym46FRzAACNwV9G+YhnZqBQ1TORY/z5DNr0h1lCdPFl4d8Gqf
        Um9fgyPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYcCq-00EMfF-Sg; Mon, 19 Apr 2021 22:17:35 +0000
Date:   Mon, 19 Apr 2021 23:17:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] smp_rmb_cond
Message-ID: <20210419221724.GG2531743@casper.infradead.org>
References: <20210419201251.GE2531743@casper.infradead.org>
 <1929623.1618863640@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1929623.1618863640@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 09:20:40PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > i see worse inlining decisions from gcc with this.  maybe you see
> > an improvement that would justify it?
> > 
> > [ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99998]
> 
> Perhaps attach the patch to the bz, see if the compiler guys can recommend
> anything?

your test case loses the bogus branch

0000000000000000 <PageUptodate>:
   0:   48 8b 47 08             mov    0x8(%rdi),%rax
   4:   a8 01                   test   $0x1,%al
   6:   74 04                   je     c <PageUptodate+0xc>
   8:   48 8d 78 ff             lea    -0x1(%rax),%rdi
   c:   8b 07                   mov    (%rdi),%eax
   e:   48 c1 e8 02             shr    $0x2,%rax
  12:   24 01                   and    $0x1,%al
  14:   74 00                   je     16 <PageUptodate+0x16>
  16:   c3                      retq   

0000000000000017 <Page2Uptodate>:
  17:   48 8b 47 08             mov    0x8(%rdi),%rax
  1b:   a8 01                   test   $0x1,%al
  1d:   74 04                   je     23 <Page2Uptodate+0xc>
  1f:   48 8d 78 ff             lea    -0x1(%rax),%rdi
  23:   8b 07                   mov    (%rdi),%eax
  25:   48 c1 e8 02             shr    $0x2,%rax
  29:   83 e0 01                and    $0x1,%eax
  2c:   c3                      retq   

but that means that gcc then does more inlining to functions that
call PageUptodate:

$ ./scripts/bloat-o-meter filemap-before.o filemap-after.o 
add/remove: 0/0 grow/shrink: 3/4 up/down: 179/-91 (88)
Function                                     old     new   delta
mapping_seek_hole_data                      1203    1347    +144
__lock_page_killable                         394     426     +32
next_uptodate_page                           603     606      +3
wait_on_page_bit_common                      582     576      -6
filemap_get_pages                           1530    1512     -18
do_read_cache_page                          1031    1012     -19
filemap_read_page                            261     213     -48
Total: Before=24603, After=24691, chg +0.36%

but maybe you have a metric that shows this winning at scale instead
of in a micro?
