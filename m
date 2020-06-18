Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B071FFE70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgFRXBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 19:01:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50985 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731367AbgFRXBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592521294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fVl7NirlPBDaZbv0g3tbYP7L/Gzjwfxt3r7f0D5EtyA=;
        b=fMHKBye7qMOKzFq+rFofKjt/PWcGai6G+BvQvCxHygpQ+0yg2TmZq4S6dcKhUETjJF/XDi
        aD8NVg5LiE4BHUB1RRVdIdDP/Rhh8bepGR0ZZ8a21v13Kp/qBYkNg4EUWZ6tmv4tVltkA/
        CNLPrqir2ShHtAU2SEtzoaZz1KyrDes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-I141doS4NfOHr44PF510Eg-1; Thu, 18 Jun 2020 19:01:32 -0400
X-MC-Unique: I141doS4NfOHr44PF510Eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02636464;
        Thu, 18 Jun 2020 23:01:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07EEF5D9C5;
        Thu, 18 Jun 2020 23:01:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_do_lookup() to call correct fetch-status op
 variant
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 00:01:28 +0100
Message-ID: <159252128817.1594103.7234386826450496394.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_do_lookup()'s fallback case for when FS.InlineBulkStatus isn't
supported by the server.  In the fallback, it calls FS.FetchStatus for the
specific vnode it's meant to be looking up.  Commit b6489a49f7b7 broke this
by renaming one of the two identically-named afs_fetch_status_operation
descriptors to something else so that one of them could be made non-static.
The site that used the renamed one, however, wasn't renamed and didn't
produce any warning because the other was declared in a header.

Fix this by making afs_do_lookup() use the renamed variant.

Note that there are two variants of the success method because one is
called from ->lookup() where we may or may not have an inode, but can't
call iget until after we've talked to the server - whereas the other is
called from within iget where we have an inode, but it may or may not be
initialised.

The latter variant expects there to be an inode, but because it's being
called from there former case, there might not be - resulting in an oops
like the following:

 BUG: kernel NULL pointer dereference, address: 00000000000000b0
 ...
 RIP: 0010:afs_fetch_status_success+0x27/0x7e
 ...
 Call Trace:
  ? rxrpc_cleanup_call+0xb5/0xc5
  afs_wait_for_operation+0xda/0x234
  afs_do_lookup+0x2fe/0x3c1
  afs_lookup+0x3c5/0x4bd
  __lookup_slow+0xcd/0x10f
  walk_component+0xa2/0x10c
  ? path_init+0x101/0x2eb
  path_lookupat.isra.0+0x80/0x110
  filename_lookup+0x81/0x104
  ? slab_post_alloc_hook.isra.0+0xa/0x1a
  ? kmem_cache_alloc+0xc3/0x129
  vfs_statx+0x76/0x109
  ? touch_atime+0x33/0xac
  __do_sys_newlstat+0x39/0x6b
  ? ksys_getdents64+0xb9/0xe0
  ? vtime_delta.isra.0+0xe/0x24
  ? vtime_delta.isra.0+0xe/0x24
  ? get_vtime_delta+0x12/0x20
  ? vtime_user_exit+0x21/0x61
  ? __context_tracking_exit+0x3a/0x87
  do_syscall_64+0x4c/0x78
  entry_SYSCALL_64_after_hwframe+0x44/0xa9


Fixes: b6489a49f7b7 ("afs: Fix silly rename")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3e3c2bf0a722..96757f3abd74 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -845,7 +845,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 		 * to FS.FetchStatus for op->file[1].
 		 */
 		op->fetch_status.which = 1;
-		op->ops = &afs_fetch_status_operation;
+		op->ops = &afs_lookup_fetch_status_operation;
 		afs_begin_vnode_operation(op);
 		afs_wait_for_operation(op);
 	}


