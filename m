Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958FD25AFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgIBPoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbgIBPoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUmKgg4xwWqmh+xeFrCeVaIW4I5DLAbupfKnbPLRKZg=;
        b=L88L8NIJtjYJ1IlTPBb5ZfrmjPRiXjnWXZfy0i9APa4m5YzmJ8PoiE9Aath7yvMGeMfqi7
        I2JU0SVpm7rdZyaA4M9lURfeYOdld4rgRqMLVfmQ4b1srbS5N59zKx85bTHAQ254FtthZJ
        y36R8ZKn78/oY5vWniWuGujHaqzCtS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-2AQ8V7JJM1KQ-wGLWT8C-A-1; Wed, 02 Sep 2020 11:44:29 -0400
X-MC-Unique: 2AQ8V7JJM1KQ-wGLWT8C-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D44BC18C5200;
        Wed,  2 Sep 2020 15:44:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C795B5C1D7;
        Wed,  2 Sep 2020 15:44:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/6] Fix khugepaged's request size in collapse_file() [ver
 #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Song Liu <songliubraving@fb.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:24 +0100
Message-ID: <159906146405.663183.8327943081419924909.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

collapse_file() in khugepaged passes PAGE_SIZE as the number of pages to be
read ahead to page_cache_sync_readahead().  It seems this was expressed as a
number of bytes rather than a number of pages.

Fix it to use the number of pages to the end of the window instead.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 mm/khugepaged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6d199c353281..f2d243077b74 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1706,7 +1706,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
-							  PAGE_SIZE);
+							  end - index);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);


