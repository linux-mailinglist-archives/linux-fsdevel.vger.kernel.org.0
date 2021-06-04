Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE739AF57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDBJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:09:16 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:41506 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFDBJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:09:15 -0400
Received: by mail-ej1-f43.google.com with SMTP id ho18so968930ejc.8;
        Thu, 03 Jun 2021 18:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=un5fUz8IxWJJnYpdIXhHBw4mM8q8tHdga8I9S0ipQL8=;
        b=E3f/hAVzrG9FD5BpY4KQ1SaFu74wRY5rovX5mgc8Cpiun+FwAmkihTrMWdCbugsx3h
         sZzpC8ZyB4BsDXF4NEy/ypPXe1HrnzixUQAHIlQ/NF27PZ06sn5ETRdZ5ythffjotqkN
         KRrXYU3MoNtBbfcX2sCAxtytCRPILE5B2SMOVJipg+sOZ0bTYWLy38u1pE8pCA8l/Afu
         tIh3sFDReAMPdWRKbvTFC9Gw4Z5L527SrLHIJVANKiAGBZ/Eegrfe8FCNqlGgiwu5quj
         I7ZTDMjVBwi73sD6j9D0XpA7MpbeitZ7dRTd62Giw+NE2AXEte047iP5sQKLIvR2yj8b
         qU5w==
X-Gm-Message-State: AOAM531z18U8fV0u2EfFQpsv3GbItV0rsS8rDciH4sLe4MlS+4l9fBe9
        kEbp120nQXwj23gCQyS4B3bPMmvnDXo0Hw==
X-Google-Smtp-Source: ABdhPJyNboBrhnP6+iXknOKJT4T3Wt2/pjB9F0EslZMIu2yefv5lph6V+/K0lOvBWxqfyFb4AJ1F6A==
X-Received: by 2002:a17:906:388b:: with SMTP id q11mr1796769ejd.43.1622768838417;
        Thu, 03 Jun 2021 18:07:18 -0700 (PDT)
Received: from localhost (net-37-119-128-179.cust.vodafonedsl.it. [37.119.128.179])
        by smtp.gmail.com with ESMTPSA id o64sm2501652eda.83.2021.06.03.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:07:17 -0700 (PDT)
Date:   Fri, 4 Jun 2021 03:07:12 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/33] Memory folios
Message-ID: <20210604030712.11b31259@linux.microsoft.com>
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 May 2021 22:47:02 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> We also waste a lot of instructions ensuring that we're not looking at
> a tail page.  Almost every call to PageFoo() contains one or more
> hidden calls to compound_head().  This also happens for get_page(),
> put_page() and many more functions.  There does not appear to be a
> way to tell gcc that it can cache the result of compound_head(), nor
> is there a way to tell it that compound_head() is idempotent.
> 

Maybe it's not effective in all situations but the following hint to
the compiler seems to have an effect, at least according to bloat-o-meter:


--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -179,7 +179,7 @@ enum pageflags {
 
 struct page;   /* forward declaration */
 
-static inline struct page *compound_head(struct page *page)
+static inline __attribute_const__ struct page *compound_head(struct page *page)
 {
        unsigned long head = READ_ONCE(page->compound_head);
 

$ scripts/bloat-o-meter vmlinux.o.orig vmlinux.o
add/remove: 3/13 grow/shrink: 65/689 up/down: 21080/-198089 (-177009)
Function                                     old     new   delta
ntfs_mft_record_alloc                      14414   16627   +2213
migrate_pages                               8891   10819   +1928
ext2_get_page.isra                          1029    2343   +1314
kfence_init                                  180    1331   +1151
page_remove_rmap                             754    1893   +1139
f2fs_fsync_node_pages                       4378    5406   +1028
deferred_split_huge_page                    1279    2286   +1007
relock_page_lruvec_irqsave                     -     975    +975
f2fs_file_write_iter                        3508    4408    +900
__pagevec_lru_add                            704    1311    +607
[...]
pagevec_move_tail_fn                        5333    3215   -2118
__activate_page                             6183    4021   -2162
__unmap_and_move                            2190       -   -2190
__page_cache_release                        4738    2547   -2191
migrate_page_states                         7088    4842   -2246
lru_deactivate_fn                           5925    3652   -2273
move_pages_to_lru                           7259    4980   -2279
check_move_unevictable_pages                7131    4594   -2537
release_pages                               6940    4386   -2554
lru_lazyfree_fn                             6798    4198   -2600
ntfs_mft_record_format                      2940       -   -2940
lru_deactivate_file_fn                      9220    5631   -3589
shrink_page_list                           20653   15749   -4904
page_memcg                                  5149     193   -4956
Total: Before=388863526, After=388686517, chg -0.05%

I don't know if it breaks something though, nor if it gives some real
improvement.

-- 
per aspera ad upstream
