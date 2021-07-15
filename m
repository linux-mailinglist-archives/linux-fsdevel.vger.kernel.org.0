Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4233CAF14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhGOWXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGOWXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:23:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2BC06175F;
        Thu, 15 Jul 2021 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyOzjVd5xv9UTPCfq0G+15JQNVxKW8TyYTiG0nAPA8w=; b=FMQVRor86Nwv/OQ7Smz3KjErMl
        artn8SEfy3MRpb7yjC91QDQHpjYi5BXFE6mZr5wW/mWmDfxfdPY9iGTi0bi9jWEw/fX5ltVJLAZTB
        1GUWL/CiVhhYoOz20bQt7iDwZmjmT6xkF7tOVsqFvZGIoid77ypDOP8M3PUykMUzb2BVGqligwQK7
        RMUW+xOYgM3CFpXIzwwTHmG/ZddpdZRI7JwKTqqBCxogbZ1E610ljj3wHyvvUSj4H0wfrg3MCPBLk
        QYodRw4Oa8WnlbxqHFRhAsdlRXTXk2N3uwCAtkJt3q07Vtoe/sREFEPjfn6T57YY/raIh52a5Eg17
        CfDup3sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m49iL-003vpR-Tj; Thu, 15 Jul 2021 22:20:26 +0000
Date:   Thu, 15 Jul 2021 23:20:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 124/138] fs: Convert vfs_dedupe_file_range_compare to
 folios
Message-ID: <YPC0oYG/fsnPXcac@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-125-willy@infradead.org>
 <20210715220840.GS22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715220840.GS22357@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:08:40PM -0700, Darrick J. Wong wrote:
> On Thu, Jul 15, 2021 at 04:36:50AM +0100, Matthew Wilcox (Oracle) wrote:
> > We still only operate on a single page of data at a time due to using
> > kmap().  A more complex implementation would work on each page in a folio,
> > but it's not clear that such a complex implementation would be worthwhile.
> 
> Does this break up a compound folio into smaller pages?

No.  We just operate on each page in turn.  Splitting a folio is an
expensive and unrealiable thing to do, so we avoid it unless necessary.

> > +/* Unlock two folios, being careful not to unlock the same folio twice. */
> > +static void vfs_unlock_two_folios(struct folio *folio1, struct folio *folio2)
> >  {
> > -	unlock_page(page1);
> > -	if (page1 != page2)
> > -		unlock_page(page2);
> > +	folio_unlock(folio1);
> > +	if (folio1 != folio2)
> > +		folio_unlock(folio2);
> 
> This could result in a lot of folio lock cycling.  Do you think it's
> worth the effort to minimize this by keeping the folio locked if the
> next page is going to be from the same one?

I think that might well be a worthwhile optimisation.  I'd like to do
that as a separate patch, though (and maybe somebody other than me could
do it ;-)
