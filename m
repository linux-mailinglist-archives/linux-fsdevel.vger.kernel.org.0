Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B87A22BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjIOPop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjIOPoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7C3F3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694792607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HjRpUexdgJAehf7Qv6azxAmOLDK2cUSsvpp8na9Sbw=;
        b=OK9AHQfcJjfRryj9S3+lt/2D9UHH2J7ekFKBm7XbS2JclByyhfooR6l54Wr6B9z7mvuCd9
        TlOqrJjcXQYlB4s/QDdEkbbBkxW1qnzsLsohLaXzJwzi4OlhV1hbydxlm2GSmsSPK0j71Q
        lZCaiXcHeXXgQbiBKrVx7pcAOUXSxN8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-F41rSfQbN5S_5JNt7ndYOg-1; Fri, 15 Sep 2023 11:43:24 -0400
X-MC-Unique: F41rSfQbN5S_5JNt7ndYOg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50081b0dba6so2748011e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792603; x=1695397403;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HjRpUexdgJAehf7Qv6azxAmOLDK2cUSsvpp8na9Sbw=;
        b=V7Ag/O+cUaB0Y6pjeN1hHxvDAxmWTMs56iRQ9Z+erg6cCMxjDKcl93b+5qT3uzLKTN
         5LDLCyL4NzPhCIERE2zDKfkuLKhovOWyG6pkAh98bMK5UaRoIRsWWDbzgerD0rhCvnZ8
         7qP42U571amKmctrT8wlREuL7ojgKP5mNQ5JVb7yyXMpHqMkpsuo3p2FXrIPyv9rw8u0
         ZhIbRsNT57srBbXbfXNU5RCU1wM/tthvOUHU6mpGBdjNKICrbFm82x6/Q3kPB5Z6PUbH
         i8rPnOIfHeGakBkfWJuViLYwGuozaFltX7yWNEajhCvwuhThjg5Jjv5iO1n7HEG+J68y
         h2oQ==
X-Gm-Message-State: AOJu0YwSSu/C0BxLD6GxQMbtYbUXQCOR2Rj77LrQMz5YTRqd5DPxtTu9
        /OG88WqlSWlqxeynI75g/OAqqdobdihw9rSmEbkzKes4x/oIO5fGxN1ZXMbJe7ZHBykezs8+RrG
        DyH2gfW6AmqY70GfwP8C5SilS7A==
X-Received: by 2002:a05:6512:2528:b0:4fd:f84f:83c1 with SMTP id be40-20020a056512252800b004fdf84f83c1mr1921025lfb.64.1694792603013;
        Fri, 15 Sep 2023 08:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUlzqnI9IhxadefzLCHSEYLKXLnj68ovmQNeMXOp3JfxSWFhttFec7rrRBDh3udFZ2SJb/Tg==
X-Received: by 2002:a05:6512:2528:b0:4fd:f84f:83c1 with SMTP id be40-20020a056512252800b004fdf84f83c1mr1920990lfb.64.1694792602530;
        Fri, 15 Sep 2023 08:43:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70? (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de. [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
        by smtp.gmail.com with ESMTPSA id x25-20020ac24899000000b004fb738796casm685274lfc.40.2023.09.15.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:43:22 -0700 (PDT)
Message-ID: <15b067d7-8f95-d409-64be-d22359f0942a@redhat.com>
Date:   Fri, 15 Sep 2023 17:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
 <ZQR5nq7mKBJKEFHL@casper.infradead.org>
 <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
 <ZQR7CyddIQQAs3yb@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQR7CyddIQQAs3yb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.09.23 17:40, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 05:36:27PM +0200, David Hildenbrand wrote:
>> On 15.09.23 17:34, Matthew Wilcox wrote:
>>> No, it can't.  This patchset triggers only on write, not on read or page
>>> fault, and it's conservative, so it will only allocate folios which are
>>> entirely covered by the write.  IOW this is memory we must allocate in
>>> order to satisfy the write; we're just allocating it in larger chunks
>>> when we can.
>>
>> Oh, good! I was assuming you would eventually over-allocate on the write
>> path.
> 
> We might!  But that would be a different patchset, and it would be
> subject to its own discussion.
> 
> Something else I've been wondering about is possibly reallocating the
> pages on a write.  This would apply to both normal files and shmem.
> If you read in a file one byte at a time, then overwrite a big chunk of
> it with a large single write, that seems like a good signal that maybe
> we should manage that part of the file as a single large chunk instead
> of individual pages.  Maybe.
> 
> Lots of things for people who are obsessed with performance to play
> with ;-)

:) Absolutely. ... because if nobody will be consuming that written 
memory any time soon, it might also be the wrong place for a large/huge 
folio.

-- 
Cheers,

David / dhildenb

