Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6B683125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAaPRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjAaPQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B47A56897
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675178041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zW1XGfXvloprCDLBhrMNbL256Bwo1kZTo72rPkh4eec=;
        b=LV8YRkm2RT1811tZRynUJ6gqcwxu9eDZE7co9EUN4di6OLsjue5BuOD1c/FZ20DbKlAImD
        FovlweGB348LVozJuMpHEr+GcsqrQfu2IA7jKBVAFMQMmJ606BYWtrQy+IPf+lVniQqB78
        1sfn/IrV9PD5G3WDC93KCoJ7n+W6SRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-5C9kPdgpON6jHAXMsT4ELA-1; Tue, 31 Jan 2023 10:10:23 -0500
X-MC-Unique: 5C9kPdgpON6jHAXMsT4ELA-1
Received: by mail-wm1-f70.google.com with SMTP id iv6-20020a05600c548600b003dc4b8ee42fso5320541wmb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW1XGfXvloprCDLBhrMNbL256Bwo1kZTo72rPkh4eec=;
        b=VguLxNTnrhNKAD6pa7Rq4VZBYtZJ7fSQPtSxQSaMolPdBlMCeSSH7sS1JLwRriTziP
         OoiZuLO1dLfFNKJkFy1Mv4nnEHTuhPlB5jnrVXJ1KuTFSqyvoLbxrrbcqg1judjU4JqE
         A9BCpCnHspY9Q+qL9+9GP4//FidMB1mVWVi2UpAtCUmGHDdvlI0EqnyGeVtPzZWrOk53
         jBfrvwDLgs6RSYnQ45GwcyY2e9T/zKzgoTp8qCn/oq4+uiyoZI4hhHRSUq21W5BHwEP7
         wD7yQa+Bx65U7rjPfHVEXskDn+dKGqR6r1k0UhtpuktNiw6Jaak1Hqo4nqiTZ16l299g
         MCOA==
X-Gm-Message-State: AFqh2krq8TXKGCFQgkWibD05bZIS5L6l6oU3nG0lmaeIEC/0okaCs65Z
        k8gsYkbssvt5f6xZ+A39n5xIoHLq1kZvUysqMflh8zvum9fq4ob4mspxYFItTnwLxXwDVXhzdB+
        zkYdzHIxgL91YsAY/k9EffFiP3w==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr46934670wro.48.1675177821835;
        Tue, 31 Jan 2023 07:10:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRDcsJhRjJCJ6S8KsEYz50Ornge6E54XXYexnHU4JDCIVppDpu1q2bl+uSQOGtZBJMJSxZ0Q==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr46934651wro.48.1675177821494;
        Tue, 31 Jan 2023 07:10:21 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b002b065272da2sm14989741wrn.13.2023.01.31.07.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:10:21 -0800 (PST)
Message-ID: <0361aae6-59b2-1bbc-5530-a5be587b8a59@redhat.com>
Date:   Tue, 31 Jan 2023 16:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
 <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <3791872.1675172490@warthog.procyon.org.uk>
 <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
 <f2fb6cc5-ff95-ca51-b377-5e4bd239d5e8@kernel.dk>
 <7f8f2d0f-4bf2-71aa-c356-c78c6b7fd071@redhat.com>
 <028c959d-e52a-5d08-6ac6-004ecdb3e549@kernel.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <028c959d-e52a-5d08-6ac6-004ecdb3e549@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.01.23 16:04, Jens Axboe wrote:
> On 1/31/23 8:02?AM, David Hildenbrand wrote:
>> On 31.01.23 15:50, Jens Axboe wrote:
>>> On 1/31/23 6:48?AM, David Hildenbrand wrote:
>>>> On 31.01.23 14:41, David Howells wrote:
>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>>>> percpu counters maybe - add them up at the point of viewing?
>>>>>>> They are percpu, see my last email. But for every 108 changes (on
>>>>>>> my system), they will do two atomic_long_adds(). So not very
>>>>>>> useful for anything but low frequency modifications.
>>>>>>>
>>>>>>
>>>>>> Can we just treat the whole acquired/released accounting as a debug mechanism
>>>>>> to detect missing releases and do it only for debug kernels?
>>>>>>
>>>>>>
>>>>>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>>>>>> really defer it any longer ... but I'm curious if it would be of any help to
>>>>>> only have a single PINNED counter that goes into both directions (inc/dec on
>>>>>> pin/release), to reduce the flushing.
>>>>>>
>>>>>> Of course, once we pin/release more than ~108 pages in one go or we switch
>>>>>> CPUs frequently it won't be that much of a help ...
>>>>>
>>>>> What are the stats actually used for?  Is it just debugging, or do we actually
>>>>> have users for them (control groups spring to mind)?
>>>>
>>>> As it's really just "how many pinning events" vs. "how many unpinning
>>>> events", I assume it's only for debugging.
>>>>
>>>> For example, if you pin the same page twice it would not get accounted
>>>> as "a single page is pinned".
>>>
>>> How about something like the below then? I can send it out as a real
>>> patch, will run a sanity check on it first but would be surprised if
>>> this doesn't fix it.
>>>
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index f45a3a5be53a..41abb16286ec 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>             */
>>>            smp_mb__after_atomic();
>>>    +#ifdef CONFIG_DEBUG_VM
>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>>> +#endif
>>>              return folio;
>>>        }
>>> @@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>    static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>>>    {
>>>        if (flags & FOLL_PIN) {
>>> +#ifdef CONFIG_DEBUG_VM
>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>>> +#endif
>>>            if (folio_test_large(folio))
>>>                atomic_sub(refs, folio_pincount_ptr(folio));
>>>            else
>>> @@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>>>            } else {
>>>                folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>>>            }
>>> -
>>> +#ifdef CONFIG_DEBUG_VM
>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>>> +#endif
>>>        }
>>>          return 0;
>>>
>>
>> We might want to hide the counters completely by defining them only
>> with CONFIG_DEBUG_VM.
> 
> Are all of them debug aids only? If so, yes we should just have
> node_stat_* under CONFIG_DEBUG_VM.
> 

Rather only these 2. Smth like:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 815c7c2edf45..a526964b65ce 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -196,8 +196,10 @@ enum node_stat_item {
  	NR_WRITTEN,		/* page writings since bootup */
  	NR_THROTTLED_WRITTEN,	/* NR_WRITTEN while reclaim throttled */
  	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
+#ifdef CONFIG_DEBUG_VM
  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
+#endif
  	NR_KERNEL_STACK_KB,	/* measured in KiB */
  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
  	NR_KERNEL_SCS_KB,	/* measured in KiB */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..5cbd9a1924bf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1227,8 +1227,10 @@ const char * const vmstat_text[] = {
  	"nr_written",
  	"nr_throttled_written",
  	"nr_kernel_misc_reclaimable",
+#ifdef CONFIG_DEBUG_VM
  	"nr_foll_pin_acquired",
  	"nr_foll_pin_released",
+#endif
  	"nr_kernel_stack",
  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
  	"nr_shadow_call_stack",

-- 
Thanks,

David / dhildenb

