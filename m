Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02699597525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbiHQRdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiHQRdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F84DBA
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660757593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vqIWYsxr0L8X4TPhLFVMWagw5j3xvLwRpzXiF8hND4g=;
        b=R+leZRP484OgNCIFV47RqkWKmE7LrRQz22EQ53Ejo7rLJM46plHH+BKrqq86FkbOVuAdCA
        tP/dvtklvtlJAcFCTsWh+oqQj+0+9VF6mGSRlXgIYbCZg1x9yHdYeHUKhLgq0ToJeQaYlB
        xPWkDPfGU+d/4V4J6MigunMOoaXc19s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-7ngCXykBPQSgA5fVt66_gw-1; Wed, 17 Aug 2022 13:33:10 -0400
X-MC-Unique: 7ngCXykBPQSgA5fVt66_gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A97AE805AF5;
        Wed, 17 Aug 2022 17:33:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5EF11121315;
        Wed, 17 Aug 2022 17:33:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] locks: Fix dropped call to ->fl_release_private()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 18:33:08 +0100
Message-ID: <166075758809.3532462.13307935588777587536.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior to commit 4149be7bda7e, sys_flock() would allocate the file_lock
struct it was going to use to pass parameters, call ->flock() and then call
locks_free_lock() to get rid of it - which had the side effect of calling
locks_release_private() and thus ->fl_release_private().

With commit 4149be7bda7e, however, this is no longer the case: the struct
is now allocated on the stack, and locks_free_lock() is no longer called -
and thus any remaining private data doesn't get cleaned up either.

This causes afs flock to cause oops.  Kasan catches this as a UAF by the
list_del_init() in afs_fl_release_private() for the file_lock record
produced by afs_fl_copy_lock() as the original record didn't get delisted.
It can be reproduced using the generic/504 xfstest.

Fix this by reinstating the locks_release_private() call in sys_flock().
I'm not sure if this would affect any other filesystems.  If not, then the
release could be done in afs_flock() instead.

Fixes: 4149be7bda7e ("fs/lock: Don't allocate file_lock in flock_make_lock().")
cc: Kuniyuki Iwashima <kuniyu@amazon.com>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---

 fs/locks.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index c266cfdc3291..f2d5aca782c6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2116,7 +2116,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 
 	error = security_file_lock(f.file, fl.fl_type);
 	if (error)
-		goto out_putf;
+		goto out_release;
 
 	can_sleep = !(cmd & LOCK_NB);
 	if (can_sleep)
@@ -2128,7 +2128,8 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 					    &fl);
 	else
 		error = locks_lock_file_wait(f.file, &fl);
-
+out_release:
+	locks_release_private(&fl);
  out_putf:
 	fdput(f);
 


