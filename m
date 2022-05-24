Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475E532049
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 03:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiEXBc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 21:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiEXBc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 21:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05929427FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653355946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDqY6e/ZCTT5vbybB6QpEFM89saOLe+qmuOxqy77J64=;
        b=Z3jn+clBgzjvHgUnfBPzwZUPdPR7KH5cevIiT0lzS7bqL2ogDg/u3Mz+NtT48jzfuZctxR
        pEx/CgDp/0/xCdlx4fS8Gp9bi8NEncFlo4suhHvcxjjHPeQNMccS54p96WEZPufcHTjDMi
        koKiT8yAjYkY2BhTdk76+2RFH5TQQ+g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-4vb_Cfz-NOicVBcOb8Z7Pw-1; Mon, 23 May 2022 21:32:24 -0400
X-MC-Unique: 4vb_Cfz-NOicVBcOb8Z7Pw-1
Received: by mail-pg1-f200.google.com with SMTP id e33-20020a631e21000000b003f63a616b12so6582636pge.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 18:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mDqY6e/ZCTT5vbybB6QpEFM89saOLe+qmuOxqy77J64=;
        b=zdQNSAz4MrKBI28TWoX3TaXaPIbjkWjB4GAp+vmXHx1w1tCoPBM69hTlCz2UBEVTtz
         fDm4kW6yS+aIe06VX4Z285vAKgB+diYrJuqLtiw/uZYi9Gn2d3zz9E+jX5f51mDMDHpC
         cQaVDs6WXYcq+an73KYiSv4wR2UpVQisSgN6V6ry8DwWSgN5KAjAK98Yj9mwbLqS4ITB
         DBIyTCjW6QhRppp/IepPu43mKaEDzlZ9oE2U0084qr8tPqp9D7H4Q29kQlebF1PllAqx
         bjZ9aoSDSYFHi0gyfqOQHbaejqvuny3J9p0IHxv/cO2PVQAJLBIUKIi8P36qRV1MnW+Y
         YYBQ==
X-Gm-Message-State: AOAM530FvHSoOwcWix4vWuL1aWZ39d3yhXdL6HAUwrMPegL9dPi+tabp
        BqyAz8L3QWPP+EP1O1ovkvMUcikELLeCFV4VG+vKp5EmM0I31pe+veurHjUFbItLDXCDu7xNZ2L
        wcLiu80Yc7/mWqdNTEh8ImtIV3Q==
X-Received: by 2002:a17:90b:33ca:b0:1dc:e5b8:482b with SMTP id lk10-20020a17090b33ca00b001dce5b8482bmr1907546pjb.165.1653355943606;
        Mon, 23 May 2022 18:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE4PFaKoyH4N/WVGpnU5+sYV8dbMj6GNSkjOf7FxYsNhFUq1QPHd7EEfxpYHEOMscQ1+Qy9w==
X-Received: by 2002:a17:90b:33ca:b0:1dc:e5b8:482b with SMTP id lk10-20020a17090b33ca00b001dce5b8482bmr1907529pjb.165.1653355943372;
        Mon, 23 May 2022 18:32:23 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x64-20020a628643000000b0050e006279bfsm7707332pfd.137.2022.05.23.18.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 18:32:22 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] fs/dcache: add d_compare() helper support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        vshankar@redhat.com, ceph-devel@vger.kernel.org, arnd@arndb.de,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519101847.87907-1-xiubli@redhat.com>
 <20220519101847.87907-2-xiubli@redhat.com>
 <YovqeybXUKEmhvsi@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2bda8367-0f85-027c-33ef-6d631c791c75@redhat.com>
Date:   Tue, 24 May 2022 09:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YovqeybXUKEmhvsi@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/22 4:11 AM, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 06:18:45PM +0800, Xiubo Li wrote:
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ... empty commit message?

Will add it.

Thanks.


>> ---
>>   fs/dcache.c            | 15 +++++++++++++++
>>   include/linux/dcache.h |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 93f4f5ee07bf..95a72f92a94b 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dentry *dentry,
>>   				       name) == 0;
>>   }
>>   
>> +/**
>> + * d_compare - compare dentry name with case-exact name
>> + * @parent: parent dentry
>> + * @dentry: the negative dentry that was passed to the parent's lookup func
>> + * @name:   the case-exact name to be associated with the returned dentry
>> + *
>> + * Return: 0 if names are same, or 1
>> + */
>> +bool d_compare(const struct dentry *parent, const struct dentry *dentry,
>> +	       const struct qstr *name)
>> +{
>> +	return !d_same_name(dentry, parent, name);
>> +}
>> +EXPORT_SYMBOL(d_compare);
>> +
>>   /**
>>    * __d_lookup_rcu - search for a dentry (racy, store-free)
>>    * @parent: parent dentry
>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>> index f5bba51480b2..444b2230e5c3 100644
>> --- a/include/linux/dcache.h
>> +++ b/include/linux/dcache.h
>> @@ -233,6 +233,8 @@ extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
>>   					wait_queue_head_t *);
>>   extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>>   extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
>> +extern bool d_compare(const struct dentry *parent, const struct dentry *dentry,
>> +		      const struct qstr *name);
>>   extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
>>   extern struct dentry *d_find_any_alias(struct inode *inode);
>>   extern struct dentry * d_obtain_alias(struct inode *);
>> -- 
>> 2.36.0.rc1
>>

