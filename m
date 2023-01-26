Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452467C7CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjAZJxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAZJxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A55DC2F
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674726744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=AtBDEYboMRa0IlO4EH28yBvnQGsUIUTQoTs2hN/Uy0d9iJ7Pt3HggE1zisyha075+2Sc0O
        P8Ou6lr6apXxOSmVCk8bAevxMSL7ynwO5sEVG5BGz8mEESpAy43SB6r4XqBbW1BY21xev2
        0LuEBwWUW8WpiLrB1e7UiYizMb+x90I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-ElNuX1eRNLea9Yi0RLCj5g-1; Thu, 26 Jan 2023 04:52:23 -0500
X-MC-Unique: ElNuX1eRNLea9Yi0RLCj5g-1
Received: by mail-wr1-f71.google.com with SMTP id v5-20020adf8b45000000b002bde0366b11so176076wra.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=X8N3uUe7GkJVjcb1lFEZ6Zi5OQK6S1ynxqh6xu1VhJElcmldZrGI0yyvJF/Z8hb7Ai
         iWq6Zr4TUFsWqF/UKvRMz1Lz65L7rVGqCqkOV4icNG0fj5IbrFa7zdhDA6/Skq48GaKb
         mu1Peo/l5TE+9X9yCdwIesZ1J0M87+SreAuYF9E4JOP+BCqMrQI+GHFyRmyDVN5R2kH1
         clmcb+S3kCiVttA7+Twyxi8pxTtKBoGhMLSG4K6CKJtT4VnrIvWDp0H8aOpO+nw9sSgR
         GjepspWoGmYcceQJBacmRaj38uPTXPUwXxrWFn/0RUZjambCFD2idVWb0QybFbzjPcPY
         zXbQ==
X-Gm-Message-State: AFqh2kpn1+Afy+B/j9cRQ1q16dzbGSHA7dL1ysGv1oz5PRBi7bud9zP2
        fzNR4UDwcVD/awY3ZELbmZZYSUPveKgcugMnu64GvD1YpoJnb/inWW5bBz9jvInM14NRs9RE8Ow
        8BJ1eHvYbgaqceuR69ramvC9BDA==
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558724wrz.29.1674726742082;
        Thu, 26 Jan 2023 01:52:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt6POr1Th+z4xBilbq6MD55kPKMFdkWNrVBw8NH64BJ/rotUwhIVj/VoLFHThktbZr6ujT1Dg==
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558712wrz.29.1674726741832;
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002bfb1de74absm839299wrj.114.2023.01.26.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Message-ID: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
Date:   Thu, 26 Jan 2023 10:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page
 extraction.
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
References: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2613249.1674726566@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.23 10:49, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Just a note that the usage of new __bitwise types instead of "unsigned" is
>> encouraged for flags.
>>
>> See rmap_t in include/linux/rmap.h as an example.
> 
> Hmmm...  rmap_t really ought to be unsigned int.

Not sure if that particularly matters here in practice, ... anyhow

$ git grep "typedef int" | grep __bitwise | wc -l
27
$ git grep "typedef unsigned" | grep __bitwise | wc -l
23

So chose what you prefer ;)


-- 
Thanks,

David / dhildenb

