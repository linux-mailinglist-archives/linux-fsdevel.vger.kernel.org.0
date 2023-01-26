Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0F67D9EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjAZXqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 18:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAZXqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE74534C1D
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674776739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDPidku7XYmtarp/AVuc4betwoJhftsFOw1T5iwHCJo=;
        b=XnUFKjgDH0EC22ftJntI62LvXlvrdwDh+LM++rynAcVu+EkGXeLo+YrCz8uUDOl/wf00Vv
        ftDxQvMu7t7ctRA7dPiNO70FjCyJ5xrlj4oQj9/zy0RW1WTOxChlDvCl8W6FZin44+Q3mL
        9sv3riPiyCTK2w+6EjCsWwNcA8OtcV0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-SCaPdMtHNi2JFbBtP60YPw-1; Thu, 26 Jan 2023 18:45:38 -0500
X-MC-Unique: SCaPdMtHNi2JFbBtP60YPw-1
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so3655899wmb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 15:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDPidku7XYmtarp/AVuc4betwoJhftsFOw1T5iwHCJo=;
        b=FfpejXivjHIAlLAUwTZP+QEtAtExFCZM5MBxDzYnUDmS14hLgcL1oqbM77R/SGrwK6
         LuDZFQ2N7Kaxe8By4fB+066cL2FbB2L+CPwvizZZPRkBnUVC8QPPNWnDCyrHRn8b9lyz
         ecmf/J8wuzZ7PE4avcIxYfD3IQKz3Nt2pJwENYfcdM0dfyFdPWZa040KxVylqKaNCTxX
         xgpNohtkcmr5smZVlTnup2qk4IiYaxuYc73rDE50ro6km+gqVnPI8TyWdmBs3pibPmVo
         0LnebXPW33ODBNU+NuJ5JsrIRlwhuoOcLqJqFDwdetYdrUy1HrCSymydqfUT7xJbm3Gf
         RvSA==
X-Gm-Message-State: AFqh2krvmA9PZPEVbiNJ+jdT9hmpYcCRQ2UgU4pz9OZAbPbI+pXfZXnT
        e33cvqiUdnaJz/lRrAhYluHHY4rhZpx2tTtOz9ksmi/OU0ci8afzUv6JmCBNnSUWgZzI0JQXgTc
        /Suptl8W9Gczf8Txu9/yHayBzWQ==
X-Received: by 2002:a05:6000:1049:b0:2bb:ee8a:4282 with SMTP id c9-20020a056000104900b002bbee8a4282mr31802026wrx.34.1674776737006;
        Thu, 26 Jan 2023 15:45:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhVMC6HMmdj7izpzyhUASFO5g0VF0QIXfsOyqbgQyokValMXycp+aM8dqC3EF6J/Z4LUfi0A==
X-Received: by 2002:a05:6000:1049:b0:2bb:ee8a:4282 with SMTP id c9-20020a056000104900b002bbee8a4282mr31802010wrx.34.1674776736691;
        Thu, 26 Jan 2023 15:45:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b002bc6c180738sm2925652wry.90.2023.01.26.15.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:45:36 -0800 (PST)
Message-ID: <7622ebe2-7405-ce4f-6bae-2d51dc8bf929@redhat.com>
Date:   Fri, 27 Jan 2023 00:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 1/8] iov_iter: Define flags to qualify page
 extraction.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-2-dhowells@redhat.com> <Y9L2iFZlC4CFwN4t@ZenIV>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9L2iFZlC4CFwN4t@ZenIV>
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

On 26.01.23 22:54, Al Viro wrote:
> On Thu, Jan 26, 2023 at 02:16:19PM +0000, David Howells wrote:
> 
>> +typedef unsigned int iov_iter_extraction_t;
> 
>> +/* Flags for iov_iter_get/extract_pages*() */
>> +/* Allow P2PDMA on the extracted pages */
>> +#define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
> 
> That __force makes sense only if you make it a bitwise type -
> otherwise it's meaningless.  IOW, either turn the typedef into
> 
> typedef unsigned int __bitwise iov_iter_extraction_t;
> 
> or lose __force in the cast...
> 

Well spotted, iov_iter_extraction_t is missing __bitwise.

-- 
Thanks,

David / dhildenb

