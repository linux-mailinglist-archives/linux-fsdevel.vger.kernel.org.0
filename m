Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723E67C8D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjAZKmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 05:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjAZKmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E311657
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674729704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=Y2nMHQP2QM+h4S7fN3EsURiXO0W8AWg1Iz6xu7EiBAP2owrxooH6uOAl1EEZ6tOYyyFK6/
        n4WRuLt09g2DTXgHCwKjr9GOFGvgctJhunxqZVNCtan0ICPsmfe9IipCZEYJ8N6ohbM4J6
        XpTTtN2Lvc2+7e7LJ4FBrJT3lJpD7L4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-VnhpzoWoMU24Rd-TH395Jg-1; Thu, 26 Jan 2023 05:41:43 -0500
X-MC-Unique: VnhpzoWoMU24Rd-TH395Jg-1
Received: by mail-wm1-f69.google.com with SMTP id az37-20020a05600c602500b003da50af44b3so847434wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=SXwY7WsPB0VYT3yBnBF4aKBZJJMzgaIv+KEF0wtwN1A8OGM0YbtVDw6eQh4wPqEIix
         k2OmN+tV/esPs1kTCD4ofS/GeIusQrLuoCpyCvSIJBtHMagWi5QSxneixYLtd278+MN2
         3kDEJDNVrVW1fJKvG21+FZB9C4ifCOdU+sw79VHXIrHonABHXo5+7XBrWqtoFsM3/reJ
         EuICaWec4IFKTC09msDXRx0yVTVjZ49oT+224AX8jlg0tDxOuAeQWlVwQiG87Ez+1lKr
         Y4AULQxU4uZIrseZf2LpbcFIeSgfuFaVio8Te9xqGlABJKHRv49Y4t7RpRP9T1KWscbb
         qkaw==
X-Gm-Message-State: AFqh2kpbDqdILdg3eyye9tRIlFdZ/g3qs8tYgP0ixu+2P9d7vxS6WDBz
        i9zt0O0DsuPVlch1B2MYJJK6DvpDw3PIzpLksXY38KmHGSfW0utrdjgmzl8dlLbkXRZqsYFwAKH
        QcJWDDHcsr2MGwh6vQeyaYQycUQ==
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303909wmn.2.1674729702025;
        Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWhy4TGOvCPFAbQoLxK9D8awwiSNTdJq0Nz5MUw3B7wix4cF4N7mvyXVyul/6m5yzASpKTpA==
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303893wmn.2.1674729701735;
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003d9fb04f658sm4683254wmq.4.2023.01.26.02.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Message-ID: <b8082dcd-632b-bf75-061c-143cca6fa70d@redhat.com>
Date:   Thu, 26 Jan 2023 11:41:40 +0100
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
 <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
 <2638928.1674729230@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] iov_iter: Use __bitwise with the extraction_flags
In-Reply-To: <2638928.1674729230@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.23 11:33, David Howells wrote:

> Interestingly, things like __be32 are __bitwise.  I wonder if that actually
> makes sense or if it was just convenient so stop people doing arithmetic on
> them.  I guess doing AND/OR/XOR on them isn't a problem provided both
> arguments are appropriately byte-swapped.

I recall that __be32 and friends were one of the early users of 
__bitwise in the kernel. And the reason IIRC was exactly that: detect 
when no proper conversion was performed using static code analysis 
(Sparse). While some operations might make sense, the abuse is much more 
likely.


LGTM, thanks!

-- 
Thanks,

David / dhildenb

