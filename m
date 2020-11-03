Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7D2A4B99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKCQdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgKCQdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604421185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rh02QKGX84nhra5jyTMHRudQLVhPKvsvo4vCQqCRuEw=;
        b=ALjKtEs6yMYtXk91wAv7TYqQkp3XJzzM9Eddtm9vCYfMddqWNTBKWUz24UK+qQqvtT0YGO
        BovsZJbWpuPA3DXYxOH48r32KGA7SYoKoyIbDEzI6CfkQECgd0fRk8jN4W4mIqkN71+6Ks
        BxGe56em1uuCOXkX7N7AgDBciRgBTBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-OsNJZ1jTMhWgTbpiKMCW8Q-1; Tue, 03 Nov 2020 11:33:04 -0500
X-MC-Unique: OsNJZ1jTMhWgTbpiKMCW8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D036415C;
        Tue,  3 Nov 2020 16:33:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7095B4A1;
        Tue,  3 Nov 2020 16:33:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] afs: Fix warning due to unadvanced marshalling pointer
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Nov 2020 16:32:58 +0000
Message-ID: <160442117884.677368.3642109457622229990.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When using the afs.yfs.acl xattr to change an AuriStor ACL, a warning can
be generated when the request is marshalled because the buffer pointer
isn't increased after adding the last element, thereby triggering the check
at the end if the ACL wasn't empty.  This just causes something like the
following warning, but doesn't stop the call from happening successfully:

    kAFS: YFS.StoreOpaqueACL2: Request buffer underflow (36<108)

Fix this simply by increasing the count prior to the check.

Fixes: f5e4546347bc ("afs: Implement YFS ACL setting")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/yfsclient.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 3b1239b7e90d..bd787e71a657 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1990,6 +1990,7 @@ void yfs_fs_store_opaque_acl2(struct afs_operation *op)
 	memcpy(bp, acl->data, acl->size);
 	if (acl->size != size)
 		memset((void *)bp + acl->size, 0, size - acl->size);
+	bp += size / sizeof(__be32);
 	yfs_check_req(call, bp);
 
 	trace_afs_make_fs_call(call, &vp->fid);


