Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF29929D62B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgJ1WMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730609AbgJ1WMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORcn3B8leoo4q9li1h7odSk682umRjCQ5ZaqggknKR8=;
        b=PluKrRhoS0Y1YIuR6Q3U8oFsxUhxkPFXrpWiQEz0Nt/jqWHd/LcmtqI8OgDr3abwtfj5Px
        2Q3p5/GTUCqIgsK/uR4ugCf5ByQTiWzbygzk0FETEsjvyHjvU3oU2BDZ+pgPfCKmjgB2oO
        2MuPTne+Mh1V/RgpMBeTZlHYIaFnYKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-A7AdynufMCSbbRs3e8salg-1; Wed, 28 Oct 2020 10:10:27 -0400
X-MC-Unique: A7AdynufMCSbbRs3e8salg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B60E4966B43;
        Wed, 28 Oct 2020 14:10:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A433C1C4;
        Wed, 28 Oct 2020 14:10:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/11] afs: Fix to take ref on page when PG_private is set
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:10:24 +0000
Message-ID: <160389422491.300137.18176057671220409936.stgit@warthog.procyon.org.uk>
In-Reply-To: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs to take a ref on a page when it sets PG_private on it and to drop
the ref when removing the flag.

Note that in afs_write_begin(), a lot of the time, PG_private is already
set on a page to which we're going to add some data.  In such a case, we
leave the bit set and mustn't increment the page count.  To this end, make
TestSetPagePrivate() available.

Fixes: 31143d5d515e ("AFS: implement basic file write support")
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |    3 +++
 fs/afs/dir_edit.c          |    1 +
 fs/afs/file.c              |    2 ++
 fs/afs/write.c             |    9 +++++++--
 include/linux/page-flags.h |    1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1d2e61e0ab04..064eb66c33e9 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -283,6 +283,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 			set_page_private(req->pages[i], 1);
 			SetPagePrivate(req->pages[i]);
+			get_page(req->pages[i]);
 			unlock_page(req->pages[i]);
 			i++;
 		} else {
@@ -1977,6 +1978,7 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
 
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
+	put_page(page);
 
 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
@@ -2006,5 +2008,6 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 	if (offset == 0 && length == PAGE_SIZE) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
+		put_page(page);
 	}
 }
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index b108528bf010..997f6798beee 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -246,6 +246,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			if (!PagePrivate(page)) {
 				set_page_private(page, 1);
 				SetPagePrivate(page);
+				get_page(page);
 			}
 			dir_page = kmap(page);
 		}
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 91225421ad37..7dafa2266048 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -632,6 +632,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 					     page->index, priv);
 			set_page_private(page, 0);
 			ClearPagePrivate(page);
+			put_page(page);
 		}
 	}
 
@@ -666,6 +667,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 				     page->index, priv);
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
+		put_page(page);
 	}
 
 	/* indicate that the page can be released */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index b937ec047ec9..29685947324e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -151,7 +151,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	priv |= f;
 	trace_afs_page_dirty(vnode, tracepoint_string("begin"),
 			     page->index, priv);
-	SetPagePrivate(page);
+	if (!TestSetPagePrivate(page))
+		get_page(page);
 	set_page_private(page, priv);
 	_leave(" = 0");
 	return 0;
@@ -338,6 +339,8 @@ static void afs_pages_written_back(struct afs_vnode *vnode,
 			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
 					     pv.pages[loop]->index, priv);
 			set_page_private(pv.pages[loop], 0);
+			ClearPagePrivate(pv.pages[loop]);
+			put_page(pv.pages[loop]);
 			end_page_writeback(pv.pages[loop]);
 		}
 		first += count;
@@ -863,7 +866,8 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	priv |= 0; /* From */
 	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
 			     vmf->page->index, priv);
-	SetPagePrivate(vmf->page);
+	if (!TestSetPagePrivate(vmf->page))
+		get_page(vmf->page);
 	set_page_private(vmf->page, priv);
 	file_update_time(file);
 
@@ -930,6 +934,7 @@ int afs_launder_page(struct page *page)
 			     page->index, priv);
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
+	put_page(page);
 
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page)) {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..37d65b55a6c6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -365,6 +365,7 @@ PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
  */
 PAGEFLAG(Private, private, PF_ANY) __SETPAGEFLAG(Private, private, PF_ANY)
 	__CLEARPAGEFLAG(Private, private, PF_ANY)
+	TESTSETFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
 PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 	TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)


