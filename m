Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A51747977
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGDVQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGDVQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291810D5
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688505354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8bJxR2hg9jZOo9xJJwily7Z9DBcJ34R5Ty+xrrHVZo=;
        b=cq1sTclzrKy5GRRZ6BowhtHGn2GJSmXuR003H402e6szEhHzB8GOxTfXWEu0/45G2ZgGwP
        bsc9eNiS2MsGn7aNaxIXHd6NUuqLaLJxnbmBGxdPCunMFqMirUAxiKA240UjBGZ9/VXb8q
        FLnsBhx48NpdZy2Ep9jhGpKszoPvr3E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-aJ5evl6EPhCEhlIAoDCCTA-1; Tue, 04 Jul 2023 17:15:53 -0400
X-MC-Unique: aJ5evl6EPhCEhlIAoDCCTA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so13536156d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 14:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688505352; x=1691097352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8bJxR2hg9jZOo9xJJwily7Z9DBcJ34R5Ty+xrrHVZo=;
        b=kpz1pb5CY7FslHmsjpXz8L3Nir40AXmjNyo6dbL16hFePykbYGZ2PMYbuwHwt1uqLZ
         nTS7VGUi8OkVN4i1v6tr2BJnOSJXe3Fl9Zm2sgynab7THtQp68TZQCaqojw2MQMW8Kvv
         S65pLvUZMD871d+INSZuJgEwB5aOyChKnbKS4uJ4R2S5wW6qUU/bst+ankdiaO89qIvR
         2VpVvaqWtEHCm18SwWRLuxy2SBUuy/j20xH+L4Nz8vg4XJsxyr7xQp9BSfuoDHB7Iw4s
         dFCi3Txg2yLar3kCkDz+lVHiw+p5tbmRCAT+ONKKsL4dGkpyhmZrga1ESiLetN80HNoT
         Aiew==
X-Gm-Message-State: ABy/qLbZpuuMYO5Vqt9D++leIa2KEPlovm947SwopaBC0MTL3MjRKnOZ
        RU75fioQ/oqJEAOv5YVA1+r3Sm30EJpq1CNQlr73kpSIGveaDVEITCfOvP0acFqncqqYOU8oB9f
        plii78mgHIrgBPqKSANsHrcgiHw==
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15299195qvb.4.1688505352756;
        Tue, 04 Jul 2023 14:15:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGplsPlE6k/Ac9I4olk/6Quorme09kXiBKYGVccc9DwPZ/ze9ZJey/GJMFKHSw2A+5sGFeDSQ==
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15299183qvb.4.1688505352469;
        Tue, 04 Jul 2023 14:15:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id px11-20020a056214050b00b006238f82cde4sm12696617qvb.108.2023.07.04.14.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 14:15:52 -0700 (PDT)
Date:   Tue, 4 Jul 2023 17:15:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/6] selftests/mm: add uffd unit test for UFFDIO_POISON
Message-ID: <ZKSMBnLkGXhlcwWs@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629205040.665834-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:50:39PM -0700, Axel Rasmussen wrote:
> The test is pretty basic, and exercises UFFDIO_POISON straightforwardly.
> We register a region with userfaultfd, in missing fault mode. For each
> fault, we either UFFDIO_COPY a zeroed page (odd pages) or UFFDIO_POISON
> (even pages). We do this mix to test "something like a real use case",
> where guest memory would be some mix of poisoned and non-poisoned pages.
> 
> We read each page in the region, and assert that the odd pages are
> zeroed as expected, and the even pages yield a SIGBUS as expected.
> 
> Why UFFDIO_COPY instead of UFFDIO_ZEROPAGE? Because hugetlb doesn't
> support UFFDIO_ZEROPAGE, and we don't want to have special case code.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

