Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05E1C2982
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 05:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgECD0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 23:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgECD0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 23:26:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBDBC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2020 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gbrZNlMFQlYE/I3C2vGWmyxKRpefW8HzvpvAcGyZaSU=; b=Bh836s1kg+jTFBSzvRLZTQ2oH6
        yyzchzuXks7mETgI+TTRB0IMPqam+Yw1wniVNFQhlKHPtYRNt0HEJCEEJMyR+YkoPKfez3J5WjKvu
        d/6mf7CoEceyyZnY57s6Gi7FRU1ylIzBSNNJjP+juh+ruQO4Z58qcQtCwwiI1a+/ELOK8ugOf8FNa
        TBI1h7cHxJYJI8IIypiLcvgKTKcL7Z6MgFggvsyH0qkFV4b82pVDtQVZ9fpEBvgsRjxsjP2my+8sh
        gaFFLN56+s8DLQ5LLHwzhyAcVZVjfkOZ9Zf7UR/tH76KlwKblXHSclGB1HO+c8EM4LkndfJfUZEZc
        riH3kdWg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jV5Gf-0008Bm-Im; Sun, 03 May 2020 03:26:13 +0000
Date:   Sat, 2 May 2020 20:26:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: fuse: trying to steal weird page
Message-ID: <20200503032613.GE29705@bombadil.infradead.org>
References: <87a72qtaqk.fsf@vostro.rath.org>
 <877dxut8q7.fsf@vostro.rath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dxut8q7.fsf@vostro.rath.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 02, 2020 at 08:52:48PM +0100, Nikolaus Rath wrote:
> On May 02 2020, Nikolaus Rath <Nikolaus@rath.org> wrote:
> > I have recently noticed that a FUSE filesystem regularly produces many
> > kernel messages like this:
> >
> > [ 2333.009931] fuse: trying to steal weird page
> > [ 2333.009937] fuse: page=00000000dd1750e3 index=2022240 flags=17ffffc0000097, count=1,
> > mapcount=0, mapping=00000000125079ad
...
> > What are the implications of the above kernel message? Is there a way to
> > provide more debugging information?

It'd be helpful to use the common debugging infrastructure which prints
more useful information:

+++ b/fs/fuse/dev.c
@@ -772,8 +772,7 @@ static int fuse_check_page(struct page *page)
               1 << PG_lru |
               1 << PG_active |
               1 << PG_reclaim))) {
-               pr_warn("trying to steal weird page\n");
-               pr_warn("  page=%p index=%li flags=%08lx, count=%i, mapcount=%i, mapping=%p\n", page, page->index, page->flags, page_count(page), page_mapcount(page), page->mapping);
+               dump_page(page, "fuse: trying to steal weird page");
                return 1;
        }
        return 0;

(whitespace damaged; if you can't make the equivalent change, let me
know and I'll send you a real patch)
