Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7945B4F75A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 08:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiDGGLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 02:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiDGGLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:11:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00B190B5A;
        Wed,  6 Apr 2022 23:09:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A29E1210E4;
        Thu,  7 Apr 2022 06:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649311777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JT4UvlPRTF1rf1PNVYTQl5oxY75vXHbMm6cxI+vJlzM=;
        b=wOiyRM1WKAijaiXA/6UPpDOabfmgWyFiXfUydWL/10ZCv7yghtyaXvUcoBtsxJ2dnhBhf4
        MXxBRV2J27Fs0oBPGyW3Bcz1OeFP7yQybfPi0d2TDSS1Rp6Pn1IPyM3ErNotkeHAJf1Ysz
        2ylrrplM7mJGkpksfcE/0PXv/RJ0b84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649311777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JT4UvlPRTF1rf1PNVYTQl5oxY75vXHbMm6cxI+vJlzM=;
        b=qH6/6KvekVW7yUEoPIXC0j8Nl8eBqt7dLT/vdiczEh3nQdRmXIIFkTLVPwnvPg8wyiCLJm
        FUCApLKkaSIR8qDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4017213485;
        Thu,  7 Apr 2022 06:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kE04BRyATmI2UQAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 07 Apr 2022 06:09:32 +0000
Message-ID: <ac88801d-c1f9-e8a4-e0cf-e5f7cbdfbfc3@suse.de>
Date:   Thu, 7 Apr 2022 14:09:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 26/27] block: uncouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-27-hch@lst.de>
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20220406060516.409838-27-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/6/22 2:05 PM, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For the bcache part,

Acked-by: Coly Li <colyli@suse.de>


Thanks.

Coly Li


> ---
>   block/blk-core.c                    |  2 +-
>   block/blk-lib.c                     | 64 ++++++++++++++++++++---------
>   block/blk-mq-debugfs.c              |  1 -
>   block/blk-settings.c                | 16 +++++++-
>   block/fops.c                        |  2 +-
>   block/ioctl.c                       | 43 +++++++++++++++----
>   drivers/block/drbd/drbd_receiver.c  |  5 ++-
>   drivers/block/rnbd/rnbd-clt.c       |  4 +-
>   drivers/block/rnbd/rnbd-srv-dev.h   |  2 +-
>   drivers/block/xen-blkback/blkback.c | 15 +++----
>   drivers/block/xen-blkback/xenbus.c  |  5 +--
>   drivers/block/xen-blkfront.c        |  5 ++-
>   drivers/md/bcache/alloc.c           |  2 +-
>   drivers/md/dm-table.c               |  8 ++--
>   drivers/md/dm-thin.c                |  4 +-
>   drivers/md/md.c                     |  2 +-
>   drivers/md/raid5-cache.c            |  6 +--
>   drivers/mmc/core/queue.c            |  2 +-
>   drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>   drivers/target/target_core_file.c   |  2 +-
>   drivers/target/target_core_iblock.c |  2 +-
>   fs/btrfs/extent-tree.c              |  4 +-
>   fs/ext4/mballoc.c                   |  2 +-
>   fs/f2fs/file.c                      | 16 ++++----
>   fs/f2fs/segment.c                   |  2 +-
>   fs/jbd2/journal.c                   |  2 +-
>   fs/nilfs2/sufile.c                  |  4 +-
>   fs/nilfs2/the_nilfs.c               |  4 +-
>   fs/ntfs3/super.c                    |  2 +-
>   fs/xfs/xfs_discard.c                |  2 +-
>   fs/xfs/xfs_log_cil.c                |  2 +-
>   include/linux/blkdev.h              | 27 +++++++-----
>   mm/swapfile.c                       |  6 +--
>   33 files changed, 168 insertions(+), 99 deletions(-)
[snipped]
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 097577ae3c471..ce13c272c3872 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -336,7 +336,7 @@ static int bch_allocator_thread(void *arg)
>   				mutex_unlock(&ca->set->bucket_lock);
>   				blkdev_issue_discard(ca->bdev,
>   					bucket_to_sector(ca->set, bucket),
> -					ca->sb.bucket_size, GFP_KERNEL, 0);
> +					ca->sb.bucket_size, GFP_KERNEL);
>   				mutex_lock(&ca->set->bucket_lock);
>   			}
>   


[snipped]

