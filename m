Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D84BAF09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 02:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiBRBKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 20:10:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBRBKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:10:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 671153C4A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 17:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645146583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77v//07Q7Ub0x6y6b3OazX/wTU5H+y/7bl9FrnzFqoM=;
        b=hjxrCvmuk5CkrzYFQLMEwk99rz+rLGL8gGGdQmKkOKgv0PRsWysCKhV0ulh8uQrVrRzQ7E
        UzzsfGPtFwvb4BYT2zeLs/NssDEEneYkkZR7BJAEWpWBMpvusPeo0IY6fSN+SVAS7UZccs
        rouoFiiMXA43QoaW9faUi53ystEXsFU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-FxJRasPfOpeBSj4pZrikAQ-1; Thu, 17 Feb 2022 20:09:43 -0500
X-MC-Unique: FxJRasPfOpeBSj4pZrikAQ-1
Received: by mail-pg1-f197.google.com with SMTP id 145-20020a630397000000b00373b72d65f5so1353070pgd.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 17:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=77v//07Q7Ub0x6y6b3OazX/wTU5H+y/7bl9FrnzFqoM=;
        b=65v3Xwl243eIRfsrBTs8fWqtoWARTidgE+bmYoUibNGzBoBzVWQURt3NkznSTMp2NB
         qrL62Fq/RPk1uABwHikSEZjJKe6Q0acwVWgpRL4GnnO4g1Lb/7yPo4QN6Q6u2ByM9/NF
         y1/AwLLEasaWkOA43ZUFtbhfBnjbJOGz4vpGMYB6c7U9Se7w6qQ0zFVfdwQMZXEihxZl
         IrQZ5wVaCNcvWwB8H+phGy7OTD70r3te61s56dwfX9lFRj6tkhRNve88K7wRAoiFNV2n
         pkErjRpk4+VCahxSYFK0NoowgmK2RNOT7eOOI8MdsXjcc+APESJUds+lteU1CJiyX23r
         B3/g==
X-Gm-Message-State: AOAM530fL7CrCQbEzQIUALCDkJmx/h8XtZCEpir6qRfh1a/2mISJRFb/
        syv3pB81JsA2tjRS0FHK76NMtj76HM86TgglnhaY7l2WqBQDcNYDZFd0vmCO9mEF1p1/SiJGQUF
        iUpsu7w1DSa0gLClTclM8d/+8gQ==
X-Received: by 2002:a17:90a:2e07:b0:1b9:e28d:4f6d with SMTP id q7-20020a17090a2e0700b001b9e28d4f6dmr10059633pjd.81.1645146581244;
        Thu, 17 Feb 2022 17:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNnV1at+3ISbtwHH1vcv7uVWPCT98tmw/1kAkk/ypaov14xXhYNxViiblMVH4UghKULgWIiw==
X-Received: by 2002:a17:90a:2e07:b0:1b9:e28d:4f6d with SMTP id q7-20020a17090a2e0700b001b9e28d4f6dmr10059608pjd.81.1645146580901;
        Thu, 17 Feb 2022 17:09:40 -0800 (PST)
Received: from [10.72.12.153] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o1sm9089281pgv.47.2022.02.17.17.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 17:09:40 -0800 (PST)
Subject: Re: [RFC PATCH v10 07/48] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-8-jlayton@kernel.org>
 <4faa6b1e-1e64-da2e-f722-0fc75fec51b7@redhat.com>
 <91736a9af23930729a7079dfaf77d3933464fa9f.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7d77fcf4-72f0-329d-7791-01c3193a47da@redhat.com>
