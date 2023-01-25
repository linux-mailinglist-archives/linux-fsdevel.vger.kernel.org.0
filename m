Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBB67B5E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjAYP3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjAYP3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:34 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8C2BEC2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:29 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-3EfvZVd9OROi4KMasCLRNA-1; Wed, 25 Jan 2023 10:29:25 -0500
X-MC-Unique: 3EfvZVd9OROi4KMasCLRNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ECAC802D1B;
        Wed, 25 Jan 2023 15:29:25 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2FF2026D4B;
        Wed, 25 Jan 2023 15:29:23 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 0/6] proc: Add allowlist for procfs files
Date:   Wed, 25 Jan 2023 16:28:47 +0100
Message-Id: <cover.1674660533.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch expands subset= option. If the proc is mounted with the
subset=allowlist option, the /proc/allowlist file will appear. This file
contains the filenames and directories that are allowed for this
mountpoint. By default, /proc/allowlist contains only its own name.
Changing the allowlist is possible as long as it is present in the
allowlist itself.

This allowlist is applied in lookup/readdir so files that will create
modules after mounting will not be visible.

Compared to the previous patches [1][2], I switched to a special virtual
file from listing filenames in the mount options.

[1] https://lore.kernel.org/lkml/20200604200413.587896-1-gladkov.alexey@gmail.com/
[2] https://lore.kernel.org/lkml/YZvuN0Wqmn7XB4dX@localhost.localdomain/

Signed-off-by: Alexey Gladkov <legion@kernel.org>

---

Alexey Gladkov (6):
  proc: Fix separator for subset option
  proc: Add allowlist to control access to procfs files
  proc: Check that subset= option has been set
  proc: Allow to use the allowlist filter in userns
  proc: Validate incoming allowlist
  doc: proc: Add description of subset=allowlist

 Documentation/filesystems/proc.rst |  10 +
 fs/proc/Kconfig                    |  10 +
 fs/proc/Makefile                   |   1 +
 fs/proc/generic.c                  |  15 +-
 fs/proc/inode.c                    |  16 +-
 fs/proc/internal.h                 |  33 ++++
 fs/proc/proc_allowlist.c           | 300 +++++++++++++++++++++++++++++
 fs/proc/root.c                     |  36 +++-
 include/linux/proc_fs.h            |  18 +-
 9 files changed, 420 insertions(+), 19 deletions(-)
 create mode 100644 fs/proc/proc_allowlist.c

-- 
2.33.6

