Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50FD4C8DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 15:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiCAObk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiCAObh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0717AA146D
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646145053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCBZadNCzDs/+D8PMng5UB+Av/am0XrQxJ6VFDTx6aM=;
        b=IaSgB4V1kP9uT5GgD1XdBYv4qHt/MPHHGpKNa2gqfxbgUfGcvKDJGM0bBkzfIM9CYZCy0v
        GiZiR/GqxMyE8lxZjRgg5Vrqpd/jVpfPjan3PqYaOezg++puGZnYDr0KA8dQh7uXyfyxC7
        Mxivq/OjV/cXsuSVTJ3tKu895b+yzOo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-3KHxnchWPamdhFgcj_EqWQ-1; Tue, 01 Mar 2022 09:30:52 -0500
X-MC-Unique: 3KHxnchWPamdhFgcj_EqWQ-1
Received: by mail-pf1-f199.google.com with SMTP id y28-20020aa793dc000000b004e160274e3eso9888684pff.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 06:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TCBZadNCzDs/+D8PMng5UB+Av/am0XrQxJ6VFDTx6aM=;
        b=wZez0XMqW58U1yFpymSiUA4mp4LR9/SkkoOPtu1aBRlr8fbM+HYT5vZWm9ZEwpH2dc
         Dbx/N52TBSujzOQkHZgLR6Q1QezEwPqX0bs03RRkVcXpQOlRa9PG3Kg1ndqT2B/JyfON
         3er6mnhMi6z6/UjWIzad56S4RwDxZhT2p9NJMnrIASmypbcwF1tEmosynIPZxEaZORi6
         BBYDq4126tqp/m6cZFHHU4GvGnBMXc5D7qTlL6zIV7QEeZJliWbd0Ob6l49+DwVKZtQv
         nCMScbDKJvAeHKeSThRs8xXOQ8yWXoMaOT83pHjaMrQbKeRvGJUyO+6Njk546GJczxeA
         QYCA==
X-Gm-Message-State: AOAM533lug9sErYR6rAyM/IBM63K85lw0NFbBJ77w+pmvYHhIntrCXgl
        dXbDgANklGkZEjGMc1Fl5w8inuZWUSdhcG7PB2eVvut12t5WUjMUisor8RoWKxwhu8YMv9Gra0C
        qtazAE/9Xp2LGRqzcB7tFW/t/og==
X-Received: by 2002:a63:f241:0:b0:365:948d:19bb with SMTP id d1-20020a63f241000000b00365948d19bbmr22056194pgk.253.1646145050185;
        Tue, 01 Mar 2022 06:30:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8SyavcgdpMNF/6HUlOlokE9V1MLnNkHkxvHRSkvZydTprNghlxMZ4gF+igbMELMq/XFyurg==
X-Received: by 2002:a63:f241:0:b0:365:948d:19bb with SMTP id d1-20020a63f241000000b00365948d19bbmr22056140pgk.253.1646145049672;
        Tue, 01 Mar 2022 06:30:49 -0800 (PST)
Received: from [10.72.12.87] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b004c283dcbbccsm17072256pfj.176.2022.03.01.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:30:48 -0800 (PST)
Subject: Re: [RFC PATCH v10 11/48] ceph: decode alternate_name in lease info
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-12-jlayton@kernel.org>
 <ae096a5b-2f2e-c392-e598-59fd82b44734@redhat.com>
 <c5c1cf58efbbef6e13a2a7ca067ffaeeae15c1d4.camel@kernel.org>
 <77168a2e-1ce4-9924-17ee-7ac58c0fc996@redhat.com>
 <227b08a2f92ba03badfb81a282c10f60440fdb73.camel@kernel.org>
 <089389cc-2092-291f-1e87-01ae0cc03a42@redhat.com>
 <0d067adf7893b7378d13cde3902eb7608c11282c.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d4ba779e-fc38-647f-da9c-e1fdcc818914@redhat.com>