Date:   Fri, 18 Feb 2022 09:09:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <91736a9af23930729a7079dfaf77d3933464fa9f.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/17/22 7:39 PM, Jeff Layton wrote:
> On Thu, 2022-02-17 at 16:25 +0800, Xiubo Li wrote:
>> On 1/12/22 3:15 AM, Jeff Layton wrote:
>>> ...and store them in the ceph_inode_info.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/file.c       |  2 ++
>>>    fs/ceph/inode.c      | 18 ++++++++++++++-
>>>    fs/ceph/mds_client.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>>>    fs/ceph/mds_client.h |  4 ++++
>>>    fs/ceph/super.h      |  6 +++++
>>>    5 files changed, 84 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index ace72a052254..5937a25ddddd 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -597,6 +597,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>>>    	iinfo.xattr_data = xattr_buf;
>>>    	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>>>    
>>> +	/* FIXME: set fscrypt_auth and fscrypt_file */
>>> +
>>>    	in.ino = cpu_to_le64(vino.ino);
>>>    	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>>>    	in.version = cpu_to_le64(1);	// ???
>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>>> index 649d7a059d7b..d090fe081093 100644
>>> --- a/fs/ceph/inode.c
>>> +++ b/fs/ceph/inode.c
>>> @@ -609,7 +609,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>>>    	INIT_WORK(&ci->i_work, ceph_inode_work);
>>>    	ci->i_work_mask = 0;
>>>    	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
>>> -
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	ci->fscrypt_auth = NULL;
>>> +	ci->fscrypt_auth_len = 0;
>>> +#endif
>>>    	ceph_fscache_inode_init(ci);
>>>    
>>>    	return &ci->vfs_inode;
>>> @@ -620,6 +623,9 @@ void ceph_free_inode(struct inode *inode)
>>>    	struct ceph_inode_info *ci = ceph_inode(inode);
>>>    
>>>    	kfree(ci->i_symlink);
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	kfree(ci->fscrypt_auth);
>>> +#endif
>>>    	kmem_cache_free(ceph_inode_cachep, ci);
>>>    }
>>>    
>>> @@ -1020,6 +1026,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>>>    		xattr_blob = NULL;
>>>    	}
>>>    
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
>>> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>>> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
>>> +		iinfo->fscrypt_auth = NULL;
>>> +		iinfo->fscrypt_auth_len = 0;
>>> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
>>> +	}
>>> +#endif
>>> +
>>>    	/* finally update i_version */
>>>    	if (le64_to_cpu(info->version) > ci->i_version)
>>>    		ci->i_version = le64_to_cpu(info->version);
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index 57cf21c9199f..bd824e989449 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -184,8 +184,50 @@ static int parse_reply_info_in(void **p, void *end,
>>>    			info->rsnaps = 0;
>>>    		}
>>>    
>>> +		if (struct_v >= 5) {
>>> +			u32 alen;
>>> +
>>> +			ceph_decode_32_safe(p, end, alen, bad);
>>> +
>>> +			while (alen--) {
>>> +				u32 len;
>>> +
>>> +				/* key */
>>> +				ceph_decode_32_safe(p, end, len, bad);
>>> +				ceph_decode_skip_n(p, end, len, bad);
>>> +				/* value */
>>> +				ceph_decode_32_safe(p, end, len, bad);
>>> +				ceph_decode_skip_n(p, end, len, bad);
>>> +			}
>>> +		}
>>> +
>>> +		/* fscrypt flag -- ignore */
>>> +		if (struct_v >= 6)
>>> +			ceph_decode_skip_8(p, end, bad);
>>> +
>>> +		info->fscrypt_auth = NULL;
>>> +		info->fscrypt_file = NULL;
>> The 'fscrypt_auth_len' and 'fscrypt_file_len' should also be reset here.
>> Or we will hit the issue I mentioned as bellow:
>>
>>
>> cp: cannot access './dir___683': No buffer space available
>> cp: cannot access './dir___686': No buffer space available
>>
>> The dmesg logs:
>>
>> <7>[ 1256.918250] ceph:  readdir 0000000089964a71 file 00000000065cb689
>> pos 0
>> <7>[ 1256.918254] ceph:  readdir off 0 -> '.'
>> <7>[ 1256.918258] ceph:  readdir off 1 -> '..'
>> <4>[ 1256.918262] fscrypt (ceph, inode 1099511630270): Error -105
>> getting encryption context
>> <7>[ 1256.918269] ceph:  readdir 0000000089964a71 file 00000000065cb689
>> pos 2
>> <4>[ 1256.918273] fscrypt (ceph, inode 1099511630270): Error -105
>> getting encryption context
>>
>>
>> This can be reproduced when using an old ceph cluster without fscrypt
>> support.
>>
>> And also I have sent out one fix to zero the memory when allocating it
>> in ceph_readdir() to fix the potential bug like this.
>>
>> Thanks
>>
>> BRs
>>
>> -- Xiubo
>>
>>
> Good catch, Xiubo.
>
> I merged your patch into the testing branch, and fixed this patch to
> also zero out the fscrypt_auth_len and fscrypt_file_len. I've also
> rebased the wip-fscrypt branch onto the current testing branch.

