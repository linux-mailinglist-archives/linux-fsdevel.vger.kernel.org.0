Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6054B7432E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjF3CxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjF3CxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:53:08 -0400
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E330D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:53:06 -0700 (PDT)
Message-ID: <b588f7a9-7b0f-1b07-dad0-4f9c5fbe27ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688093584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNYY2ch+AhQRhfGgtPdbuU80M2llLwBf2dvMDKLxqy0=;
        b=iJ3NctfE2mlkrm+Blj7qCdegcIr2/jvqwCVJtfNNbhSEPF/HnYkaXPf3CgwPmlGrUn2KE3
        JDTWXLY1JxHdDJ8BAxJBhlhlJ6B+UMOs7/M/w4Nq4NRXWl4maIlZrP6kQcK6XVc6ca5lGA
        aZHPkONXc84t4xY7sk6gjD+B+GXoF3I=
Date:   Fri, 30 Jun 2023 10:52:52 +0800
MIME-Version: 1.0
Subject: Re: [fuse-devel] [PATCH v2] fuse: add a new fuse init flag to relax
 restrictions in no cache mode
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net, miklos@szeredi.hu
References: <20230629081733.11309-1-hao.xu@linux.dev>
 <1f0bf6c6-eac8-1a13-17b2-48cec5e991e2@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <1f0bf6c6-eac8-1a13-17b2-48cec5e991e2@fastmail.fm>
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

Hi Bernd,

On 6/30/23 01:13, Bernd Schubert wrote:
> 
> 
> On 6/29/23 10:17, Hao Xu wrote:
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
>> coherency, e.g. network filesystems. Thus shared mmap is disabled since
>> it leverages page cache and may write to it, which may cause
>> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
>> reduce memory footprint as well, e.g. reduce guest memory usage with
>> virtiofs. Therefore, add a new fuse init flag FUSE_DIRECT_IO_RELAX to
>> relax restrictions in that mode, currently, it allows shared mmap.
>> One thing to note is to make sure it doesn't break coherency in your
>> use case.
>>
>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>> ---
>>
>> v1 -> v2:
>>      make the new flag a fuse init one rather than a open flag since it's
>>      not common that different files in a filesystem has different
>>      strategy of shared mmap.
>>
>>   fs/fuse/file.c            | 8 ++++++--
>>   fs/fuse/fuse_i.h          | 3 +++
>>   fs/fuse/inode.c           | 5 ++++-
>>   include/uapi/linux/fuse.h | 1 +
>>   4 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index bc4115288eec..871b66b54322 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -2478,14 +2478,18 @@ static const struct vm_operations_struct 
>> fuse_file_vm_ops = {
>>   static int fuse_file_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>>   {
>>       struct fuse_file *ff = file->private_data;
>> +    struct fuse_conn *fc = ff->fm->fc;
>>       /* DAX mmap is superior to direct_io mmap */
>>       if (FUSE_IS_DAX(file_inode(file)))
>>           return fuse_dax_mmap(file, vma);
>>       if (ff->open_flags & FOPEN_DIRECT_IO) {
>> -        /* Can't provide the coherency needed for MAP_SHARED */
>> -        if (vma->vm_flags & VM_MAYSHARE)
>> +        /* Can't provide the coherency needed for MAP_SHARED
>> +         * if FUSE_DIRECT_IO_RELAX isn't set.
>> +         */
>> +        if (!(ff->open_flags & fc->direct_io_relax) &&
>> +            vma->vm_flags & VM_MAYSHARE)
>>               return -ENODEV;
> 
> I'm confused here, the idea was that open_flags do not need additional 
> flags? Why is this not just
> 

sorry for this, seems I sent a WIP version by accident.., I'll fix it soon.

Thanks,
Hao

