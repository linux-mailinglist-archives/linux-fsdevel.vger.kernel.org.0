Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B26679BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjAXO3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjAXO3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569946099
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcE8aMk0nuyOp8A5rZ9P6/Lyi869xz8dmy/T7YLnETw=;
        b=b5wqsKp2tArvbvhMPNDROePp6kKsN/eNEFAlQCkww2MqHFrt/6IF3JdGx/UOyjvChFilPH
        OdF2+10eleQoowA8m8asfvQuElg/wnomBRBXjtFGPC+JbKajFh5xxRF2xctKLmmvdV7nYG
        HxISyFHEYX+Oo7G+m2uxnKhzzXnj7HA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-t1MXB1JlNVSiL8tN0BVN8A-1; Tue, 24 Jan 2023 09:28:50 -0500
X-MC-Unique: t1MXB1JlNVSiL8tN0BVN8A-1
Received: by mail-wm1-f72.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso9296650wmb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcE8aMk0nuyOp8A5rZ9P6/Lyi869xz8dmy/T7YLnETw=;
        b=kdECYdL4+gudrZSAYxwYD2ai+6RswlYI76KFnaZhMEKD113+6F19EuK7zYIm3MpUSX
         7ESwRmz9UJg0yYja/VIgxWMyOoaMJaSQ4ZQa1jsdHROAmU7NXPOq5TyOUwL1TvEZLbSO
         vFpUoKkQt3suMkNV9QTwgHAxB0Vk7kazLFQ3aHmzitPZPxrcscd3zKfJL4Mf0C4FF4rA
         kked2KbIbphMCzAjMey/sKO4ydM12TRuKQU5yHLeK28GhLFQ+aW3NpAwsrw/duQJQyhE
         zNlfRfKuGaGu5f65tE8nJjeE40pQPb32vtIe+26Qt/nmON4db4fq60cb1lDDYeFPkz6N
         KZdg==
X-Gm-Message-State: AFqh2krXX5XeZlqnGDof3pJaTuc7EegsvvGyVt71DD5viN+7/QdZaWTx
        2R4mDi60hKwwWA8rH0MbxIFbRy/kGYrcGlCjIltQB+GG2NlWXXScn2xlLFUMR2jsTBNuzq8rPYC
        xSUOeTGmqT3zEEeHBjSQad3CtSw==
X-Received: by 2002:a05:600c:4928:b0:3da:acb1:2edb with SMTP id f40-20020a05600c492800b003daacb12edbmr27860146wmp.5.1674570529073;
        Tue, 24 Jan 2023 06:28:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvU+TzNYusrMmexwZqzE1le1hmjTrZbLX2uQALSqtbhAfUPq7shzbKGAP8syH8G1OEcV3h/g==
X-Received: by 2002:a05:600c:4928:b0:3da:acb1:2edb with SMTP id f40-20020a05600c492800b003daacb12edbmr27860130wmp.5.1674570528771;
        Tue, 24 Jan 2023 06:28:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b002bddd75a83fsm2053264wrt.8.2023.01.24.06.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:28:48 -0800 (PST)
Message-ID: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com>
Date:   Tue, 24 Jan 2023 15:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-4-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123173007.325544-4-dhowells@redhat.com>
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

On 23.01.23 18:30, David Howells wrote:
> Provide a helper in the get_user_pages code to drop a pin or a ref on a
> page based on being given FOLL_GET or FOLL_PIN in its flags argument or do
> nothing if neither is set.

Does the FOLL_GET part still apply to this patch set?

-- 
Thanks,

David / dhildenb

