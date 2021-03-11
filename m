Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30171337527
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 15:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhCKOLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 09:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233192AbhCKOKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615471836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lztVusrdV4TAvh9vZ9Pq3FUWJN6K0FoxU0NLDUSt5YI=;
        b=T7OOS2ZudSPnJdD6OO+f7rcrm2t0pjGhiCxkxkAWRZ76BaldISESjlAmwMRWjbCsLh1TTd
        7aBIa8Uko6b8qEn5bCqyS6gySW9HnJqifvwgr5E/4ZjPLkb5rDE1dAVxFKhkKxpLLX6adz
        2AHIUMaP9mA4RzYSJy7vQDNjPDy6hS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-U8jYs-iGNga1x2W0XsemFw-1; Thu, 11 Mar 2021 09:10:33 -0500
X-MC-Unique: U8jYs-iGNga1x2W0XsemFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB5E41084C83;
        Thu, 11 Mar 2021 14:10:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012565D739;
        Thu, 11 Mar 2021 14:10:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] afs: Fix afs_listxattr() to not list afs ACL special
 xattrs
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 14:10:30 +0000
Message-ID: <161547183017.1868820.15107551878060916410.stgit@warthog.procyon.org.uk>
In-Reply-To: <161547181530.1868820.12933722592029066752.stgit@warthog.procyon.org.uk>
References: <161547181530.1868820.12933722592029066752.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

afs_listxattr() lists all the available special afs xattrs (i.e. those in
the "afs.*" space), no matter what type of server we're dealing with.  But
OpenAFS servers, for example, cannot deal with some of the extra-capable
attributes that AuriStor (YFS) servers provide.  Unfortunately, the
presence of the afs.yfs.* attributes causes errors[1] for anything that
tries to read them if the server is of the wrong type.

Fix afs_listxattr() so that it doesn't list any of the AFS ACL xattrs.  It
does mean, however, that getfattr won't list them, though they can still be
accessed with getxattr() and setxattr().

This can be tested with something like:

	getfattr -d -m ".*" /afs/example.com/path/to/file

With this change, none of the afs.* ACL attributes should be visible.

Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
cc: linux-afs@lists.infradead.org
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003502.html [1]
---

 fs/afs/xattr.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 4934e325a14a..81a6aec764cc 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -12,14 +12,9 @@
 #include "internal.h"
 
 static const char afs_xattr_list[] =
-	"afs.acl\0"
 	"afs.cell\0"
 	"afs.fid\0"
-	"afs.volume\0"
-	"afs.yfs.acl\0"
-	"afs.yfs.acl_inherited\0"
-	"afs.yfs.acl_num_cleaned\0"
-	"afs.yfs.vol_acl";
+	"afs.volume";
 
 /*
  * Retrieve a list of the supported xattrs.


