Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80929DCDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgJ1WXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733118AbgJ1WXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhBCr/kNOv10l2PohOVnQJvYd1RPY4KWC4eptFHnJ5k=;
        b=J+zZkhuWDRC0Yl8pakWynxFUPius5U/GpFzHXhsFl4IEyV+tBfHYHQKsCGYeh5ay127ZWR
        PqsOhRtWzumyOp+IVmJ2I3t1cslU+Mp01ImK7MSjgCRDSkMaiPpbTSOAs6zDlMeY2EKU3B
        K70Ii2fPwq2pBZru1r3N4fqRvgBZZ8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Xzf9DnkVPGKHVMTP87C32A-1; Wed, 28 Oct 2020 18:23:00 -0400
X-MC-Unique: Xzf9DnkVPGKHVMTP87C32A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74CE8107AFAF;
        Wed, 28 Oct 2020 22:22:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8BB19931;
        Wed, 28 Oct 2020 22:22:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/11] afs: Fix a use after free in afs_xattr_get_acl()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:22:57 +0000
Message-ID: <160392377743.592578.7592892849456748664.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The "op" pointer is freed earlier when we call afs_put_operation().

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Colin Ian King <colin.king@canonical.com>
---

 fs/afs/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 84f3c4f57531..38884d6c57cd 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -85,7 +85,7 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 			if (acl->size <= size)
 				memcpy(buffer, acl->data, acl->size);
 			else
-				op->error = -ERANGE;
+				ret = -ERANGE;
 		}
 	}
 


