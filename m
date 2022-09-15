Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1355B9574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIOHbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 03:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIOHay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:30:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2B92F7A;
        Thu, 15 Sep 2022 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ce5oxbNCfkPoGNRNpzYs1rUvcqZHHOUc5FToIXFyoE0=; b=XUZrwG7YMmGzRjyOKpDZDDlmP1
        4C7lb3eeg6UMvtXg3K268iHj4xzPfF9+V3v/ejtROgOqJpgEAof3YwHdGuA/be2awjk8bs6qxYqEd
        eGm9Mhy4Im90tgljsc1WPEWpJ6cvoMuhpuRlHcl1uTD/yVBPIx05Mi3dTlRck3YyDYeJif7IaFX/F
        kC7hHnf8YeVyfi4RL/h/CtQZOZTn8wUhj4ffyUJvDiqKunJQUHjj6AtLTdWifRQZee4/SGsf8zQGO
        Qkhoe29qDe7nmbQbqkOdDDaaTEDwLr0eCKYQo8sjDJ+7e4m9xPSlVcC6PzIhTQOjmSziq9oznzBDe
        yImqsgtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYjKP-000tIb-U2; Thu, 15 Sep 2022 07:30:29 +0000
Date:   Thu, 15 Sep 2022 08:30:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ke Sun <sunke@kylinos.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Make folio_put_wait_locked static
Message-ID: <YyLUlQbQi3O0ntwY@casper.infradead.org>
References: <20220914015836.3193197-1-sunke@kylinos.cn>
 <44af62e3-8f51-bf0a-509e-4a5fdbf62b29@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44af62e3-8f51-bf0a-509e-4a5fdbf62b29@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:45:33AM +0800, Ke Sun wrote:
> Ping.

Don't be rude.  I'm at a conference this week and on holiday next week.
This is hardly an urgent patch.

> On 2022/9/14 09:58, Ke Sun wrote:
> > It's only used in mm/filemap.c, since commit <ffa65753c431>
> > ("mm/migrate.c: rework migration_entry_wait() to not take a pageref").
> > 
> > Make it static.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Ke Sun <sunke@kylinos.cn>
> > ---
> > include/linux/pagemap.h | 1 -
> > mm/filemap.c | 2 +-
> > 2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 0178b2040ea3..82880993dd1a 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -1042,7 +1042,6 @@ static inline int
> > wait_on_page_locked_killable(struct page *page)
> > return folio_wait_locked_killable(page_folio(page));
> > }
> > -int folio_put_wait_locked(struct folio *folio, int state);
> > void wait_on_page_writeback(struct page *page);
> > void folio_wait_writeback(struct folio *folio);
> > int folio_wait_writeback_killable(struct folio *folio);
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 15800334147b..ade9b7bfe7fc 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
> > *
> > * Return: 0 if the folio was unlocked or -EINTR if interrupted by a
> > signal.
> > */
> > -int folio_put_wait_locked(struct folio *folio, int state)
> > +static int folio_put_wait_locked(struct folio *folio, int state)
> > {
> > return folio_wait_bit_common(folio, PG_locked, state, DROP);
> > }
