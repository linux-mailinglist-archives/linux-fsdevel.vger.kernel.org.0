Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56332ED3C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbhAGPtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 10:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728445AbhAGPte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610034488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDaftgeeZ7W1VliR39bzmF/2KN14UchQ7T5nm6XtJEk=;
        b=M5GFZ2jZttU3iBCdvRxi/76GZL7J3d6bruKMIOCkbY7UicLUpijPyeHx8oSFtzM0/3uLe9
        V5VDt+fY5ZXsaO1tKwc/0aML4jJTP2g54ovwHYYAL58DdZAtSLrco8XxBNjuJWNFS9OhKw
        397TFufaA1hx09IuUXqT3iP6pVFTjVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-5utIsjstOCa0C84xFeGfdA-1; Thu, 07 Jan 2021 10:48:03 -0500
X-MC-Unique: 5utIsjstOCa0C84xFeGfdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D9D107ACE3;
        Thu,  7 Jan 2021 15:48:02 +0000 (UTC)
Received: from starship (unknown [10.35.206.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4954119C48;
        Thu,  7 Jan 2021 15:48:01 +0000 (UTC)
Message-ID: <382d2087bb8652861bf30dec1b9096c44d093e00.camel@redhat.com>
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Date:   Thu, 07 Jan 2021 17:48:00 +0200
In-Reply-To: <20210107154034.1490-1-jack@suse.cz>
References: <20210107154034.1490-1-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-01-07 at 16:40 +0100, Jan Kara wrote:
> blkdev_fallocate() tries to detect whether a discard raced with an
> overlapping write by calling invalidate_inode_pages2_range(). However
> this check can give both false negatives (when writing using direct IO
> or when writeback already writes out the written pagecache range) and
> false positives (when write is not actually overlapping but ends in the
> same page when blocksize < pagesize). This actually causes issues for
> qemu which is getting confused by EBUSY errors.
> 
> Fix the problem by removing this conflicting write detection since it is
> inherently racy and thus of little use anyway.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> Link: https://lore.kernel.org/qemu-devel/20201111153913.41840-1-mlevitsk@redhat.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/block_dev.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3e5b02f6606c..a97f43b49839 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1797,13 +1797,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		return error;
>  
>  	/*
> -	 * Invalidate again; if someone wandered in and dirtied a page,
> -	 * the caller will be given -EBUSY.  The third argument is
> -	 * inclusive, so the rounding here is safe.
> +	 * Invalidate the page cache again; if someone wandered in and dirtied
> +	 * a page, we just discard it - userspace has no way of knowing whether
> +	 * the write happened before or after discard completing...
>  	 */
> -	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
> -					     start >> PAGE_SHIFT,
> -					     end >> PAGE_SHIFT);
> +	return truncate_bdev_range(bdev, file->f_mode, start, end);
>  }


But what happens if write and discard don't overlap? Won't we
discard the written data in this case?


Best regards,
	Maxim Levitsky


>  
>  const struct file_operations def_blk_fops = {


