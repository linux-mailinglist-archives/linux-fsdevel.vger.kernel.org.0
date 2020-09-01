Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58425259896
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgIAQ2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:28:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33689 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730937AbgIAQ23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTnz/AaJx61OeSfsF40kwfwZQcF1Wav17QC/9an/tGk=;
        b=NZnOhBI/ZnlExqDujBTv5XYWHW6OnVxiZcV/acCR1ZlitHgI3uNrKMa/nnOm5BYRIDFc0E
        TRj6S3AnMmN2y5oMaXmCXPJixSB69MMHkZRARWGlpf2RV+0bLW6hE9Mu9L7dDA1zccUH2X
        b0vROx7Q7GTttai/53Hjc2gQ4V/GBGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-mAcqF4gmO_e3Y975aLiNFQ-1; Tue, 01 Sep 2020 12:28:26 -0400
X-MC-Unique: mAcqF4gmO_e3Y975aLiNFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41578014D9;
        Tue,  1 Sep 2020 16:28:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456CE5C1A3;
        Tue,  1 Sep 2020 16:28:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/7] Fix khugepaged's request size in collapse_file()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:22 +0100
Message-ID: <159897770245.405783.16506873187032379873.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
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
cc: Matthew Wilcox <willy@infradead.org>
cc: Song Liu <songliubraving@fb.com>
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


