Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F25437E0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhJVTMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234352AbhJVTLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56csLWKOXC3CFqzKs+ecqrHyAxkY2LTXGKgqQ8XEXPg=;
        b=fAINKO7AnecbNXoqvdkMRnGZrym2tqeOxYEefn9w5M3uYgR9+87ARBvglT7O8IF295kDCy
        ZR3oMKz1Cy40NlgjzvWty7zF+GY8u7zVlJAyJOPnyGxMj7UZQ4KYqw+fGf9wNT8ryqbsgt
        aa34jMYKJbhx8IqqMpQHaRRy1iBkdNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-sENI_xwvNY6IZ-Qj0JDDIg-1; Fri, 22 Oct 2021 15:08:55 -0400
X-MC-Unique: sENI_xwvNY6IZ-Qj0JDDIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B73362F8;
        Fri, 22 Oct 2021 19:08:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DBB31017E28;
        Fri, 22 Oct 2021 19:08:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 43/53] afs: Make afs_write_begin() return the THP subpage
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:08:45 +0100
Message-ID: <163492972548.1038219.2862380188907793320.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

generic_perform_write() can't handle a THP, so we have to return the
subpage of that THP from afs_write_begin() and then convert it back into
the head on entry to afs_write_end().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19be3153d610..a01b1687a146 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -78,7 +78,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 			goto flush_conflicting_write;
 	}
 
-	*_page = page;
+	*_page = find_subpage(page, pos / PAGE_SIZE);
 	_leave(" = 0");
 	return 0;
 
@@ -108,9 +108,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
  */
 int afs_write_end(struct file *file, struct address_space *mapping,
 		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *page, void *fsdata)
+		  struct page *subpage, void *fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	struct page *page = thp_head(subpage);
 	unsigned long priv;
 	unsigned int f, from = offset_in_thp(page, pos);
 	unsigned int t, to = from + copied;


