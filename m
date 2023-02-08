Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8668F981
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjBHVNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBHVNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB3CC08
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWs5syWzL3AMT8pL8dG+0Q7bw+lD8ANchOAIxFLnI5k=;
        b=Z9CaJ/t6GqMHh6zhUhKAW5ceN8axLQAo021tW63r4tlAp7uHgU428jJ/7BSZzWXH9jrj0Q
        3KEwuIUzECrEBoAJPEYIaaHy8BHddpLAYCPnM8q32L/OHtIFklIogXpp0uXSC0nloPCNno
        9NOFdfPKVZQ7uRtPhK6+jCRvpPv9wrY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-7aik-s4rMYiH4t5hCYLHHg-1; Wed, 08 Feb 2023 16:12:16 -0500
X-MC-Unique: 7aik-s4rMYiH4t5hCYLHHg-1
Received: by mail-qv1-f72.google.com with SMTP id kd28-20020a056214401c00b0053cd4737a42so32397qvb.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWs5syWzL3AMT8pL8dG+0Q7bw+lD8ANchOAIxFLnI5k=;
        b=hrs85SI/YuCX2AQVx80IBupfp614PXqU62Cw3r/opmx1t4mBpGnzewhlefTqOae7D8
         zdI4k7HQ6M6VS8HFcsZbYn0+vi63amU4/ww+mtxxmX95iyMEboDyDgJChhIjl2AUlqxX
         506YJ3dXXmhpbCW55Fgf42t8P2jYW8e1k9TFjrLWQKz6cTM6LY8ZmT2fb+aLJ5Bhts/X
         DV0s4kjyFSmMTKOc/QQjhNXP+GeXg2KlvFxgojin+X7dAu4NJZr5m9vCwe0xxfhUYoFu
         K3aN8xQQs8WWB0CSt3wbssWNQojXd4WSwDbofbWIQrzzh+SGds57XgOJWXPUD/+rEqUO
         IVgg==
X-Gm-Message-State: AO0yUKV/jfgKzs3RPg75L7fuwfLKTXTohWXVuVHtq8KjFSJD6WB7vyO6
        iaCf0MI/S5AP3Cvt4xgpqX+X4meNSb+AKagYkpp9yoURlsTpaiTzzIWm7sS4Jo+gR4Z1mM/vkxN
        h56lGfzWiF7D7zKlkf9qK6s2qbQ==
X-Received: by 2002:a05:622a:4d2:b0:3b8:58d0:b4d4 with SMTP id q18-20020a05622a04d200b003b858d0b4d4mr17052263qtx.2.1675890735742;
        Wed, 08 Feb 2023 13:12:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/ztOWL/58E/IzCjCqlkCIGCW9TptwyHWWsTpgaTb3Ns2l76HkUmDIhP+fLnPBVXV0SefeqEw==
X-Received: by 2002:a05:622a:4d2:b0:3b8:58d0:b4d4 with SMTP id q18-20020a05622a04d200b003b858d0b4d4mr17052210qtx.2.1675890735410;
        Wed, 08 Feb 2023 13:12:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id r10-20020ac83b4a000000b003b9bcd88f7dsm12083178qtf.43.2023.02.08.13.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:14 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 1/6] userfaultfd: Add UFFD WP Async support
Message-ID: <Y+QQLNrhyiVwXI50@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:29:10PM +0500, Muhammad Usama Anjum wrote:
> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
> faults on its own. It can be used to track that which pages have been
> written-to from the time the pages were write-protected. It is very
> efficient way to track the changes as uffd is by nature pte/pmd based.
> 
> UFFD synchronous WP sends the page faults to the userspace where the
> pages which have been written-to can be tracked. But it is not efficient.
> This is why this asynchronous version is being added. After setting the
> WP Async, the pages which have been written to can be found in the pagemap
> file or information can be obtained from the PAGEMAP_IOCTL.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v10:
> - Build fix
> - Update comments and add error condition to return error from uffd
>   register if hugetlb pages are present when wp async flag is set
> 
> Changes in v9:
> - Correct the fault resolution with code contributed by Peter
> 
> Changes in v7:
> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
> - Handle automatic page fault resolution in better way (thanks to Peter)
> 
> update to wp async
> 
> uffd wp async
> ---
>  fs/userfaultfd.c                 | 20 ++++++++++++++++++--
>  include/linux/userfaultfd_k.h    | 11 +++++++++++
>  include/uapi/linux/userfaultfd.h | 10 +++++++++-
>  mm/memory.c                      | 23 ++++++++++++++++++++---
>  4 files changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 15a5bf765d43..422f2530c63e 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1422,10 +1422,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  			goto out_unlock;
>  
>  		/*
> -		 * Note vmas containing huge pages
> +		 * Note vmas containing huge pages. Hugetlb isn't supported
> +		 * with UFFD_FEATURE_WP_ASYNC.
>  		 */

Need to set "ret = -EINVAL;" here.  Or..

> -		if (is_vm_hugetlb_page(cur))
> +		if (is_vm_hugetlb_page(cur)) {
> +			if (ctx->features & UFFD_FEATURE_WP_ASYNC)
> +				goto out_unlock;

.. it'll return -EBUSY, which does not sound like the right errcode here.

> +

Drop this empty line?

>  			basic_ioctls = true;
> +		}
>  
>  		found = true;
>  	}

Other than that looks good, thanks.

-- 
Peter Xu

