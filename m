Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A244E019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 03:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhKLCHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 21:07:47 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46526 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhKLCHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:07:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uw6nhTS_1636682694;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uw6nhTS_1636682694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Nov 2021 10:04:55 +0800
Subject: Re: [PATCH v7 5/7] fuse: negotiate per inode DAX in FUSE_INIT
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
 <20211102052604.59462-6-jefflexu@linux.alibaba.com>
 <YY1yzRcX6u60zYAl@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <eb6b386f-cbdd-8219-98af-93b3b3291b73@linux.alibaba.com>
Date:   Fri, 12 Nov 2021 10:04:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YY1yzRcX6u60zYAl@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/12/21 3:45 AM, Vivek Goyal wrote:
> On Tue, Nov 02, 2021 at 01:26:02PM +0800, Jeffle Xu wrote:
>> Among the FUSE_INIT phase, client shall advertise per inode DAX if it's
>> mounted with "dax=inode". Then server is aware that client is in per
>> inode DAX mode, and will construct per-inode DAX attribute accordingly.
>>
>> Server shall also advertise support for per inode DAX. If server doesn't
>> support it while client is mounted with "dax=inode", client will
>> silently fallback to "dax=never" since "dax=inode" is advisory only.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/dax.c    |  2 +-
>>  fs/fuse/fuse_i.h |  3 +++
>>  fs/fuse/inode.c  | 16 +++++++++++++---
>>  3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index 8a328fb20dcb..c8ee601b94b8 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -1350,7 +1350,7 @@ static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>>  		return true;
>>  
>>  	/* dax_mode is FUSE_DAX_INODE or FUSE_DAX_NONE */
>> -	return flags & FUSE_ATTR_DAX;
>> +	return fc->inode_dax && (flags & FUSE_ATTR_DAX);
>>  }
>>  
>>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 055b39430540..58e54b5a4d65 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -777,6 +777,9 @@ struct fuse_conn {
>>  	/* Propagate syncfs() to server */
>>  	unsigned int sync_fs:1;
>>  
>> +	/* Does the filesystem support per inode DAX? */
>> +	unsigned int inode_dax:1;
>> +
>>  	/** The number of requests waiting for completion */
>>  	atomic_t num_waiting;
>>  
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index acba14002d04..0512d8cb36c3 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1136,11 +1136,19 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>  					min_t(unsigned int, fc->max_pages_limit,
>>  					max_t(unsigned int, arg->max_pages, 1));
>>  			}
>> -			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
>> -			    arg->flags & FUSE_MAP_ALIGNMENT &&
>> +#ifdef CONFIG_FUSE_DAX
>> +			if ((arg->flags & FUSE_HAS_INODE_DAX) &&
>> +			    fuse_is_inode_dax_mode(fc->dax_mode)) {
> 
> Why do we call fuse_is_inode_dax_mode() here? While sending INIT request
> we set FUSE_HAS_INODE_DAX only if fuse_is_inode_dax_mode() is true. So
> we should not have to call it again when server replies.?

OK I'll remove this redundant call for fuse_is_inode_dax_mode(). If fuse
server replies with FUSE_HAS_INODE_DAX when fuse client doesn't
advertise FUSE_HAS_INODE_DAX, then obviously fuse server shall be blamed.


> 
>> +				fc->inode_dax = 1;
>> +			}
>> +			if (arg->flags & FUSE_MAP_ALIGNMENT &&
>>  			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
>> -				ok = false;
>> +				if (fuse_is_inode_dax_mode(fc->dax_mode))
>> +					fc->inode_dax = 0;
> 
> If mapping alignment is not right, I guess we can fail (even in case
> of dax=inode). In this case client wants per dax inode, server supports
> it but alignment is wrong. I think that should be an error and user should
> fix it. IMHO, just leave this code path in place and we will error out.

I'm OK with the behavior of reporting error directly, but I'm afraid the
behavior is inconsistency then. That is, the following requirements are
needed to support DAX mode:

1. the virtiofs device doesn't support DAX at all
(VIRTIO_FS_SHMCAP_ID_CACHE not defined at all)
2. server's map alignment is non-compliant (fail fuse_dax_check_alignment())
3. server doesn't advertise support for per inode DAX
(FUSE_HAS_INODE_DAX) during FUSE_INIT

When virtiofs is mounted in 'dax=inode' mode inside guest, when case 1/3
occur, we silently fallback to 'dax=never'; while case 2 occurs, we just
error out.

-- 
Thanks,
Jeffle
