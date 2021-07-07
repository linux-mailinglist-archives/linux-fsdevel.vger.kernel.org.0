Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F703BE83D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhGGMup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231660AbhGGMuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625662083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+Yj0Rbydzr94inG/7jICqp0c5D/s6sS1R9wfONqCYQ=;
        b=aJLedEVzJmkvbac5UMDsKvOJRiP7XqWKMynGsIg99Xzo0elcUFTPz6HCYCH9ORQ0xzhmQV
        J9w5o6nmvsNh+BnuTI+uBDZ4ne/EE0sdTgHDws8xZTXTjjyMgXo0V7fFiE1Q0b7k8lATAX
        bwY8Oyexe7WZDbGhbLcO6dsOTIgM4PM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-qCBBQLvZO3e1Vl6JtYSiYQ-1; Wed, 07 Jul 2021 08:48:02 -0400
X-MC-Unique: qCBBQLvZO3e1Vl6JtYSiYQ-1
Received: by mail-pg1-f197.google.com with SMTP id i189-20020a6387c60000b0290228552e3ac7so1666795pge.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 05:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i+Yj0Rbydzr94inG/7jICqp0c5D/s6sS1R9wfONqCYQ=;
        b=HK4bdluXcjM8A8WX1+AIDYMZ4JQgPApyA0E9oNMOVCSaWaFsozd4XjYOLS8qxSO4hd
         3EGB7jMq4qmaSAGU4iAf1ECd9CrTCqAwXvFKaMf/GchJ32VOsXcOXaNypclNNA+6sxr5
         ysd+IpSHI1fKauC4fQWJBpyV381LMID2ZV+uNaN3zh9ACAgt+81l50c7F6LOhVLJW7MU
         DW0cAao4UuY+LyB0TJiedTEoYY4gxZCb4G3tZ5/tk4FvwUU2d8gNL2jisssHB7GXeOSb
         le/QWzqNPs0qy28dAl6raipdRemTfJgon9AK4fkgQf9L4jhnXuJzqu5wjmd66NpBhuBj
         dZ8Q==
X-Gm-Message-State: AOAM533/ne6X7cDsJZKW7vCyQEmXmMFRkzvxhWPaeGJsoFyE/0y/qDSj
        sxjL+7Bt5Fe50sMz8KF0trZzybnquMXI6A9wpR+IrlHmpJFz3Gm+EAAipxO5x0a2DXbDxt3R8Rr
        9D0oTHPlO3tSbnPymWiK6G+C6kw==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr21014123plh.11.1625662081480;
        Wed, 07 Jul 2021 05:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeWwVAdBuz+rP20tD0ZI0KDY3z6MlvIGK1Zu12IpSt8wDkWaf6/FRssapZWLuS+3u0Yb88RQ==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr21014107plh.11.1625662081214;
        Wed, 07 Jul 2021 05:48:01 -0700 (PDT)
Received: from [10.72.12.137] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d9sm19355738pfd.91.2021.07.07.05.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 05:48:00 -0700 (PDT)
Subject: Re: [RFC PATCH v7 07/24] ceph: add fscrypt_* handling to caps.c
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-8-jlayton@kernel.org>
 <f8c7dc0f-49ee-2c25-8e41-e47557db80e4@redhat.com>
 <82a5c4dbcb9ccc131ab426490484334b02627691.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8b3bd09a-a4ab-176f-091b-1b40c24a2084@redhat.com>
Date:   Wed, 7 Jul 2021 20:47:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <82a5c4dbcb9ccc131ab426490484334b02627691.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/7/21 8:02 PM, Jeff Layton wrote:
> On Wed, 2021-07-07 at 15:20 +0800, Xiubo Li wrote:
>> Hi Jeff,
>>
>> There has some following patches in your "fscrypt" branch, which is not
>> posted yet, the commit is:
>>
>> "3161d2f549db ceph: size handling for encrypted inodes in cap updates"
>>
>> It seems buggy.
>>
> Yes. Those are still quite rough. If I haven't posted them, then YMMV. I
> often push them to -experimental branches just for backup purposes. You
> may want to wait on reviewing those until I've had a chance to clean
> them up and post them.

Yeah, sure.

I am reviewing the code from you experimental branch.


>> In the encode_cap_msg() you have removed the 'fscrypt_file_len' and and
>> added a new 8 bytes' data encoding:
>>
>>           ceph_encode_32(&p, arg->fscrypt_auth_len);
>>           ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
>> -       ceph_encode_32(&p, arg->fscrypt_file_len);
>> -       ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
>> +       ceph_encode_32(&p, sizeof(__le64));
>> +       ceph_encode_64(&p, fc->size);
>>
>> That means no matter the 'arg->encrypted' is true or not, here it will
>> always encode extra 8 bytes' data ?
>>
>>
>> But in cap_msg_size(), you are making it optional:
>>
>>
>>    static inline int cap_msg_size(struct cap_msg_args *arg)
>>    {
>>           return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
>> -                       arg->fscrypt_file_len;
>> +                       arg->encrypted ? sizeof(__le64) : 0;
>>    }
>>
>>
>> Have I missed something important here ?
>>
>> Thanks
>>
> Nope, you're right. I had fixed that one in my local branch already, and
> just hadn't yet pushed it to the repo. I'll plan to clean this up a bit
> later today and push an updated branch.

