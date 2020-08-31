Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174BA257EE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHaQh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 12:37:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33952 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaQh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:37:56 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1CF6A1B44DF;
        Tue,  1 Sep 2020 01:37:54 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VGbqgR365803
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 01:37:53 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VGbqKn3458441
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 01:37:52 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07VGbp6g3458440;
        Tue, 1 Sep 2020 01:37:51 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
References: <87ft85osn6.fsf@mail.parknet.co.jp>
        <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
Date:   Tue, 01 Sep 2020 01:37:51 +0900
In-Reply-To: <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 09:22:15 -0600")
Message-ID: <87o8mq6aao.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On Sat, Aug 29, 2020 at 7:08 PM OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>
>> On one system, there was bdi->io_pages==0. This seems to be the bug of
>> a driver somewhere, and should fix it though. Anyway, it is better to
>> avoid the divide-by-zero Oops.
>>
>> So this check it.
>>
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  fs/fat/fatent.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
>> index f7e3304..98a1c4f 100644
>> --- a/fs/fat/fatent.c   2020-08-30 06:52:47.251564566 +0900
>> +++ b/fs/fat/fatent.c   2020-08-30 06:54:05.838319213 +0900
>> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
>>         if (fatent->entry >= ent_limit)
>>                 return;
>>
>> -       if (ra_pages > sb->s_bdi->io_pages)
>> +       if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
>>                 ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
>>         reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);
>
> I don't think we should work-around this here. What device is this on?
> Something like the below may help.

The reported bug is from nvme stack, and the below patch (I submitted
same patch to you) fixed the reported case though. But I didn't verify
all possible path, so I'd liked to use safer side.

If block layer can guarantee io_pages!=0 instead, and can apply to
stable branch (5.8+). It would work too.

Thanks.

> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..10c08ac50697 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -539,6 +539,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>  		goto fail_stats;
>  
>  	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
> +	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
>  	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
>  	q->node = node_id;


-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
