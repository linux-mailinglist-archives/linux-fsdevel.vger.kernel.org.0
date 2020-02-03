Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478891507CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 14:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgBCNxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 08:53:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41569 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgBCNxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:53:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so9734603lfp.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BzZMF6PZ0CInPvS+JZXdg2mkWs0iWkEH6sfExWwcsOM=;
        b=SfWu8ptXcrqdLvVIL+9GNYbYTZM0c3Z4oRhn+03/fTLd35Qc+pNcEyJxhwF7lafzH0
         d4srVxbs7KN6s0DICeR+xID9QEiL5Ej66kNXiGFzrPIy+dgRsWNigr9yFPOqIyzZR8Yb
         ezgjxg7hzzAmGX6kvhZCjj1aEVb4gOrxjTbd3o1JoGMpP1dhE/N79lBbK3054K5SB+fF
         sutl1znM5FUFndqKtQ2KHkt653qpODXWXb5b8k4kzpzBzqKQnCE7UTp+MxesWWLH9esw
         gf66cdzuHedRhs58dFM9lmhZn7vMWU0idxfbqcAx5q1dYQlC2UcJeninpwCmf5bqLBhQ
         tQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BzZMF6PZ0CInPvS+JZXdg2mkWs0iWkEH6sfExWwcsOM=;
        b=ltaUdmt78lko697odQGM31Qmi15m302d6ekCz3re/VfZiNhyPXHICBfIdyN6nWPnEr
         LO3OC9cmGGQkzpa7G8G6EqdufMBjQm3BZU18s/+SsR34/nfLZ1mTVk4/By57kCSaqEki
         Q06FpCQa20foDS3OqXLvEHVKGCM1rqv4HIsJIwm24tUr7TK/UqOfbBWn9lEf1WM4Tlat
         B36st18SQxweFQ2EEC68b9cSgUgtwXeCzenVXae4wQbShsfc0/p+XRkumaqm8ii0fy06
         K8feTJe9HVEhfzmObcatBv/QXTwnn6HXoBcvq3jmnEhY+xlx/4dpHUzbqe3EjnWejS3a
         QEgA==
X-Gm-Message-State: APjAAAVZ8hqaKSCTs3ZWVgCfZzaE+Yor7/wKwR0X+UHIJ16LTXJoI8Qc
        v669g8OCqHlN50xOzIi5ejKjMg==
X-Google-Smtp-Source: APXvYqysggXpYEJxCI/09xpMW4ELlsRRYlF7cYLpGOA4E8c4YYLRqJg9/VEkldqlzmdwIjBILEU4cQ==
X-Received: by 2002:ac2:4246:: with SMTP id m6mr12217244lfl.165.1580737988577;
        Mon, 03 Feb 2020 05:53:08 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a12sm9743048ljk.48.2020.02.03.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:53:07 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AD6E1100DC8; Mon,  3 Feb 2020 16:53:20 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:53:20 +0300
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
Subject: Re: [PATCH v3 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200203135320.edujsfjwt5nvtiit@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-11-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:27PM -0800, John Hubbard wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index c10d0d051c5b..9fe61d15fc0e 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -29,6 +29,19 @@ struct follow_page_context {
>  	unsigned int page_mask;
>  };
>  
> +#ifdef CONFIG_DEBUG_VM

Why under CONFIG_DEBUG_VM? There's nothing about this in the cover letter.

> +static inline void __update_proc_vmstat(struct page *page,
> +					enum node_stat_item item, int count)
> +{
> +	mod_node_page_state(page_pgdat(page), item, count);
> +}
> +#else
> +static inline void __update_proc_vmstat(struct page *page,
> +					enum node_stat_item item, int count)
> +{
> +}
> +#endif
> +
>  static void hpage_pincount_add(struct page *page, int refs)
>  {
>  	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
-- 
 Kirill A. Shutemov
