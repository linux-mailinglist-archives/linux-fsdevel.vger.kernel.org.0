Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183B44343B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJTDMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 23:12:47 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35695 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhJTDMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 23:12:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ut.VWlg_1634699430;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Ut.VWlg_1634699430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 11:10:31 +0800
Subject: Re: [PATCH v6 4/7] fuse: negotiate per-file DAX in FUSE_INIT
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-5-jefflexu@linux.alibaba.com>
 <YW2E6jaTbv1FcFnu@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <778cd99d-fb40-1135-5d62-58a008c14919@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 11:10:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW2E6jaTbv1FcFnu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/18/21 10:30 PM, Vivek Goyal wrote:
> On Mon, Oct 11, 2021 at 11:00:49AM +0800, Jeffle Xu wrote:
>> Among the FUSE_INIT phase, client shall advertise per-file DAX if it's
>> mounted with "-o dax=inode". Then server is aware that client is in
>> per-file DAX mode, and will construct per-inode DAX attribute
>> accordingly.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/inode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index b4b41683e97e..f4ad99e2415b 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1203,6 +1203,8 @@ void fuse_send_init(struct fuse_mount *fm)
>>  #ifdef CONFIG_FUSE_DAX
>>  	if (fm->fc->dax)
>>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
>> +	if (fm->fc->dax_mode == FUSE_DAX_INODE)
>> +		ia->in.flags |= FUSE_PERFILE_DAX;
> 
> Are you not keeping track of server's response whether server supports
> per inode dax or not. Client might be new and server might be old and
> server might not support per inode dax. In that case, we probably 
> should error out if user mounted with "-o dax=inode".
> 

Yes, if guest virtiofs is mounted with '-o dax=inode' while virtiofsd is
old and doesn't support per inode dax, then guest virtiofs will never
receive FUSE_ATTR_DAX and actually behaves as '-o dax=never'. So the
whole system works in this case, though the behavior may be beyond the
expectation of users ....

If the behavior really matters, I could change the behavior and fail
directly if virtiofsd doesn't advertise supporting per inode DAX.

-- 
Thanks,
Jeffle
