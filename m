Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA62C3E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 11:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgKYKqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 05:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgKYKqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:46:31 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so929035plt.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnc8KDiJS9zJVO+Q3qSYUmt23FwsXfv4q0DMPASNe/4=;
        b=hFgJiBMYmJoJULShPIPuNFObtOlQO+AXKCh474EiOXcrsBhvo0VhQkwhhJVtQAZqZk
         KO72BkCsbeQQdg6QJBJxCj+LBm+FCX71GnzLpo9XMN9OeG1vV7dL1U8dqpMRAcghKJ5i
         IemwfKQP8vatixmdSVbbnj73OWA7K6TEC5ZMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnc8KDiJS9zJVO+Q3qSYUmt23FwsXfv4q0DMPASNe/4=;
        b=FSBe+ugTa9AUTH/kFtsiRD9IBnFZzqskqk78J0AxEWMXsPey52S6NVytjGkUtaiHha
         PylRPEHZ8TNY775YmQs59SWV0eee1clQHQH9Von4aFZaUBK3DaKymly67Zt9jratX4++
         ISuKsGg81LDnLB+H34Vzj9Ozg8n/3OjWy2ynBSWbD+Ddbi2pP0Dy1j3FS2QyCiqf2hNC
         kjbLEWmqdLtWY+OcNgf7mQmLMwL7b25AFT0qA/lSDtk585Yj0bSvHjoNBYBHEvqDQclC
         RemoQsybW7PReYOVdqYHaUl7aOGZh0CLCjF0BYeg+Fm0+ivClzW+BXvi1bGCH9QX4avW
         BLLw==
X-Gm-Message-State: AOAM530AHNKXpJ3WCxzr3auHYxkmai2WSMgLl51dcT5ArX8QQ7uJ4lII
        Ecslv7oPvfD9++i4ir4qrIqzOfUe0s5pSQ==
X-Google-Smtp-Source: ABdhPJy3zOYU8eqY3skS39PebfD5Vf+npvbjLmqWQuDZ7tRcYejDi3+05/z0n0VIsSSSRVoDTY/fqQ==
X-Received: by 2002:a17:902:9049:b029:d5:eadd:3d13 with SMTP id w9-20020a1709029049b02900d5eadd3d13mr2481381plz.15.1606301186374;
        Wed, 25 Nov 2020 02:46:26 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p15sm2408252pjg.21.2020.11.25.02.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 02:46:25 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v1 0/3] Make overlayfs volatile mounts reusable
Date:   Wed, 25 Nov 2020 02:46:18 -0800
Message-Id: <20201125104621.18838-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The volatile option is great for "ephemeral" containers. Unfortunately,
it doesn't capture all uses. There are two ways to use it safely right now:

1. Throw away the entire upperdir between mounts
2. Manually syncfs between mounts

For certain use-cases like serverless, or short-lived containers, it is
advantageous to be able to stop the container (runtime) and start it up on
demand / invocation of the function. Usually, there is some bootstrap
process which involves downloading some artifacts, or putting secrets on
disk, and then upon invocation of the function, you want to (re)start the
container.

If you have to syncfs every time you do this, it can lead to excess
filesystem overhead for all of the other containers on the machine, and
stall out every container who's upperdir is on the same underlying
filesystem, unless your filesystem offers something like subvolumes,
and if sync can be restricted to a subvolume.

The kernel has information that it can use to determine whether or not this
is safe -- primarily if the underlying FS has had writeback errors or not.
Overlayfs doesn't delay writes, so the consistency of the upperdir is not
contingent on the mount of overlayfs, but rather the mount of the
underlying filesystem. It can also make sure the underlying filesystem
wasn't remounted. Although, it was suggested that we use derive this
information from the upperdir's inode[1], we can checkpoint this data on
disk in an xattr.

Specifically we checkpoint:
  * Superblock "id": This is a new concept introduced in one of the patches
    which keeps track of (re)mounts of filesystems, by having a per boot
    monotonically increasing integer identifying the superblock. This is
    safer than trying to obfuscate the pointer and putting it into an
    xattr (due to leak risk, and address reuse), and during the course
    of a boot, the u64 should not wrap.
  * Overlay "boot id": This is a new UUID that is overlayfs specific,
    as overlayfs is a module that's independent from the rest of the
    system and can be (re)loaded independently -- thus it generates
    a UUID at load time which can be used to uniquely identify it.
  * upperdir / workdir errseq: A sample of the errseq_t on the workdir /
    upperdir's superblock. Since the errseq_t is implemented as a u32
    with errno + error counter, we can safely store it in a checkpoint.

This has to be done in kernelspace because userspace does not have access
to information such as superblock (re)mounts, the writeback errseq value,
and whether the module has been (re)loaded. Although this mechanism only
determines a subset of the error scenarios, it lays out the groundwork
for adding more.

In the future, we may want to make it so overlayfs shuts down on errors,
or have some kind of other behaviour when errors are detected. If we want
a per-file (on the upperdir) piece of metadata can be added indicating
errseq_t for just that file, and we can check it on each close / open,
and then allow the user to make an intelligent decision of how they want
overlayfs to handle the error. This would allow for errors to be captured
during normal operation as opposed to just between remounts.

RFC [2]:
 * Changed datastructure names
 * No longer delete the volatile dir / dirty file
 * Moved xattr to volatile directory
 * Split errseq check

[1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhadzC3-kh-igfxv3pAmC3ocDtAQTxByu4hrn8KtZuieQ@mail.gmail.com/
[2]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#t

Sargun Dhillon (3):
  fs: Add s_instance_id field to superblock for unique identification
  overlay: Add the ability to remount volatile directories when safe
  overlay: Add rudimentary checking of writeback errseq on volatile
    remount

 Documentation/filesystems/overlayfs.rst |  6 +-
 fs/overlayfs/overlayfs.h                | 38 +++++++++-
 fs/overlayfs/readdir.c                  | 94 +++++++++++++++++++++----
 fs/overlayfs/super.c                    | 75 +++++++++++++++-----
 fs/overlayfs/util.c                     |  2 +
 fs/super.c                              |  3 +
 include/linux/fs.h                      |  7 ++
 7 files changed, 193 insertions(+), 32 deletions(-)

-- 
2.25.1

