Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFE7250D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbjFFXf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjFFXf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:35:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EA170A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 16:35:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b046bc0a83so25816225ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686094554; x=1688686554;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nrm4KWzvI342qxUWuFoP1xZ+ALX9wFb7Mi+LynEpxsg=;
        b=lRCGsNGXPqKlpaXsU05AWd1fUlOlpAhGfQeW2fCgsGKt5P8UgaTIvq74hHLSEDnmFY
         +7WoYf1/H9mJXa9Y3NM9wdCTD2kojewkwZsY4f75ldI4+Yvjm4IKeICdeAqf9l/05UUv
         gkwT9FzAv/JXMuxbLwBS7DNXojYnnP4SOlJmhpuqxCNAwTGQJq+Z3V9DoOjaUM70J2N2
         os0qkC4e0s4lGAV78hRYpekQ7tUGh5r+lkmhtTkcIwLxQ+Hq/fg47HpBHm6OTw54JV/Y
         LrbW5uOB2w2l7+Zr91Z7OdmZWnyuZeinFkEAZ5SuMf5RC8IhdC/OisFZdHmA6LUYiA1A
         VTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686094554; x=1688686554;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrm4KWzvI342qxUWuFoP1xZ+ALX9wFb7Mi+LynEpxsg=;
        b=kX0nt8WVWIyVIOh8JBIiuU/4yeX9SqhzAHeNe3eHApS7xdcn0wTLenvJKE4f3zwMQn
         N0qQzC9LuRjk0C09VYVXKGDrCanThZtuLHrbkbI0a14wxE+fd/3fi7DtFupWszH2AtvI
         xyGfk1nVyW+nShChVDxeZMGLb1coLOOO+DA/CQvhuQdGxr5QZ0nA/XRY0MIUyFDpH7dU
         K4jUjGF3IskCRukks+QtulMUuouaHMfxStg8Q6BtWNdige4Dtt05W3jhxMIHc/YaNx9T
         KE6BLK1F6TJ9YAq9W+UiQkCyU+O3yHrnjQArNCHrlqb/JbsCcg3zg5z1Mca5WWBDRGNW
         O5Mw==
X-Gm-Message-State: AC+VfDz0SXQ96vTjQHgh5uJk+We2LWoo871s8+oOduEurAqyU8kDo+bR
        aAlAhGe0PHYgYK4ZXajDSQ44FvecG9+k02hAZw==
X-Google-Smtp-Source: ACHHUZ7q6E1gWJ3kbY1dNGCYsjTabqZQbdrfT4r5LiLkPjIIR2hW6wwf+79ekz+zCEWvGvRp9xg+zuQatRldWVrX9Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:cecf:b0:1b1:86ad:332d with
 SMTP id d15-20020a170902cecf00b001b186ad332dmr1191476plg.12.1686094554168;
 Tue, 06 Jun 2023 16:35:54 -0700 (PDT)
Date:   Tue, 06 Jun 2023 23:35:52 +0000
In-Reply-To: <20230606224101.GB4150@monkey> (message from Mike Kravetz on Tue,
 6 Jun 2023 15:41:01 -0700)
Mime-Version: 1.0
Message-ID: <diqzilc0i2p3.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
From:   Ackerley Tng <ackerleytng@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, songmuchun@bytedance.com,
        vannapurve@google.com, erdemaktas@google.com,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 06/05/23 17:26, Ackerley Tng wrote:
>> Mike Kravetz <mike.kravetz@oracle.com> writes:

>> This doesn't seem to work as expected:

>> Here's a test I did

>>   ...

>> The above gave me: page_cache_next_miss(xa, 4, 3): 7

>> But I was expecting a return value of 6.

>> I investigated a little, and it seems like entry at index 6 if we start
>> iterating before 6 is 0xe, and xa_is_internal(entry) returns true.

>> Not yet familiar with the internals of xarrays, not sure what the fix
>> should be.

> I am NOT an expert with xarray.  However, the documentation says:

> "Calling xa_store_range() stores the same entry in a range
>   of indices.  If you do this, some of the other operations will behave
>   in a slightly odd way.  For example, marking the entry at one index
>   may result in the entry being marked at some, but not all of the other
>   indices.  Storing into one index may result in the entry retrieved by
>   some, but not all of the other indices changing."

> This may be why your test is not functioning as expected?  I modified
> your check_find_5() routine as follows (within lib/test_xarray.c):

> static noinline void check_find_5(struct xarray *xa, bool mult)
> {
> 	unsigned long max_scan;
> 	void *p = &max_scan;

> 	XA_BUG_ON(xa, !xa_empty(xa));

> 	if (mult) {
> 		xa_store(xa, 3, p, GFP_KERNEL);
> 		xa_store(xa, 4, p, GFP_KERNEL);
> 		xa_store(xa, 5, p, GFP_KERNEL);
> 	} else {
> 		xa_store_range(xa, 3, 5, p, GFP_KERNEL);
> 	}

> 	max_scan = 3;
> 	if (mult)
> 		printk("---> multiple stores\n");
> 	else
> 		printk("---> range store\n");

> 	printk("page_cache_next_miss(xa, %d, %ld): %ld\n", 4, max_scan,
> 		__page_cache_next_miss(xa, 4, max_scan));

> 	if (mult) {
> 		xa_store(xa, 3, NULL, GFP_KERNEL);
> 		xa_store(xa, 4, NULL, GFP_KERNEL);
> 		xa_store(xa, 5, NULL, GFP_KERNEL);
> 	} else {
> 		xa_store_range(xa, 3, 5, NULL, GFP_KERNEL);
> 	}

> 	xa_destroy(xa);
> }

> This results in:
> [  149.998676] ---> multiple stores
> [  149.999391] page_cache_next_miss(xa, 4, 3): 6
> [  150.003342] ---> range store
> [  150.007002] page_cache_next_miss(xa, 4, 3): 7

> I am fairly confident the page cache code will make individual xa_store
> calls as opposed to xa_store_range.

I tried this out with xa_store and a non-NULL pointer, and it works as
expected. Thanks!

I also checked that filemap/page_cache doesn't use xa_store_range(). It
only uses xas_store().

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
