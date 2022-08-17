Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389F5975DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiHQSle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHQSld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602DA00C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660761690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KrNH++9OSLFu7Ijopj+il7JOfOGrBfah2cWjWaVWpUk=;
        b=CmKbRRbACgUwELiDx/E+DtHoIFFDezVFYo+OaPqEMkGAp6FXl0VrcVM6ktf55ZxgDN789f
        jEK2D+UgzpbPt1czxqEJe7iBCnxT5zAVktO7Pw/brLMH+x8cZkILQZH+A38xMwFrg7lWHv
        RBAJXLTthrLRdNLh1lIjd6CdhFtwBcY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-32larb_kPq-ypeLxP7hJuQ-1; Wed, 17 Aug 2022 14:41:29 -0400
X-MC-Unique: 32larb_kPq-ypeLxP7hJuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 105481C01B43;
        Wed, 17 Aug 2022 18:41:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13FFB1121315;
        Wed, 17 Aug 2022 18:41:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2] locks: Fix dropped call to ->fl_release_private()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 17 Aug 2022 19:41:27 +0100
Message-ID: <166076168742.3677624.2936950729624462101.stgit@warthog.procyon.org.uk>
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

Changes
=======
ver #2)
 - Don't need to call ->fl_release_private() after calling the security
   hook, only after calling ->flock().

Fixes: 4149be7bda7e ("fs/lock: Don't allocate file_lock in flock_make_lock().")
cc: Kuniyuki Iwashima <kuniyu@amazon.com>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/166075758809.3532462.13307935588777587536.stgit@warthog.procyon.org.uk/ # v1
---

 fs/locks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/locks.c b/fs/locks.c
index c266cfdc3291..607f94a0e789 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2129,6 +2129,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	else
 		error = locks_lock_file_wait(f.file, &fl);
 
+	locks_release_private(&fl);
  out_putf:
 	fdput(f);
 


