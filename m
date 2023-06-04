Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D2721AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjFDWLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 18:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:11:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C853AB7;
        Sun,  4 Jun 2023 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eN655bXSpArXRBWxuMXlH+of+zA9r+Yq7PoaU0EV9C0=; b=cwrrT8FnD2qCajGgiuyjQZD8me
        qkF08blGIICVTGMK8RysRVaXNEpSlCmovQYafN6b3jFWttv+xaNHT3BHilXBRA9z0/whNJSsNHy+t
        IagdAHRrm6dzUUEMKaUx5R7380FFbDKl8a0lxeqt88McxsAmz3aom+Uy6Ax0NM8r6xO8+4JPF0GmY
        ehK9JK7JUWZvivPgL5r5PbRkpIHhSsd93/uKt2BriNCxzvuY8rifFowQnHKgoZggl6f+iqz4/awVl
        4BPhNPQavZT9CKNeVsq5LY0g5+Mkiz5W9fZR5g/XBKhlFDtOnk0617nuu+PQ8wQG3G4TlnaFXKLSr
        URI4fBfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5vwc-00BOlU-RE; Sun, 04 Jun 2023 22:11:26 +0000
Date:   Sun, 4 Jun 2023 23:11:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Message-ID: <ZH0MDtoTyUMQ7eok@casper.infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604182952.GH72241@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 04, 2023 at 11:29:52AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
> > -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> > +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> 
> I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
> actually know how to deal with a multipage folio?  AFAICT it takes a
> page, kmaps it, and copies @bytes starting at @offset in the page.  If
> a caller feeds it a multipage folio, does that all work correctly?  Or
> will the pagecache split multipage folios as needed to make it work
> right?

It's a smidgen inefficient, but it does work.  First, it calls
page_copy_sane() to check that offset & n fit within the compound page
(ie this all predates folios).

... Oh.  copy_page_from_iter() handles this correctly.
copy_page_from_iter_atomic() doesn't.  I'll have to fix this
first.  Looks like Al fixed copy_page_from_iter() in c03f05f183cd
and didn't fix copy_page_from_iter_atomic().

> If we create a 64k folio at pos 0 and then want to write a byte at pos
> 40k, does __filemap_get_folio break up the 64k folio so that the folio
> returned by iomap_get_folio starts at 40k?  Or can the iter code handle
> jumping ten pages into a 16-page folio and I just can't see it?

Well ... it handles it fine unless it's highmem.  p is kaddr + offset,
so if offset is 40k, it works correctly on !highmem.
