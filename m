Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751A477C232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjHNVMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjHNVMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9C1736
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x6X/UhlcOZkD6o+yr1KBD7CLkqi3R+/GBSx6Mum85Rc=;
        b=WJbQ9xKQsoQG91DMm2jUGsYuidt8TJvZRzAKYy3Ub1S9nHN2ecN/KZi+xcaEHKcc5RIJHS
        bm0MRpWFJUrKUypQa1RTIRxjFwvebVW2ecVPnmcnZNd3yfifv8/ttEwGj6Mc4hgQJGbeJW
        rdPfZ1mpRbxK4qTuYtOeHSew8QH0Ayc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-CyJDJ10jOxaWZtgUFZRwWQ-1; Mon, 14 Aug 2023 17:11:22 -0400
X-MC-Unique: CyJDJ10jOxaWZtgUFZRwWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37EE8185A78B;
        Mon, 14 Aug 2023 21:11:22 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B483EC15BAD;
        Mon, 14 Aug 2023 21:11:21 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 0/7] fs: nfs: async lock request changes
Date:   Mon, 14 Aug 2023 17:11:09 -0400
Message-Id: <20230814211116.3224759-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

this patch series contains changes to lockd asynchronous lock request
handling over vfs_lock_file(). The only one upstream user so far I see
is DLM. The current DLM handling of asynchronous lock request is broken.
Those patches makes the asynchronous lock request handling better, there
are still issues with fencing or lock cancellation that this patch
series does not tackle.

The cifs filesystem is another user of FILE_LOCK_DEFERRED but it does
not do anything on checking lm_grant() as the asynchronous lock API is
required to check if it's set.

- Alex

changes since v2:
 - add dlm fixes/changes to show how the new API should work. It's used
   by gfs2/ocfs2.
 - handle non-blocking request synchronously. For this reason we needed
   to introduce a new per nlm_block request to fix a race between
   request and lm_grant() callback handling, see b_cb_mutex
 - update documentation for new FL_SLEEP handling when lm_grant() is
   set and new requirement that lm_grant() need to be called from a
   sleepable contex.
 - clear new CALLBACK PENDING flag when nlm_block is removed from
   nlm_blocked
 - introduce helper export_op_support_safe_async_lock() to check if
   the filesystem supports asynchronous lock request calls
 - fix block variable never NULL when iterating over nlm_blocked list

Alexander Aring (7):
  lockd: fix race in async lock request handling
  lockd: FILE_LOCK_DEFERRED only on FL_SLEEP
  lockd: introduce safe async lock op
  locks: update lock callback documentation
  dlm: use fl_owner from lockd
  dlm: use FL_SLEEP to check if blocking request
  dlm: implement EXPORT_OP_SAFE_ASYNC_LOCK

 fs/dlm/plock.c              |  54 +++++++-------
 fs/gfs2/export.c            |   1 +
 fs/lockd/svclock.c          | 140 ++++++++++++++++++++----------------
 fs/locks.c                  |  28 ++++----
 fs/nfsd/nfs4state.c         |  13 +++-
 fs/ocfs2/export.c           |   1 +
 include/linux/exportfs.h    |   8 +++
 include/linux/lockd/lockd.h |   2 +
 8 files changed, 140 insertions(+), 107 deletions(-)

-- 
2.31.1

