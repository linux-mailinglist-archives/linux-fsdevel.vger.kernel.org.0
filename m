Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674C3D25D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 16:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhGVNx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhGVNxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:53:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56890C061575;
        Thu, 22 Jul 2021 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JoQvWSbt6SW54dfwq8nTFQWZq5OjwOKf2hg/K4WfrbE=; b=mztzqYmyrfFAEWbV2CbDFhUOXR
        cEzYUywmqyUMsCLXrc3bVj/8TenC/M8GeZ2GWlBhTFz9//PSBU/ElGsjV+jUg01gN2yDEr4AEo0c1
        vrrzr2xcPj+XxkeWUNhtzv/sxAAH32AFvB7FiZDw5f+5vQH+6S+p6I0cok1ml0jR++fQ0/y+43cSV
        J0EDbj69m7yMV+m1ZZKVVDpXzWTno8KflCrL9L463/L4H5WcX+ttBDw3C93SsIYMySQCRY0p7VP9T
        30N32vApe7OorUFlCpdazvACkB1JNiB5yzr5X3gq/Ca4wVzZniayL2xSXeHdLxb/FS0pSxrcMJlXf
        F7zkIJ6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6ZmF-00ALhz-KV; Thu, 22 Jul 2021 14:34:23 +0000
Date:   Thu, 22 Jul 2021 15:34:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
Message-ID: <YPmB60EwQPpEvdb/@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
 <a670e7c1-95fb-324f-055f-74dd4c81c0d0@gmail.com>
 <YPlko1ObxD/CEz8o@casper.infradead.org>
 <fd3fe780-1a1b-1ba7-1725-72286470ce4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3fe780-1a1b-1ba7-1725-72286470ce4c@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 04:45:59PM +0300, Dmitry Osipenko wrote:
> 22.07.2021 15:29, Matthew Wilcox пишет:
> > On Thu, Jul 22, 2021 at 02:52:28PM +0300, Dmitry Osipenko wrote:
> ...
> > The obvious solution is just to change folio_copy():
> > 
> >  {
> > -       unsigned i, nr = folio_nr_pages(src);
> > +       unsigned i = 0;
> > +       unsigned nr = folio_nr_pages(src);
> > 
> > -       for (i = 0; i < nr; i++) {
> > -               cond_resched();
> > +       for (;;) {
> >                 copy_highpage(folio_page(dst, i), folio_page(src, i));
> > +               if (i++ == nr)
> 
> This works with the ++i precedence change. Thanks!

Thanks for testing!  (and fixing my bug)
I just pushed out an update to for-next with this fix.

> The fs/ and mm/ are mostly outside of my scope, hope you'll figure out
> the buffer-head case soon.

Thanks.  We don't need it fixed yet, but probably in the next six months.
