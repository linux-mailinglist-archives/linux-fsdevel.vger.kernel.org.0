Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3E345D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCWLyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhCWLyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616500448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfTZ5dVZVKYQZ21C4WLUSXr1iMf8RN9mZGDZX59otA4=;
        b=ipH8uwlj/X4eaPnoE8mKOGF4j488awg1hbkVoUQ8YGtwyQIW8jn4PQfNLOIIn6+EMLV+/z
        yA7G/o1ZyEXD76InnvyqGwfL8q6/TGDl1sVf9dSMYR2MR3Yz5rmgYXcTIQVqIl+9ojl7zp
        ZDRAZ2veJ4cc1CdS5nrR2EGSIKnqt6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-8lNYiJ20P6-kMKuidgbFFg-1; Tue, 23 Mar 2021 07:54:03 -0400
X-MC-Unique: 8lNYiJ20P6-kMKuidgbFFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677F780006E;
        Tue, 23 Mar 2021 11:54:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ED27179B3;
        Tue, 23 Mar 2021 11:53:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] afs: Use wait_on_page_writeback_killable
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 11:53:57 +0000
Message-ID: <161650043737.2445805.16573960069907170426.stgit@warthog.procyon.org.uk>
In-Reply-To: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
References: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

Open-coding this function meant it missed out on the recent bugfix
for waiters being woken by a delayed wake event from a previous
instantiation of the page.

[DH: Changed the patch to use vmf->page rather than variable page which
 doesn't exist yet upstream]

Fixes: 1cf7a1518aef ("afs: Implement shared-writeable mmap")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20210320054104.1300774-4-willy@infradead.org
---

 fs/afs/write.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c9195fc67fd8..eb737ed63afb 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -851,8 +851,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	fscache_wait_on_page_write(vnode->cache, vmf->page);
 #endif
 
-	if (PageWriteback(vmf->page) &&
-	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
+	if (wait_on_page_writeback_killable(vmf->page))
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(vmf->page) < 0)


