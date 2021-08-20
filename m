Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C033F31C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhHTQy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhHTQyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:54:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274FC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 09:54:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so9743226pgk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/jv/65/o/pr3Arrh3DCsUW+kuq3VQXikqXf2iTWhR0=;
        b=wmKOKlHKACOKqcXgGfzOyuS+T8nTPa0UTHRKzXqyEB7n1oMhL9ybIy4re4kL145HF1
         bMtrau52pfw/I1Kc5cdxzuDtd0Et/jJkS5US+hv/mTQyQM7TcCklar0bSyyEBZaFQivs
         wSYZ7huQEIGoNty7O9v1HlhEnIt+psE5sGUDc9it5+LPZ7q/ulbelZHxwf3w1Cir636k
         IGP2ByU9d0ypCXvfCnbVJxTWgVNrKwxvWAw8s1imwihI5Uzzw1LN35likbg8w9wlGZNJ
         vEpJZYYjxE1je5/O/8C/dWmlALP8frPW0a+yHWctwSdYLH99P7ISs6wJ2ZSV9hwtj/V7
         R6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/jv/65/o/pr3Arrh3DCsUW+kuq3VQXikqXf2iTWhR0=;
        b=cmCEAN1wN6F9SrwZAf4Qww0XdDtz4GcNNDsXg8a79fpOvjR61/B984zl0vBnekOAri
         m/UAvRLWPdTOiA7qJrTqJxeZUwCRZPee6xd/n0Kaur2/6e9uMVuXWNyOCCsAA20eq/a6
         ew4NHsLFvBrcUYZpGF7ZXz7w7nGf/p7h3GE5igl86w6BHoSn9uFQhPf9kf74I5by0/la
         2tnfxtgrgZVKoZrFfFgxLMtTDyjlv5+UYpI2lkfr9GfYA4tBJhANIh5R5I9kiEPqmS+2
         VL/nQFyEP4SQx7dAHaBLXngnIQDQvazeAqJcTE53TNO5UVwgTw20whCBGSG/6UfAW+s8
         +TrQ==
X-Gm-Message-State: AOAM532cieqM5kVsiNsjyewqncadBLVO/FiJXZa/j/gImz5FPTPy5hwx
        g2DMjrVRyZLfRF2n3Nf/46QR2tcdbgboF9s/TLcY1A==
X-Google-Smtp-Source: ABdhPJxOaSnUuSDnQi5DeVTlIJ2tZRX4+NfWecFNtpOa2DU5Lh7Ot8DcjqxkMAwkp+e/mA/IvF4DoFjucZJd3KA/Wvo=
X-Received: by 2002:a65:6642:: with SMTP id z2mr7510515pgv.240.1629478457626;
 Fri, 20 Aug 2021 09:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-4-ruansy.fnst@fujitsu.com> <a5580cf5-9fcc-252d-5835-f199469516b0@oracle.com>
In-Reply-To: <a5580cf5-9fcc-252d-5835-f199469516b0@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 09:54:06 -0700
Message-ID: <CAPcyv4hQvR+KND8F1zGoX=jBJQ6bXhLtmEAPVb=O7rDwzHniiQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 3/9] mm: factor helpers for memory_failure_dev_pagemap
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 5, 2021 at 6:01 PM Jane Chu <jane.chu@oracle.com> wrote:
>
>
> On 7/30/2021 3:01 AM, Shiyang Ruan wrote:
> > -     /*
> > -      * Prevent the inode from being freed while we are interrogating
> > -      * the address_space, typically this would be handled by
> > -      * lock_page(), but dax pages do not use the page lock. This
> > -      * also prevents changes to the mapping of this pfn until
> > -      * poison signaling is complete.
> > -      */
> > -     cookie = dax_lock_page(page);
> > -     if (!cookie)
> > -             goto out;
> > -
> >       if (hwpoison_filter(page)) {
> >               rc = 0;
> > -             goto unlock;
> > +             goto out;
> >       }
>
> why isn't dax_lock_page() needed for hwpoison_filter() check?

Good catch. hwpoison_filter() is indeed consulting page->mapping->host
which needs to be synchronized against inode lifetime.
