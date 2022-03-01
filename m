Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F371D4C8D50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCAOIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 09:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiCAOIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB853193DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 06:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646143686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfpcPMH60PRLy+I0feWKSF8NfCf9XHVMHlQ63yvdBVY=;
        b=ajA3Cg0jflNkEw5gr662U8Psu6m2EIkHv1ZiFID3oDrToK/H6VkzXiySCz6icupfBou4nt
        v7giGxFmgjJrd6yluvD7rmoNiX2PyVKeQ8XPZNVAZtXmCZwiVAw5RuFOVTkAHUHidpzst0
        S6lFVCL+7AeGtcDwmxPrvc+pNMV1LX8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-ACc6jmkcMYmLbX-5UnE4Pw-1; Tue, 01 Mar 2022 09:08:04 -0500
X-MC-Unique: ACc6jmkcMYmLbX-5UnE4Pw-1
Received: by mail-pj1-f72.google.com with SMTP id c7-20020a17090a674700b001beef0afd32so68906pjm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 06:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GfpcPMH60PRLy+I0feWKSF8NfCf9XHVMHlQ63yvdBVY=;
        b=3e3vmH1AfWNPYNznLPcxs5LNng7e4C8A4mV+ApB5GXaV/w/DqagAPm1bjxrMhYkHJv
         yTUWzs/wvimg03iubS4VbeNFiYBpZF/utm3pl2qDt1rnlyenrsR/EwrIvrfsok+rQtT4
         1chm8qY3XGgj5tm8yvxQHJ4/Zio84V2seKmazw6EANveHyC7dgCnFG2hXxbjfGsfql8m
         s6W788wLxDGkqsY/nNduKdFWPp57MtoejPa1JsdvJ5D5Q5pI8zIzC2ejtyDqo2t/xpk5
         k6pf3/GC71R8qqGiSwPNeg0Ih6baCodKJ2bW/wbN4NwzKWKeeQKkpgaRVtK9xeiRSDMS
         DX5Q==
X-Gm-Message-State: AOAM532Cd2jrZRQlBV0BkbndZ1JY+vsB6+kpSjzPEOtqFlcm305aTWkO
        ZwpacaFIHUluMFlGhMDVGf+mt5We8oODZumRGBWuXKTewkM0keqK0e8fqU7avj4A8LXJIQlFjui
        q6PNeMBFSSY25SYxGr0Jsf7xfNg==
X-Received: by 2002:a17:90a:9517:b0:1bc:81ef:79cd with SMTP id t23-20020a17090a951700b001bc81ef79cdmr21737034pjo.164.1646143683610;
        Tue, 01 Mar 2022 06:08:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOhxvtI8Fwc3pjamou5uKtq/gTvP8hapK0KZSgoeDmodGXPdnb2mcCQ8VQvbI+L66kLW10bg==
X-Received: by 2002:a17:90a:9517:b0:1bc:81ef:79cd with SMTP id t23-20020a17090a951700b001bc81ef79cdmr21737004pjo.164.1646143683180;
        Tue, 01 Mar 2022 06:08:03 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm2234114pjc.56.2022.03.01.06.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:08:02 -0800 (PST)
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
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <089389cc-2092-291f-1e87-01ae0cc03a42@redhat.com>
Date:   Tue, 1 Mar 2022 22:07:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <227b08a2f92ba03badfb81a282c10f60440fdb73.camel@kernel.org>
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


