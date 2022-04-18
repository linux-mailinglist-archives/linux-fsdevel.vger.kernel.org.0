Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121F505F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 23:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiDRVkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiDRVkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE22ED63
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 14:37:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 39A381F41BE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650317839;
        bh=aqZ/sq+j8QUOgvzBXdkd5NE7N/6Wr11NqMESsYe11pM=;
        h=From:To:Cc:Subject:Date:From;
        b=oW4ApWcimHnbFor0ZjzfIAqT4tqJUslwxI7DlzXP76/APzx4x1IyJM7UZFIbNB6/a
         PC0O9+uw6SxAjkQuVtAz0HDpGfAYP2DW7XOT8h/5kMGNAtUUtZYe0kepM72B484EWP
         adgfMzUKL8+ys/SPG6d000grmj1Rcz+5tzQ7wWgeseafC06TI2JbfCr9sLUZ7JBz8D
         VC1RKPQ/PtNkLao47K8oXJ7YTSUYBnecV5k7CglssmkHCzlJ9cLBBM6VNC22V1hKW7
         JAGJFA3qhkHgCO+CVdjYszp5XwVwK4VArLdXwnd2DMw0AtbV0FzoWR9nlAiYlAaS7r
         12MhIlSwM0OSw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     hughd@google.com, akpm@linux-foundation.org, amir73il@gmail.com
Cc:     viro@zeniv.linux.org.uk,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for lack of space.
Date:   Mon, 18 Apr 2022 17:37:10 -0400
Message-Id: <20220418213713.273050-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only difference from v2 is applying Viro's coment on how the life of
the sbinfo should now be tied to the kobject.  I hope it is correct the
way i did it.  Tested by mount/umount while holding a reference.

* v2 cover:

the only difference from v1 is addressing Amir's comment about
generating the directory in sysfs using the minor number.

* Original cover letter

When provisioning containerized applications, multiple very small tmpfs
are used, for which one cannot always predict the proper file system
size ahead of time.  We want to be able to reliably monitor filesystems
for ENOSPC errors, without depending on the application being executed
reporting the ENOSPC after a failure.  It is also not enough to watch
statfs since that information might be ephemeral (say the application
recovers by deleting data, the issue can get lost).  For this use case,
it is also interesting to differentiate IO errors caused by lack of
virtual memory from lack of FS space.

This patch exposes two counters on sysfs that log the two conditions
that are interesting to observe for container provisioning.  They are
recorded per tmpfs superblock, and can be polled by a monitoring
application.

I proposed a more general approach [1] using fsnotify, but considering
the specificity of this use-case, people agreed it seems that a simpler
solution in sysfs is more than enough.

[1] https://lore.kernel.org/linux-mm/20211116220742.584975-3-krisman@collabora.com/T/#mee338d25b0e1e07cbe0861f9a5ca8cc439b3edb8

To: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Khazhismel Kumykov <khazhy@google.com>
Cc: Linux MM <linux-mm@kvack.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>

Gabriel Krisman Bertazi (3):
  shmem: Keep track of out-of-memory and out-of-space errors
  shmem: Introduce /sys/fs/tmpfs support
  shmem: Expose space and accounting error count

 Documentation/ABI/testing/sysfs-fs-tmpfs | 13 ++++
 include/linux/shmem_fs.h                 |  5 ++
 mm/shmem.c                               | 76 ++++++++++++++++++++++--
 3 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-tmpfs

-- 
2.35.1

