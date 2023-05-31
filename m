Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E84717879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjEaHn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjEaHnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED34E49
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685518951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pu0dxF+jwnL1jQ+DhiyLdliDD3ireyhq8OENBi+96kc=;
        b=fMh4OHxZJYZqhnDXp8oFtK50LNOUn3ha91Ubf2LNc9uvhGO9TSxkUQedkcbZHaJ575o+RZ
        POZ0P4W1FswIAixnBoBWa3PtvOoAgwxZAiMY8lciJ7vclC+teC3SdN/6SpG/HdAbcXPnwy
        7meGrC3hoKbH4QzRBHvraftUFYO9f/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-z9Ko_-F0Ow6F-5xGg-aCNw-1; Wed, 31 May 2023 03:42:30 -0400
X-MC-Unique: z9Ko_-F0Ow6F-5xGg-aCNw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3078b9943d6so2110183f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685518949; x=1688110949;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu0dxF+jwnL1jQ+DhiyLdliDD3ireyhq8OENBi+96kc=;
        b=RcXAXp05G+S+Yb+HHj6MZTQ8kBE/8f+ntAYAQXKintfJaHWyj6CGC3k4ah5/ml5mIB
         rNWP2/VsZ5wDNdD/hBMxvQw+5SICJxMsnG7ujzk7zYfBQvwBAF46tQlaUFWCL7DlSlfN
         Pf+bEgBc7mEZXq3HUgE54ClWJg39QdxvzXaCl/7X0rwYYqrQ4ctD/mPrAm7TRhmycBrZ
         Q0Fe4bNsyHK0RJvHOGxkvhBYojaqNrCWrmVATGlji/hGQw812a16mLmnh/A4rYu+FiCF
         EI/cCCi1ItC89UXAm10YPaIuVkAocAmAGjC0x7J0pF+HQZuIEVfm/mj9soFeN+YqdjJH
         pRXw==
X-Gm-Message-State: AC+VfDwS0tgn0m39DRQYcwl9f+ha5sMLbFG3A0KQlJeA24BghY0cnye/
        usIu/B/US+aFRshgPV8TWLC/BaBTrChnBbZSf/39q1IiSLZx7fsRPvFQ5NB1wcjShVrvyGXMcpf
        sjLloCw7bP8Y95eiTUGDD4VZQ9Q==
X-Received: by 2002:adf:fac6:0:b0:30a:ea8b:4488 with SMTP id a6-20020adffac6000000b0030aea8b4488mr3243072wrs.16.1685518949148;
        Wed, 31 May 2023 00:42:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/TwaL/29NG4Q1Wh9FQAc5H0Tf7tBtuQA1EX6A8ez87/GPRHlCFpKjZKyenEHxOPL3HkoPpg==
X-Received: by 2002:adf:fac6:0:b0:30a:ea8b:4488 with SMTP id a6-20020adffac6000000b0030aea8b4488mr3243049wrs.16.1685518948739;
        Wed, 31 May 2023 00:42:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id p12-20020adfcc8c000000b0030adfa48e1esm5812964wrj.29.2023.05.31.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:42:28 -0700 (PDT)
Message-ID: <de425aeb-4064-733a-52ed-e702c640c36f@redhat.com>
Date:   Wed, 31 May 2023 09:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 2/3] mm: Provide a function to get an additional pin on
 a page
In-Reply-To: <20230526214142.958751-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.05.23 23:41, David Howells wrote:
> Provide a function to get an additional pin on a page that we already have
> a pin on.  This will be used in fs/direct-io.c when dispatching multiple
> bios to a page we've extracted from a user-backed iter rather than redoing
> the extraction.
> 

I guess this function is only used for "replicating" an existing pin, 
and not changing the semantics of an existing pin: something that was 
pinned !FOLL_LONGTERM cannot suddenly become effectively pinned 
FOLL_LONGTERM.

Out of curiosity, could we end up passing in an anonymous page, or is 
this almost exclusively for pagecache+zero pages? (I rememebr John H. 
had a similar patch where he said it would not apply to anon pages)

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Lorenzo Stoakes <lstoakes@gmail.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

