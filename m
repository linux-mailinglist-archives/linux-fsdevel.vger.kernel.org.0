Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18B550E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 03:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiFTBak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiFTBai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF0CF60DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655688636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m84C8oG+oFGyQ0i+A2o8bEJV9tjqcgrBl3QurQb4ooo=;
        b=Sa4T7Zy/g56tXuSVYWoRR8PdMQ4xHkVFERyzgDrJTHTVp8OWKZZDjTXRRFxxgyZtsaa8jz
        wZt01e+KtSAjreDFllLUZJFCAiDgVMqcdiZ+zFbIVHvjQhV0kSExwoYx464u0roiLznYhJ
        T0noQec9r/tpBzh2RmF3CDiWT9RUSgE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-iHoHlRcmMPKRvVdgJxP-Nw-1; Sun, 19 Jun 2022 21:30:33 -0400
X-MC-Unique: iHoHlRcmMPKRvVdgJxP-Nw-1
Received: by mail-pl1-f197.google.com with SMTP id c4-20020a170902d48400b001640bfb2b4fso6013830plg.20
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 18:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m84C8oG+oFGyQ0i+A2o8bEJV9tjqcgrBl3QurQb4ooo=;
        b=KmZBwZlbD0gjMSFeBBGB3Y4druPt3IZsfdEQOMB7h6zGSgOS2w0P2bPw1CcpuK6t6i
         IsDYMyPs4qmnthJodUJ7FiJJ51wiKstiq8WLk+kOC4EDZqqsN0i4gAkWUg0lRNzTViTq
         R4rs3UjpFTkEoiZwjrhV50vP3KthJNZDyFNmY02xfLrXqfaJVIWqAKYhTI/EwjPWfkfT
         G6EAWFTAeJCJGkwxTtv8p1yKUWrGbFsPSZJ8a0pWLxjan/Ht+Uq/JYNw9F3TmhMYquO6
         ld1LDdMXDjTY2hgGN0RIlyniQ32JX3kXQaxTvo07GDyalJO2gud6ahQVudb271Q6Hi5N
         Pq2A==
X-Gm-Message-State: AJIora9xTISE3yIj5bW7981yYu80YgnK/BHTsNqRvh8zu9Uu5udT9+DR
        CKuDgdMiFtvGZwuSPc3JNokrP4G3zz9ZkkhhFJ+KqeRBtp2UDuv5nTlcYj59fd4KVP/lNNETyfk
        xJYPl0nsHwuWYUtkHZgm7DLgN6Q==
X-Received: by 2002:a63:6ec3:0:b0:40c:450f:2f83 with SMTP id j186-20020a636ec3000000b0040c450f2f83mr15126071pgc.220.1655688632314;
        Sun, 19 Jun 2022 18:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0Zqp5eQp+eTkibB14bRc7BTuzOIbNFEFvRZPn1cuuTDGjY1baAwtXtghfbI6xSFV7JYKQSw==
X-Received: by 2002:a63:6ec3:0:b0:40c:450f:2f83 with SMTP id j186-20020a636ec3000000b0040c450f2f83mr15126040pgc.220.1655688631953;
        Sun, 19 Jun 2022 18:30:31 -0700 (PDT)
Received: from [10.72.12.43] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b00162496617b9sm7287770pls.286.2022.06.19.18.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 18:30:31 -0700 (PDT)
Subject: Re: [PATCH] ceph: switch back to testing for NULL folio->private in
 ceph_dirty_folio
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220610154013.68259-1-jlayton@kernel.org>
 <6189bdb3-6bfa-b85a-8df5-0fe94d7a962a@redhat.com>
 <Yq6c0fxTLJnnU0Ob@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <63d6a1eb-44a5-eef9-2d28-acd172d87c2d@redhat.com>
Date:   Mon, 20 Jun 2022 09:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Yq6c0fxTLJnnU0Ob@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/19/22 11:49 AM, Matthew Wilcox wrote:
> On Mon, Jun 13, 2022 at 08:48:40AM +0800, Xiubo Li wrote:
>> On 6/10/22 11:40 PM, Jeff Layton wrote:
>>> Willy requested that we change this back to warning on folio->private
>>> being non-NULl. He's trying to kill off the PG_private flag, and so we'd
>>> like to catch where it's non-NULL.
>>>
>>> Add a VM_WARN_ON_FOLIO (since it doesn't exist yet) and change over to
>>> using that instead of VM_BUG_ON_FOLIO along with testing the ->private
>>> pointer.
>>>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/addr.c          | 2 +-
>>>    include/linux/mmdebug.h | 9 +++++++++
>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>>> index b43cc01a61db..b24d6bdb91db 100644
>>> --- a/fs/ceph/addr.c
>>> +++ b/fs/ceph/addr.c
>>> @@ -122,7 +122,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
>>>    	 * Reference snap context in folio->private.  Also set
>>>    	 * PagePrivate so that we get invalidate_folio callback.
>>>    	 */
>>> -	VM_BUG_ON_FOLIO(folio_test_private(folio), folio);
>>> +	VM_WARN_ON_FOLIO(folio->private, folio);
>>>    	folio_attach_private(folio, snapc);
>>>    	return ceph_fscache_dirty_folio(mapping, folio);
> I found a couple of places where page->private needs to be NULLed out.
> Neither of them are Ceph's fault.  I decided that testing whether
> folio->private and PG_private are in agreement was better done in
> folio_unlock() than in any of the other potential places we could
> check for it.

Hi Willy,

Cool. I will test this patch today. Thanks!

-- Xiubo

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8ef861297ffb..acef71f75e78 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1535,6 +1535,9 @@ void folio_unlock(struct folio *folio)
>   	BUILD_BUG_ON(PG_waiters != 7);
>   	BUILD_BUG_ON(PG_locked > 7);
>   	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_BUG_ON_FOLIO(!folio_test_private(folio) &&
> +			!folio_test_swapbacked(folio) &&
> +			folio_get_private(folio), folio);
>   	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
>   		folio_wake_bit(folio, PG_locked);
>   }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2e2a8b5bc567..af0751a79c19 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2438,6 +2438,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>   			page_tail);
>   	page_tail->mapping = head->mapping;
>   	page_tail->index = head->index + tail;
> +	page_tail->private = 0;
>   
>   	/* Page flags must be visible before we make the page non-compound. */
>   	smp_wmb();
> diff --git a/mm/migrate.c b/mm/migrate.c
> index eb62e026c501..fa8e36e74f0d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1157,6 +1157,8 @@ static int unmap_and_move(new_page_t get_new_page,
>   	newpage = get_new_page(page, private);
>   	if (!newpage)
>   		return -ENOMEM;
> +	BUG_ON(compound_order(newpage) != compound_order(page));
> +	newpage->private = 0;
>   
>   	rc = __unmap_and_move(page, newpage, force, mode);
>   	if (rc == MIGRATEPAGE_SUCCESS)
>