On 3/1/22 9:57 PM, Jeff Layton wrote:
> On Tue, 2022-03-01 at 21:51 +0800, Xiubo Li wrote:
>> On 3/1/22 9:10 PM, Jeff Layton wrote:
>>> On Tue, 2022-03-01 at 18:57 +0800, Xiubo Li wrote:
>>>> On 1/12/22 3:15 AM, Jeff Layton wrote:
>>>>> Ceph is a bit different from local filesystems, in that we don't want
>>>>> to store filenames as raw binary data, since we may also be dealing
>>>>> with clients that don't support fscrypt.
>>>>>
>>>>> We could just base64-encode the encrypted filenames, but that could
>>>>> leave us with filenames longer than NAME_MAX. It turns out that the
>>>>> MDS doesn't care much about filename length, but the clients do.
>>>>>
>>>>> To manage this, we've added a new "alternate name" field that can be
>>>>> optionally added to any dentry that we'll use to store the binary
>>>>> crypttext of the filename if its base64-encoded value will be longer
>>>>> than NAME_MAX. When a dentry has one of these names attached, the MDS
>>>>> will send it along in the lease info, which we can then store for
>>>>> later usage.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>>     fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++----------
>>>>>     fs/ceph/mds_client.h | 11 +++++++----
>>>>>     2 files changed, 37 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>>> index 34a4f6dbac9d..709f3f654555 100644
>>>>> --- a/fs/ceph/mds_client.c
>>>>> +++ b/fs/ceph/mds_client.c
>>>>> @@ -306,27 +306,44 @@ static int parse_reply_info_dir(void **p, void *end,
>>>>>     
>>>>>     static int parse_reply_info_lease(void **p, void *end,
>>>>>     				  struct ceph_mds_reply_lease **lease,
>>>>> -				  u64 features)
>>>>> +				  u64 features, u32 *altname_len, u8 **altname)
>>>>>     {
>>>>> +	u8 struct_v;
>>>>> +	u32 struct_len;
>>>>> +
>>>>>     	if (features == (u64)-1) {
>>>>> -		u8 struct_v, struct_compat;
>>>>> -		u32 struct_len;
>>>>> +		u8 struct_compat;
>>>>> +
>>>>>     		ceph_decode_8_safe(p, end, struct_v, bad);
>>>>>     		ceph_decode_8_safe(p, end, struct_compat, bad);
>>>>> +
>>>>>     		/* struct_v is expected to be >= 1. we only understand
>>>>>     		 * encoding whose struct_compat == 1. */
>>>>>     		if (!struct_v || struct_compat != 1)
>>>>>     			goto bad;
>>>>> +
>>>>>     		ceph_decode_32_safe(p, end, struct_len, bad);
>>>>> -		ceph_decode_need(p, end, struct_len, bad);
>>>>> -		end = *p + struct_len;
>>>> Hi Jeff,
>>>>
>>>> This is buggy, more detail please see https://tracker.ceph.com/issues/54430.
>>>>
>>>> The following patch will fix it. We should skip the extra memories anyway.
>>>>
>>>>
>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>> index 94b4c6508044..3dea96df4769 100644
>>>> --- a/fs/ceph/mds_client.c
>>>> +++ b/fs/ceph/mds_client.c
>>>> @@ -326,6 +326,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>                            goto bad;
>>>>
>>>>                    ceph_decode_32_safe(p, end, struct_len, bad);
>>>> +               end = *p + struct_len;
>>> There may be a bug here,
>> Yeah, this will be crash when I use the PR
>> https://github.com/ceph/ceph/pull/45208.
>>
>>
>>> but this doesn't look like the right fix. "end"
>>> denotes the end of the buffer we're decoding. We don't generally want to
>>> go changing it like this. Consider what would happen if the original
>>> "end" was shorter than *p + struct_len.
>> I missed you have also set the struct_len in the else branch.
>>>>            } else {
>>>>                    struct_len = sizeof(**lease);
>>>>                    *altname_len = 0;
>>>> @@ -346,6 +347,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>>>                            *altname = NULL;
>>>>                            *altname_len = 0;
>>>>                    }
>>>> +               *p = end;
>>> I think we just have to do the math here. Maybe this should be something
>>> like this?
>>>
>>>       *p += struct_len - sizeof(**lease) - *altname_len;
>> This is correct, but in future if we are adding tens of new fields we
>> must minus them all here.
>>
>> How about this one:
>>
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 94b4c6508044..608d077f2eeb 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -313,6 +313,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>    {
>>           u8 struct_v;
>>           u32 struct_len;
>> +       void *lend;
>>
>>           if (features == (u64)-1) {
>>                   u8 struct_compat;
>> @@ -332,6 +333,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>                   *altname = NULL;
>>           }
>>
>> +       lend = *p + struct_len;
>
> Looks reasonable. Maybe also add a check like this?
>
>      if (lend > end)
> 	    return -EIO;

I don't think this is needed because the:

   ceph_decode_need(p, end, struct_len, bad);

before it will help check it ?


>
>
>>           ceph_decode_need(p, end, struct_len, bad);
>>           *lease = *p;
>>           *p += sizeof(**lease);
>> @@ -347,6 +349,7 @@ static int parse_reply_info_lease(void **p, void *end,
>>                           *altname_len = 0;
>>                   }
>>           }
>> +       *p = lend;
>>           return 0;
>>    bad:
>>           return -EIO;
>>
>>
>>>>            }
>>>>            return 0;
>>>>     bad:
>>>>
>>>>
>>>>
>>>>> +	} else {
>>>>> +		struct_len = sizeof(**lease);
>>>>> +		*altname_len = 0;
>>>>> +		*altname = NULL;
>>>>>     	}
>>>>>     
>>>>> -	ceph_decode_need(p, end, sizeof(**lease), bad);
>>>>> +	ceph_decode_need(p, end, struct_len, bad);
>>>>>     	*lease = *p;
>>>>>     	*p += sizeof(**lease);
>>>>> -	if (features == (u64)-1)
>>>>> -		*p = end;
>>>>> +
>>>>> +	if (features == (u64)-1) {
>>>>> +		if (struct_v >= 2) {
>>>>> +			ceph_decode_32_safe(p, end, *altname_len, bad);
>>>>> +			ceph_decode_need(p, end, *altname_len, bad);
>>>>> +			*altname = *p;
>>>>> +			*p += *altname_len;
>>>>> +		} else {
>>>>> +			*altname = NULL;
>>>>> +			*altname_len = 0;
>>>>> +		}
>>>>> +	}
>>>>>     	return 0;
>>>>>     bad:
>>>>>     	return -EIO;
>>>>> @@ -356,7 +373,8 @@ static int parse_reply_info_trace(void **p, void *end,
>>>>>     		info->dname = *p;
>>>>>     		*p += info->dname_len;
>>>>>     
>>>>> -		err = parse_reply_info_lease(p, end, &info->dlease, features);
>>>>> +		err = parse_reply_info_lease(p, end, &info->dlease, features,
>>>>> +					     &info->altname_len, &info->altname);
>>>>>     		if (err < 0)
>>>>>     			goto out_bad;
>>>>>     	}
>>>>> @@ -423,9 +441,11 @@ static int parse_reply_info_readdir(void **p, void *end,
>>>>>     		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
>>>>>     
>>>>>     		/* dentry lease */
>>>>> -		err = parse_reply_info_lease(p, end, &rde->lease, features);
>>>>> +		err = parse_reply_info_lease(p, end, &rde->lease, features,
>>>>> +					     &rde->altname_len, &rde->altname);
>>>>>     		if (err)
>>>>>     			goto out_bad;
>>>>> +
>>>>>     		/* inode */
>>>>>     		err = parse_reply_info_in(p, end, &rde->inode, features);
>>>>>     		if (err < 0)
>>>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>>>> index e7d2c8a1b9c1..128901a847af 100644
>>>>> --- a/fs/ceph/mds_client.h
>>>>> +++ b/fs/ceph/mds_client.h
>>>>> @@ -29,8 +29,8 @@ enum ceph_feature_type {
>>>>>     	CEPHFS_FEATURE_MULTI_RECONNECT,
>>>>>     	CEPHFS_FEATURE_DELEG_INO,
>>>>>     	CEPHFS_FEATURE_METRIC_COLLECT,
>>>>> -
>>>>> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
>>>>> +	CEPHFS_FEATURE_ALTERNATE_NAME,
>>>>> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_ALTERNATE_NAME,
>>>>>     };
>>>>>     
>>>>>     /*
>>>>> @@ -45,8 +45,7 @@ enum ceph_feature_type {
>>>>>     	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>>>>>     	CEPHFS_FEATURE_DELEG_INO,		\
>>>>>     	CEPHFS_FEATURE_METRIC_COLLECT,		\
>>>>> -						\
>>>>> -	CEPHFS_FEATURE_MAX,			\
>>>>> +	CEPHFS_FEATURE_ALTERNATE_NAME,		\
>>>>>     }
>>>>>     #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>>>>     
>>>>> @@ -98,7 +97,9 @@ struct ceph_mds_reply_info_in {
>>>>>     
>>>>>     struct ceph_mds_reply_dir_entry {
>>>>>     	char                          *name;
>>>>> +	u8			      *altname;
>>>>>     	u32                           name_len;
>>>>> +	u32			      altname_len;
>>>>>     	struct ceph_mds_reply_lease   *lease;
>>>>>     	struct ceph_mds_reply_info_in inode;
>>>>>     	loff_t			      offset;
>>>>> @@ -117,7 +118,9 @@ struct ceph_mds_reply_info_parsed {
>>>>>     	struct ceph_mds_reply_info_in diri, targeti;
>>>>>     	struct ceph_mds_reply_dirfrag *dirfrag;
>>>>>     	char                          *dname;
>>>>> +	u8			      *altname;
>>>>>     	u32                           dname_len;
>>>>> +	u32                           altname_len;
>>>>>     	struct ceph_mds_reply_lease   *dlease;
>>>>>     
>>>>>     	/* extra */

