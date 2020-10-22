Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0527B2961BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368650AbgJVPfi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 11:35:38 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:54730 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2901452AbgJVPfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:35:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-za5zEBnYOSqH-hBOoifJQA-1; Thu, 22 Oct 2020 11:35:29 -0400
X-MC-Unique: za5zEBnYOSqH-hBOoifJQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FAA804B64;
        Thu, 22 Oct 2020 15:35:28 +0000 (UTC)
Received: from ovpn-66-200.rdu2.redhat.com (ovpn-66-200.rdu2.redhat.com [10.10.66.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3D9319C4F;
        Thu, 22 Oct 2020 15:35:26 +0000 (UTC)
Message-ID: <7ec15e2710db02be81a6c47afc57abed4bf8016c.camel@lca.pw>
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
Date:   Thu, 22 Oct 2020 11:35:26 -0400
In-Reply-To: <20201022004906.GQ20115@casper.infradead.org>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
         <20201022004906.GQ20115@casper.infradead.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cai@lca.pw
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: lca.pw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-22 at 01:49 +0100, Matthew Wilcox wrote:
> On Wed, Oct 21, 2020 at 08:30:18PM -0400, Qian Cai wrote:
> > Today's linux-next starts to trigger this wondering if anyone has any clue.
> 
> I've seen that occasionally too.  I changed that BUG_ON to VM_BUG_ON_PAGE
> to try to get a clue about it.  Good to know it's not the THP patches
> since they aren't in linux-next.
> 
> I don't understand how it can happen.  We have the page locked, and then we
> do:
> 
>                         if (PageWriteback(page)) {
>                                 if (wbc->sync_mode != WB_SYNC_NONE)
>                                         wait_on_page_writeback(page);
>                                 else
>                                         goto continue_unlock;
>                         }
> 
>                         VM_BUG_ON_PAGE(PageWriteback(page), page);
> 
> Nobody should be able to put this page under writeback while we have it
> locked ... right?  The page can be redirtied by the code that's supposed
> to be writing it back, but I don't see how anyone can make PageWriteback
> true while we're holding the page lock.

It happened again on today's linux-next:

[ 7613.579890][T55770] page:00000000a4b35e02 refcount:3 mapcount:0 mapping:00000000457ceb87 index:0x3e pfn:0x1cef4e
[ 7613.590594][T55770] aops:xfs_address_space_operations ino:805d85a dentry name:"doio.f1.55762"
[ 7613.599192][T55770] flags: 0xbfffc0000000bf(locked|waiters|referenced|uptodate|dirty|lru|active)
[ 7613.608596][T55770] raw: 00bfffc0000000bf ffffea0005027d48 ffff88810eaec030 ffff888231f3a6a8
[ 7613.617101][T55770] raw: 000000000000003e 0000000000000000 00000003ffffffff ffff888143724000
[ 7613.625590][T55770] page dumped because: VM_BUG_ON_PAGE(PageWriteback(page))
[ 7613.632695][T55770] page->mem_cgroup:ffff888143724000

