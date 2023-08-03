Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFEC76F339
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHCTHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 15:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjHCTGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964363A90
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691089525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPDr3fHEuj+B4yeJMYhNPLAGlxXe+c7xVHr2n9vPefY=;
        b=VW7C+229dJ/5Z9ZvgL/ZirL8YGYjjAyH6QDdBJJohCWVLSET5kjuhkxSWjOuvOapSYxv0t
        TnSKlwRvsOmoYnVftqbt5p2xaKCrW3+XDjPDECdUowkWAKkpDBAT/Q2Fb9RkBcHPTtFq/V
        ptgMOcc71nUn+HoQ1saqreYtDb+HsuM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-KV5UQJJtM7uDTEwipBxnEw-1; Thu, 03 Aug 2023 15:05:24 -0400
X-MC-Unique: KV5UQJJtM7uDTEwipBxnEw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76cb292df12so32374385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 12:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089524; x=1691694324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPDr3fHEuj+B4yeJMYhNPLAGlxXe+c7xVHr2n9vPefY=;
        b=eZEYD8b6H3duR4haxiqOhz6UFOr+nBKlhHbNAk0i6/yhPr0JGskFqyqJ0a72fjcBNe
         t/dh9CtwWwAzRuhlKWVGnBpA1QLRU+ER3BV/w0f6TwPuspw/zrD3kLYxa9ukUPdEz7+3
         AsscZ9UuXdKHH+6cOWFjQgo8p75Q3Aoo5E8JNJkN8du1fubTQTCipbj5GlKAgSvotxWa
         n2IjgFrIp0ZvcWM3mN3ETqfE9+idOgAO0gZj9rPhW5GzCztdyAw5lqPx61Yui9IVGQRh
         k3Vq1mKeqBtP1cCHKhd6RWDlhB251sPlt9lsTevELOTlURWy8DpUQAJ9R35BLvUB787a
         9E7g==
X-Gm-Message-State: ABy/qLY8UZAL+/UqrJgqd7/FVNSia6oMF/Ioikx0y8ud9Tt1VLYDkUz8
        7TosF/n2UaNNpyMe14cZSxbGD4fn3S+icAg78grs2Rx8x+XG+Y68ccJP5EXb4kaYhf5j/svWoM7
        Uu9om5Otw0OoP0xsyIfE82q3vCw==
X-Received: by 2002:a05:622a:c1:b0:400:8036:6f05 with SMTP id p1-20020a05622a00c100b0040080366f05mr24001859qtw.2.1691089523796;
        Thu, 03 Aug 2023 12:05:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2ykL98pmKhK3SiQ2b6vrIhtlRShiCOrIVRmlDJBxu7aT77VMcWW+uQQCpCeqHjK8Bd8KhMA==
X-Received: by 2002:a05:622a:c1:b0:400:8036:6f05 with SMTP id p1-20020a05622a00c100b0040080366f05mr24001840qtw.2.1691089523525;
        Thu, 03 Aug 2023 12:05:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m25-20020aed27d9000000b0040fe0fdf555sm135924qtg.22.2023.08.03.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:05:23 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:05:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 6/7] selftest/mm: ksm_functional_tests: test in
 mmap_and_merge_range() if anything got merged
Message-ID: <ZMv6cZH2PdyeTmw1@x1n>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803143208.383663-7-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:32:07PM +0200, David Hildenbrand wrote:
> Let's extend mmap_and_merge_range() to test if anything in the current
> process was merged. range_maps_duplicates() is too unreliable for that
> use case, so instead look at KSM stats.
> 
> Trigger a complete unmerge first, to cleanup the stable tree and
> stabilize accounting of merged pages.
> 
> Note that we're using /proc/self/ksm_merging_pages instead of
> /proc/self/ksm_stat, because that one is available in more existing
> kernels.
> 
> If /proc/self/ksm_merging_pages can't be opened, we can't perform any
> checks and simply skip them.
> 
> We have to special-case the shared zeropage for now. But the only user
> -- test_unmerge_zero_pages() -- performs its own merge checks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
>  .../selftests/mm/ksm_functional_tests.c       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 0de9d33cd565..cb63b600cb4f 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -30,6 +30,7 @@
>  static int ksm_fd;
>  static int ksm_full_scans_fd;
>  static int proc_self_ksm_stat_fd;
> +static int proc_self_ksm_merging_pages_fd;
>  static int ksm_use_zero_pages_fd;
>  static int pagemap_fd;
>  static size_t pagesize;
> @@ -88,6 +89,22 @@ static long get_my_ksm_zero_pages(void)
>  	return my_ksm_zero_pages;
>  }
>  
> +static long get_my_merging_pages(void)
> +{
> +	char buf[10];
> +	ssize_t ret;
> +
> +	if (proc_self_ksm_merging_pages_fd < 0)
> +		return proc_self_ksm_merging_pages_fd;

Better do the fds check all in main(), e.g. not all callers below considers
negative values, so -1 can pass "if (get_my_merging_pages())" etc.

> +
> +	ret = pread(proc_self_ksm_merging_pages_fd, buf, sizeof(buf) - 1, 0);
> +	if (ret <= 0)
> +		return -errno;
> +	buf[ret] = 0;
> +
> +	return strtol(buf, NULL, 10);
> +}

-- 
Peter Xu

