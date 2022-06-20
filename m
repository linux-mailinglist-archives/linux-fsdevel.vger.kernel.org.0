Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A859855285D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiFTXmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 19:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiFTXmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C801B7A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655768552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loNrawDUVj3mdCQPJAzyrH5o/8r/aVwsRAwGWDR9o6c=;
        b=Aw9qSXLTp6m+bHYFb1EFdlfUua8cYXz5x1wWIzhaWbPOtrlati4gHlGlwRf0aefRjX2JpG
        H+8RTduAZ7wCmvDhD42/vPoQkYjy5FzsCDa/cgBhv8IH2e5JgJkHH5pXmlMWIbbRLmqPPu
        glx2prLrMq3Vl0lrcZXy3KIN3Y7EIck=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-uCCU3axxOzWELpqaAForSw-1; Mon, 20 Jun 2022 19:42:31 -0400
X-MC-Unique: uCCU3axxOzWELpqaAForSw-1
Received: by mail-pg1-f197.google.com with SMTP id e18-20020a656492000000b003fa4033f9a7so6759205pgv.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 16:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=loNrawDUVj3mdCQPJAzyrH5o/8r/aVwsRAwGWDR9o6c=;
        b=P6b8mdzUQMWneJmZviYSBHwhpRDzTii1UxZsv5dq6ntaXBpIzISE3OFqe5W04rMPxt
         Q6z1I9MGD7LNaHqBDw5u6AV/edZvvxnfIpGWEs057oiogMTyazyEYlsCKLADfPMhCCzo
         mrasBMaqhwwmb7BCGTDr+XDLwsYZ8SQusYBmx1ySlDtn9dDgkdJjXiHnjiDm7nGV0WIw
         mtPw4Z5F0nFrN0T4oycsP2aAgcXLShzeCnA4zMs42S3RuYAxaZPXGNd3vRMR0wJfxEYg
         p6wv7sPar4DcPbJcwBCZOgaH7yvRj1paTuGkyjw2BUoo21gy1mN0JMjOfdb5JExSOGp9
         XlrQ==
X-Gm-Message-State: AJIora8IJ62lYDJzYpWpjIW7/tiasFihcs4/vY2tLbYAo860N6fQlwQH
        On1aMVQ0vRdJbKPF3DQ9LCJxfgacXzCtcH21A6H+3fKwRaZCcNN+RlCZxrwsYGsoIX1kdNZyBf/
        hfr6GJaN70jSZRiuUv4gZViCPpQ==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr27112514pfh.53.1655768550092;
        Mon, 20 Jun 2022 16:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vORMwzs8V7+LrHTlliRKYxkGiU/vCdiqyLc8Q5/6bM9DBCI5Hbys8gcn5U1fwE/tmqG8fLOg==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr27112494pfh.53.1655768549770;
        Mon, 20 Jun 2022 16:42:29 -0700 (PDT)
Received: from [10.72.12.43] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q23-20020a17090a065700b001ec9ae91e30sm3437393pje.12.2022.06.20.16.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 16:42:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: Clear page->private when splitting or migrating a
 page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-4-willy@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <88cbf01f-a82e-f527-b343-73f85cc6f1c8@redhat.com>
Date:   Tue, 21 Jun 2022 07:42:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220619151143.1054746-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/19/22 11:11 PM, Matthew Wilcox (Oracle) wrote:
> In our efforts to remove uses of PG_private, we have found folios with
> the private flag clear and folio->private not-NULL.  That is the root
> cause behind 642d51fb0775 ("ceph: check folio PG_private bit instead
> of folio->private").  It can also affect a few other filesystems that
> haven't yet reported a problem.
>
> compaction_alloc() can return a page with uninitialised page->private,
> and rather than checking all the callers of migrate_pages(), just zero
> page->private after calling get_new_page().  Similarly, the tail pages
> from split_huge_page() may also have an uninitialised page->private.
>
> Reported-by: Xiubo Li <xiubli@redhat.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/huge_memory.c | 1 +
>   mm/migrate.c     | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f7248002dad9..9b31a50217b5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2377,6 +2377,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>   			page_tail);
>   	page_tail->mapping = head->mapping;
>   	page_tail->index = head->index + tail;
> +	page_tail->private = NULL;
>   
>   	/* Page flags must be visible before we make the page non-compound. */
>   	smp_wmb();
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e51588e95f57..6c1ea61f39d8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1106,6 +1106,7 @@ static int unmap_and_move(new_page_t get_new_page,
>   	if (!newpage)
>   		return -ENOMEM;
>   
> +	newpage->private = 0;
>   	rc = __unmap_and_move(page, newpage, force, mode);
>   	if (rc == MIGRATEPAGE_SUCCESS)
>   		set_page_owner_migrate_reason(newpage, reason);

Test this patch by reverting my previous patch for many times yesterday, 
and it worked well for me till now. I will test it more to see whether 
there are other cases could cause the crash.

Tested-by: Xiubo Li <xiubli@redhat.com>

-- Xiubo



