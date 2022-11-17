Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA862D00F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiKQAq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 19:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKQAqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:46:24 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F88C6B236
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 16:45:24 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k2so227653qkk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEOs2OljVpzFekHebtNmxJNTS1biZDzbDC+7E+gbGXE=;
        b=NKUDG6/HRBHYArrki2ErKlKAFAloDP3syGXEvUqNJ9D2fVrZim0dI4zYfgnJWEKy+2
         eIgPOs+mttvXhYUIJL/UppN4gHtQqcQpWlrONSgHhATtfRfLqa70r2Y5AFUtDhoXumLz
         QwAO0SpqErl+SpXb2isD+wqK260zhrI3m0OcjGKZmRIuadG54e+ieDR5HURAecTq4gww
         +4XuPNBvBD2G5dec/bz8Eh9V9EDh1RbiHGn8GIrcO4V8END9r1k5y0xfRAbT/lxmG9Cm
         d4SXiY9+ZupOQT/Gb+ZePnA6lwtOPkxvxI9tRVsC2WHBPZX7s+xnX8nZsTymxhqmYSZB
         7vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEOs2OljVpzFekHebtNmxJNTS1biZDzbDC+7E+gbGXE=;
        b=ZQ6G/T3ehYQgS5091GVKek+Jw6tqHxWjDeHzAu0GRvRCrDWzdJPh67y6rn/QPHw/p6
         ya13zFebm2JX+M7DL3Izt0/rjraVOCsEFdlcK24j6Fwi4F8IgKk2KpPwG+SQpS1fQJ2/
         d9vjTAECUYoNaPxGoTz/l6guF3rufw3clKUXDl41/XHxXOqmRK4r+iVYFC/KUyEnPG/b
         +q3WBAhu8qgJJELf4ZXtnT+Aes54gU6nubhaQTbN1YnXfuBYJ11CsUYn6HnvYYOeHsO/
         xVn8qnw+V9P49vZ19NoclBhDjmfYjEJq5TBgYoTgj32qjAuJDg6cyX6m//3m+pTDBGPl
         W/vQ==
X-Gm-Message-State: ANoB5pkwg+8adU9fuFJpkJgyHLh9NLCkNXD+lP63DeAyGYXUdfcuNM4K
        YNrZvkFNuHmpqie1EthAEhJCiw==
X-Google-Smtp-Source: AA0mqf7xjJLeTnaPhhrans4JhE0iVba1LlwPzkyl9vYE07B6pyjsI7ODbIFQEN1WHHyVUFKfNxMUWg==
X-Received: by 2002:a05:620a:1455:b0:6ee:80b5:32d3 with SMTP id i21-20020a05620a145500b006ee80b532d3mr22079595qkl.237.1668645923644;
        Wed, 16 Nov 2022 16:45:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id n7-20020ac86747000000b00399ad646794sm9480378qtp.41.2022.11.16.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:45:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ovT1t-0066TN-E8;
        Wed, 16 Nov 2022 20:45:21 -0400
Date:   Wed, 16 Nov 2022 20:45:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mm-unstable v1 10/20] RDMA/umem: remove FOLL_FORCE usage
Message-ID: <Y3WEIVROhUPTtaeQ@ziepe.ca>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-11-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:49AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Tested-by: Leon Romanovsky <leonro@nvidia.com> # Over mlx4 and mlx5.
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/infiniband/core/umem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
