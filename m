Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D667DAAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjA0AVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA0AVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C3E7518A
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674778809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhv1sJ/5W0UVM3IUaKfTJOk/lsk/OG7li8FezRc9IqY=;
        b=DkTunwBpJSYy9e1W7sU472ZkNv4MM0IFJWe1JsveDEugSr8Wd9Autzjn7MEykf4FjOuQBT
        AW4IFLMoce8iV6RPWEueK9r8xGgCBKn2kZAD9P572Mkfqg6eW2VL7Cwbf6VrSiDhQs69zC
        DOxYElIqYVP9pcuJM0tn7QuTOkB/taI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-QIK-oXVPNGiG_AtkY1pMZg-1; Thu, 26 Jan 2023 19:20:08 -0500
X-MC-Unique: QIK-oXVPNGiG_AtkY1pMZg-1
Received: by mail-wm1-f70.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso1902427wmb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 16:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhv1sJ/5W0UVM3IUaKfTJOk/lsk/OG7li8FezRc9IqY=;
        b=wYA6XET/NEcynvCoZ+RunH+TffSj4WcDWuWdG16Y2gZN47VG+KqkBdZ28rsRH4gqnh
         V7GvOLJC0vGCN23M1qLi1ooxnjhlUMiGGfF0Hr929nOEN/7CnmvlcMmlAOBf3lYReuMu
         VxqZUzwRi1Nm6KisnwzVbpJa7W8gJMDKF1l9EUBSvkIAj4J4/xoNZeOWdDAw1iCMWYtK
         9YrYQiubqaAvCpOW5sKV3F+AC2GAQJp1Wuz86jqe/prz3DjFkto0ugMnpe76k5o3OwMd
         Up4Z3QUDpXDjlK6jll+7lXGo7vyFncWBVkp+TbiDKCHbLFCdeeMD6ViPXCF1OiFbgBjX
         B+1A==
X-Gm-Message-State: AO0yUKWu8fBUUgCDHzOZ47Lg2aTO/tdDnxsdSplKlD6e3B4EjEa+Zyv8
        E/99r5mePfTZ2ILt0OxbRyfTv2awXDzPtTKmv7qfn0hhl6BZ17tWmKWva4TbruLqVSVSF/NFwI9
        sOvMNObrGhiYlL1f0iQ5NA+tXNg==
X-Received: by 2002:a05:600c:310c:b0:3dc:18de:b20d with SMTP id g12-20020a05600c310c00b003dc18deb20dmr9805066wmo.33.1674778807382;
        Thu, 26 Jan 2023 16:20:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+gxf09mnZS2txjdvCu5CPjJ98z7mHcuibpRYdj9hAoCYlhY/aoOQNZFqN0DCrStRv4arpcvw==
X-Received: by 2002:a05:600c:310c:b0:3dc:18de:b20d with SMTP id g12-20020a05600c310c00b003dc18deb20dmr9805046wmo.33.1674778807122;
        Thu, 26 Jan 2023 16:20:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c2e5200b003d1de805de5sm2656808wmf.16.2023.01.26.16.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 16:20:06 -0800 (PST)
Message-ID: <3396eec4-a469-5b95-06db-c40e5616465b@redhat.com>
Date:   Fri, 27 Jan 2023 01:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
References: <5a1796f3-e49c-80e8-2dd6-9a6e82939271@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com> <Y9L7cRFFZh9A7kZY@ZenIV>
 <2907560.1674777959@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
In-Reply-To: <2907560.1674777959@warthog.procyon.org.uk>
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

On 27.01.23 01:05, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> As raised already somewhere in the whole discussion by me, the right way to
>> take such a long-term ping as vmsplice() does is to use
>> FOLL_PIN|FOLL_LONGTERM.
> 
> So the pipe infrastructure would have to be able to pin pages instead of
> carrying refs on them?  What about pages just allocated and added to the pipe
> ring in normal pipe use?
Ordinary kernel allocations (alloc_page() ...) always have to be freed 
via put_page() and friends. Such allocations are unmovable as default 
and don't require any special care.

Pages mapped into user space are movable as default and might be placed 
on ZONE_MOVABLE/CMA memory (well, and might be swapped out). 
FOLL_LONGTERM makes sure to migrate these pages off of such problematic 
physical memory regions, such that we can safely pin them until eternity.

-- 
Thanks,

David / dhildenb

