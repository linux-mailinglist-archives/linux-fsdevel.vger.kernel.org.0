Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4502F672268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjARQEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 11:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjARQDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:03:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDC13D50;
        Wed, 18 Jan 2023 08:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GSOq94AXmVvB2t/Hu5/HVPL9U2Xr3S2Gs4mgbP3Jze4=; b=H4jFoXQ9JNPPdfRtFstnPmrvPm
        uWOrVD7S7r2C0I7UGlhUvnbnsIczzMh9ht9Oh0scSjoKcjMxXkXI6boL8jWnYcX5zmHYFU70+t16b
        dN7B/gIGvyDbv0wwI2uVzsQ7PKSchDHzdh9lT9KlZJC7fZHeDWn1sEm8LHv7KH0wT4jLZ+vMGxy+V
        H2yYWTjNseX7HXyuJ+iNn6aQyEJudOmctSm+1V2Rja3yR7l2qa3gu8ehNTyGzdEfq4GAEGDydDvmd
        ShS6JHhXe1t92VTzt3aWfQPXYFs/nr0AgLwyTPmVoSrjd/4HITqMfh19kKAiG5w2cMYxZDRIIVlni
        FN18xZOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIArZ-0007eO-4K; Wed, 18 Jan 2023 16:00:33 +0000
Date:   Wed, 18 Jan 2023 16:00:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 7/9] gfs2: handle a NULL folio in gfs2_jhead_process_page
Message-ID: <Y8gXodKIUneO+XQb@casper.infradead.org>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094329.9553-8-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:27AM +0100, Christoph Hellwig wrote:
> filemap_get_folio can return NULL, so exit early for that case.

I'm not sure it can return NULL in this specific case.  As I understand
this code, we're scanning the journal looking for the log head.  We've
just submitted the bio to read this page.  I suppose memory pressure
could theoretically push the page out, but if it does, we're doing the
wrong thing by just returning here; we need to retry reading the page.

Assuming we're not willing to do the work to add that case, I think I'd
rather see the crash in folio_wait_locked() than get data corruption
from failing to find the head of the log.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/lops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 1902413d5d123e..51d4b610127cdb 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -472,6 +472,8 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
>  	struct folio *folio;
>  
>  	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
> +	if (!folio)
> +		return;
>  
>  	folio_wait_locked(folio);
>  	if (folio_test_error(folio))
> -- 
> 2.39.0
> 
