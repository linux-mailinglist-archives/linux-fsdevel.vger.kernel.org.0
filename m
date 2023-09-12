Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07279DB3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbjILVz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbjILVzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946AE10F4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=twgRLEWHQGgDrs33JHbFXACkmGR+Ekoa3f4TUpczBRw=;
        b=ANiRNbNsVdf11A4NYqc76RZQM/Nn7hSJajed5wIl0nqVAjbNkhCWqXqeCUKVVZbeY+wahc
        2SD1koBPh7ZqCF9C3azmh36IYg6ue7KiPa67VHnX6zjZ7n0Q5XcOYXzkJkw3IpZvUH08Iq
        gD025OsL3CmxkR+AC6In0Wsd33aznDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-NfuNQi9KNDe6K-7MWlQ7wA-1; Tue, 12 Sep 2023 17:53:47 -0400
X-MC-Unique: NfuNQi9KNDe6K-7MWlQ7wA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 131BF8019DC;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 958C840C2009;
        Tue, 12 Sep 2023 21:53:46 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 0/7] lockd: dlm: async lock request changes
Date:   Tue, 12 Sep 2023 17:53:17 -0400
Message-Id: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I sent this as a PATCH now and drop the RFC. I got some review back from
Jeff Layton and hope I was successful to follow it. There are still
issues with lockd and asynchronous lock request but it will at least not
directly crash when somebody is using nfs on top of GFS2. The issues are
related to cancellation of locks/lockd decides to drop nlm_block for
some reasons while pending request is happening.

I did not change more documentation about the asynchronous lock request
functionality to not confuse users. In my opinion there should be more
documentation about what you SHOULD NOT do with this API. Otherwise I
think the documentation is still correct.

I will send a follow up patch to fsdevel to change all users using
IS_SETLKW() to use FL_SLEEP to determine if it's blocking or
non-blocking and send it to fsdevel as it was recommended. This will
just be a grep and replace patch and look what happens.

- Alex

changes since v2:
 - remove B_PENDING_CALLBACK paragraph from commit msg. Was a leftover
   and I forgot to update the commit message.
 - change function name from export_op_support_safe_async_lock()
   to exportfs_lock_op_is_async()
 - change flag name from EXPORT_OP_SAFE_ASYNC_LOCK to
   EXPORT_OP_ASYNC_LOCK
 - add documentation for EXPORT_OP_ASYNC_LOCK to
   Documentation/filesystems/nfs/exporting.rst
 - add newline between function name and return type of
   exportfs_lock_op_is_async()
 - remove f_op->lock() check and mention it in
   Documentation/filesystems/nfs/exporting.rst to only use it with
   filesystems implementing their own ->lock()
 - add kdoc for exportfs_lock_op_is_async()

changes since RFC:

- drop the pending callback flag but introduce "lockd: don't call
  vfs_lock_file() for pending requests", see patch why I need it.
- drop per nlm_block callback mutex
- change async lock request documentation
- use always FL_SLEEP to determine if it's blocking vs non-blocking in
  DLM

Alexander Aring (7):
  lockd: introduce safe async lock op
  lockd: don't call vfs_lock_file() for pending requests
  lockd: fix race in async lock request handling
  lockd: add doc to enable EXPORT_OP_ASYNC_LOCK
  dlm: use fl_owner from lockd
  dlm: use FL_SLEEP to determine blocking vs non-blocking
  dlm: implement EXPORT_OP_ASYNC_LOCK

 Documentation/filesystems/nfs/exporting.rst |  7 ++++
 fs/dlm/plock.c                              | 20 +++--------
 fs/gfs2/export.c                            |  1 +
 fs/lockd/svclock.c                          | 38 ++++++++++++++-------
 fs/locks.c                                  | 12 ++++---
 fs/nfsd/nfs4state.c                         | 10 ++++--
 fs/ocfs2/export.c                           |  1 +
 include/linux/exportfs.h                    | 14 ++++++++
 8 files changed, 67 insertions(+), 36 deletions(-)

-- 
2.31.1

