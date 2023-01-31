Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D13682E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjAaNth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjAaNtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EB749940
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675172932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjJLFD2d2G0+4FaeIQz9TlcS4nROfEwnimKGLhaKDRA=;
        b=PZMp0m/Rr7OHld/3ObrDNwqSGqP4dKyP2z3EAGB/91L7KUJJI3fVVsiBJS1mUkRTtDzzS6
        UgvtuCiIG+jovOAPliTJ71rSgWs5ikohOw2yCcLOpkHZC3DBTwI6XM/dpjdbXGUgxs6Cjw
        EdL7sRSARlYJPJOsWIoxpi6AbCH6hrU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-fXUeHbjAMkiKWaNMG6My4Q-1; Tue, 31 Jan 2023 08:48:51 -0500
X-MC-Unique: fXUeHbjAMkiKWaNMG6My4Q-1
Received: by mail-wm1-f71.google.com with SMTP id bi10-20020a05600c3d8a00b003dd1b5d2a36so537538wmb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 05:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjJLFD2d2G0+4FaeIQz9TlcS4nROfEwnimKGLhaKDRA=;
        b=fAYVzl2UDY2Jx1F11SZtFdgGzph0o8xyL+Zb0dmfU4yi76R0t7M+a36KCARlgcDlyG
         vz0KT3lmkf5ILlgbeL0KyO2TWpegqGGIDBh1igjynj/eShs1rK8cXRfhawfbppRO63PY
         pz5bpnC8a2pQisiEg9mHQqdnBxC45OxJgji5tw/s7CSiF7CEnVYfzsioKq+aEGuz7oL+
         +3VfU3kbWvLOQ8b3X+3cT5qS21fEYWHHnEQdmyJgZ+qqNpW+kmW0eIlXADGY9W4kfH0c
         s72YX7kwCi/j3Nc4PbmkQvfXTIUTq84Qhh+L8vZ7Qusm5FDjmHiEASabIfw/Hn6xw0N2
         9ooQ==
X-Gm-Message-State: AFqh2krYiRpgCEVQvcphDY1xaMTJlKBKAs+of+yxiJihNvx3SBlg+piL
        mQSR7GywF0BP6yrLyQdUL56NHBdvI68lv5wdjjwvP7BqMZL0KPqgsYR8W70AXjYjgB2ztosIDUR
        Zrr3JQB92WaW/tJ+UiqntL0Lm/g==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr47082371wmq.40.1675172930143;
        Tue, 31 Jan 2023 05:48:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXshlDM/kQP8UJqjwbUaYwp0yiDAedYva3SxuXjhG46v5k1mOFWlDh+q4kEbTiH/6PL7Sw4dLg==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr47082333wmq.40.1675172929825;
        Tue, 31 Jan 2023 05:48:49 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003dc4aae4739sm13771171wms.27.2023.01.31.05.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:48:48 -0800 (PST)
Message-ID: <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
Date:   Tue, 31 Jan 2023 14:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, John Hubbard <jhubbard@nvidia.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3791872.1675172490@warthog.procyon.org.uk>
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

On 31.01.23 14:41, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>>>> percpu counters maybe - add them up at the point of viewing?
>>> They are percpu, see my last email. But for every 108 changes (on
>>> my system), they will do two atomic_long_adds(). So not very
>>> useful for anything but low frequency modifications.
>>>
>>
>> Can we just treat the whole acquired/released accounting as a debug mechanism
>> to detect missing releases and do it only for debug kernels?
>>
>>
>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>> really defer it any longer ... but I'm curious if it would be of any help to
>> only have a single PINNED counter that goes into both directions (inc/dec on
>> pin/release), to reduce the flushing.
>>
>> Of course, once we pin/release more than ~108 pages in one go or we switch
>> CPUs frequently it won't be that much of a help ...
> 
> What are the stats actually used for?  Is it just debugging, or do we actually
> have users for them (control groups spring to mind)?

As it's really just "how many pinning events" vs. "how many unpinning 
events", I assume it's only for debugging.

For example, if you pin the same page twice it would not get accounted 
as "a single page is pinned".

-- 
Thanks,

David / dhildenb

