Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1B4320CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhJRO6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232969AbhJRO63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SB5Ii7xfPTM4p2eEWvijuPkly8hQ6NZB0idEsu0sEO8=;
        b=i0wnd6bDQ0h7WvkONsuavPF6mitRdu39YunsVtYhiuh/19IKZxEwd1uE3s7Tjhyyxd0Got
        fZ/UB9qZ7EpbTR2mlZFmTMrApOhz1RdF0Y7L9cVdP4oS2kFfSN5WGXkPe/vAuXbSG1VCxi
        NLUgtVSTPJbb+30uGrxEuYXQUWqWC04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-WzAoXm61Pnm4_oBBDiJ4qA-1; Mon, 18 Oct 2021 10:56:12 -0400
X-MC-Unique: WzAoXm61Pnm4_oBBDiJ4qA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A73701006AA2;
        Mon, 18 Oct 2021 14:56:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 388E85BB12;
        Mon, 18 Oct 2021 14:56:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/67] cachefiles: Prevent inode from going away when burying
 a dentry
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:56:01 +0100
Message-ID: <163456896131.2614702.10188463290568833365.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When deleting a file, we want to make sure that the inode doesn't get
detached from it (leading to ->d_inode being cleared) as we may still want
to touch the inode afterwards (we want to clear the belongs-to-kernel flag
and we may have the dentry referred to by a file struct).

Do this by getting an extra ref on the dentry around the vfs_unlink() call
so that d_delete() doesn't see the refcount == 1.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 4bd31be3be30..04c767624e3d 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -106,7 +106,9 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 			cachefiles_io_error(cache, "Unlink security error");
 		} else {
 			trace_cachefiles_unlink(object, rep, why);
+			dget(rep);
 			ret = vfs_unlink(&init_user_ns, d_inode(dir), rep, NULL);
+			dput(rep);
 		}
 
 		inode_unlock(d_inode(dir));


