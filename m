Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639EE1C2206
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 02:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEBAmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 20:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgEBAmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 20:42:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6CC061A0C;
        Fri,  1 May 2020 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wCroxG0qo4d90wbE2ZO3cJm2P6ZeLXZvihIg8REOcgs=; b=FFzOdU2u101Y4v8/bow0YrVHOq
        Yq2ZkgZ5WywkZPzpDw1cTKINrvLjkorYmOrrcKeOZkB0S7+ueftGEtP19MgpNU5Ih+5VAXg/CYbfE
        gnPyWIYBYsjLaeTODQMJ/GXXTCLdLBRmH0o2JhvTrSUhX6tWTpy0WfR30mJzDVy3npb3j5FSXMAmo
        3tERt9YP3Yi9VFa8MZde/Y9t7NoErTGSgWjW01+MZp8zzXyrtb7rHKi6iNRChzCaZwQJZbwRO02sN
        bgbo0ygKrxz7jmavzDTXd4mtAR/OucbITlBB9Hmo9GVpVxFFExZKYzLmPsvi+/zXFC0+fhSBHWeWg
        PGmGj6mA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUgEA-0002yp-JR; Sat, 02 May 2020 00:41:58 +0000
Date:   Fri, 1 May 2020 17:41:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
Subject: Re: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to
 cleanup code
Message-ID: <20200502004158.GD29705@bombadil.infradead.org>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200501221626.GC29705@bombadil.infradead.org>
 <889f9f82-64ba-50b3-147b-459303617aeb@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <889f9f82-64ba-50b3-147b-459303617aeb@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 02, 2020 at 12:42:15AM +0200, Guoqing Jiang wrote:
> On 5/2/20 12:16 AM, Matthew Wilcox wrote:
> > On Thu, Apr 30, 2020 at 11:44:41PM +0200, Guoqing Jiang wrote:
> > >    include/linux/pagemap.h: introduce attach/clear_page_private
> > >    md: remove __clear_page_buffers and use attach/clear_page_private
> > >    btrfs: use attach/clear_page_private
> > >    fs/buffer.c: use attach/clear_page_private
> > >    f2fs: use attach/clear_page_private
> > >    iomap: use attach/clear_page_private
> > >    ntfs: replace attach_page_buffers with attach_page_private
> > >    orangefs: use attach/clear_page_private
> > >    buffer_head.h: remove attach_page_buffers
> > I think mm/migrate.c could also use this:
> > 
> >          ClearPagePrivate(page);
> >          set_page_private(newpage, page_private(page));
> >          set_page_private(page, 0);
> >          put_page(page);
> >          get_page(newpage);
> > 
> 
> Thanks for checking!  Assume the below change is appropriate.
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7160c1556f79..f214adfb3fa4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct address_space
> *mapping,
>         if (rc != MIGRATEPAGE_SUCCESS)
>                 goto unlock_buffers;
> 
> -       ClearPagePrivate(page);
> -       set_page_private(newpage, page_private(page));
> -       set_page_private(page, 0);
> -       put_page(page);
> +       set_page_private(newpage, detach_page_private(page));
>         get_page(newpage);

I think you can do:

@@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
        if (rc != MIGRATEPAGE_SUCCESS)
                goto unlock_buffers;
 
-       ClearPagePrivate(page);
-       set_page_private(newpage, page_private(page));
-       set_page_private(page, 0);
-       put_page(page);
-       get_page(newpage);
+       attach_page_private(newpage, detach_page_private(page));
 
        bh = head;
        do {
@@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
 
        } while (bh != head);
 
-       SetPagePrivate(newpage);
-
        if (mode != MIGRATE_SYNC_NO_COPY)

... but maybe there's a subtlety to the ordering of the setup of the bh
and setting PagePrivate that means what you have there is a better patch.
Anybody know?
