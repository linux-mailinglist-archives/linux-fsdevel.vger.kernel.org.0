Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7D677C67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 14:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjAWNZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 08:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWNZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F3F244B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674480257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=EbxXMhRtRiYzDy2F9fR304N9/g+oOp9PfPHLlQ9jRxzWuF/SbMUbDdFY3iAT5Gen9p/LpN
        kZpG9ti/U+wePKkWACqtbqvFmMxQfrinvB+aphtZT6d6Gbw7ng0SXlzeVIRWKsi1mRx8Zx
        ROqAE1GsUPEiKkGMv6hLOVsu4GRiJyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-utBspWt-Nfy4q4XotTVVNQ-1; Mon, 23 Jan 2023 08:24:16 -0500
X-MC-Unique: utBspWt-Nfy4q4XotTVVNQ-1
Received: by mail-wm1-f70.google.com with SMTP id l31-20020a05600c1d1f00b003da8b330db2so3267218wms.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=FJB56zLYIg32kmzs4nFgfLZRT+mugaFCnRywt6M9hl74/YObsEzu0RiyZdNfLz+VqT
         RUm5MJPgNgZYMlTpjw0szsteKyzzZ33s4WoQQs+FqXURTAvyuCEVXIjDnFqNCKP8Gthh
         yb4hFWgsStfashEjTazz5s+ScsOSwFM8tUQzsPH/Q+kYiNIcFFIMFxR41biGmvzvW7pn
         DVWTtNLUrQYK3YXj+X3aQ2VKeN3x0JKTDQkisWNmyh71kN2zwv0WU3hXXgFk1B5DmZ0C
         10PkffVwKDoBt7mWsqKz4xBvGZVcQmkW5UHPkVI5BlxPYDVp1EA4f/5UmvjjjCnEXTen
         blzg==
X-Gm-Message-State: AFqh2kp5/ecyjIb6QQTSFHNbWyn/xGo06Q9sP0oKMTJUUuZRe2G9hAx/
        v0xFi+EOppum7esK5JzKEBr/+CrgbXJhu/kXb0uWqZKhSiUYYuHMmsmkRazWs8CCiMwcJJZNvPM
        Zyp1VRNVIXwdvt3DVMwWVA0QCxQ==
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258708wru.11.1674480255379;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvSy/zF5gTuo4Pty91+hnKwsIVtv4UfaZ96iv4w0a9eQ3v+gYxG+33cMyS8lFosJqrFvgcRYQ==
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258685wru.11.1674480255115;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002bdcce37d31sm33258092wrw.99.2023.01.23.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:24:14 -0800 (PST)
Message-ID: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
Date:   Mon, 23 Jan 2023 14:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3903251.1674479992@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.01.23 14:19, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
>> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
>> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
>> unfortunately, no reflect reality yet.
> 
> Yeah - I just came across that.
> 
> Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
> get_user_pages()?  In which case my patches only need keep track of
> pinned/not-pinned and never "got".

That would be the ideal case: whenever intending to access page content, 
use FOLL_PIN instead of FOLL_GET.

The issue that John was trying to sort out was that there are plenty of 
callsites that do a simple put_page() instead of calling 
unpin_user_page(). IIRC, handling that correctly in existing code -- 
what was pinned must be released via unpin_user_page() -- was the 
biggest workitem.

Not sure how that relates to your work here (that's why I was asking): 
if you could avoid FOLL_GET, that would be great :)

-- 
Thanks,

David / dhildenb

