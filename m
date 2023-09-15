Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3377A228D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjIOPhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbjIOPhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17363E6C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694792192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKvZfNUAeqRJOa+1glQDGtoNRuRm5yfurVcRjFqOx34=;
        b=ivO79RbsbHLEJqodTn5lBhridvZAPtxlVMqJRajFE3eVaBwZAta+BsIDnAq+wK/g39Fwts
        nULoIsACG3VDRIqKcvJBZmqSDrSV4IPPC3gpynhLo0ddgZvRUj09KOwbGs9sggVdmbq/iK
        WfbLWYKicJqQzJAnuwttX6OtevSFE8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-9ZKqDhR_NSOE_11vKKcLHQ-1; Fri, 15 Sep 2023 11:36:31 -0400
X-MC-Unique: 9ZKqDhR_NSOE_11vKKcLHQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31fed999e27so747203f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792190; x=1695396990;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKvZfNUAeqRJOa+1glQDGtoNRuRm5yfurVcRjFqOx34=;
        b=JR0wciN7x9InYPUmQ8UPzRzmING/nRDBiSKq3MGnz9DbEbDu1mffL7EbTJbbO4lBEr
         FKGZNWOxvZfPKBvXL3x4yN3KuvjIW2z4zkLgzh9IYhcH2Uw1EXLO3tQ9MLmytVuz4S3Z
         J2XHbsW4Esz9SfgFyp86ErET9gJavpcOCVmqUbz26fxEP4xz4RAKOvFWl5a18BhO5F9K
         zaBiZ8fDf4pr8u/PW4j8AG7/KGJ8jxcynkVlEhN+iXEU9DqmI+ijBtvjfQU6aqh5Tm+9
         3qqHKIAvlnHSEZnFD5X4n22XYVfljy/zDt1xFBlit8To8bf4dlv/i53ZC8x0Gwyo39Sd
         YA6g==
X-Gm-Message-State: AOJu0YwvBJR6Q+PkD+coVOazRcQ61VRbdBZ7+lFYKgKYhkpunVDmtP64
        MG/CboVXRGsiG/2pJcZv3ugTWMUipBCaNkcp3zdIgZO+sLwrjERuncJSDODJv9qKZ5IBYuWR/xr
        +NhQtJW/E6qMyHNx9Zvw55OYOwQ==
X-Received: by 2002:a5d:46cf:0:b0:317:ec04:ee0c with SMTP id g15-20020a5d46cf000000b00317ec04ee0cmr1704606wrs.47.1694792189683;
        Fri, 15 Sep 2023 08:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtkB87/+nnfRuxfOJgL+CM9Ct3RseBJxuj5P7xcBr31HK1aWFwbEWtn8JZFFHltZl8Pm3o9Q==
X-Received: by 2002:a5d:46cf:0:b0:317:ec04:ee0c with SMTP id g15-20020a5d46cf000000b00317ec04ee0cmr1704581wrs.47.1694792189303;
        Fri, 15 Sep 2023 08:36:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70? (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de. [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b003176eab8868sm4793784wrs.82.2023.09.15.08.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:36:28 -0700 (PDT)
Message-ID: <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
Date:   Fri, 15 Sep 2023 17:36:27 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQR5nq7mKBJKEFHL@casper.infradead.org>
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

On 15.09.23 17:34, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 05:29:51PM +0200, David Hildenbrand wrote:
>> On 15.09.23 11:51, Daniel Gomez wrote:
>>> This series add support for high order folios in shmem write
>>> path.
>>> There are at least 2 cases/topics to handle that I'd appreciate
>>> feedback.
>>> 1. With the new strategy, you might end up with a folio order matching
>>> HPAGE_PMD_ORDER. However, we won't respect the 'huge' flag anymore if
>>> THP is enabled.
>>> 2. When the above (1.) occurs, the code skips the huge path, so
>>> xa_find with hindex is skipped.
>>
>> Similar to large anon folios (but different to large non-shmem folios in the
>> pagecache), this can result in memory waste.
> 
> No, it can't.  This patchset triggers only on write, not on read or page
> fault, and it's conservative, so it will only allocate folios which are
> entirely covered by the write.  IOW this is memory we must allocate in
> order to satisfy the write; we're just allocating it in larger chunks
> when we can.

Oh, good! I was assuming you would eventually over-allocate on the write 
path.

-- 
Cheers,

David / dhildenb

