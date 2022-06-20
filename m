Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886AA55109B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiFTGmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiFTGmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067C3E0B5
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655707330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5pSUOYEncUaPjeaEkr5IYucBBc8bLp3nCeCZmaUrOE=;
        b=cQ2VpiKwpyRzX9k5fIkpGMOojWcId1JStmnpyOo83wFycJ4IkACpSbz8tAo0IVN4iYPOSi
        VSQyXiE57+HIkVB6xcR0W/nhKnrGhVjjYvq3LAO8uiFP+mKVlN4qvLw93KMWwh/ZMudXeb
        NhN1C2yMxtveJvaFNFxgFtgKxpXZT38=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-bzc3WTVqMfWTQTfltM-OUw-1; Mon, 20 Jun 2022 02:42:08 -0400
X-MC-Unique: bzc3WTVqMfWTQTfltM-OUw-1
Received: by mail-pj1-f71.google.com with SMTP id v2-20020a17090a0c8200b001ec8f5b5e95so1983304pja.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 23:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B5pSUOYEncUaPjeaEkr5IYucBBc8bLp3nCeCZmaUrOE=;
        b=CPJEv2Fbl0+gBWPo5UvRzEjW7z0uShj92mBmBwT6lhHriqOKjRUxD+NaUzhXyD5yFy
         XtCej4Try+TsQ3aEAJzbBK1W+cSWBYXN+AVijcd3qaAygzxHZSMcohuOLCgbwVCL2vNm
         sV21QB92W7/xrYXr2J4O7tsUWPyhbZp1Y2IiZvM9f+/XKcokBC1tZKE0mvkDH6Pl4IvE
         GqobSdInGgaub+Mts0+zMMWAOlOPMVwvlB9conL/Tvthih3/2lm84GA2rGEERURbtSf7
         mKyaNgVphlBO6dG928mXDzB2XL1Bje0Nxp5i6dnk/JZtipGmxm6r7qsJJAVVGp5kUStN
         KQAQ==
X-Gm-Message-State: AJIora+e46fdYNzl25WjlfN+iFByVcySPDplcMu+MouPLDgE2ls4o9ac
        y6rVC+tb8eHmF1EZyA1x/qzUduqn1yO+z5X1Ob6w72pVxy2ol93PrdAtnTPJq8s5ze4CGBFLBpg
        QMbmXkArN7oilZNjUzi335ithx01fVbY685+w1xBoLc8SLkyVD6HqQETRy8m2JTdo9ju5tmMu5f
        Y=
X-Received: by 2002:a63:3608:0:b0:40c:a38e:2a3b with SMTP id d8-20020a633608000000b0040ca38e2a3bmr5229659pga.31.1655707326384;
        Sun, 19 Jun 2022 23:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vayy0dcfFwO7ndztwu/0c7V86tRzzO8t/BWwPdFrAopmGRmWzudi9T0GZvGPOV8ZY7FB73/A==
X-Received: by 2002:a63:3608:0:b0:40c:a38e:2a3b with SMTP id d8-20020a633608000000b0040ca38e2a3bmr5229633pga.31.1655707325972;
        Sun, 19 Jun 2022 23:42:05 -0700 (PDT)
Received: from [10.72.12.43] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090aa58900b001e2f6c7b6f6sm7379811pjq.10.2022.06.19.23.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 23:42:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: Clear page->private when splitting or migrating a
 page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-4-willy@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2031fee3-e09a-5cea-be26-71360893d161@redhat.com>
Date:   Mon, 20 Jun 2022 14:41:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220619151143.1054746-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

There has a warning when compiling it:

mm/huge_memory.c: In function ‘__split_huge_page_tail’:
mm/huge_memory.c:2380:21: warning: assignment to ‘long unsigned int’ 
from ‘void *’ makes integer from pointer without a cast [-Wint-conversion]
   page_tail->private = NULL;
                      ^
   AR      mm/built-in.a


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

