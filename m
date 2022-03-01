Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0344C8A85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 12:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiCALT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiCALTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EFB921E3C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646133524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVwaAu3+OuCoIgw/Sb24D9h9G3i2OwgmBnH7D5d+zfE=;
        b=gG9DadDW1q4Lrn4TwBGsoXGxiI8ZeLB7rUAiJc8IU7Hkugokq1Ox7A0AUfXZ4sm26qtIui
        jvCJWIr7UQs12NLtnLmfvGw3wDp3wnpYoicqbBVto+KdCCd4q6z0Bwc4+uhVy1aNH1rtAb
        9MnEwBLIojfkluRx4Tr7Sn9n9OL7ZVo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-DGyEf9xkMY6P7hPhWhh1bA-1; Tue, 01 Mar 2022 06:18:43 -0500
X-MC-Unique: DGyEf9xkMY6P7hPhWhh1bA-1
Received: by mail-pf1-f198.google.com with SMTP id z28-20020aa79f9c000000b004e10449d919so9621226pfr.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 03:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jVwaAu3+OuCoIgw/Sb24D9h9G3i2OwgmBnH7D5d+zfE=;
        b=lnzOwA0+25MIe1fQbtz7HFFePiAsELIs0N+l0hY5ab4s4hdBuTvmcqPWWxZ35oz//9
         gwQ6lKysn/6lkQTP5k/SYVW4bUQuv7F3mBfEFr1sHgjdnuACb7A2R0Fnmf2ZVMNtRQ3G
         knRHS98MY01VombNT+UboHUiag8V0KW9xROPHXnXsuMulR69nEjWHwZ2NVG62jQY5JpT
         /SWJAAurl9TwHSJMvWSv7DOxJ37pkU0MkyIvlilCM31gg+oHEIfltWOp7jpZBb1rM75M
         FHrhmpwvbgb6y9/8M/XS6YK4T+y9xtON832DYt3xl/wDYnXkqMqQ88qfeQtmv5Fkfdzz
         fVXw==
X-Gm-Message-State: AOAM533iALpPPbJUOl8fI19aM6sECPBHGts6b7XFLp5GFeO0cdN05KtY
        SHbBrS2dwY9kY294y8StQo61coXJ/O4jDZJ9DsIbYT61XMTZK0sx6pCMnFHSBAmWFcWYiTsjp1v
        sdqr/NmhnXPWEEo8rsC/sKwtt4Q==
X-Received: by 2002:a63:eb0c:0:b0:373:334d:c32f with SMTP id t12-20020a63eb0c000000b00373334dc32fmr21274713pgh.358.1646133522077;
        Tue, 01 Mar 2022 03:18:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJ4UaFuu8Uceb24/fk9B17rKlGdJqD+DI2HHRdaGVHPnObAElXg7tJldcELrmoTudLQ2ngrQ==
X-Received: by 2002:a63:eb0c:0:b0:373:334d:c32f with SMTP id t12-20020a63eb0c000000b00373334dc32fmr21274692pgh.358.1646133521705;
        Tue, 01 Mar 2022 03:18:41 -0800 (PST)
Received: from [10.72.12.114] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q194-20020a6275cb000000b004f396541cecsm15838769pfc.155.2022.03.01.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:18:40 -0800 (PST)
Subject: Re: [RFC PATCH v10 11/48] ceph: decode alternate_name in lease info
From:   Xiubo Li <xiubli@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-12-jlayton@kernel.org>
 <ae096a5b-2f2e-c392-e598-59fd82b44734@redhat.com>
Message-ID: <538550f1-9cf9-e0cb-efe4-8d80fa0f0739@redhat.com>
Date:   Tue, 1 Mar 2022 19:18:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ae096a5b-2f2e-c392-e598-59fd82b44734@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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


