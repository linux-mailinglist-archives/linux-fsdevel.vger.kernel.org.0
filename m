Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB2742560
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjF2MHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjF2MHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:07:25 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 05:06:36 PDT
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [IPv6:2001:41d0:203:375::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE134237
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 05:06:35 -0700 (PDT)
Message-ID: <40ed526b-a5b0-cae1-0757-1bdfeb1002a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688040019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aginTdI1loOn44DJuVkIT4YXuXtpGohCw7P0VQcW8rM=;
        b=QreJKnMn5WmxJyiEfKhvzk0YRRzyhG44sB7vObg4UAL548uDOV41zjJlUkO9lzWO+CUBRv
        why4UjOW9jGaQC23e2NTSdPtiW76x/qvOcMrCCAgp+T487tp5AKrC4jDPoB++iL3RqkM7U
        6oRmT7+OMbqziVTXQar9VZzOUZWkcJQ=
Date:   Thu, 29 Jun 2023 20:00:12 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH] fuse: invalidate page cache pages before direct write
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230509080128.457489-1-hao.xu@linux.dev>
 <0625d0cb-2a65-ffae-b072-e14a3f6c7571@linux.dev>
 <7da6719c-23ee-736e-6787-1aad56d22e07@fastmail.fm>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <7da6719c-23ee-736e-6787-1aad56d22e07@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

On 6/27/23 02:23, Bernd Schubert wrote:
> 
> 
> On 6/8/23 09:17, Hao Xu wrote:
>> Ping...
>>
>> On 5/9/23 16:01, Hao Xu wrote:
>>> From: Hao Xu <howeyxu@tencent.com>
>>>
>>> In FOPEN_DIRECT_IO, page cache may still be there for a file, direct
>>> write should respect that and invalidate the corresponding pages so
>>> that page cache readers don't get stale data. Another thing this patch
>>> does is flush related pages to avoid its loss.
>>>
>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>> ---
>>>
>>> Reference:
>>> https://lore.kernel.org/linux-fsdevel/ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev/#:~:text=I%20think%20this%20problem%20exists%20before%20this%20patchset
>>>
>>>   fs/fuse/file.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 89d97f6188e0..edc84c1dfc5c 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1490,7 +1490,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, 
>>> struct iov_iter *iter,
>>>       int write = flags & FUSE_DIO_WRITE;
>>>       int cuse = flags & FUSE_DIO_CUSE;
>>>       struct file *file = io->iocb->ki_filp;
>>> -    struct inode *inode = file->f_mapping->host;
>>> +    struct address_space *mapping = file->f_mapping;
>>> +    struct inode *inode = mapping->host;
>>>       struct fuse_file *ff = file->private_data;
>>>       struct fuse_conn *fc = ff->fm->fc;
>>>       size_t nmax = write ? fc->max_write : fc->max_read;
>>> @@ -1516,6 +1517,17 @@ ssize_t fuse_direct_io(struct fuse_io_priv 
>>> *io, struct iov_iter *iter,
>>>               inode_unlock(inode);
>>>       }
>>> +    res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
>>> +    if (res)
>>> +        return res;
>>> +
>>> +    if (write) {
>>> +        if (invalidate_inode_pages2_range(mapping,
>>> +                idx_from, idx_to)) {
>>> +            return -ENOTBLK;
>>> +        }
>>> +    }
>>> +
>>>       io->should_dirty = !write && user_backed_iter(iter);
>>>       while (count) {
>>>           ssize_t nres;
>>
> 
> Is this part not working?
> 
>      if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>          if (!write)
>              inode_lock(inode);
>          fuse_sync_writes(inode);
>          if (!write)
>              inode_unlock(inode);
>      }
> 
> 


This code seems to be waiting for already triggered page cache writeback
requests, it's not related with the issue this patch tries to address.
The issue here is we should invalidate related page cache page before we
do direct write.

Regards,
Hao

> 
> Thanks,
> Bernd