Date:   Tue, 1 Mar 2022 22:30:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0d067adf7893b7378d13cde3902eb7608c11282c.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/1/22 10:14 PM, Jeff Layton wrote:
> On Tue, 2022-03-01 at 22:07 +0800, Xiubo Li wrote:
>> On 3/1/22 9:57 PM, Jeff Layton wrote:
>>> On Tue, 2022-03-01 at 21:51 +0800, Xiubo Li wrote:
>>>> On 3/1/22 9:10 PM, Jeff Layton wrote:
>>>>> On Tue, 2022-03-01 at 18:57 +0800, Xiubo Li wrote:
>>>>>> On 1/12/22 3:15 AM, Jeff Layton wrote:
>>>>>>> Ceph is a bit different from local filesystems, in that we don't want
>>>>>>> to store filenames as raw binary data, since we may also be dealing
>>>>>>> with clients that don't support fscrypt.
>>>>>>>
>>>>>>> We could just base64-encode the encrypted filenames, but that could
>>>>>>> leave us with filenames longer than NAME_MAX. It turns out that the
>>>>>>> MDS doesn't care much about filename length, but the clients do.
>>>>>>>
>>>>>>> To manage this, we've added a new "alternate name" field that can be
>>>>>>> optionally added to any dentry that we'll use to store the binary
>>>>>>> crypttext of the filename if its base64-encoded value will be longer
>>>>>>> than NAME_MAX. When a dentry has one of these names attached, the MDS
>>>>>>> will send it along in the lease info, which we can then store for
>>>>>>> later usage.
>>>>>>>
>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> ---
>>>>>>>      fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++----------
>>>>>>>      fs/ceph/mds_client.h | 11 +++++++----
>>>>>>>      2 files changed, 37 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>>>>> index 34a4f6dbac9d..709f3f654555 100644
>>>>>>> --- a/fs/ceph/mds_client.c
>>>>>>> +++ b/fs/ceph/mds_client.c
>>>>>>> @@ -306,27 +306,44 @@ static int parse_reply_info_dir(void **p, void *end,
>>>>>>>      
>>>>>>>      static int parse_reply_info_lease(void **p, void *end,
>>>>>>>      				  struct ceph_mds_reply_lease **lease,
>>>>>>> -				  u64 features)
>>>>>>> +				  u64 features, u32 *altname_len, u8 **altname)
>>>>>>>      {
>>>>>>> +	u8 struct_v;
>>>>>>> +	u32 struct_len;
>>>>>>> +
>>>>>>>      	if (features == (u64)-1) {
>>>>>>> -		u8 struct_v, struct_compat;
>>>>>>> -		u32 struct_len;
>>>>>>> +		u8 struct_compat;
>>>>>>> +
>>>>>>>      		ceph_decode_8_safe(p, end, struct_v, bad);
>>>>>>>      		ceph_decode_8_safe(p, end, struct_compat, bad);
>>>>>>> +
>>>>>>>      		/* struct_v is expected to be >= 1. we only understand
>>>>>>>      		 * encoding whose struct_compat == 1. */
>>>>>>>      		if (!struct_v || struct_compat != 1)
>>>>>>>      			goto bad;
>>>>>>> +
>>>>>>>      		ceph_decode_32_safe(p, end, struct_len, bad);
>>>>>>> -		ceph_decode_need(p, end, struct_len, bad);
>>>>>>> -		end = *p + struct_len;
>>>>>> Hi Jeff,
>>>>>>
>>>>>> This is buggy, more detail please see https://tracker.ceph.com/issues/54430.
>>>>>>
>>>>>> The following patch will fix it. We should skip the extra memories anyway.
>>>>>>
>>>>>>
>>>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>>>> index 94b4c6508044..3dea96df4769 100644
>>>>>> --- a/fs/ceph/mds_client.c
>>>>>> +++ b/fs/ceph/mds_client.c
>>>>>> @@ -326,6 +326,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>>>                             goto bad;
>>>>>>
>>>>>>                     ceph_decode_32_safe(p, end, struct_len, bad);
>>>>>> +               end = *p + struct_len;
>>>>> There may be a bug here,
>>>> Yeah, this will be crash when I use the PR
>>>> https://github.com/ceph/ceph/pull/45208.
>>>>
>>>>
>>>>> but this doesn't look like the right fix. "end"
>>>>> denotes the end of the buffer we're decoding. We don't generally want to
>>>>> go changing it like this. Consider what would happen if the original
>>>>> "end" was shorter than *p + struct_len.
>>>> I missed you have also set the struct_len in the else branch.
>>>>>>             } else {
>>>>>>                     struct_len = sizeof(**lease);
>>>>>>                     *altname_len = 0;
>>>>>> @@ -346,6 +347,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>>>                             *altname = NULL;
>>>>>>                             *altname_len = 0;
>>>>>>                     }
>>>>>> +               *p = end;
>>>>> I think we just have to do the math here. Maybe this should be something
>>>>> like this?
>>>>>
>>>>>        *p += struct_len - sizeof(**lease) - *altname_len;
>>>> This is correct, but in future if we are adding tens of new fields we
>>>> must minus them all here.
>>>>
>>>> How about this one:
>>>>
>>>>
>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>> index 94b4c6508044..608d077f2eeb 100644
>>>> --- a/fs/ceph/mds_client.c
>>>> +++ b/fs/ceph/mds_client.c
>>>> @@ -313,6 +313,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>     {
>>>>            u8 struct_v;
>>>>            u32 struct_len;
>>>> +       void *lend;
>>>>
>>>>            if (features == (u64)-1) {
>>>>                    u8 struct_compat;
>>>> @@ -332,6 +333,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>                    *altname = NULL;
>>>>            }
>>>>
>>>> +       lend = *p + struct_len;
>>> Looks reasonable. Maybe also add a check like this?
>>>
>>>       if (lend > end)
>>> 	    return -EIO;
>> I don't think this is needed because the:
>>
>>     ceph_decode_need(p, end, struct_len, bad);
>>
>> before it will help check it ?
>>
>>
> Oh, right....good point. That patch looks fine then.

Cool, I will send out one separate patch to fix it in wip-fscrypt branch.

- Xiubo

>
>>>
>>>>            ceph_decode_need(p, end, struct_len, bad);
>>>>            *lease = *p;
>>>>            *p += sizeof(**lease);
>>>> @@ -347,6 +349,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>                            *altname_len = 0;
>>>>                    }
>>>>            }
>>>> +       *p = lend;
>>>>            return 0;
>>>>     bad:
>>>>            return -EIO;
>>>>
>>>>
>>>>>>             }
>>>>>>             return 0;
>>>>>>      bad:
>>>>>>
>>>>>>
>>>>>>
>>>>>>> +	} else {
>>>>>>> +		struct_len = sizeof(**lease);
>>>>>>> +		*altname_len = 0;
>>>>>>> +		*altname = NULL;
>>>>>>>      	}
>>>>>>>      
>>>>>>> -	ceph_decode_need(p, end, sizeof(**lease), bad);
>>>>>>> +	ceph_decode_need(p, end, struct_len, bad);
>>>>>>>      	*lease = *p;
>>>>>>>      	*p += sizeof(**lease);
>>>>>>> -	if (features == (u64)-1)
>>>>>>> -		*p = end;
>>>>>>> +
>>>>>>> +	if (features == (u64)-1) {
>>>>>>> +		if (struct_v >= 2) {
>>>>>>> +			ceph_decode_32_safe(p, end, *altname_len, bad);
>>>>>>> +			ceph_decode_need(p, end, *altname_len, bad);
>>>>>>> +			*altname = *p;
>>>>>>> +			*p += *altname_len;
>>>>>>> +		} else {
>>>>>>> +			*altname = NULL;
>>>>>>> +			*altname_len = 0;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>>      	return 0;
>>>>>>>      bad:
>>>>>>>      	return -EIO;
>>>>>>> @@ -356,7 +373,8 @@ static int parse_reply_info_trace(void **p, void *end,
>>>>>>>      		info->dname = *p;
>>>>>>>      		*p += info->dname_len;
>>>>>>>      
>>>>>>> -		err = parse_reply_info_lease(p, end, &info->dlease, features);
>>>>>>> +		err = parse_reply_info_lease(p, end, &info->dlease, features,
>>>>>>> +					     &info->altname_len, &info->altname);
>>>>>>>      		if (err < 0)
>>>>>>>      			goto out_bad;
>>>>>>>      	}
>>>>>>> @@ -423,9 +441,11 @@ static int parse_reply_info_readdir(void **p, void *end,
>>>>>>>      		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
>>>>>>>      
>>>>>>>      		/* dentry lease */
>>>>>>> -		err = parse_reply_info_lease(p, end, &rde->lease, features);
>>>>>>> +		err = parse_reply_info_lease(p, end, &rde->lease, features,
>>>>>>> +					     &rde->altname_len, &rde->altname);
>>>>>>>      		if (err)
>>>>>>>      			goto out_bad;
>>>>>>> +
>>>>>>>      		/* inode */
>>>>>>>      		err = parse_reply_info_in(p, end, &rde->inode, features);
>>>>>>>      		if (err < 0)
>>>>>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>>>>>> index e7d2c8a1b9c1..128901a847af 100644
>>>>>>> --- a/fs/ceph/mds_client.h
>>>>>>> +++ b/fs/ceph/mds_client.h
>>>>>>> @@ -29,8 +29,8 @@ enum ceph_feature_type {
>>>>>>>      	CEPHFS_FEATURE_MULTI_RECONNECT,
>>>>>>>      	CEPHFS_FEATURE_DELEG_INO,
>>>>>>>      	CEPHFS_FEATURE_METRIC_COLLECT,
>>>>>>> -
>>>>>>> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
>>>>>>> +	CEPHFS_FEATURE_ALTERNATE_NAME,
>>>>>>> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_ALTERNATE_NAME,
>>>>>>>      };
>>>>>>>      
>>>>>>>      /*
>>>>>>> @@ -45,8 +45,7 @@ enum ceph_feature_type {
>>>>>>>      	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>>>>>>>      	CEPHFS_FEATURE_DELEG_INO,		\
>>>>>>>      	CEPHFS_FEATURE_METRIC_COLLECT,		\
>>>>>>> -						\
>>>>>>> -	CEPHFS_FEATURE_MAX,			\
>>>>>>> +	CEPHFS_FEATURE_ALTERNATE_NAME,		\
>>>>>>>      }
>>>>>>>      #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>>>>>>      
>>>>>>> @@ -98,7 +97,9 @@ struct ceph_mds_reply_info_in {
>>>>>>>      
>>>>>>>      struct ceph_mds_reply_dir_entry {
>>>>>>>      	char                          *name;
>>>>>>> +	u8			      *altname;
>>>>>>>      	u32                           name_len;
>>>>>>> +	u32			      altname_len;
>>>>>>>      	struct ceph_mds_reply_lease   *lease;
>>>>>>>      	struct ceph_mds_reply_info_in inode;
>>>>>>>      	loff_t			      offset;
>>>>>>> @@ -117,7 +118,9 @@ struct ceph_mds_reply_info_parsed {
>>>>>>>      	struct ceph_mds_reply_info_in diri, targeti;
>>>>>>>      	struct ceph_mds_reply_dirfrag *dirfrag;
>>>>>>>      	char                          *dname;
>>>>>>> +	u8			      *altname;
>>>>>>>      	u32                           dname_len;
>>>>>>> +	u32                           altname_len;
>>>>>>>      	struct ceph_mds_reply_lease   *dlease;
>>>>>>>      
>>>>>>>      	/* extra */

