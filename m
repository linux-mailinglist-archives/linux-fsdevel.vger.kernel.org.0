Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB0B433D97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhJSRjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSRjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:39:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8C8C06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:37:12 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id z15so440138qvj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DDNcSaWi4PeJUv65MFP/RIGeIRJgEuWKda7nGMDceGo=;
        b=k6DqTzZMVb56PMbP6dhTEzv807yXtBKtSHK9voYdsh/iNyU+p6graFaSzdYI7M8qrV
         vUb9prw7dddQ+FJS/PWGSXmQTWNP//pI6Gn+F+s118xKRmSgT8TWSJCyww49K6/6rh4k
         4H8KeeCy0d/vl4WDKueyBIQyF8CbffACXmR2txHvBuhM9nhOhxnN2pB1XnsGUvZJqRWy
         Wq30s1RgF9g77GoilJOAZOZiok4vS+qmQ/Hl0nat1UfB46ddipvi2uhtRXKsJc4YCySL
         x0bYYzoWIYjQyCinEf5MI7/ujz6SBRWlt2yEujel/8jKqtlcszL1XUxIPh/OZUndZaTh
         SrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DDNcSaWi4PeJUv65MFP/RIGeIRJgEuWKda7nGMDceGo=;
        b=jUBD4XswiQ6PESPNYJglVU4joFGqdYAjZVhxq/66/EftBnvqmHY14wwWU/Ha+ifHjK
         CVU5BsZ1H1iB9eOxDqhk2t1EUWeRXdaYtK6Q+kNvujNM9/lFB6uHMsVD7sQ37XXSp8d+
         Pz+hIq1869n5CgTWQIzY14Dp6FKRu6rdSGz/9scj6rB8fQUGwNgsJAB0AyHCmFlbZd0f
         kmXlI/ZXTUtsmVoOKhpLUFlKzHfgBf35TcqxzW5WqEsm/nbXq9d+D+RcuqL8+sXBco/R
         qfM4V4rcWwbRLPfr/h6xe58gr1ikcK7ByuidXqBoztjnIbzxoBtcsSMLqrqNiGLwPnkd
         j2xg==
X-Gm-Message-State: AOAM533LpnELfhHs34kM01G7jUGKXLD5oSVipl/bWVMr3+OzrBm1DP87
        yEGAwMaRCi2FRH4r6jkjX0YKeg==
X-Google-Smtp-Source: ABdhPJyqJwDw6epqpXpG73lSY7+KwBLvn+msGtZ7q+PCo3+V0I8r/sjIIYZ4fJS6nEEZ+4BY3ExJQg==
X-Received: by 2002:a0c:ffa9:: with SMTP id d9mr1231035qvv.53.1634665031269;
        Tue, 19 Oct 2021 10:37:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t26sm7975721qkg.40.2021.10.19.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:37:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mct30-00GtVo-A1; Tue, 19 Oct 2021 14:37:10 -0300
Date:   Tue, 19 Oct 2021 14:37:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Splitting struct page into multiple types - Was: re: Folio
 discussion recap -
Message-ID: <20211019173710.GI3686969@ziepe.ca>
References: <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
 <YW7uN2p8CihCDsln@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7uN2p8CihCDsln@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:11:35PM -0400, Kent Overstreet wrote:

> I have no idea if this approach works for network pool pages or how those would
> be used, I haven't gotten that far - if someone can chime in about those that

Generally the driver goal is to create a shared memory buffer between
kernel and user space.

The broadly two common patterns are to have userspace call mmap() and
the kernel side returns the kernel pages from there - getting them
from some kernel allocator.

Or, userspace allocates the buffer and the kernel driver does
pin_user_pages() to import them to its address space.

I think it is quite feasible to provide some simple library API to
manage the shared buffer through mmap approach, and if that library
wants to allocate inodes, folios and what not it should be possible.

It would help this idea to see Christoph's cleanup series go forward:

https://lore.kernel.org/all/20200508153634.249933-1-hch@lst.de/

As it makes it alot easier for drivers to get inodes in the first
place.

> would be great. But, the end goal I'm envisioning is a world where _only_ bog
> standard file & anonymous pages are mapped to userspace - then _mapcount can be
> deleted from struct page and only needs to live in struct folio.

There is a lot of work in the past years on ZONE_DEVICE pages into
userspace. Today FSDAX is kind of a mashup of a file and device page,
but other stuff is less obvious, especially DEVICE_COHERENT.

Jason
