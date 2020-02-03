Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD2151224
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBCVzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:55:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34487 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:55:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so10832809lfc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJAkb73npUQtmUSyvboyg3nc2D2eMj/LRe7QTM0JtTw=;
        b=DW4g/6/MYnXF1LPe7/2RfS04IyD4h5v6Zw7F9g9HD0UoluTY5xl5rQH07HxoIfbmSL
         LbFPoisu/4Tf5fjpwS9AZkUc3Kpx3LfxRMz8B9pPJvkrCLA7ieUqNXTThuqVrogXnyXm
         YmQ06qGBkh/Fdsm2rVaRMS0Rnw0TP30W+hypvgpymsuhXKoHKFW7l3sqQWzs6Er7Z+aE
         hf88D1ebprJj+AYGaHcWnx0tNLJhNmcUm61BuHbDtb4G838UMGhHK90rGrVQ2upG1cZ/
         o/zhxtnTwPa6UXPgEeMmNrNB7tYI4gWFHfxIfqHrrdDCxj+zCFGgWe5xu355ukz9kbT4
         S7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJAkb73npUQtmUSyvboyg3nc2D2eMj/LRe7QTM0JtTw=;
        b=USwRNVYVkqyN3RR9kYFCO46RYQ9zMKL1+zJwsvNv6uLkPeAWPaUcvh5gaa67yOgaE1
         OOavSE0wabYGhOMGPW52p8Lebu89Y5R4jKA0Ff0QsN6tIEwjs7qBa1yCuGxV8ZtS/9qG
         iYobRICFpB52hjt+22CApbkMdjnhWkR2tdohtGXI4DKaIAZc7ZX26ySl94v6YiC+O/G/
         Zctux++/GkA7qwySp9aGWXB6UUMh09bLU008c578RR035p21iI/ph3Tacii3C1XrCY39
         K0NcpjMIFwUWSUQfC0X/1gYuhd3oDPYVqxrElM9XSdoQGwJLnkN6/w7re2qgwQu3mFxE
         wmMQ==
X-Gm-Message-State: APjAAAXgE/JkF0LvABBsy3Ei5NR1biYlEBpfocPXZOl9N+mEXCHaAN3Z
        unRKMYxSXIiEQLUjq0q9ZvVzXg==
X-Google-Smtp-Source: APXvYqzKhf8yy+VrDIH7P5bwPA/N4dISxyqqDNekLgToc6ApS5rJ2jA6asIx54ka9+WFODqsBDZ5WA==
X-Received: by 2002:a19:9159:: with SMTP id y25mr13507738lfj.63.1580766941406;
        Mon, 03 Feb 2020 13:55:41 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 144sm9700269lfi.67.2020.02.03.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:55:40 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86130100AF6; Tue,  4 Feb 2020 00:55:53 +0300 (+03)
Date:   Tue, 4 Feb 2020 00:55:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200203215553.q7zx6diprbby6ns5@box.shutemov.name>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-12-jhubbard@nvidia.com>
 <20200203135845.ymfbghs7rf67awex@box>
 <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:17:40PM -0800, John Hubbard wrote:
> On 2/3/20 5:58 AM, Kirill A. Shutemov wrote:
> ...
> >> @@ -19,6 +21,48 @@ struct gup_benchmark {
> >>  	__u64 expansion[10];	/* For future use */
> >>  };
> >>  
> >> +static void put_back_pages(unsigned int cmd, struct page **pages,
> >> +			   unsigned long nr_pages)
> >> +{
> >> +	int i;
> >> +
> >> +	switch (cmd) {
> >> +	case GUP_FAST_BENCHMARK:
> >> +	case GUP_LONGTERM_BENCHMARK:
> >> +	case GUP_BENCHMARK:
> >> +		for (i = 0; i < nr_pages; i++)
> > 
> > 'i' is 'int' and 'nr_pages' is 'unsigned long'.
> > There's space for trouble :P
> > 
> 
> Yes, I've changed it to "unsigned int", thanks.

I'm confused. If nr_pages is more than UINT_MAX, this is endless loop.
Hm?

-- 
 Kirill A. Shutemov
