Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB675C5D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGUL1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUL1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:27:38 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD661198D
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 04:27:36 -0700 (PDT)
Message-ID: <2622afd7-228f-02f3-3b72-a1c826844126@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689938855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1t9Noi98+yFXc3CQ7auVWOS7sGiO5j4YJVgm2UWIUI=;
        b=ZGXGQqmO6C2vVev3Ly+V0Mg0alKF5MCdliO6ovbAsCXUCYvlLt79Zy6TtMnonP+KVL7dl9
        jSQN+GBcm0eI2eVXdNSDM2fPs7tKd/W5iatU3+3OfsWaQnohX1dG16VXhyV1TnRFHqU1nG
        k4jub15DMgEV1AqUn7hXu4gQiA7Z/7E=
Date:   Fri, 21 Jul 2023 19:27:26 +0800
MIME-Version: 1.0
Subject: Re: [External] [fuse-devel] [PATCH 3/3] fuse: write back dirty pages
 before direct write in direct_io_relax mode
Content-Language: en-US
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        miklos@szeredi.hu
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-4-hao.xu@linux.dev>
 <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/23 14:35, Jiachen Zhang wrote:
> 
> On 2023/6/30 17:46, Hao Xu wrote:
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> In direct_io_relax mode, there can be shared mmaped files and thus dirty
>> pages in its page cache. Therefore those dirty pages should be written
>> back to backend before direct write to avoid data loss.
>>
>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>> ---
>>   fs/fuse/file.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 176f719f8fc8..7c9167c62bf6 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, 
>> struct iov_iter *iter,
>>       if (!ia)
>>           return -ENOMEM;
>> +    if (fopen_direct_write && fc->direct_io_relax) {
>> +        res = filemap_write_and_wait_range(mapping, pos, pos + count 
>> - 1);
>> +        if (res) {
>> +            fuse_io_free(ia);
>> +            return res;
>> +        }
>> +    }
>>       if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>>           if (!write)
>>               inode_lock(inode);
> 
> Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> 
> 
> Looks good to me.
> 
> By the way, the behaviour would be a first FUSE_WRITE flushing the page 
> cache, followed by a second FUSE_WRITE doing the direct IO. In the 
> future, further optimization could be first write into the page cache 
> and then flush the dirty page to the FUSE daemon.
> 

I think this makes sense, cannot think of any issue in it for now, so
I'll do that change and send next version, super thanks, Jiachen!

Thanks,
Hao

> 
> Thanks,
> Jiachen

