Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490412A0504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgJ3MI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 08:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgJ3MIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604059702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxlJ8Mwn0Tke0WPb8nHZ6w8mEJXEo5j2Z00nnV/ApfQ=;
        b=Wmzq52KaSQ1+YGSIS2RnmLNb3RBhkISIVRfYUkZD3drb5hVPL6ZHSLaIkwEkzC6f4AtRzv
        u8PSSLINt2sRK0NDCAf1TwxjGErLbPeBJoIzfgqiDrq1xDxXkNzyNmZId1gffnhcKflG/a
        cOlYaXdcNwOyNPQV1iNDqQFVsqN0Gjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-AzIfXLJtNRSF2-f3T9HVoQ-1; Fri, 30 Oct 2020 08:08:18 -0400
X-MC-Unique: AzIfXLJtNRSF2-f3T9HVoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A88A101F000;
        Fri, 30 Oct 2020 12:08:17 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F238219C71;
        Fri, 30 Oct 2020 12:08:15 +0000 (UTC)
Message-ID: <be8410fb81e6908457a524bc8e1df83a648d38f1.camel@redhat.com>
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Date:   Fri, 30 Oct 2020 08:08:15 -0400
In-Reply-To: <20201022171243.GX20115@casper.infradead.org>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
         <20201022004906.GQ20115@casper.infradead.org>
         <7ec15e2710db02be81a6c47afc57abed4bf8016c.camel@lca.pw>
         <20201022171243.GX20115@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-22 at 18:12 +0100, Matthew Wilcox wrote:
> On Thu, Oct 22, 2020 at 11:35:26AM -0400, Qian Cai wrote:
> > On Thu, 2020-10-22 at 01:49 +0100, Matthew Wilcox wrote:
> > > On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> > > > Today's linux-next starts to trigger this wondering if anyone has any
> > > > clue.
> > > 
> > > I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
> > > to try to get a clue about it.  Good to know it's not the THP patches
> > > since they aren't in linux-next.
> > > 
> > > I don't understand how it can happen.  We have the page locked, and then
> > > we
> > > do:
> > > 
> > >                         if (PageWriteback(page)) {
> > >                                 if (wbc->sync_mode != WB_SYNC_NONE)
> > >                                         wait_on_page_writeback(page);
> > >                                 else
> > >                                         goto continue_unlock;
> > >                         }
> > > 
> > >                         VM_BUG_ON_PAGE(PageWriteback(page), page);
> > > 
> > > Nobody should be able to put this page under writeback while we have it
> > > locked ... right?  The page can be redirtied by the code that's supposed
> > > to be writing it back, but I don't see how anyone can make PageWriteback
> > > true while we're holding the page lock.
> > 
> > It happened again on today's linux-next:
> > 
> > [ 7613.579890][T55770] page:00000000a4b35e02 refcount:3 mapcount:0
> > mapping:00000000457ceb87 index:0x3e pfn:0x1cef4e
> > [ 7613.590594][T55770] aops:xfs_address_space_operations ino:805d85a dentry
> > name:"doio.f1.55762"
> > [ 7613.599192][T55770] flags:
> > 0xbfffc0000000bf(locked|waiters|referenced|uptodate|dirty|lru|active)
> > [ 7613.608596][T55770] raw: 00bfffc0000000bf ffffea0005027d48
> > ffff88810eaec030 ffff888231f3a6a8
> > [ 7613.617101][T55770] raw: 000000000000003e 0000000000000000
> > 00000003ffffffff ffff888143724000
> > [ 7613.625590][T55770] page dumped because:
> > VM_BUG_ON_PAGE(PageWriteback(page))
> > [ 7613.632695][T55770] page->mem_cgroup:ffff888143724000
> 
> Seems like it reproduces for you pretty quickly.  I have no luck ;-(
> 
> Can you add this?

It turns out I had no luck for the last a few days. I'll keep running and report
back if it triggers again.

> 
> +++ b/mm/page-writeback.c
> @@ -2774,6 +2774,7 @@ int __test_set_page_writeback(struct page *page, bool
> keep_write)
>         struct address_space *mapping = page_mapping(page);
>         int ret, access_ret;
>  
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
>         lock_page_memcg(page);
>         if (mapping && mapping_use_writeback_tags(mapping)) {
>                 XA_STATE(xas, &mapping->i_pages, page_index(page));
> 
> This is the only place (afaict) that sets PageWriteback, so that will
> tell us whether someone is setting Writeback without holding the lock,
> or whether we're suffering from a spurious wakeup.
> 

