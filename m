Return-Path: <linux-fsdevel+bounces-4357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABD7FEF38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069A6B20C4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C138F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852910DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:38:57 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VZRTtEY_1701340734;
Received: from 30.46.227.138(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VZRTtEY_1701340734)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 18:38:54 +0800
Message-ID: <e347d634-1964-4fd0-a1fd-961f6bc373dc@antgroup.com>
Date: Thu, 30 Nov 2023 18:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 2/2] fuse: Use the high bit of request ID for
 indicating resend requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20231129094317.453025-1-winters.zc@antgroup.com>
 <20231129094317.453025-3-winters.zc@antgroup.com>
 <CAJfpegtbhTRVDbRXvMf6jNnCU23HdYFWqKMSzQNcKN5QKrw9AA@mail.gmail.com>
From: "Zhao Chen" <winters.zc@antgroup.com>
In-Reply-To: <CAJfpegtbhTRVDbRXvMf6jNnCU23HdYFWqKMSzQNcKN5QKrw9AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/29 下午11:04, Miklos Szeredi 写道:
> On Wed, 29 Nov 2023 at 10:43, Zhao Chen <winters.zc@antgroup.com> wrote:
>>
>> Some FUSE daemons want to know if the received request is a resend
>> request, after writing to the sysfs resend API. The high bit of the fuse
>> request id is utilized for indicating this, enabling the receiver to
>> perform appropriate handling.
>>
>> An init flag is added to indicate this feature.
>>
>> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
>> ---
>>   fs/fuse/dev.c             | 11 +++++++----
>>   fs/fuse/inode.c           |  3 ++-
>>   include/uapi/linux/fuse.h | 11 +++++++++++
>>   3 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index c91cb2bd511b..8a90a41b9a17 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -28,6 +28,7 @@ MODULE_ALIAS("devname:fuse");
>>   /* Ordinary requests have even IDs, while interrupts IDs are odd */
>>   #define FUSE_INT_REQ_BIT (1ULL << 0)
>>   #define FUSE_REQ_ID_STEP (1ULL << 1)
>> +#define FUSE_REQ_ID_MASK (~(FUSE_INT_REQ_BIT | FUSE_REQ_ID_RESEND_BIT))
>>
>>   static struct kmem_cache *fuse_req_cachep;
>>
>> @@ -194,14 +195,14 @@ EXPORT_SYMBOL_GPL(fuse_len_args);
>>
>>   u64 fuse_get_unique(struct fuse_iqueue *fiq)
>>   {
>> -       fiq->reqctr += FUSE_REQ_ID_STEP;
>> +       fiq->reqctr = (fiq->reqctr + FUSE_REQ_ID_STEP) & FUSE_REQ_ID_MASK;
>>          return fiq->reqctr;
>>   }
>>   EXPORT_SYMBOL_GPL(fuse_get_unique);
>>
>>   static unsigned int fuse_req_hash(u64 unique)
>>   {
>> -       return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
>> +       return hash_long(unique & FUSE_REQ_ID_MASK, FUSE_PQ_HASH_BITS);
> 
> Possible simplification if FUSE_REQ_ID_RESEND_BIT is not used as a
> separate flag, but as a part of the unique request ID.  That way
> there's no need to mask it out.

Yes, I will simplify it in v3.

> 
>>   }
>>
>>   /*
>> @@ -1813,7 +1814,7 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
>>          struct fuse_req *req;
>>
>>          list_for_each_entry(req, &fpq->processing[hash], list) {
>> -               if (req->in.h.unique == unique)
>> +               if ((req->in.h.unique & FUSE_REQ_ID_MASK) == unique)
> 
> Same here.

OK.

> 
> 
>>                          return req;
>>          }
>>          return NULL;
>> @@ -1884,7 +1885,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>>          spin_lock(&fpq->lock);
>>          req = NULL;
>>          if (fpq->connected)
>> -               req = request_find(fpq, oh.unique & ~FUSE_INT_REQ_BIT);
>> +               req = request_find(fpq, oh.unique & FUSE_REQ_ID_MASK);
>>
>>          err = -ENOENT;
>>          if (!req) {
>> @@ -2274,6 +2275,8 @@ void fuse_resend_pqueue(struct fuse_conn *fc)
>>
>>          list_for_each_entry_safe(req, next, &to_queue, list) {
>>                  __set_bit(FR_PENDING, &req->flags);
>> +               /* mark the request as resend request */
>> +               req->in.h.unique |= FUSE_REQ_ID_RESEND_BIT;
>>          }
>>
>>          spin_lock(&fiq->lock);
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 2a6d44f91729..e774865fbfa3 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1330,7 +1330,8 @@ void fuse_send_init(struct fuse_mount *fm)
>>                  FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>>                  FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
>>                  FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>> -               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
>> +               FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>> +               FUSE_UID_HAS_RESEND_BIT;
>>   #ifdef CONFIG_FUSE_DAX
>>          if (fm->fc->dax)
>>                  flags |= FUSE_MAP_ALIGNMENT;
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index e7418d15fe39..ecfb7cbcfe30 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -410,6 +410,8 @@ struct fuse_file_lock {
>>    *                     symlink and mknod (single group that matches parent)
>>    * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
>>    * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
>> + * FUSE_UID_HAS_RESEND_BIT: use high bit of request ID for indicating resend
>> + *                         requests
>>    */
>>   #define FUSE_ASYNC_READ                (1 << 0)
>>   #define FUSE_POSIX_LOCKS       (1 << 1)
>> @@ -449,6 +451,7 @@ struct fuse_file_lock {
>>   #define FUSE_CREATE_SUPP_GROUP (1ULL << 34)
>>   #define FUSE_HAS_EXPIRE_ONLY   (1ULL << 35)
>>   #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
>> +#define FUSE_UID_HAS_RESEND_BIT (1ULL << 37)
> 
> "FUSE_HAS_RESEND" should be sufficiently descriptive.

Yes, "FUSE_HAS_RESEND" is better.

>>
>>   /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
>>   #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
>> @@ -960,6 +963,14 @@ struct fuse_fallocate_in {
>>          uint32_t        padding;
>>   };
>>
>> +/**
>> + * FUSE request unique ID flag
>> + *
>> + * Indicates whether this is a resend request. The receiver should handle this
>> + * request accordingly.
>> + */
>> +#define FUSE_REQ_ID_RESEND_BIT (1ULL << 63)
> 
> How about "FUSE_UNIQUE_RESEND"?
> 
> Thanks,
> Miklos

Yes, "FUSE_UNIQUE_RESEND" is better. Thank you for your patient review!

Regards,
Zhao Chen


