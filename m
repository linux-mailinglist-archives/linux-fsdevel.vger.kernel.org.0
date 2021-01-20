Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1C2FDFA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 03:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbhATXri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 18:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730429AbhATWYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611181358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YedMCP9lMu2Cnddwp+/wzr1wQ5ddOE8Fl4udQS58Uic=;
        b=HkBQ52lpLQVpmkhtIxaeWqotzHlCKW+WmYZsNzymnT29BAYT0wGV4TazuhYEoY7tGservA
        07OE9tNDGCTCwu3kTL0y7HYsVRx2KDJFuqhz6X1Q3gf+gXNA/jWUGfY0rMGtjUECCl2bTc
        19bP6eE75N180dtwNuEPAPy/oZVJQjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Phb2yheGO86JpjJx1MlyLg-1; Wed, 20 Jan 2021 17:22:33 -0500
X-MC-Unique: Phb2yheGO86JpjJx1MlyLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A44580A5CB;
        Wed, 20 Jan 2021 22:22:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D7A72C161;
        Wed, 20 Jan 2021 22:22:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/25] cachefiles: Drop superfluous readpages aops NULL check
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jan 2021 22:22:24 +0000
Message-ID: <161118134449.1232039.7782285502855946342.stgit@warthog.procyon.org.uk>
In-Reply-To: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
References: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

After the recent actions to convert readpages aops to readahead, the
NULL checks of readpages aops in cachefiles_read_or_alloc_page() may
hit falsely.  More badly, it's an ASSERT() call, and this panics.

Drop the superfluous NULL checks for fixing this regression.

[DH: Note that cachefiles never actually used readpages, so this check was
 never actually necessary]

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208883
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1175245
Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 fs/cachefiles/rdwr.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8bda092e60c5..e027c718ca01 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -413,7 +413,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
@@ -713,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;


