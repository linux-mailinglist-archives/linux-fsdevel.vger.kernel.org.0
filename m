Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F812BAEBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKTPTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729159AbgKTPTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIkx8tZwUOn3GO1HchdWNQxPfUS0TK2X8uwNc5x6YvQ=;
        b=AKl9RK3JVQvVeYIfRkQfuLM/Ee0RTxKBtEeQKcT6kcBwS5vn7lO7UC3R7DQGcaNX9z8B/k
        ik+RQ3nMwzxHJd1aFsLhvjEwRcMVo7+jTKpft9qEY+2BxMnzXB/2oK5Rd9fqnUbgh3aIT9
        I/Iksa7YTMgleqFE8Rut4I93ylSmx84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-K-cx1Y4ePPmYDs1KCfDqfg-1; Fri, 20 Nov 2020 10:19:40 -0500
X-MC-Unique: K-cx1Y4ePPmYDs1KCfDqfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4480D80EDB3;
        Fri, 20 Nov 2020 15:19:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC7710023AB;
        Fri, 20 Nov 2020 15:19:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 75/76] afs: Make afs_write_begin() return the THP subpage
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:19:31 +0000
Message-ID: <160588557132.3465195.5617528680363774731.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
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
---

 fs/afs/write.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index bab110c00abd..a88c6ae71868 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -81,7 +81,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 			goto flush_conflicting_write;
 	}
 
-	*_page = page;
+	*_page = find_subpage(page, pos / PAGE_SIZE);
 	_leave(" = 0");
 	return 0;
 
@@ -110,9 +110,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
  */
 int afs_write_end(struct file *file, struct address_space *mapping,
 		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *page, void *fsdata)
+		  struct page *subpage, void *fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	struct page *page = thp_head(subpage);
 	unsigned long priv;
 	unsigned int f, from = pos & (thp_size(page) - 1);
 	unsigned int t, to = from + copied;