On 3/1/22 6:57 PM, Xiubo Li wrote:
>
> On 1/12/22 3:15 AM, Jeff Layton wrote:
>> Ceph is a bit different from local filesystems, in that we don't want
>> to store filenames as raw binary data, since we may also be dealing
>> with clients that don't support fscrypt.
>>
>> We could just base64-encode the encrypted filenames, but that could
>> leave us with filenames longer than NAME_MAX. It turns out that the
>> MDS doesn't care much about filename length, but the clients do.
>>
>> To manage this, we've added a new "alternate name" field that can be
>> optionally added to any dentry that we'll use to store the binary
>> crypttext of the filename if its base64-encoded value will be longer
>> than NAME_MAX. When a dentry has one of these names attached, the MDS
>> will send it along in the lease info, which we can then store for
>> later usage.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++----------
>>   fs/ceph/mds_client.h | 11 +++++++----
>>   2 files changed, 37 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 34a4f6dbac9d..709f3f654555 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -306,27 +306,44 @@ static int parse_reply_info_dir(void **p, void 
>> *end,
>>     static int parse_reply_info_lease(void **p, void *end,
>>                     struct ceph_mds_reply_lease **lease,
>> -                  u64 features)
>> +                  u64 features, u32 *altname_len, u8 **altname)
>>   {
>> +    u8 struct_v;
>> +    u32 struct_len;
>> +
>>       if (features == (u64)-1) {
>> -        u8 struct_v, struct_compat;
>> -        u32 struct_len;
>> +        u8 struct_compat;
>> +
>>           ceph_decode_8_safe(p, end, struct_v, bad);
>>           ceph_decode_8_safe(p, end, struct_compat, bad);
>> +
>>           /* struct_v is expected to be >= 1. we only understand
>>            * encoding whose struct_compat == 1. */
>>           if (!struct_v || struct_compat != 1)
>>               goto bad;
>> +
>>           ceph_decode_32_safe(p, end, struct_len, bad);
>> -        ceph_decode_need(p, end, struct_len, bad);
>> -        end = *p + struct_len;
>
> Hi Jeff,
>
> This is buggy, more detail please see 
> https://tracker.ceph.com/issues/54430.
>
> The following patch will fix it. We should skip the extra memories 
> anyway.
>
>
Hi Jeff,

I will send out a patch series to fix this later.

And we could merge the new patch to this one.

- XIubo



> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 94b4c6508044..3dea96df4769 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -326,6 +326,7 @@ static int parse_reply_info_lease(void **p, void 
> *end,
>                         goto bad;
>
>                 ceph_decode_32_safe(p, end, struct_len, bad);
> +               end = *p + struct_len;
>         } else {
>                 struct_len = sizeof(**lease);
>                 *altname_len = 0;
> @@ -346,6 +347,7 @@ static int parse_reply_info_lease(void **p, void 
> *end,
>                         *altname = NULL;
>                         *altname_len = 0;
>                 }
> +               *p = end;
>         }
>         return 0;
>  bad:
>
>
>
>> +    } else {
>> +        struct_len = sizeof(**lease);
>> +        *altname_len = 0;
>> +        *altname = NULL;
>>       }
>>   -    ceph_decode_need(p, end, sizeof(**lease), bad);
>> +    ceph_decode_need(p, end, struct_len, bad);
>>       *lease = *p;
>>       *p += sizeof(**lease);
>> -    if (features == (u64)-1)
>> -        *p = end;
>> +
>> +    if (features == (u64)-1) {
>> +        if (struct_v >= 2) {
>> +            ceph_decode_32_safe(p, end, *altname_len, bad);
>> +            ceph_decode_need(p, end, *altname_len, bad);
>> +            *altname = *p;
>> +            *p += *altname_len;
>> +        } else {
>> +            *altname = NULL;
>> +            *altname_len = 0;
>> +        }
>> +    }
>>       return 0;
>>   bad:
>>       return -EIO;
>> @@ -356,7 +373,8 @@ static int parse_reply_info_trace(void **p, void 
>> *end,
>>           info->dname = *p;
>>           *p += info->dname_len;
>>   -        err = parse_reply_info_lease(p, end, &info->dlease, 
>> features);
>> +        err = parse_reply_info_lease(p, end, &info->dlease, features,
>> +                         &info->altname_len, &info->altname);
>>           if (err < 0)
>>               goto out_bad;
>>       }
>> @@ -423,9 +441,11 @@ static int parse_reply_info_readdir(void **p, 
>> void *end,
>>           dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
>>             /* dentry lease */
>> -        err = parse_reply_info_lease(p, end, &rde->lease, features);
>> +        err = parse_reply_info_lease(p, end, &rde->lease, features,
>> +                         &rde->altname_len, &rde->altname);
>>           if (err)
>>               goto out_bad;
>> +
>>           /* inode */
>>           err = parse_reply_info_in(p, end, &rde->inode, features);
>>           if (err < 0)
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index e7d2c8a1b9c1..128901a847af 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -29,8 +29,8 @@ enum ceph_feature_type {
>>       CEPHFS_FEATURE_MULTI_RECONNECT,
>>       CEPHFS_FEATURE_DELEG_INO,
>>       CEPHFS_FEATURE_METRIC_COLLECT,
>> -
>> -    CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
>> +    CEPHFS_FEATURE_ALTERNATE_NAME,
>> +    CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_ALTERNATE_NAME,
>>   };
>>     /*
>> @@ -45,8 +45,7 @@ enum ceph_feature_type {
>>       CEPHFS_FEATURE_MULTI_RECONNECT,        \
>>       CEPHFS_FEATURE_DELEG_INO,        \
>>       CEPHFS_FEATURE_METRIC_COLLECT,        \
>> -                        \
>> -    CEPHFS_FEATURE_MAX,            \
>> +    CEPHFS_FEATURE_ALTERNATE_NAME,        \
>>   }
>>   #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>   @@ -98,7 +97,9 @@ struct ceph_mds_reply_info_in {
>>     struct ceph_mds_reply_dir_entry {
>>       char                          *name;
>> +    u8                  *altname;
>>       u32                           name_len;
>> +    u32                  altname_len;
>>       struct ceph_mds_reply_lease   *lease;
>>       struct ceph_mds_reply_info_in inode;
>>       loff_t                  offset;
>> @@ -117,7 +118,9 @@ struct ceph_mds_reply_info_parsed {
>>       struct ceph_mds_reply_info_in diri, targeti;
>>       struct ceph_mds_reply_dirfrag *dirfrag;
>>       char                          *dname;
>> +    u8                  *altname;
>>       u32                           dname_len;
>> +    u32                           altname_len;
>>       struct ceph_mds_reply_lease   *dlease;
>>         /* extra */

