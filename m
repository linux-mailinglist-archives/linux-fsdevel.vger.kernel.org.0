Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED34532059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiEXBqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiEXBqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 21:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97B3D66F96
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653356807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMCSafXGdmuY2thLWOyQ96BnlXt8iWQ0Jbeb4u86zi0=;
        b=dPKci6qyCAG+ET5IJKhY6HJ5wB20K5LI4NRk7WeIiify7AADHCv13IawGpfC7g+gWVSjIL
        PZIlYAU9bnSaMO0eN1nZ130vD7LICHuj8WkCPl7vqM5RkIYg/BmSVSx+5jqeSw4HhJNp8h
        aP9Y1BoprOt12oRZVDbhWuAiigmZHSM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-_t6IXnA1PSCyiaU_K1h90A-1; Mon, 23 May 2022 21:46:43 -0400
X-MC-Unique: _t6IXnA1PSCyiaU_K1h90A-1
Received: by mail-pg1-f198.google.com with SMTP id e27-20020a63371b000000b003f65557a472so5983528pga.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 18:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IMCSafXGdmuY2thLWOyQ96BnlXt8iWQ0Jbeb4u86zi0=;
        b=sYCXTmLS0IP94i+KF0Qb2kUL8rpchT1mKNPNZnVQydCdKdgt7BmzJp+z6wygG2f909
         GRtLgVWg/km/BdfF9OYBLET47xNKd8NptIuVycHXsa+ImHIO3wYq1yifIDvRs6GgpGrK
         804F01Oeb3s7qyg4Xa359yQGBRe8hElCaAD1INwIpQQAvjYaBzPP1tcwFn29915WfA/r
         kMFqEer9dclMh/2GCJlhWWWQ0MTqYvWxof2yc0bb6ixh6K6RAcFFiXwyql1B1Kc5aUpc
         Nz2LQc4lW/MoYe+0mF+J/7md/yFOpIE6mZOmQVlxCjL/v82TC5KuW3vwuhyWs2tSbZYC
         4DEA==
X-Gm-Message-State: AOAM533hupnvJ4dzcToI87UKphak36fF8QOficUYK1MwL9RfnviSgHLE
        P0pUAUlU65MteCYoWiAzv5ZwZwsIQPv1+zW21hQQiogdMkzuM0E8r0EDlWY3Os3yBNSn5O+VT3P
        LgnqxSJA0fnrCM8X6tDp568myug==
X-Received: by 2002:a17:90b:3c50:b0:1df:7b1f:8b79 with SMTP id pm16-20020a17090b3c5000b001df7b1f8b79mr2011783pjb.71.1653356802812;
        Mon, 23 May 2022 18:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmLKzJlzwvLHI4ZZ+EhG8vgjK7IyZ53D6A6JhDfQIllhjiR9qUwgx4HwRIGf8jCR7j9tp7vw==
X-Received: by 2002:a17:90b:3c50:b0:1df:7b1f:8b79 with SMTP id pm16-20020a17090b3c5000b001df7b1f8b79mr2011771pjb.71.1653356802565;
        Mon, 23 May 2022 18:46:42 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s10-20020a170903214a00b001623cf06dc5sm449354ple.61.2022.05.23.18.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 18:46:42 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] fs/dcache: add d_compare() helper support
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519101847.87907-1-xiubli@redhat.com>
 <20220519101847.87907-2-xiubli@redhat.com>
 <YovK86vEmOUUoBn6@bombadil.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2f43382d-3ab1-3562-c527-5cfef9ac069e@redhat.com>
Date:   Tue, 24 May 2022 09:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YovK86vEmOUUoBn6@bombadil.infradead.org>
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


On 5/24/22 1:57 AM, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 06:18:45PM +0800, Xiubo Li wrote:
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
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
> What's wrong with d_same_name()? Why introduce a whole new operation
> and export it when you the same prototype except first and second
> argument moved with an even more confusing name?

Sounds resonable, will export the d_same_name instead.

>> +}
>> +EXPORT_SYMBOL(d_compare);
> New symbols should go with EXPORT_SYMBOL_GPL() instead.

Not familiar with the story about this, before I checked the Doc and 
didn't find any where says we must use it and just followed what recent 
commits did.

If this is what we should use I will switch to it in the next version.

Thanks

-- Xiubo


>
>    Luis
>

