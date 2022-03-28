Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9774F4E8BD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiC1CGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiC1CGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:06:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E86AE73
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 19:05:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2D2AA1F42F39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648433103;
        bh=YQwmxHNUIjUbR7VNXES3Vf/IfbnrF5LgkehmOk77BNw=;
        h=From:To:Cc:Subject:Date:From;
        b=XhZLDmm+cTd0qtlAuDdCkwpaKlPZwypMWs0SaSjBctTfSPtfVwK/h9eP+1KEkG+DB
         VOyVxi/7K8E/nd+vAT9TxSR+yz0XXbdqEf9nxO2krVxa8TkRekCt7hNiTtWo+XYV4p
         aOfu7sNYe+cNiE3C/0AL58BBQNLOwKzuI0Hn7DpcKNK0pbLoZxF3O3Eo8T1Na7uNOd
         MZiU5dtMOLtYVA7wZJ/dxl5Vb5sqKj9WvhrEFRRpphpetAd4ebQbudQ9HXpgXSCuOI
         sn0TlGi8KzCzPlKUZ9jEa6dHl3CwNpIScSCcqY2LGxFvGkl5nav1A9wqTP2yGCyczU
         H4ZAjbEaztEZw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 0/3] shmem: Allow userspace monitoring of tmpfs for lack of space.
Date:   Sun, 27 Mar 2022 22:04:40 -0400
Message-Id: <20220328020443.820797-1-krisman@collabora.com>
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

 Documentation/ABI/testing/sysfs-fs-tmpfs |  13 +++
 include/linux/shmem_fs.h                 |   7 ++
 mm/shmem.c                               | 102 ++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-tmpfs

-- 
2.35.1

