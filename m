Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D504530D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiEWJjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiEWJjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 05:39:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75A19FA8;
        Mon, 23 May 2022 02:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE52CB8100E;
        Mon, 23 May 2022 09:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B0AC385A9;
        Mon, 23 May 2022 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653298749;
        bh=aIcyCgc/p2LLDrwfgKccbx8NoqUUFgJUGse71d3Ph6A=;
        h=From:To:Cc:Subject:Date:From;
        b=ThRxU4lXguBLpElKHUAOrgCi0JRy5qGht+sb6hj7xuoDx7P/LaQcOX3edf248xs2H
         CkjU5JZgxg4DosqkpAXGV/7h2blatfFNEXwbbmEZ5FoiyZY7vyYG//5GAzlakBCoV7
         H/aw+2EUWsXXy1NGtw8Nr8LcZv6uFUzh7xbrkhmpwg4qH5Meh0Iq9PWyriUAvhzPiO
         5KGuZGz85XVn6mn7iHtusETXY4O7LfajSYWBLCTFdV1A1fMJZsCSsXCZAHNw9VYw+/
         pELyvK5GIY65wcUrwgpJoO3i2Aw8aMGDXz+ZJYCiPB0xVXhxfcCzlEgEZDIWzTOajp
         eW/9knL4UuLZg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs idmapped mount updates for v5.19
Date:   Mon, 23 May 2022 11:38:36 +0200
Message-Id: <20220523093835.1096673-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains two minor updates:

* An update to the idmapping documentation by Rodrigo making it easier to
  understand that we first introduce several use-cases that fail without
  idmapped mounts simply to explain how they can be handled with idmapped
  mounts.

* When changing a mount's idmapping we now hold writers to make it more robust.

  This is similar to turning a mount ro with the difference that in contrast to
  turning a mount ro changing the idmapping can only ever be done once while a
  mount can transition between ro and rw as much as it wants.

  The vfs layer itself takes care to retrieve the idmapping of a mount once
  ensuring that the idmapping used for vfs permission checking is identical to
  the idmapping passed down to the filesystem. All filesystems with
  FS_ALLOW_IDMAP raised take the same precautions as the vfs in code-paths that
  are outside of direct control of the vfs such as ioctl()s.

  However, holding writers makes this more robust and predictable for both the
  kernel and userspace.

  This is a minor user-visible change. But it is extremely unlikely to matter.
  The caller must've created a detached mount via OPEN_TREE_CLONE and then
  handed that O_PATH fd to another process or thread which then must've gotten
  a writable fd for that mount and started creating files in there while the
  caller is still changing mount properties. While not impossible it will be an
  extremely rare corner-case and should in general be considered a bug in the
  application. Consider making a mount MOUNT_ATTR_NOEXEC or MOUNT_ATTR_NODEV
  while allowing someone else to perform lookups or exec'ing in parallel by
  handing them a copy of the OPEN_TREE_CLONE fd or another fd beneath that
  mount.

  I've pinged all major users of idmapped mounts pointing out this change and
  none of them have active writers on a mount while still changing mount
  properties. It would've been strange if they did.

The rest and majority of the work will be coming through the overlayfs tree
this cycle. In addition to overlayfs this cycle should also see support for
idmapped mounts on erofs as I've acked a patch to this effect a little while
ago.

/* Testing */
All patches are based on v5.18-rc4 and have been sitting in linux-next.
Because of the patch changing how we set a mount's idmapping we had to remove
the now invalid test 781bb995a149e ("vfs/idmapped-mounts: remove invalid test")
from xfstests (see [1]). No build failures or warnings were observed and
fstests and selftests have seen no regressions.

Link: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=781bb995a149e0dae074019e56477855587198cf [1]

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.19

for you to fetch changes up to e1bbcd277a53e08d619ffeec56c5c9287f2bf42f:

  fs: hold writers when changing mount's idmapping (2022-05-12 10:12:00 +0200)

Please consider pulling these changes from the signed fs.idmapped.v5.19 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.v5.19

----------------------------------------------------------------
Christian Brauner (1):
      fs: hold writers when changing mount's idmapping

Rodrigo Campos (1):
      docs: Add small intro to idmap examples

 Documentation/filesystems/idmappings.rst | 5 +++++
 fs/namespace.c                           | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)
