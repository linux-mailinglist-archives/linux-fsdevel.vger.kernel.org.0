Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8E77465E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHHSza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHHSzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A2063F51
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691514542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shf77ttmFOuwEPRuUfK1N01vHtXf9AN1dtY0xeqDGqo=;
        b=eVWe2b40hTh+SYEtdT66XKGC1vcenA7US72nNxF1v9DhkVM7+sLY/BDo7k8qMz4E/2EO3b
        bnM1mYRWNfX1qFvfi60NOS4cwXzEi5Nu3O31HC+l4ywrFTMtt1N2Am+yl4uYKpv5lc65kN
        CYyT8rwAhYZSmqTce3WrPvfX/kAQZ8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-XnGU85L9PiypKcgtm4ln8g-1; Tue, 08 Aug 2023 05:01:23 -0400
X-MC-Unique: XnGU85L9PiypKcgtm4ln8g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe13881511so32822175e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691485282; x=1692090082;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shf77ttmFOuwEPRuUfK1N01vHtXf9AN1dtY0xeqDGqo=;
        b=DTmLrl4bxzWBcF+MVsvNWm7HFXyy9dagxPBxVOinxT+GBZ6LNiMFfXW7uKiwfd/HLR
         riGTXjWLHu5UqNbT46ItWJLJvzavziTTIHXcgdD4rjP2YAFbS2sSRezq2OrlD2jHfb6L
         yXZBbY2De1jYwicwidt/esQ2vnei6pst+uFzi2iZ2XtqvRnor3hw6XOdpq2DaOjTcgCf
         nRNkRUtrPhqhQ5oDSxFD/UeFdA4wlyByzIggNuJziau3ibb1DGbch/BZQPLbBvASrt43
         yhsWbOUpofC10/b6YoqR9l9U/J4Qe5jYoHobPZf1pKAeqwlbuWdMJuXkB3Y8VmN45dLD
         g0Vg==
X-Gm-Message-State: AOJu0YzqGAlJMKtes5xIM/mDL8Zo4lYiNo/5FVVldiA9rC1muJC3RSaL
        zvIoQ247B7FSyhwY43RsxxF6bnNX3Knw/D2gcfzVbG7j0JxsiLlROkxucC5YhySR/wwfkWl8YUD
        65pxBSK3mKE4Wxzqt4QUBbEJspA==
X-Received: by 2002:a7b:cbd0:0:b0:3fe:6199:9393 with SMTP id n16-20020a7bcbd0000000b003fe61999393mr2034362wmi.27.1691485282159;
        Tue, 08 Aug 2023 02:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFA5Seop9fNnaQkYPBraxOC6MTzn8Sh8rEy/VzyB1IOBl8ajH4lLtxy9feUh5m6i1Su9ndJw==
X-Received: by 2002:a7b:cbd0:0:b0:3fe:6199:9393 with SMTP id n16-20020a7bcbd0000000b003fe61999393mr2034323wmi.27.1691485281593;
        Tue, 08 Aug 2023 02:01:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:4500:a7dd:abc0:e4c2:4b31? (p200300cbc74c4500a7ddabc0e4c24b31.dip0.t-ipconnect.de. [2003:cb:c74c:4500:a7dd:abc0:e4c2:4b31])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c7414000000b003fe215e4492sm13146195wmc.4.2023.08.08.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:01:20 -0700 (PDT)
Message-ID: <b545cac8-76f7-e3c3-0e1c-3cb922c9c9ae@redhat.com>
Date:   Tue, 8 Aug 2023 11:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/7] mm: thp: split huge page to any lower order pages.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230329011712.3242298-1-zi.yan@sent.com>
 <20230329011712.3242298-6-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230329011712.3242298-6-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.03.23 03:17, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will see
> list corruption when checking the page_deferred_list again.
> 
> It has many uses, like minimizing the number of pages after
> truncating a huge pagecache page. For anonymous THPs, we can only split
> them to order-0 like before until we add support for any size anonymous
> THPs.
>

Because I'm currently looking into something that would also not be 
compatible with order-1 for now:

You should make it clear that order-1 is not supported, like:

"mm: thp: split huge page to any lower order pages (except order 1)"

And clarify in the subject why that is the case.

-- 
Cheers,

David / dhildenb