Sure, I will test it.

-- Xiubo

>>> +		if (struct_v >= 7) {
>>> +			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
>>> +			if (info->fscrypt_auth_len) {
>>> +				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
>>> +				if (!info->fscrypt_auth)
>>> +					return -ENOMEM;
>>> +				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
>>> +						      info->fscrypt_auth_len, bad);
>>> +			}
>>> +			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
>>> +			if (info->fscrypt_file_len) {
>>> +				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
>>> +				if (!info->fscrypt_file)
>>> +					return -ENOMEM;
>>> +				ceph_decode_copy_safe(p, end, info->fscrypt_file,
>>> +						      info->fscrypt_file_len, bad);
>>> +			}
>>> +		}
>>>    		*p = end;
>>>    	} else {
>>> +		/* legacy (unversioned) struct */
>>>    		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
>>>    			ceph_decode_64_safe(p, end, info->inline_version, bad);
>>>    			ceph_decode_32_safe(p, end, info->inline_len, bad);
>>> @@ -626,8 +668,21 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>>>    
>>>    static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>>>    {
>>> +	int i;
>>> +
>>> +	kfree(info->diri.fscrypt_auth);
>>> +	kfree(info->diri.fscrypt_file);
>>> +	kfree(info->targeti.fscrypt_auth);
>>> +	kfree(info->targeti.fscrypt_file);
>>>    	if (!info->dir_entries)
>>>    		return;
>>> +
>>> +	for (i = 0; i < info->dir_nr; i++) {
>>> +		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
>>> +
>>> +		kfree(rde->inode.fscrypt_auth);
>>> +		kfree(rde->inode.fscrypt_file);
>>> +	}
>>>    	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>>>    }
>>>    
>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>> index c3986a412fb5..98a8710807d1 100644
>>> --- a/fs/ceph/mds_client.h
>>> +++ b/fs/ceph/mds_client.h
>>> @@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
>>>    	s32 dir_pin;
>>>    	struct ceph_timespec btime;
>>>    	struct ceph_timespec snap_btime;
>>> +	u8 *fscrypt_auth;
>>> +	u8 *fscrypt_file;
>>> +	u32 fscrypt_auth_len;
>>> +	u32 fscrypt_file_len;
>>>    	u64 rsnaps;
>>>    	u64 change_attr;
>>>    };
>>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>>> index 532ee9fca878..5b4092e5f291 100644
>>> --- a/fs/ceph/super.h
>>> +++ b/fs/ceph/super.h
>>> @@ -433,6 +433,12 @@ struct ceph_inode_info {
>>>    	struct work_struct i_work;
>>>    	unsigned long  i_work_mask;
>>>    
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	u32 fscrypt_auth_len;
>>> +	u32 fscrypt_file_len;
>>> +	u8 *fscrypt_auth;
>>> +	u8 *fscrypt_file;
>>> +#endif
>>>    #ifdef CONFIG_CEPH_FSCACHE
>>>    	struct fscache_cookie *fscache;
>>>    #endif

