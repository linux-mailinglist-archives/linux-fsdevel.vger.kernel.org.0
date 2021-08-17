Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8244A3EED4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhHQNYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 09:24:37 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50134 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239973AbhHQNYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjRGOPv_1629206627;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjRGOPv_1629206627)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 21:23:47 +0800
Subject: Re: [Virtio-fs] [PATCH v4 6/8] fuse: mark inode DONT_CACHE when
 per-file DAX indication changes
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022220.17574-7-jefflexu@linux.alibaba.com>
 <YRuO5ZzqDmuSC3pN@work-vm>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <f5f91a42-3997-2df8-a126-cf390291beea@linux.alibaba.com>
Date:   Tue, 17 Aug 2021 21:23:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRuO5ZzqDmuSC3pN@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/17/21 6:26 PM, Dr. David Alan Gilbert wrote:
> * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
>> When the per-file DAX indication changes while the file is still
>> *opened*, it is quite complicated and maybe fragile to dynamically
>> change the DAX state.
>>
>> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> 
>                                                      ^^^^^^^^^^
> typo as DONT ?
> 

Thanks. I will fix it.

> 
>> per-file DAX indication changes, so that the inode instance will be
>> evicted and freed as soon as possible once the file is closed and the
>> last reference to the inode is put. And then when the file gets reopened
>> next time, the inode will reflect the new DAX state.
>>
>> In summary, when the per-file DAX indication changes for an *opened*
>> file, the state of the file won't be updated until this file is closed
>> and reopened later.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/dax.c    | 9 +++++++++
>>  fs/fuse/fuse_i.h | 1 +
>>  fs/fuse/inode.c  | 3 +++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index 30833f8d37dd..f7ede0be4e00 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>>  }
>>  
>> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
>> +{
>> +	struct fuse_conn *fc = get_fuse_conn(inode);
>> +
>> +	if (fc->dax_mode == FUSE_DAX_INODE &&
>> +	    fc->perfile_dax && (!!IS_DAX(inode) != newdax))
>> +		d_mark_dontcache(inode);
>> +}
>> +
>>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
>>  {
>>  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 7b7b4c208af2..56fe1c4d2136 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -1260,6 +1260,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>>  void fuse_dax_inode_cleanup(struct inode *inode);
>> +void fuse_dax_dontcache(struct inode *inode, bool newdax);
>>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>>  void fuse_dax_cancel_work(struct fuse_conn *fc);
>>  
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 8080f78befed..8c9774c6a210 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -269,6 +269,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>>  		if (inval)
>>  			invalidate_inode_pages2(inode->i_mapping);
>>  	}
>> +
>> +	if (IS_ENABLED(CONFIG_FUSE_DAX))
>> +		fuse_dax_dontcache(inode, attr->flags & FUSE_ATTR_DAX);
>>  }
>>  
>>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
>> -- 
>> 2.27.0
>>
>> _______________________________________________
>> Virtio-fs mailing list
>> Virtio-fs@redhat.com
>> https://listman.redhat.com/mailman/listinfo/virtio-fs
>>

-- 
Thanks,
Jeffle
