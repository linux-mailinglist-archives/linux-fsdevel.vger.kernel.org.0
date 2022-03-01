Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51354C8606
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 09:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiCAIMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 03:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiCAIMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADDB85668
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 00:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646122316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLkX7j7/Zb/EioGFBRjJTWhVN81CKkKlGzO4G8wrZag=;
        b=LKpX2qmrRXf958gP5+DYYsOb/jADH9x6LHptzyr7IJx7g+bLe8TZOUZtVG0EFciqXEKfzW
        cZFLbjDZfLiLCDXrzHC0BWYSN1BRLEp61BZkZeKskGetu6Gds/qWk4/KXiNOdelVa/eEzi
        +FQ0aIGZH2U98AkQtPG4xznINoHoWZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-pYJgP1IyOKqHOB2YoGXHTA-1; Tue, 01 Mar 2022 03:11:55 -0500
X-MC-Unique: pYJgP1IyOKqHOB2YoGXHTA-1
Received: by mail-wr1-f70.google.com with SMTP id ba15-20020a0560001c0f00b001f01822f821so274437wrb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 00:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=qLkX7j7/Zb/EioGFBRjJTWhVN81CKkKlGzO4G8wrZag=;
        b=LD2q7o1xLLj4I8RIczy2kEvsWXkz7BN0vuX8xw4Psun1vNx++eG79uJ2JEyReGU421
         XsCDeklxX6rovrA/uq/rgp5a/dc2ZRcdP+qOmYeRNHQP9OkzWyxN+AYTb6tVP93B1UnU
         jBRb5/p7a4oGdG09KpnRoQobRd85TrB0afqUSWsdAfYtrd5+vCOYfdtIgyfC3Yg3A3W7
         WPqJNFVj0d5QbYbXXW4eo3sFIZ08B81ZoAJ1XA3Bnj3u7CmOv6DKc48BNEwJVt3hTuFp
         eLeXAhbmf7vldTU6QErzorz7u+wza1caJpyJnXu61qQ9vtdhjcJ799MOVZ7NBchuOpMJ
         i0DQ==
X-Gm-Message-State: AOAM531TE1mJ4g6pWP8P/txxHHZtjbzNCipoIpp7RvDLpbDyIhTpFtDl
        Wr3sozLsnYQQ2nqVFxGdeNvIeaFzzju/CZr57dAniwvFOwy98GTXEhzgK+sct/JZJ0YRVOvKttC
        qK7BxSLTNpWcZJzmKTK5Rh5Ygcw==
X-Received: by 2002:adf:80d0:0:b0:1dc:90a8:4a1d with SMTP id 74-20020adf80d0000000b001dc90a84a1dmr18203767wrl.180.1646122313904;
        Tue, 01 Mar 2022 00:11:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwBInwnw6NRfKHm0uyj7te/EYVf6/GOQYqJd8ME8Bnl5vPD/mD+TALb3jA9hO3PUEIhyoYLg==
X-Received: by 2002:adf:80d0:0:b0:1dc:90a8:4a1d with SMTP id 74-20020adf80d0000000b001dc90a84a1dmr18203754wrl.180.1646122313681;
        Tue, 01 Mar 2022 00:11:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323? (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de. [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b0037c2c6d2a91sm1962455wms.2.2022.03.01.00.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:11:53 -0800 (PST)
Message-ID: <d3973adb-9403-5b64-23ec-d6800d67e538@redhat.com>
Date:   Tue, 1 Mar 2022 09:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225085025.3052894-2-jhubbard@nvidia.com>
 <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
 <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
In-Reply-To: <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 28.02.22 22:14, John Hubbard wrote:
> On 2/28/22 05:27, David Hildenbrand wrote:
> ...
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 5c3f6ede17eb..44446241c3a9 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -3034,6 +3034,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>>>   }
>>>   EXPORT_SYMBOL(pin_user_pages);
>>>   
>>> +/**
>>> + * pin_user_page() - apply a FOLL_PIN reference to a page ()
>>> + *
>>> + * @page: the page to be pinned.
>>> + *
>>> + * Similar to get_user_pages(), in that the page's refcount is elevated using
>>> + * FOLL_PIN rules.
>>> + *
>>> + * IMPORTANT: That means that the caller must release the page via
>>> + * unpin_user_page().
>>> + *
>>> + */
>>> +void pin_user_page(struct page *page)
>>> +{
>>> +	struct folio *folio = page_folio(page);
>>> +
>>> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
>>> +
>>> +	/*
>>> +	 * Similar to try_grab_page(): be sure to *also*
>>> +	 * increment the normal page refcount field at least once,
>>> +	 * so that the page really is pinned.
>>> +	 */
>>> +	if (folio_test_large(folio)) {
>>> +		folio_ref_add(folio, 1);
>>> +		atomic_add(1, folio_pincount_ptr(folio));
>>> +	} else {
>>> +		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>>> +	}
>>> +
>>> +	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>>> +}
>>> +EXPORT_SYMBOL(pin_user_page);
>>> +
>>>   /*
>>>    * pin_user_pages_unlocked() is the FOLL_PIN variant of
>>>    * get_user_pages_unlocked(). Behavior is the same, except that this one sets
>>
>> I assume that function will only get called on a page that has been
>> obtained by a previous pin_user_pages_fast(), correct?
>>
> 
> Well, no. This is meant to be used in place of get_page(), for code that
> knows that the pages will be released via unpin_user_page(). So there is
> no special prerequisite there.

That might be problematic and possibly the wrong approach, depending on
*what* we're actually pinning and what we're intending to do with that.

My assumption would have been that this interface is to duplicate a pin
on a page, which would be perfectly fine, because the page actually saw
a FOLL_PIN previously.

We're taking a pin on a page that we haven't obtained via FOLL_PIN if I
understand correctly. Which raises the questions, how do we end up with
the pages here, and what are we doing to do with them (use them like we
obtained them via FOLL_PIN?)?


If it's converting FOLL_GET -> FOLL_PIN manually, then we're bypassing
FOLL_PIN special handling in GUP code:

page = get_user_pages(FOLL_GET)
pin_user_page(page)
put_page(page)


For anonymous pages, we'll bail out for example once we have

https://lkml.kernel.org/r/20220224122614.94921-14-david@redhat.com

Because the conditions for pinned anonymous pages might no longer hold.

If we won't call pin_user_page() on anonymous pages, it would be fine.
But then, I still wonder how we come up the "struct page" here.

-- 
Thanks,

David / dhildenb

