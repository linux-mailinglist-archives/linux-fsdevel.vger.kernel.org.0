Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1125F780A85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347002AbjHRKyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376449AbjHRKyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D371121
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 03:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECA0658E8
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB3BC433C8;
        Fri, 18 Aug 2023 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356062;
        bh=JTlo8VVlWWxiNVXMng/QL2SrVEYO1T88dCf3mXkeeDc=;
        h=From:Subject:Date:To:Cc:From;
        b=ujMcsyllZj9yGYossqqJeygND11Bx5xUNoo6a+hWwvj3qJVr5abPPbFWUMm7efFQG
         Ung2beoP4Xi2b1gH7eSVXy0UB/WQCbS6W5/At5jYQX7vdT/piIdnnd4McRdkU6RG5q
         iO0tDurkWB7hA56JJEVqgSbaevTrEX3k5bkDAbHQsstkVwhwE7MQVlJdZhwpoPsvKl
         6pyIq45Cj4aKDOIgMPJ4mWjb2qD6HKbs0DtweJ3kmEFvA41YtIRv4dsvYLQoAomhTA
         rLVB5ZMlEj2njnaH8ryjgRwBjHVXfEW/vlbxddbxz3pPm01K8x4474JQDmnQyhMRF1
         cXqJj7A5rvRWw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/4] super: allow waiting without s_umount held
Date:   Fri, 18 Aug 2023 12:54:14 +0200
Message-Id: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZN32QC/22NQQ6CMBBFr0K6dkhbAogr72FYlDKFRlPIjDYaw
 t1tSdy5fJl5/22CkTyyuBSbIIye/RIS6FMh7GzChODHxEJLXcmzaiA6Bn6tSOD8GxliBU5b5xr
 VaVNLkcSV8Lgl79YnHgwjDGSCnfNUWiiPhfw7e34u9Dn6UWXjl2r/paICCbIZR7SmlXU3XO9IA
 R/lQpPo933/AkTY/qbRAAAA
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JTlo8VVlWWxiNVXMng/QL2SrVEYO1T88dCf3mXkeeDc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc972TaOEj4tyvcTjv+4ZDaWs2P1oQ4Z34ZrHph4NW7zfq
 ++yO6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIzQRGhtlfcy1OzlhwwLSPp+ZUei
 nnk2SNCerv5ro8/tn1pfKEPgPD/0pWo0jXLrYfyh2mpQ+mZL3PuSj9qiCEY4rT8bf8xyyS+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This is an attempty to allow concurrent mounters and iterators to wait
on superblock state changes without having to hold s_umount. This is
made necessary by recent attempts to open block devices after superblock
creation and fixing deadlocks due to blkdev_put() trying to acquire
s_umount while s_umount is already held.

This is on top of Jan's and Christoph's work in vfs.super. Obviously not
for v6.6. I hope I got it right but this is intricate. 

It reliably survives xfstests for btrfs, ext4, and xfs while
concurrently having 7 processes running ustat() hammering on
super_blocks and a while true loop that tries to mount a filsystem with
an invalid superblock hammering on sget{_fc}() concurrently as well.
Even with inserting an arbitrary 5s delay after generic_shutdown_super()
and blkdev_put() things work fine.

Thanks and don't hit me over the head with things.
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Rename various functions according to Jan's and Willy's suggestions.
- Remove smp_wmb() as smp_store_release() is enough.
- Remove hlist_unhashed() checks now that we wait on SB_DYING.
- Link to v1: https://lore.kernel.org/r/20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org

---
Christian Brauner (4):
      super: use locking helpers
      super: make locking naming consistent
      super: wait for nascent superblocks
      super: wait until we passed kill super

 fs/fs-writeback.c  |   4 +-
 fs/internal.h      |   2 +-
 fs/super.c         | 404 ++++++++++++++++++++++++++++++++++++++++-------------
 include/linux/fs.h |   2 +
 4 files changed, 313 insertions(+), 99 deletions(-)
---
base-commit: f3aeab61fb15edef1e81828da8dbf0814541e49b
change-id: 20230816-vfs-super-fixes-v3-f2cff6192a50

