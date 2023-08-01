Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE33A76AC92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHAJOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjHAJNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1E44B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690880941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9kdFDWcMyK/1HOobM9v5phnyHdEWyzyFaqhLZWLocA=;
        b=K9ODMQ0iZGpQPBrlQQz49Ql1kw9ompu+7Pcoy9RWrFYoQHyZfEk2I1GphxrDvv+9u7DB6K
        zdvOD2DMaRcSldAjETs7X0bIlkCSVfWtof00SiJlEp4umBSd1uirC0rH9iW2YOOksw7kR8
        Zn2XLK1/ed8qs7xNRSAkvGe4Na13H30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-JCgyEFzSM2SMWD3pdIzoBA-1; Tue, 01 Aug 2023 05:05:43 -0400
X-MC-Unique: JCgyEFzSM2SMWD3pdIzoBA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso31987335e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 02:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880742; x=1691485542;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9kdFDWcMyK/1HOobM9v5phnyHdEWyzyFaqhLZWLocA=;
        b=YxtScmvgb0D4Z0mc4IX997d5/hh2cL8NmXW5zH7rj1e5h0m0lXkPS0t+9+u4F54uIB
         gWiaROkUcxvUqTTxxnL8CKk+RKtF4Q/26iMOOtsre/aUUuspVGn4OmmJ1xdWQz+od1eV
         xpXJHAWIoLbedYI0mENihVODmOv69qdv5+ykEYYOqe3LbUpvnJZGxqHwVjaS5aWTlXtN
         GG4lH8zIyBhRk9sDYRjFNn6i2XVqRu9Z7X35G56ngv+i3AT6MnrBF8Xvt1djSF94VdbN
         gZPeS61YvBnAiX0upwan5nJqK4dl8c7OKlREbsuTYAHfFi/y1M5U1ktsEGB+xaTQDrc8
         JRmg==
X-Gm-Message-State: ABy/qLZ9PiAvG/e9aOU7zHeubuxV/4LQjkDyc+OzyirI6Tms/Bpmw+vi
        9H+/tONGGgXTxdgJA2hcmTLs3y9MSXnPVNSnIvv6kmS3cOSN1Rp+OAlMEagIzzJMJqFfcdSHA4F
        jiADyr1JqTx9knh4scqApQqggFw==
X-Received: by 2002:a7b:ce16:0:b0:3fc:521:8492 with SMTP id m22-20020a7bce16000000b003fc05218492mr1796108wmc.5.1690880742248;
        Tue, 01 Aug 2023 02:05:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEC68EW/3Q+u0VSARbq5VNE5NLUF7t+a5naaLWqjf05jsPmAZ5g85TjNh4l1QEK1armULjtOw==
X-Received: by 2002:a7b:ce16:0:b0:3fc:521:8492 with SMTP id m22-20020a7bce16000000b003fc05218492mr1796077wmc.5.1690880741870;
        Tue, 01 Aug 2023 02:05:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b00313f61889ecsm15587910wrs.66.2023.08.01.02.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:05:41 -0700 (PDT)
Message-ID: <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
Date:   Tue, 1 Aug 2023 11:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
References: <20230731215021.70911-1-lstoakes@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230731215021.70911-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.07.23 23:50, Lorenzo Stoakes wrote:
> Some architectures do not populate the entire range categorised by
> KCORE_TEXT, so we must ensure that the kernel address we read from is
> valid.
> 
> Unfortunately there is no solution currently available to do so with a
> purely iterator solution so reinstate the bounce buffer in this instance so
> we can use copy_from_kernel_nofault() in order to avoid page faults when
> regions are unmapped.
> 
> This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
> bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
> the code to continue to use an iterator.
> 
> Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 9cb32e1a78a0..3bc689038232 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>   
>   static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> +	struct file *file = iocb->ki_filp;
> +	char *buf = file->private_data;
>   	loff_t *fpos = &iocb->ki_pos;
>   	size_t phdrs_offset, notes_offset, data_offset;
>   	size_t page_offline_frozen = 1;
> @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   			fallthrough;
>   		case KCORE_VMEMMAP:
>   		case KCORE_TEXT:
> +			/*
> +			 * Sadly we must use a bounce buffer here to be able to
> +			 * make use of copy_from_kernel_nofault(), as these
> +			 * memory regions might not always be mapped on all
> +			 * architectures.
> +			 */
> +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> +				if (iov_iter_zero(tsz, iter) != tsz) {
> +					ret = -EFAULT;
> +					goto out;
> +				}
>   			/*
>   			 * We use _copy_to_iter() to bypass usermode hardening
>   			 * which would otherwise prevent this operation.
>   			 */

Having a comment at this indentation level looks for the else case looks 
kind of weird.

(does that comment still apply?)


-- 
Cheers,

David / dhildenb

