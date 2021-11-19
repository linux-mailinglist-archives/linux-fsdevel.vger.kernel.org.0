Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238D74570BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhKSOiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 09:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235991AbhKSOiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637332515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mm/1sr0bdKvIDzeoCiebWBOdcipYTxhxLdJgjjMHe5k=;
        b=Nx+rCjQVmxr46dMtnBuQdbgOk/w171GV25pDcl/b8VNhCNAMpP8+HPT8+BBU+RSonR6qWN
        ZhfDZzkn4RrqyFJWOZswCV5pIgihPW2oMpFKtNpS2N7+Pke3Gz6MQciBTazLbdOVfCdesR
        2XM+Oa1Ly5IFDgUVxKozdKPehutTOwg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-4UnMWAKTOOmf6glvyf_nKg-1; Fri, 19 Nov 2021 09:35:13 -0500
X-MC-Unique: 4UnMWAKTOOmf6glvyf_nKg-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso8519827eds.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 06:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mm/1sr0bdKvIDzeoCiebWBOdcipYTxhxLdJgjjMHe5k=;
        b=O3GI0wb0GnRdzk9ZTBspjZy7jvwAblRtTMJfq5saEUWqTU0+sIkomVR5wvdSkfg9S7
         pS+b5To7RKF4VP1mmv+iHaMwPhPcY+yPaRx6SJqCDPxJRLKhygsfT0OjBTFShszSZGYS
         2FsAz0SwnAtLS6YK3JYBtcwE0/ZhTFrmg1Fr7rZS2DTxos5GY4NiSSGuR8SiOczKhWm5
         EzME+0ZUpSGNutQwM3eJVsAi2RO6ChPaCL4xAT1BApUQFEw27roOkMtc9pOOXQS8lJGH
         4Uoush2j1kgVBatoaewFvynDCmnHYWjsZrN0HlGVvgDbVM96cBreEbLhChGkqU6+scPp
         92QA==
X-Gm-Message-State: AOAM532NC9/sbKyUqyGYzehjxHh6p1njZHlJlIKSz+ihqy7U3lGcPcjC
        pWDUbDa//ulIuLnnNa0IbZwnYv8UXSc2x3OIfrZ5NoJTIRt9uEDVa3f4Q3FUL5iLzNYb9BDu+Xn
        3yy812IHL7sRjQ1JLb6hs9D9VSQ==
X-Received: by 2002:a50:99c6:: with SMTP id n6mr24060024edb.171.1637332511821;
        Fri, 19 Nov 2021 06:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzj0Mme0k2YDoI7RMSrOdEJplOkKjDKmkbta34QlWBd7ALtl44GQCW8oR56pMnuu3cngOECUA==
X-Received: by 2002:a50:99c6:: with SMTP id n6mr24059999edb.171.1637332511663;
        Fri, 19 Nov 2021 06:35:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y17sm1749368edd.31.2021.11.19.06.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 06:35:11 -0800 (PST)
Message-ID: <99cafdbc-e4fa-9fc5-2dea-1a071919338e@redhat.com>
Date:   Fri, 19 Nov 2021 15:35:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: mmotm 2021-11-18-15-47 uploaded (<linux/proc_fs.h>)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20211118234743.-bgoWMQfK%akpm@linux-foundation.org>
 <db0b9313-fef6-2977-9b1c-4c830edea5c5@infradead.org>
 <20211118170426.bfcd00c159aba815ffc282d3@linux-foundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211118170426.bfcd00c159aba815ffc282d3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 11/19/21 02:04, Andrew Morton wrote:
> On Thu, 18 Nov 2021 16:53:30 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 11/18/21 3:47 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2021-11-18-15-47 has been uploaded to
>>>
>>>     https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> https://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>
>> Hi,
>>
>> I get hundreds of warnings from <linux/proc_fs.h>:
>>
>> from proc-make-the-proc_create-stubs-static-inlines.patch:
>>
>> ../include/linux/proc_fs.h:186:2: error: parameter name omitted
>> ../include/linux/proc_fs.h:186:32: error: parameter name omitted
>> ../include/linux/proc_fs.h:186:63: error: parameter name omitted
> 
> Nobody uses PROC_FS=n ;)

Weird I thought I did a deliberate test compile with PROC_FS=n to test this
(but without W=1 ...).

Andrew, thank you for fixing this.

Regards,

Hans


> 
> --- a/include/linux/proc_fs.h~proc-make-the-proc_create-stubs-static-inlines-fix
> +++ a/include/linux/proc_fs.h
> @@ -179,12 +179,14 @@ static inline struct proc_dir_entry *pro
>  #define proc_create_single(name, mode, parent, show) ({NULL;})
>  #define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
>  
> -static inline struct proc_dir_entry *proc_create(
> -	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *)
> +static inline struct proc_dir_entry *
> +proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent,
> +	    const struct proc_ops *proc_ops)
>  { return NULL; }
>  
> -static inline struct proc_dir_entry *proc_create_data(
> -	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *, void *)
> +static inline struct proc_dir_entry *
> +proc_create_data(const char *name, umode_t mode, struct proc_dir_entry *parent,
> +		 const struct proc_ops *proc_ops, void *data)
>  { return NULL; }
>  
>  static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
> _
> 