Cool.

Thanks.


>
>> On 6/25/21 9:58 PM, Jeff Layton wrote:
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/caps.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
>>>    1 file changed, 49 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>> index 038f59cc4250..1be6c5148700 100644
>>> --- a/fs/ceph/caps.c
>>> +++ b/fs/ceph/caps.c
>>> @@ -13,6 +13,7 @@
>>>    #include "super.h"
>>>    #include "mds_client.h"
>>>    #include "cache.h"
>>> +#include "crypto.h"
>>>    #include <linux/ceph/decode.h>
>>>    #include <linux/ceph/messenger.h>
>>>    
>>> @@ -1229,15 +1230,12 @@ struct cap_msg_args {
>>>    	umode_t			mode;
>>>    	bool			inline_data;
>>>    	bool			wake;
>>> +	u32			fscrypt_auth_len;
>>> +	u32			fscrypt_file_len;
>>> +	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
>>> +	u8			fscrypt_file[sizeof(u64)]; // for size
>>>    };
>>>    
>>> -/*
>>> - * cap struct size + flock buffer size + inline version + inline data size +
>>> - * osd_epoch_barrier + oldest_flush_tid
>>> - */
>>> -#define CAP_MSG_SIZE (sizeof(struct ceph_mds_caps) + \
>>> -		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4)
>>> -
>>>    /* Marshal up the cap msg to the MDS */
>>>    static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>>>    {
>>> @@ -1253,7 +1251,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>>>    	     arg->size, arg->max_size, arg->xattr_version,
>>>    	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
>>>    
>>> -	msg->hdr.version = cpu_to_le16(10);
>>> +	msg->hdr.version = cpu_to_le16(12);
>>>    	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
>>>    
>>>    	fc = msg->front.iov_base;
>>> @@ -1324,6 +1322,16 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>>>    
>>>    	/* Advisory flags (version 10) */
>>>    	ceph_encode_32(&p, arg->flags);
>>> +
>>> +	/* dirstats (version 11) - these are r/o on the client */
>>> +	ceph_encode_64(&p, 0);
>>> +	ceph_encode_64(&p, 0);
>>> +
>>> +	/* fscrypt_auth and fscrypt_file (version 12) */
>>> +	ceph_encode_32(&p, arg->fscrypt_auth_len);
>>> +	ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
>>> +	ceph_encode_32(&p, arg->fscrypt_file_len);
>>> +	ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
>>>    }
>>>    
>>>    /*
>>> @@ -1445,6 +1453,26 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>>>    		}
>>>    	}
>>>    	arg->flags = flags;
>>> +	if (ci->fscrypt_auth_len &&
>>> +	    WARN_ON_ONCE(ci->fscrypt_auth_len != sizeof(struct ceph_fscrypt_auth))) {
>>> +		/* Don't set this if it isn't right size */
>>> +		arg->fscrypt_auth_len = 0;
>>> +	} else {
>>> +		arg->fscrypt_auth_len = ci->fscrypt_auth_len;
>>> +		memcpy(arg->fscrypt_auth, ci->fscrypt_auth,
>>> +			min_t(size_t, ci->fscrypt_auth_len, sizeof(arg->fscrypt_auth)));
>>> +	}
>>> +	/* FIXME: use this to track "real" size */
>>> +	arg->fscrypt_file_len = 0;
>>> +}
>>> +
>>> +#define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
>>> +		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
>>> +
>>> +static inline int cap_msg_size(struct cap_msg_args *arg)
>>> +{
>>> +	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
>>> +			arg->fscrypt_file_len;
>>>    }
>>>    
>>>    /*
>>> @@ -1457,7 +1485,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
>>>    	struct ceph_msg *msg;
>>>    	struct inode *inode = &ci->vfs_inode;
>>>    
>>> -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
>>> +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS, false);
>>>    	if (!msg) {
>>>    		pr_err("error allocating cap msg: ino (%llx.%llx) flushing %s tid %llu, requeuing cap.\n",
>>>    		       ceph_vinop(inode), ceph_cap_string(arg->dirty),
>>> @@ -1483,10 +1511,6 @@ static inline int __send_flush_snap(struct inode *inode,
>>>    	struct cap_msg_args	arg;
>>>    	struct ceph_msg		*msg;
>>>    
>>> -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
>>> -	if (!msg)
>>> -		return -ENOMEM;
>>> -
>>>    	arg.session = session;
>>>    	arg.ino = ceph_vino(inode).ino;
>>>    	arg.cid = 0;
>>> @@ -1524,6 +1548,18 @@ static inline int __send_flush_snap(struct inode *inode,
>>>    	arg.flags = 0;
>>>    	arg.wake = false;
>>>    
>>> +	/*
>>> +	 * No fscrypt_auth changes from a capsnap. It will need
>>> +	 * to update fscrypt_file on size changes (TODO).
>>> +	 */
>>> +	arg.fscrypt_auth_len = 0;
>>> +	arg.fscrypt_file_len = 0;
>>> +
>>> +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(&arg),
>>> +			   GFP_NOFS, false);
>>> +	if (!msg)
>>> +		return -ENOMEM;
>>> +
>>>    	encode_cap_msg(msg, &arg);
>>>    	ceph_con_send(&arg.session->s_con, msg);
>>>    	return 0;

