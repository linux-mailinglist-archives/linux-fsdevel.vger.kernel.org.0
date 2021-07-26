Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F743D514E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 04:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhGZBzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 21:55:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59531 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhGZBzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 21:55:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UgvfLav_1627266964;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgvfLav_1627266964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Jul 2021 10:36:05 +0800
Date:   Mon, 26 Jul 2021 10:36:03 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210725221639.426565-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> Here's a fixed and cleaned up version that passes fstests on gfs2.
> 
> I see no reason why the combination of tail packing + writing should
> cause any issues, so in my opinion, the check that disables that
> combination in iomap_write_begin_inline should still be removed.

Since there is no such fs for tail-packing write, I just do a wild
guess, for example,
 1) the tail-end block was not inlined, so iomap_write_end() dirtied
    the whole page (or buffer) for the page writeback;
 2) then it was truncated into a tail-packing inline block so the last
    extent(page) became INLINE but dirty instead;
 3) during the late page writeback for dirty pages,
    if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
    would be triggered in iomap_writepage_map() for such dirty page.

As Matthew pointed out before,
https://lore.kernel.org/r/YPrms0fWPwEZGNAL@casper.infradead.org/
currently tail-packing inline won't interact with page writeback, but
I'm afraid a supported tail-packing write fs needs to reconsider the
whole stuff how page, inode writeback works and what the pattern is
with the tail-packing.

> 
> It turns out that returning the number of bytes copied from
> iomap_read_inline_data is a bit irritating: the function is really used
> for filling the page, but that's not always the "progress" we're looking
> for.  In the iomap_readpage case, we actually need to advance by an
> antire page, but in the iomap_file_buffered_write case, we need to
> advance by the length parameter of iomap_write_actor or less.  So I've
> changed that back.
> 
> I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> more useful to me.
> 
> Thanks,
> Andreas
> 
> --
> 
> Subject: [PATCH] iomap: Support tail packing
> 
> The existing inline data support only works for cases where the entire
> file is stored as inline data.  For larger files, EROFS stores the
> initial blocks separately and then can pack a small tail adjacent to the
> inode.  Generalise inline data to allow for tail packing.  Tails may not
> cross a page boundary in memory.
> 
> We currently have no filesystems that support tail packing and writing,
> so that case is currently disabled (see iomap_write_begin_inline).  I'm
> not aware of any reason why this code path shouldn't work, however.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
>  fs/iomap/direct-io.c   | 11 ++++++-----
>  include/linux/iomap.h  | 22 +++++++++++++++++++++-
>  3 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..334bf98fdd4a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
>  		struct iomap *iomap)
>  {
> -	size_t size = i_size_read(inode);
> +	size_t size = i_size_read(inode) - iomap->offset;

I wonder why you use i_size / iomap->offset here, and why you completely
ignoring iomap->length field returning by fs.

Using i_size here instead of iomap->length seems coupling to me in the
beginning (even currently in practice there is some limitation.)

Thanks,
Gao Xiang
