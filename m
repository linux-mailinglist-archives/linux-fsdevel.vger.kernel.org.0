Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C51482150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhLaBmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 20:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242471AbhLaBmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:42:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E4C061574;
        Thu, 30 Dec 2021 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zWJ2X9Lq+4uil6rtKyXxlpP4WArw8+jtoSi/ql08s+Y=; b=UHXidHTQIzC2NYqBQGlOhgqkZ4
        mtL6qGE7842aQ4ATKj/zZRml0r2EyNpBorwEbbR5lauc9SxzjAQLSpfp75fIvlqu63gygQT4Yt/dk
        bA5Dw6shmuJKPCTp9IXposFZO9+qD2PerFAOmXvhnj3Mct8NbTb3kJFlm3LdCutmuHXBfojdDWkCl
        IYQhmr9ov8yhx2yCbf1Xyod+2PmCuzgpRbWSLWlpn2jf7qxZVw5Th8i08VaB81RotoNg7G/VHxVLH
        OVjPBa7v8h+bvIgwU+HlH6t2Z1BFzVVPIBNaKpNdgqUuVak84BvZm8nnv3T3a3vOiXkkXoJwcnjg/
        f9pJSWIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n36w0-00AEtE-7H; Fri, 31 Dec 2021 01:42:20 +0000
Date:   Fri, 31 Dec 2021 01:42:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     trondmy@kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <Yc5f/C1I+N8MPHcd@casper.infradead.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230193522.55520-1-trondmy@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 02:35:22PM -0500, trondmy@kernel.org wrote:
>  Workqueue: xfs-conv/md127 xfs_end_io [xfs]
>  RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
>  Code: 7c ff 48 29 e8 4c 39 e0 76 cf 80 0b 08 eb 8c 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 e8 e6 db 7e ff 66 90 48 89 f7 57 9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 07
>  RSP: 0018:ffffac51d26dfd18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
>  RAX: 0000000000000001 RBX: ffffffff980085a0 RCX: dead000000000200
>  RDX: ffffac51d3893c40 RSI: 0000000000000202 RDI: 0000000000000202
>  RBP: 0000000000000202 R08: ffffac51d3893c40 R09: 0000000000000000
>  R10: 00000000000000b9 R11: 00000000000004b3 R12: 0000000000000a20
>  R13: ffffd228f3e5a200 R14: ffff963cf7f58d10 R15: ffffd228f3e5a200
>  FS:  0000000000000000(0000) GS:ffff9625bfb00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f5035487500 CR3: 0000000432810004 CR4: 00000000003706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   wake_up_page_bit+0x8a/0x110
>   iomap_finish_ioend+0xd7/0x1c0
>   iomap_finish_ioends+0x7f/0xb0

> +++ b/fs/iomap/buffered-io.c
> @@ -1052,9 +1052,11 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  			next = bio->bi_private;
>  
>  		/* walk each page on bio, ending page IO on them */
> -		bio_for_each_segment_all(bv, bio, iter_all)
> +		bio_for_each_segment_all(bv, bio, iter_all) {
>  			iomap_finish_page_writeback(inode, bv->bv_page, error,
>  					bv->bv_len);
> +			cond_resched();
> +		}
>  		bio_put(bio);
>  	}
>  	/* The ioend has been freed by bio_put() */

As I recall, iomap_finish_ioend() can be called in softirq (or even
hardirq?) context currently.  I think we've seen similar things before,
and the solution suggested at the time was to aggregate fewer writeback
pages into a single bio.
