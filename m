Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7568F9C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjBHVcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBHVcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98ED1E5D7
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675891890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIAor+VDsPlrB9lj+l3LEuEZ+2Aj/cQ4916Fau1bI0Q=;
        b=S5BhtdrI7YTBx6ekFDT9lO7fZxBlHk2JjTYQ4Ud1wSy2BTQNfcBLrfqomoWwAm6i/7iDkc
        9DisyeRCBDwvpHWid3EubHeVRIV5wJp+zg2NyNSXlkChczWpxdTqmhnqdPTQlWonCIWJwl
        hjSI3i8OR9GC6FIT5SrSa6nz4MMputM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-mNnFWFJ2MYaiuwKrzQxmqw-1; Wed, 08 Feb 2023 16:31:26 -0500
X-MC-Unique: mNnFWFJ2MYaiuwKrzQxmqw-1
Received: by mail-qt1-f197.google.com with SMTP id bs11-20020ac86f0b000000b003b9b4ec27c4so11515213qtb.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 13:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIAor+VDsPlrB9lj+l3LEuEZ+2Aj/cQ4916Fau1bI0Q=;
        b=aNtf7ZA8ZgPZ6v67dqSCMwDcQRUx1xBhnX53jgPP0ZiZafPJIycryho4wY6w417DLF
         r15WqnThyETKZkeC5y06eFZY+2myMIFoeDzqYQAcoxQtJuGiysFVjqhZcH46CpMEv6B8
         QPpvEKHaHTDscbz5P7w03iQmxBlzBlZ4GdVWUv/MSQI7KalIZqpyY9uuAcygIaB6rmu8
         Tn2X+/4+TeXY+/uABtwUKRPCCth0/WjhdYwunCOfP0qp/QY+YlcqyhV1RRwJ3Eac4oOt
         hHOotWKZPr1TkIZCKnSD/Na+oEhsUrnqIhMQqxbVJhSigP5fi1ypF/c1dXOZKBtAncIa
         KGaA==
X-Gm-Message-State: AO0yUKUlogzEho/lA2NhXbqkFJRTqfwzC1s7t5rKz3v/5dFm6rI8XFbI
        6fsGjUs9c9m5dT54q18dHqQGT7usWCwOQXwSinlctFMjZWZH3RfOanLjYZDSHniKnRout1xyfsk
        gfyk+eqW6sA7qAADFcsDKqfg0kg==
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr17516037qtw.4.1675891886315;
        Wed, 08 Feb 2023 13:31:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8MO3G4fUAKevd35vZj2kMQxmHZodb+yUyDlQNuQyvW5/EA2P822ioKc+/00V2eqHk7x67X+w==
X-Received: by 2002:a05:622a:4b:b0:3b8:6d44:ca7e with SMTP id y11-20020a05622a004b00b003b86d44ca7emr17515958qtw.4.1675891885909;
        Wed, 08 Feb 2023 13:31:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f4-20020a05622a1a0400b003b9b48cdbe8sm12419115qtb.58.2023.02.08.13.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:31:24 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:31:22 -0500
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
Subject: Re: [PATCH v10 2/6] userfaultfd: update documentation to describe
 UFFD_FEATURE_WP_ASYNC
Message-ID: <Y+QUqrBCwQntpxFx@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202112915.867409-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:29:11PM +0500, Muhammad Usama Anjum wrote:
> Explain the difference created by UFFD_FEATURE_WP_ASYNC to the write
> protection (UFFDIO_WRITEPROTECT_MODE_WP) mode.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 83f31919ebb3..4747e7bd5b26 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -221,6 +221,13 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
>  you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
>  used.
>  
> +If ``UFFD_FEATURE_WP_ASYNC`` is set while calling ``UFFDIO_API`` ioctl, the
> +behaviour of ``UFFDIO_WRITEPROTECT_MODE_WP`` changes such that faults for

UFFDIO_WRITEPROTECT_MODE_WP is only a flag in UFFDIO_WRITEPROTECT, while
it's forbidden only when not specified.

> +anon and shmem are resolved automatically by the kernel instead of sending
> +the message to the userfaultfd. The hugetlb isn't supported. The ``pagemap``
> +file can be read to find which pages have ``PM_UFFD_WP`` flag set which
> +means they are write-protected.

Here's my version. Please feel free to do modifications on top.

  If the userfaultfd context (that has ``UFFDIO_REGISTER_MODE_WP``
  registered against) has ``UFFD_FEATURE_WP_ASYNC`` feature enabled, it
  will work in async write protection mode.  It can be seen as a more
  accurate version of soft-dirty tracking, meanwhile the results will not
  be easily affected by other operations like vma merging.

  Comparing to the generic mode, the async mode will not generate any
  userfaultfd message when the protected memory range is written.  Instead,
  the kernel will automatically resolve the page fault immediately by
  dropping the uffd-wp bit in the pgtables.  The user app can collect the
  "written/dirty" status by looking up the uffd-wp bit for the pages being
  interested in /proc/pagemap.

  The page will be under track of uffd-wp async mode until the page is
  explicitly write-protected by ``UFFDIO_WRITEPROTECT`` ioctl with the mode
  flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
  that was tracked by async mode userfaultfd-wp is invalid.

  Currently ``UFFD_FEATURE_WP_ASYNC`` only support anonymous and shmem.
  Hugetlb is not yet supported.

-- 
Peter Xu

