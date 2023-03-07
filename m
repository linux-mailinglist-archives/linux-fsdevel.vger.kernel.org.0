Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EB6AD3AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCGBEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGBET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6B3B664
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678151009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NI0AfExXKMh7a49g+DwlRMu0IoSbzcVjYg7rYfHlygc=;
        b=eNyiQfNpZBkAw3lmef1rBkLCWZvFFqDXH++h46Y6Q8NT+6cvCMlt0e6c5Y8FBNRnCvmxL4
        1sC5FexbSkZHdeiqRBrWz/y3iSrTkRm+MC/C5B5owvC9jlH3kWhOF/7QSpf7wOJFdu9Uvx
        th29px9MN11+gGvPCwf7CnfBTf1J+wE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-KK7vfwy5O-SP_WSjZaX3vw-1; Mon, 06 Mar 2023 20:03:28 -0500
X-MC-Unique: KK7vfwy5O-SP_WSjZaX3vw-1
Received: by mail-qv1-f72.google.com with SMTP id m1-20020a05621402a100b004bb706b3a27so6581614qvv.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 17:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI0AfExXKMh7a49g+DwlRMu0IoSbzcVjYg7rYfHlygc=;
        b=4Dnut5PiyOuRiOXGDfVJ7a5kPvLfWOGeMf1GVWxjG//2pEkoW2OhR9I+f8CHTifv75
         tUve3jVWlSmtlOUszHcNSYf0aiCTJju4SCNBES0vS3MVx1sHi1lpYFzJCXhHF8KJICUa
         g1YLBDo8MjR3Ma2LG8OQNq5hxhvBRevWXOdBEpD6QV4TC4A2KpnlmweirbNcjfwfJi7B
         8DCCcR/NLu4NooyAaYtYPHUL4p+5NzbOwy9bMBeXS4oMgLWXCgEEw2QmJG5NOisWmcdH
         FDOpfr/N+L2ZNtu4uofTMB7qvFhdhudw3A60kwLdqZ13eyM5RLiR+YUYyNDeMuXLr7jC
         IboA==
X-Gm-Message-State: AO0yUKXGPPNxaiPTqTo8M3AZ9OWvLo3EpNlQHrdNILRHs2YU7/h2vFsk
        qYBm48dmd/RqPRZsyO/UoJkned41F32glgSqi2xifuvQbC483BdqikN0HQDZo93DubpvoTTfMPF
        guBi37qdWK3xUK8Bm6N0ZKXS4LQ==
X-Received: by 2002:ac8:5fc3:0:b0:3bf:f7d0:9ba9 with SMTP id k3-20020ac85fc3000000b003bff7d09ba9mr23992936qta.5.1678151008059;
        Mon, 06 Mar 2023 17:03:28 -0800 (PST)
X-Google-Smtp-Source: AK7set99I84w/Sr8J0eBicwEQ2kHrVuPgeQl4yek18dUhhAijl5ItKvc0oafFq106NiKNmjfPX03mw==
X-Received: by 2002:ac8:5fc3:0:b0:3bf:f7d0:9ba9 with SMTP id k3-20020ac85fc3000000b003bff7d09ba9mr23992906qta.5.1678151007736;
        Mon, 06 Mar 2023 17:03:27 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t64-20020ae9df43000000b007430d280879sm8701313qkf.35.2023.03.06.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:03:27 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:03:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mm: userfaultfd: don't pass around both mm and vma
Message-ID: <ZAaNXTXs5ey4QYTl@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:21PM -0800, Axel Rasmussen wrote:
> Quite a few userfaultfd functions took both mm and vma pointers as
> arguments. Since the mm is trivially accessible via vma->vm_mm, there's
> no reason to pass both; it just needlessly extends the already long
> argument list.
> 
> Get rid of the mm pointer, where possible, to shorten the argument list.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

One nit below:

> @@ -6277,7 +6276,7 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
>  		folio_in_pagecache = true;
>  	}
>  
> -	ptl = huge_pte_lock(h, dst_mm, dst_pte);
> +	ptl = huge_pte_lock(h, dst_vma->vm_mm, dst_pte);
>  
>  	ret = -EIO;
>  	if (folio_test_hwpoison(folio))
> @@ -6319,9 +6318,9 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	if (wp_copy)
>  		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
>  
> -	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +	set_huge_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
>  
> -	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
> +	hugetlb_count_add(pages_per_huge_page(h), dst_vma->vm_mm);

When vm_mm referenced multiple times (say, >=3?), let's still cache it in a
temp var?

I'm not sure whether compiler is smart enough to already do that with a
reg, even if so it may slightly improve readability too, imho, by avoiding
the multiple but same indirection for the reader.

Thanks,

-- 
Peter Xu

