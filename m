Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F9755DBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 10:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGQIDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGQID2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:03:28 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD87E5C
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 01:03:23 -0700 (PDT)
Message-ID: <7e172b70-807c-c879-6d1c-b11f4c39d144@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689581001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1RlKC/feGsn4VgTgizcJTjgvWSOnKcECYB8Hf86PPo=;
        b=ksN7xe1qs78cfrUCNYugdosoCw6OlLlO/hYoPS4HHxaCs9qU9SohEn94XwoZuDuy5+ixrB
        vusAcbffvBUb21/imEgUbOd0FNu1Ete+csUz+zqI8xkycup967M+WE3TW6v8Be1F9+QPQY
        bd7g5emtA5vaSnZBQWc60Dfux6esjto=
Date:   Mon, 17 Jul 2023 16:03:11 +0800
MIME-Version: 1.0
Subject: Re: [RFC] [PATCH] fuse: DIO writes always use the same code path
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

On 7/5/23 18:23, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> In commit 153524053bbb0d27bb2e0be36d1b46862e9ce74c DIO
> writes can be handled in parallel, as long as the file
> is not extended. So far this only works when daemon/server
> side set FOPEN_DIRECT_IO and FOPEN_PARALLEL_DIRECT_WRITES,
> but O_DIRECT (iocb->ki_flags & IOCB_DIRECT) went another
> code path that doesn't have the parallel DIO write
> optimization.
> Given that fuse_direct_write_iter has to handle page writes
> and invalidation anyway (for mmap), the DIO handler in
> fuse_cache_write_iter() is removed and DIO writes are now
> only handled by fuse_direct_write_iter().
> 
> Note: Correctness of this patch depends on a non-merged
> series from Hao Xu <hao.xu@linux.dev>
> ( fuse: add a new fuse init flag to relax restrictions in no cache mode)
> ---
>   fs/fuse/file.c |   38 +++++---------------------------------
>   1 file changed, 5 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 89d97f6188e0..1490329b536c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1337,11 +1337,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb 
> *iocb, struct iov_iter *from)
>       struct file *file = iocb->ki_filp;
>       struct address_space *mapping = file->f_mapping;
>       ssize_t written = 0;
> -    ssize_t written_buffered = 0;
>       struct inode *inode = mapping->host;
>       ssize_t err;
>       struct fuse_conn *fc = get_fuse_conn(inode);
> -    loff_t endbyte = 0;
> 
>       if (fc->writeback_cache) {
>           /* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1377,37 +1375,10 @@ static ssize_t fuse_cache_write_iter(struct 
> kiocb *iocb, struct iov_iter *from)
>       if (err)
>           goto out;
> 
> -    if (iocb->ki_flags & IOCB_DIRECT) {
> -        loff_t pos = iocb->ki_pos;
> -        written = generic_file_direct_write(iocb, from);
> -        if (written < 0 || !iov_iter_count(from))
> -            goto out;
> -
> -        pos += written;
> -
> -        written_buffered = fuse_perform_write(iocb, mapping, from, pos);
> -        if (written_buffered < 0) {
> -            err = written_buffered;
> -            goto out;
> -        }
> -        endbyte = pos + written_buffered - 1;
> -
> -        err = filemap_write_and_wait_range(file->f_mapping, pos,
> -                           endbyte);
> -        if (err)
> -            goto out;
> -
> -        invalidate_mapping_pages(file->f_mapping,
> -                     pos >> PAGE_SHIFT,
> -                     endbyte >> PAGE_SHIFT);
> +    written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
> +    if (written >= 0)
> +        iocb->ki_pos += written;
> 
> -        written += written_buffered;
> -        iocb->ki_pos = pos + written_buffered;
> -    } else {
> -        written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
> -        if (written >= 0)
> -            iocb->ki_pos += written;
> -    }
>   out:
>       current->backing_dev_info = NULL;
>       inode_unlock(inode);
> @@ -1691,7 +1662,8 @@ static ssize_t fuse_file_write_iter(struct kiocb 
> *iocb, struct iov_iter *from)
>       if (FUSE_IS_DAX(inode))
>           return fuse_dax_write_iter(iocb, from);
> 
> -    if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +    if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
> +        !(iocb->ki_flags & IOCB_DIRECT))
>           return fuse_cache_write_iter(iocb, from);
>       else
>           return fuse_direct_write_iter(iocb, from);
> 

For normal direct io(IOCB_DIRECT set, FOPEN_DIRECT_IO not set), it now
goes to fuse_direct_write_iter() but the thing is the previous patchset
I sent adds page flush and invalidation in FOPEN_DIRECT_IO
and/or fc->direct_io_relax, so I guess this part(flush and invalidation)
is not included in the normal direct io code path.

Regards,
Hao

