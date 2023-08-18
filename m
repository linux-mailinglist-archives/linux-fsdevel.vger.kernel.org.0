Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC9780D5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377612AbjHROBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377636AbjHROBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431324227
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 07:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CBA63E1C
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 14:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A99C433C7;
        Fri, 18 Aug 2023 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692367253;
        bh=ulm55Gh8T2xyKmjdI67Gsf8ZMlqy0FiWoI1/gaMGCQY=;
        h=From:Subject:Date:To:Cc:From;
        b=gX3nB8krTyBF1cJp34AlKJQoTYm59w+PIZ2Tt4VBzUTB0bCU9uGNpdE9PQf51qXLW
         H1cOaFaqupzR3XMHtsrzB+mfaNJFEWqvFx51eJHwfXWI6CjmjkvBZ8xj04x9P/Ax4l
         DEwqm4z4bFzHpir3JLWnBau/rNo85wisTMp/NqTeC2uXtqEOr/Vgin6bxHo1B19DEd
         oB3cDU7z4i3DdQZl/shPbHK0TNHdBdGc3Q9Ov0RjRTDILk06yw8XiL78Gvg/dkQ83F
         fT3cdktfTtXVaCHtOiqtVoJe/N7TSxMahozmjjJQOMyf7AB1C32Mpq5likYNXKgFxo
         4VmIZ3s7OZbtA==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/4] super: allow waiting without s_umount held
Date:   Fri, 18 Aug 2023 16:00:47 +0200
Message-Id: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9532QC/22NzQrCMBAGX0Vydkua9NeT7yEe0mTTBqUtWQ1K6
 bubFASFHj92Z2ZhhN4hsdNhYR6DIzeNccjjgelBjT2CM3EzwYXkTV5BsAT0nNGDdS8kCBKs0NZ
 WeStUyVkEZ4/bLXKXa9ydIoTOq1EPSRUN2WZIv4Ojx+TfWz/kifim6r1UyIEDr4xBrWpett35h
 n7Eezb5nqVWEL+OZtchokMb1RVlK4u2kX+OdV0/IwZJNhUBAAA=
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ulm55Gh8T2xyKmjdI67Gsf8ZMlqy0FiWoI1/gaMGCQY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTcr5w8Jy8t6PeKfIfv5yz1+RzP3Wjb2sL3SexxhiB7afQu
 hVLfjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImk5zAynJeXW/6wyU3G+YvC/sdO9/
 hkP99MF/7ks3xRx9FZgm7+EowM6/YpMWxW7Cl2jvji8nPpF9637AJnbijNDHN8GZsrtOEELwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- Improve super_lock() description.
- Use full barrier in super_wake() to ensure that waitqueue_active()
  check works as expected.
- Simplify grab_super_dead().
- Link to v2: https://lore.kernel.org/r/20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org

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
 fs/super.c         | 377 +++++++++++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |   2 +
 4 files changed, 286 insertions(+), 99 deletions(-)
---
base-commit: f3aeab61fb15edef1e81828da8dbf0814541e49b
change-id: 20230816-vfs-super-fixes-v3-f2cff6192a50

