Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A4F70997A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjESOWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjESOWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 10:22:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F89116;
        Fri, 19 May 2023 07:22:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D51C11FDA9;
        Fri, 19 May 2023 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684506122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlcBct/wzp7TvW6xV2C5NZk4K9r7Xb2dIshCQXz8B/o=;
        b=AFt2rU6BsN/C4LLgMrh7gKGcpHYIHok4I1/ZlixA6CgBGql3l73YlMa9C48tJmr9NqegsT
        LN8AClWFtwITzTZAUWgoU01jAS1F2lDDOB4JawywQhzdu2BdTVwBO7ISqWbV6ElVvIXcHy
        pS+mrAVAokuwV8tW3e7shtOpSuVArgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684506122;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlcBct/wzp7TvW6xV2C5NZk4K9r7Xb2dIshCQXz8B/o=;
        b=n6vjt7WKTMi/w+YlBK3seqHcXPDKocScWzVVUDL+yCxdpf+f0GwrDIg68CO/X1/yI4orBU
        4xpJjA0dEHwk/dCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23E2213A12;
        Fri, 19 May 2023 14:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zjpzBgqGZ2TWHwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 19 May 2023 14:22:02 +0000
Message-ID: <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
Date:   Fri, 19 May 2023 16:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 16/17] block: use iomap for writes to block devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-17-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230424054926.26927-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 07:49, Christoph Hellwig wrote:
> Use iomap in buffer_head compat mode to write to block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/Kconfig |  1 +
>   block/fops.c  | 33 +++++++++++++++++++++++++++++----
>   2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 941b2dca70db73..672b08f0096ab4 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -5,6 +5,7 @@
>   menuconfig BLOCK
>          bool "Enable the block layer" if EXPERT
>          default y
> +       select IOMAP
>          select SBITMAP
>          help
>   	 Provide block layer support for the kernel.
> diff --git a/block/fops.c b/block/fops.c
> index 318247832a7bcf..7910636f8df33b 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -15,6 +15,7 @@
>   #include <linux/falloc.h>
>   #include <linux/suspend.h>
>   #include <linux/fs.h>
> +#include <linux/iomap.h>
>   #include <linux/module.h>
>   #include "blk.h"
>   
> @@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>   }
>   
> +static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct block_device *bdev = I_BDEV(inode);
> +	loff_t isize = i_size_read(inode);
> +
> +	iomap->bdev = bdev;
> +	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> +	if (WARN_ON_ONCE(iomap->offset >= isize))
> +		return -EIO;

I'm hitting this during booting:
[    5.016324]  <TASK>
[    5.030256]  iomap_iter+0x11a/0x350
[    5.030264]  iomap_readahead+0x1eb/0x2c0
[    5.030272]  read_pages+0x5d/0x220
[    5.030279]  page_cache_ra_unbounded+0x131/0x180
[    5.030284]  filemap_get_pages+0xff/0x5a0
[    5.030292]  filemap_read+0xca/0x320
[    5.030296]  ? aa_file_perm+0x126/0x500
[    5.040216]  ? touch_atime+0xc8/0x150
[    5.040224]  blkdev_read_iter+0xb0/0x150
[    5.040228]  vfs_read+0x226/0x2d0
[    5.040234]  ksys_read+0xa5/0xe0
[    5.040238]  do_syscall_64+0x5b/0x80

Maybe we should consider this patch:

diff --git a/block/fops.c b/block/fops.c
index 524b8a828aad..d202fb663f25 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -386,10 +386,13 @@ static int blkdev_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,

         iomap->bdev = bdev;
         iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
-       if (WARN_ON_ONCE(iomap->offset >= isize))
-               return -EIO;
-       iomap->type = IOMAP_MAPPED;
-       iomap->addr = iomap->offset;
+       if (WARN_ON_ONCE(iomap->offset >= isize)) {
+               iomap->type = IOMAP_HOLE;
+               iomap->addr = IOMAP_NULL_ADDR;
+       } else {
+               iomap->type = IOMAP_MAPPED;
+               iomap->addr = iomap->offset;
+       }
         iomap->length = isize - iomap->offset;
         if (IS_ENABLED(CONFIG_BUFFER_HEAD))
                 iomap->flags |= IOMAP_F_BUFFER_HEAD;


Other that the the system seems fine.

Cheers,

Hannes

