Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7EE44BBED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhKJHGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 02:06:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhKJHGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636527797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0cadZK7XFbebH7WBSpOeCcH2GLCqGBVv5pJTjTqScgI=;
        b=Gknv3T6XW7L7pDWEGejF2xlKd3QYCJedFlFNSlu8BPzbEo0HfDajMoZWxtrhYuvoagCFMu
        c1M7biFfKTH+Pe2u5u8PADf14wlX1aelJ398+ol8LEgVPrYBBmu8I+byK9nqzD2L9ET4ZL
        K5eKhy/50Z9w89DrpUajerjIUpatnRw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-aM7uZcqBPgqLwUKAZqn8Tw-1; Wed, 10 Nov 2021 02:03:14 -0500
X-MC-Unique: aM7uZcqBPgqLwUKAZqn8Tw-1
Received: by mail-pj1-f70.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so556701pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 23:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cadZK7XFbebH7WBSpOeCcH2GLCqGBVv5pJTjTqScgI=;
        b=zL/g7musXSDC9dJRzdkgohMEGZQ0Rkd2SQxR/vKlhLzAb8GI6sgCwCTPjPDLZHmzgD
         lbxOBLO7fr1b+b9adXAyCcuKxZBjr8eTIIXBlme8RwWw5wqkPl84cTqEN3Pof86XrA8+
         iZRzeFVrGBEu0Az63x5RmfQNS5I4CMTDJbLnqA8jZDJNSgB7XZYwpkGJfHBbj6koOvQ2
         wt936GjyCWVdHdbf3xoxf+DAF0JBZxihWZk2KQKxPuiqVpuLOZTxMropfz8SKTd8uRpZ
         xBoCd2Z9V3C+JKFZqiwWn6aOvEbtFL07n2HEiMh7sCITXwGTPSJQHfzrzsd32y584Njv
         gPqQ==
X-Gm-Message-State: AOAM530CCOoym9jFWX2g3kgUuuT8m2uV2D6TQylbkzlBMYkzwtg2MOQp
        PR5Hs4lDwkbYUfu1ZlowqWAz7MN59mLXhcjDu4r4vvSrXZ8htSEXjwFbhd4Fl40oh3fnaqVCZ79
        XGfjU1EI6mgkBkswK9RLkpbCoIw==
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr13204496plg.89.1636527793169;
        Tue, 09 Nov 2021 23:03:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwADuN2McaK3Hz7vOj8bQd5Tyj05xsqo8F8qbby7T4wFIAY2nEuPkvVgYieWrNTWlsrTqt6ig==
X-Received: by 2002:a17:902:d50d:b0:141:ea03:5193 with SMTP id b13-20020a170902d50d00b00141ea035193mr13204473plg.89.1636527792955;
        Tue, 09 Nov 2021 23:03:12 -0800 (PST)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e15sm1645364pfv.131.2021.11.09.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 23:03:12 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:03:06 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YYtuqsnOSxA44AUX@t490s>
References: <20211107235754.1395488-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107235754.1395488-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Mina,

Sorry to comment late.

On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index fdc19fbc10839..8a0f0064ff336 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -23,7 +23,8 @@ There are four components to pagemap:
>      * Bit  56    page exclusively mapped (since 4.2)
>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> -    * Bits 57-60 zero
> +    * Bit  58    page is a huge (PMD size) THP mapping
> +    * Bits 59-60 zero
>      * Bit  61    page is file-page or shared-anon (since 3.5)
>      * Bit  62    page swapped
>      * Bit  63    page present
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ad667dbc96f5c..6f1403f83b310 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1302,6 +1302,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>  #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)

The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
"PM_HUGE" (as THP also means HUGE already)?

IMHO the core problem is about permission controls, and it seems to me we're
actually trying to workaround it by duplicating some information we have.. so
it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
if it's the permission part that to be enhanced, rather than a new but slightly
duplicated interface.

Thanks,

-- 
Peter Xu

