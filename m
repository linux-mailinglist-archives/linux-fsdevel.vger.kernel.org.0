Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB55490C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiAQQKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiAQQKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:10:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06559C061574;
        Mon, 17 Jan 2022 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QgdfAvNkIxpa6lPCvlC647cLv8L2qmMu1/dpfaEB93w=; b=Fjhxxp7lxySoKYa9cyiWJG7FVs
        WaEuNqpzk19HPcYLCHkevL229dA7u9e+JX1T0WA85c9fOLhvhb2kOc4CFsq2QzryBBmyC0RVej8Lh
        FsA43/etrlHVf8yNdWTsNsjNXwTAFV4YVfbh+GhHXHkQllsCEzm3oRW2q+Cb/DvfB+EnVFJHQxOWv
        /XxwnN5zRXslv8kc/D/Y8De6gYle1MEvaiGwB5QcSqHKivV4ZHVnX0L/wDvnj6d5MsQxuAwyDEKNE
        Ydi56Oc216JZHOGO24A9uW+oym3fXQJp+/3rjd5Q+gpvEOb2NOUETI4W+XNLP0gSTs+FueAGoi1z/
        sCra3q6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Uak-008MgI-8c; Mon, 17 Jan 2022 16:10:46 +0000
Date:   Mon, 17 Jan 2022 16:10:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm/vmscan: Free non-shmem folios without splitting
 them
Message-ID: <YeWVBkgYMp4MctTW@casper.infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
 <20220116121822.1727633-5-willy@infradead.org>
 <20220117160625.oofpzl7tqm5udwaj@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117160625.oofpzl7tqm5udwaj@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:06:25PM +0300, Kirill A. Shutemov wrote:
> On Sun, Jan 16, 2022 at 12:18:14PM +0000, Matthew Wilcox (Oracle) wrote:
> > We have to allocate memory in order to split a file-backed folio, so
> > it's not a good idea to split them in the memory freeing path.
> 
> Could elaborate on why split a file-backed folio requires memory
> allocation?

In the commit message or explain it to you now?

We need to allocate xarray nodes to store all the newly-independent
pages.  With a folio that's more than 64 entries in size (current
implementation), we elide the lowest layer of the radix tree.  But
with any data structure that tracks folios, we'll need to create
space in it to track N folios instead of 1.

> > It also
> > doesn't work for XFS because pages have an extra reference count from
> > page_has_private() and split_huge_page() expects that reference to have
> > already been removed.
> 
> Need to adjust can_split_huge_page()?

no?

> > Unfortunately, we still have to split shmem THPs
> > because we can't handle swapping out an entire THP yet.
> 
> ... especially if the system doesn't have swap :P

Not sure what correction to the commit message you want here.
