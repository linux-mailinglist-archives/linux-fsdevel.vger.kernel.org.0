Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB884247D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJFUUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 16:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJFUUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633551531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndoPsgxw3pXa2WkzFUSKjNPOdhdtHbMEsZXh2h30JEc=;
        b=NPckKvoR1CHgo6deH3aBUg6HgcGywgu0mjDhueYLuXpwxY9PUKRPPzS5+FvI3+L8SccRwD
        pl2o6B692iKPuQkQokJdeH0HG8OODHjakNDGLaegNaY9iPlpn0L/xXTZIw4CBBrJ5X5TWL
        ZRy52nGZQEhxKJiUGGBTn+5lkRyGVZs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Vi9Y8e1zNOqFJc11PkzQbg-1; Wed, 06 Oct 2021 16:18:50 -0400
X-MC-Unique: Vi9Y8e1zNOqFJc11PkzQbg-1
Received: by mail-qv1-f71.google.com with SMTP id p9-20020a05621421e900b003830bb235fbso3620681qvj.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 13:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndoPsgxw3pXa2WkzFUSKjNPOdhdtHbMEsZXh2h30JEc=;
        b=iU+NMirl+LFPpa5zKitTjt2xKRsqcDvpKZIkm0PKh48Ce8wnR8FjYz6r8MjYwtAOW5
         w8l7QFNcXEK9lZYAgQxuvlO9vnYentVRBduwQaogzEBqBE4OVaDxQ0n+29YQ2yP6M4yd
         LaI5DLOqTSJr+yK2qKIJeRo9ZwnGj6hPVo7fsCLqimw8RYGjy0x3oLeElMzT3x/S3XBR
         6nL70rpQ0hYVNSKtphI95BuZ5A76ZQ2my4YCWhZhpAMlHyewhez7GGgUDDG+DlR+p+Lg
         A70A0vsb6ny0C1oUJC2zOWopmF+N1r1n2yrgYdSjZWeEitXRUtD2i1hhSEKcUzpRirZi
         Xjqg==
X-Gm-Message-State: AOAM530eF9UsZQG69D2bKnQ+7k2mr7FT+kSS99yNYAgT4j2L6rU/lUYn
        aM0OCzedJC4T0VVU64tacnL+WkKyzxi1iSf35YIvXF0aaDhHpRbx2ZanLl/841o9/+6rxXwrJ3w
        ODRwwrLsQMTqCNu6X0rS6dcRyeg==
X-Received: by 2002:ac8:40da:: with SMTP id f26mr279401qtm.114.1633551530172;
        Wed, 06 Oct 2021 13:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKZ1/nqV2JLDLruE0ZKjTUxqTpHKJD6s6mBT9Z4jMzAijU04nZ79wKZ6V6d9P6rkNvidggIQ==
X-Received: by 2002:ac8:40da:: with SMTP id f26mr279377qtm.114.1633551529986;
        Wed, 06 Oct 2021 13:18:49 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id q8sm13891462qtl.80.2021.10.06.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:18:49 -0700 (PDT)
Date:   Wed, 6 Oct 2021 16:18:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV4EqOpI580SKjnR@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> +#ifdef CONFIG_MEMORY_FAILURE
> +	/* Compound pages. Stored in first tail page's flags */
> +	PG_has_hwpoisoned = PG_mappedtodisk,
> +#endif

Sorry one more comment I missed: would PG_hwpoisoned_subpage better?  It's just
that "has_hwpoison" can be directly read as "this page has been hwpoisoned",
which sounds too close to PG_hwpoisoned.  No strong opinion either.  Thanks,

-- 
Peter Xu

