Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365DD7100E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbjEXWZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbjEXWZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 18:25:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFBB99;
        Wed, 24 May 2023 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6a4TWuzTGi7+tMMLrCXx2xS2HLm+fpIBXBWX9SQFhJc=; b=Olg5NsAiR4MXUKxEfN0JWQ26G+
        48QUUb0p3dP2AO5RET1yB+OlmxpPgfW/OAuL8L3TmcLxGehBJ8zrOmr2kBjQvXnIDe74EGIXQUw5V
        jrolzbG8yKU05ZkW5mpKw/LmaGIzjIW2osv7EnQcuMT1PVUpROY1wInr2AXsx/P1CtXqq68pLnhwc
        o//oJNGyzcS02XIm8oZ0EkYqFxmeJvu+ZYfriDV2Rx6DKfxLwq6Z2WZASZL/SOiLmZyzD7t1ZY8rR
        AcKIKrMHyGez7UPTrzHiDlh7DZpdMV2McGOt3pus8tAT+JlDrTHSf6mbJJPR2Ulm/XYS7au9Vkv2O
        3mANUUxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1wsv-00EnXL-1n;
        Wed, 24 May 2023 22:23:09 +0000
Date:   Wed, 24 May 2023 15:23:09 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Daniel Gomez <da.gomez@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] block: open code __generic_file_write_iter for
 blkdev writes
Message-ID: <ZG6OTWckNlz+P+mo@bombadil.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424054926.26927-15-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:49:23AM +0200, Christoph Hellwig wrote:
> Open code __generic_file_write_iter to remove the indirect call into
> ->direct_IO and to prepare using the iomap based write code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/fops.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index b670aa7c5bb745..fd510b6142bd57 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -508,6 +508,29 @@ static int blkdev_close(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static ssize_t
> +blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	size_t count = iov_iter_count(from);
> +	ssize_t written;
> +
> +	written = kiocb_invalidate_pages(iocb, count);
> +	if (written) {
> +		if (written == -EBUSY)
> +			return 0;
> +		return written;
> +	}
> +
> +	written = blkdev_direct_IO(iocb, from);
> +	if (written > 0) {
> +		kiocb_invalidate_post_write(iocb, count);
> +		iocb->ki_pos += written;
> +	}

Written can be negative here after blkdev_direct_IO()

> +	if (written != -EIOCBQUEUED)
> +		iov_iter_revert(from, count - written - iov_iter_count(from));

And we'll then use it here on iov_iter_revert() and this can crash on
with some values. For example this can crash on a 4k write attempt
on a 32k drive when experimenting wit large block sizes.

kernel BUG at lib/iov_iter.c:999!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 4 PID: 949 Comm: fio Not tainted 6.3.0-large-block-20230426-dirty#28
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.0-debian-1.16.0-5        04/01/2014
+RIP: 0010:iov_iter_revert.part.0+0x16e/0x170
Code: f9 40 a2 63 af 74 07 03 56 08 89 d8 29 d0 89 45 08 44 89 6d 20
<etc>
RSP: 0018:ffffaa52006cfc60 EFLAGS: 00010246
RAX: 0000000000000016 RBX: 0000000000000016 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000006 RDI: ffffaa52006cfd08
RBP: ffffaa52006cfd08 R08: 0000000000000000 R09: ffffaa52006cfb40
R10: 0000000000000003 R11: ffffffffafcc21e8 R12: 0000000000004000
R13: 0000000000003fea R14: ffff9de3d7565e00 R15: ffff9de3c1f68600
FS:  00007f8bfe726c40(0000) GS:ffff9de43bd00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bf5eadd68 CR3: 0000000102c76001 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
blkdev_direct_write+0xf0/0x160
blkdev_write_iter+0x11b/0x230
io_write+0x10c/0x420
? kmem_cache_alloc_bulk+0x2a1/0x410
? fget+0x79/0xb0
io_issue_sqe+0x60/0x3b0
? io_prep_rw+0x5a/0x190
io_submit_sqes+0x1e6/0x640
__do_sys_io_uring_enter+0x54c/0xb90
? handle_mm_fault+0x9a/0x340
? preempt_count_add+0x47/0xa0
? up_read+0x37/0x70
? do_user_addr_fault+0x27c/0x780
do_syscall_64+0x37/0x90
entry_SYSCALL_64_after_hw

Although I fixed it with an early check on this routine
with:

if (count < bdev_logical_block_size(bdev))
	return -EINVAL; 

I think this can just be fixed by also using the alignment
check earier here:

if (blkdev_dio_unaligned(bdev, pos, iter))                               
	return -EINVAL;  

  Luis
