Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64555EFC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiF1UqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiF1UqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 153DC2A420
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656449175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JDvJY4KAHSAg10rH7+lRWHYt9k9YUXyZb7F/uKYKuNk=;
        b=NwmYnmvE94yViqkwmmgFNHc/aoLnq9uW0yhiA+E1QhaF38iPd9OXR9yJoqEy8E+6yBLBfV
        VOZqy/snEvs2WGQPIGtkEsLzQTpRityeMjeGApBwx1Pc9guNdH9s0+xp7NAHF0Hqzl/nd5
        H5N9aH4fDqrauJDGUsNlRK9gj4l7F74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-IeNR2ht-PC-p5IKJFfNA9w-1; Tue, 28 Jun 2022 16:46:13 -0400
X-MC-Unique: IeNR2ht-PC-p5IKJFfNA9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DB391019C83;
        Tue, 28 Jun 2022 20:46:13 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.193.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B78840C1289;
        Tue, 28 Jun 2022 20:46:12 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/5] gfs2: debugfs PID reporting improvements
Date:   Tue, 28 Jun 2022 22:46:06 +0200
Message-Id: <20220628204611.651126-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, all glock holders in the "glocks" dump file are reported as
being associated with the process that acquired them, even for holders
that are actually associated with the filesystem itself (like the
journal glock holder) or with cached inodes (like iopen and flock glock
holders).  This is confusing when those holders outlive the processes
that have acquired them, and it trips up utilities that analyze lock
dependencies.  For example, the following two glocks were acquired by
pid 10821 during the initial mount, which has since terminated:

  G:  s:EX n:9/0 f:qb t:EX d:EX/0 a:0 v:0 r:3 m:200 p:0
   H: s:EX f:ecH e:0 p:10821 [(ended)] init_inodes+0x5c2/0xb10 [gfs2]
  G:  s:EX n:2/805f f:qob t:EX d:EX/0 a:0 v:0 r:4 m:200 p:1
   H: s:EX f:H e:0 p:10821 [(ended)] gfs2_fill_super+0x92b/0xcc0 [gfs2]
   I: n:6/32863 t:8 f:0x00 d:0x00000201 s:24 p:0

This patch queue tries to fix this problem in two ways:

 * Glock holders which are not held by the process that acquired them
   are marked as GL_NOPID.  For those holders, the PID is reported as 0,
   and the process name is reported as "(none)".

 * With this change alone, we would have a much harder time detecting
   locking cycles involving iopen or flock glocks: in both cases, a
   process which has a file descriptor open depends on the iopen and
   flock glock of the corresponding inode / file.  To keep track of
   these dependencies, we introduce a new "glockfd" dump file that
   reports which file descriptors of which processes are holding which
   glocks.

A utility that checks for locking problems using this additional
information is forthcoming, but hasn't been completed so far.


NEW EXPORTS

This patch queue requires iterating through all file descriptors of all
processes, which is made easier by exporting find_ge_pid() and
task_lookup_next_fd_rcu(); copying Eric W. Biederman and the
linux-kernel and linux-fsdevel lists to make sure that's okay.


Thanks,
Andreas

Andreas Gruenbacher (5):
  gfs2: Add glockfd debugfs file
  gfs2: Add flocks to glockfd debugfs file
  gfs2: Add GL_NOPID flag for process-independent glock holders
  gfs2: Mark flock glock holders as GL_NOPID
  gfs2: Mark the remaining process-independent glock holders as GL_NOPID

 fs/file.c            |   1 +
 fs/gfs2/file.c       |  29 +++++-
 fs/gfs2/glock.c      | 211 +++++++++++++++++++++++++++++++++++++++++--
 fs/gfs2/glock.h      |   1 +
 fs/gfs2/inode.c      |   6 +-
 fs/gfs2/ops_fstype.c |  14 +--
 fs/gfs2/super.c      |   3 +-
 fs/gfs2/util.c       |   6 +-
 kernel/pid.c         |   1 +
 9 files changed, 247 insertions(+), 25 deletions(-)

-- 
2.35.1

