Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8176B9B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHAQfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHAQfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF582698
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690907672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjefxxv3ZRGBWfEsXOGOuERDMNqo6jQLqyrxh73Gpjc=;
        b=VCvG/yOgIHQa+FONiSYOWk6phsXLQb3M9pxWkq0gwOjrtIkbbkeYGTmSPnFvJivNyZa88I
        M/g32VdYGjSnGhPqmJ4KVOQUZEapyiZiuHdlV9QtQmlmBdG/F8N/qMcngwD2kkO3HjgFDb
        nawuXmcwGrUO0J9xFnB0y5Tf/XNoSi4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-oj25m4c5ORW2ZbVZ-RySww-1; Tue, 01 Aug 2023 12:34:29 -0400
X-MC-Unique: oj25m4c5ORW2ZbVZ-RySww-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313c930ee0eso3161542f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 09:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907668; x=1691512468;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjefxxv3ZRGBWfEsXOGOuERDMNqo6jQLqyrxh73Gpjc=;
        b=CXyPATUmxgdoLnQNK1J6H1ICe1tTsAK6cNW7lsVZ6YtHq81/ArnlvZHQyYLlQd7yN6
         abvcEHT/1y1zp/zziVnrEUHx7OPO0gOTrhhy3dyZ9E7sCmTyw96Q5o6sQoyzFK9ofK7j
         ehGzp5UPDEXoqgfnNscuBZxjMDCQS4b4kY++8Po9e1cpMiHYJON45PfCG18QemAFU4MG
         +CUpQCAyGWYq7uXSRwYejIDiCTe1M2ogezMFerVW5T2Pg93C2DSuAI/KvxEuKqUe3EWD
         VCwJL4nWe1SybQ9L7GQdMxSW1EqePLBdpxJxQdtlM9zax9Fr4AhRc7fA+k65nuDPMEAY
         7O1A==
X-Gm-Message-State: ABy/qLZKi+zsTHmNUXJjkbDTOFeS6rodIbgTz+eqqRb52eLg+DQnHTrR
        RaIkXSP0X2bITKg2HOVVj0Id5ng2X+a4//PsVzMuoASaYF9lRFnM8aNfKqEqfM5luGC6+6t1Ypi
        kTlVYi3a8xWnKDne6SvSLDn7fzg==
X-Received: by 2002:adf:fdd1:0:b0:317:5b76:826 with SMTP id i17-20020adffdd1000000b003175b760826mr2809313wrs.0.1690907668490;
        Tue, 01 Aug 2023 09:34:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKWzZ6D+/xJlkeJbehIdicBnTcLOWAdOin/YiX77b1Dv3+c4jpwHuRHqkO20oah6xXgdI0yA==
X-Received: by 2002:adf:fdd1:0:b0:317:5b76:826 with SMTP id i17-20020adffdd1000000b003175b760826mr2809290wrs.0.1690907668122;
        Tue, 01 Aug 2023 09:34:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b003fa8dbb7b5dsm14145674wmc.25.2023.08.01.09.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:34:27 -0700 (PDT)
Message-ID: <b6cb8d7f-f3f3-93c3-3ea0-4c184109a4db@redhat.com>
Date:   Tue, 1 Aug 2023 18:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
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
 <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
 <dc30a97b-853e-4d2a-b171-e68fb3ab026c@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <dc30a97b-853e-4d2a-b171-e68fb3ab026c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.08.23 18:33, Lorenzo Stoakes wrote:
> On Tue, Aug 01, 2023 at 11:05:40AM +0200, David Hildenbrand wrote:
>> On 31.07.23 23:50, Lorenzo Stoakes wrote:
>>> Some architectures do not populate the entire range categorised by
>>> KCORE_TEXT, so we must ensure that the kernel address we read from is
>>> valid.
>>>
>>> Unfortunately there is no solution currently available to do so with a
>>> purely iterator solution so reinstate the bounce buffer in this instance so
>>> we can use copy_from_kernel_nofault() in order to avoid page faults when
>>> regions are unmapped.
>>>
>>> This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
>>> bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
>>> the code to continue to use an iterator.
>>>
>>> Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
>>> Reported-by: Jiri Olsa <olsajiri@gmail.com>
>>> Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>>> ---
>>>    fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
>>>    1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>>> index 9cb32e1a78a0..3bc689038232 100644
>>> --- a/fs/proc/kcore.c
>>> +++ b/fs/proc/kcore.c
>>> @@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>>>    static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>>>    {
>>> +	struct file *file = iocb->ki_filp;
>>> +	char *buf = file->private_data;
>>>    	loff_t *fpos = &iocb->ki_pos;
>>>    	size_t phdrs_offset, notes_offset, data_offset;
>>>    	size_t page_offline_frozen = 1;
>>> @@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>>>    			fallthrough;
>>>    		case KCORE_VMEMMAP:
>>>    		case KCORE_TEXT:
>>> +			/*
>>> +			 * Sadly we must use a bounce buffer here to be able to
>>> +			 * make use of copy_from_kernel_nofault(), as these
>>> +			 * memory regions might not always be mapped on all
>>> +			 * architectures.
>>> +			 */
>>> +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
>>> +				if (iov_iter_zero(tsz, iter) != tsz) {
>>> +					ret = -EFAULT;
>>> +					goto out;
>>> +				}
>>>    			/*
>>>    			 * We use _copy_to_iter() to bypass usermode hardening
>>>    			 * which would otherwise prevent this operation.
>>>    			 */
>>
>> Having a comment at this indentation level looks for the else case looks
>> kind of weird.
> 
> Yeah, but having it indented again would be weird and seem like it doesn't
> apply to the block below, there's really no good spot for it and
> checkpatch.pl doesn't mind so I think this is ok :)
> 
>>
>> (does that comment still apply?)
> 
> Hm good point, actually, now we're using the bounce buffer we don't need to
> avoid usermode hardening any more.
> 
> However since we've established a bounce buffer ourselves its still
> appropriate to use _copy_to_iter() as we know the source region is good to
> copy from.
> 
> To make life easy I'll just respin with an updated comment :)

I'm not too picky this time, no need to resend if everybody else is fine :P

-- 
Cheers,

David / dhildenb

