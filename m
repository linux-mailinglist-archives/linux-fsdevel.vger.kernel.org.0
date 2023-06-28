Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7C741B32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF1VyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjF1VyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA92680
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6689430d803so29357b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687989228; x=1690581228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIcmhrIPSOZ6qM+xfce67/cuqMBkqZ/6v6aq7BqcIdk=;
        b=hPwUBdXRdEptp+GmJZgZ4Au6SMJhYcYOzijKg6H/sMUWyBal4JsEMoyf93ok1piKr5
         ubVBkRYe8lKSnvQfK6szDd0vKhIoMOEz++bA9Zr0D1/hVb8GIZ68riFiplzNpaLZH7bS
         j6OCSqpzOU7zG0DK51ranRdczixVriftyWoBczlTkiA6OziwoJgHeJ4NxDc+/Uwo78yp
         uSLz5OqNrWmOiKopaZWh7Dzo1P/E5z0mzzLjZANOgf9YB9j0RBGaCzmzyNyDczhhavvK
         nHbepUwuwxnVi3wC6vaoBxGgL8QHasgSLgxVQKWXVtgFlT8/9DxoR4IptehXnVNo693h
         Gicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989228; x=1690581228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIcmhrIPSOZ6qM+xfce67/cuqMBkqZ/6v6aq7BqcIdk=;
        b=ZBqIn/WRWDw+dU/SYzhXvGChIAERFv2g3iNIL5sf3f8oSSdEK1uihALbjTtUa8dpJe
         UBpQWxzalYAJlgv8skls0tEb+FWtZY4vYpaIgtom1U7ozUVCGy+9OrXtRIfmeTmL9QHG
         dlEOvzqe1M7DcZiblVu2kMEZW9PmQFRW+m4VC4XrRGCrrQ5+yawzuV672GGByB1fsFwI
         akUVWHKoGDlQXU0d8iUN0zM2hapOkaZaFyCv7ODQN7nJkSE7gk2KddDCNv8Nv4SltI4N
         B3cMVw0LhwCL9d9d3mwG0SmL8RPFIRH4CvVbKXwJEkdqfYVZ00D/PnSV53WzreqKCsub
         O73Q==
X-Gm-Message-State: AC+VfDzzLPfswZM8P1YlVAnneCRLZV9Bj1dR0UQmORiWMX+oc7jstG14
        EHptK/ynwBRtVGDe/2EucMMRNg==
X-Google-Smtp-Source: ACHHUZ7/846CFkEFwGXV2KLkI+em3anja+vG5GpO1hNT5a+Pj40cmSDjRcq/d55+DapJexxh7LBxSA==
X-Received: by 2002:a05:6a20:9143:b0:122:6fd2:7a2a with SMTP id x3-20020a056a20914300b001226fd27a2amr23996605pzc.55.1687989228248;
        Wed, 28 Jun 2023 14:53:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0065da94fe917sm7379093pfn.36.2023.06.28.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEd6f-00HNoi-02;
        Thu, 29 Jun 2023 07:53:45 +1000
Date:   Thu, 29 Jun 2023 07:53:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZJyr6GyVyvHxOpNB@dread.disaster.area>
References: <20230628185548.981888-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628185548.981888-1-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:55:48PM +0100, Matthew Wilcox (Oracle) wrote:
> nr_to_write is a count of pages, so we need to decrease it by the number
> of pages in the folio we just wrote, not by 1.  Most callers specify
> either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> might end up writing 512x as many pages as it asked for.
> 
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/page-writeback.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 1d17fb1ec863..d3f42009bb70 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2434,6 +2434,7 @@ int write_cache_pages(struct address_space *mapping,
>  
>  		for (i = 0; i < nr_folios; i++) {
>  			struct folio *folio = fbatch.folios[i];
> +			unsigned long nr;
>  
>  			done_index = folio->index;
>  
> @@ -2471,6 +2472,7 @@ int write_cache_pages(struct address_space *mapping,
>  
>  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  			error = writepage(folio, wbc, data);
> +			nr = folio_nr_pages(folio);

This should really be done before writepage() is called, right? By
the time the writepage() returns, the folio can be unlocked, the
entire write completed and the folio partially invalidated which may
try to split the folio...

Even if this can't happen (folio refcount is elevated, right?), it
makes much more sense to me to sample the size of the folio while it
is obviously locked and not going to change...

Other than that, change looks good.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
