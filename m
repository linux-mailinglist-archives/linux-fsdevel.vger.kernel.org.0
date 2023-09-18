Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EED7A48E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjIRLzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbjIRLy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032E19A6;
        Mon, 18 Sep 2023 04:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC542C433C9;
        Mon, 18 Sep 2023 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695038049;
        bh=v+xypjGMEIlYAlPz2FidGLaJjBWo4XUOP393ptzMwzg=;
        h=From:To:Cc:Subject:Date:From;
        b=keiGkh7A0IvMJISs7RIF0kow9jUiEFqIi/T4bpgQniYEIfVNbOGX3g4jju3qiQUwX
         rmIoOWV/XMm2YjAn6Lp+NpYd9icMOdTd+wXl1kKOtqbk86+jvf7FAydYgS7ICTF3wD
         RnosGW1WJo7ayBvpQBfRvBj0WQ3ngPHde7/c0e9ukNI0IR9sjb/N8K70vk7xxSm7DV
         5D3+eZ8/N7RHuk1hEzwnt3MpshQoERKsdZd/pvw37ewBT8anXxoLaO/A38I+gaxWAj
         pG3grOks4WM71DX1bbl0d5XsySIeNoo5+K7FazzMrVsxsQyf6uussHM/MScg9Osrxd
         HyJsx58/yle5w==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] timestamp fixes
Date:   Mon, 18 Sep 2023 13:53:25 +0200
Message-Id: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=brauner@kernel.org; h=from:subject:message-id; bh=3jEO6GpBAHPkvujhQ7ujs4cc5WObAyG+rtu0U4VrKxU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRyWHHFiBgXuQhyfN29ekf7bWPFiRP8pvKIF99TlV+xtkJU 70J4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQSlRj+R6xdPG9bjsaPn5d3uc+vnt Qg4Z08+RPvp+pXbB/PeYt5rGf4K878stNgsl2V+OUJokd51htuZxVfeHUj+xJeloPe6fNl2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a few fixes for the multi-grain timestamps work for this cycle:

* Only update the atime if "now" is later than the current value. This
  can happen when the atime gets updated with a fine-grained timestamp
  and then later gets updated using a coarse-grained timestamp.
* Make sure setattr_copy() handles multi-grained timestamps.
* Always initialize the __i_ctime field during allocation otherwise
  inode_set_ctime_current() may skip initializing __i_ctime because the
  random value in there might be in the future.
* Fix overlayfs to always set ctime when it sets atime and mtime.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.6-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc2.vfs.ctime

for you to fetch changes up to f8edd33686154b9165457c95e2ed5943e916781e:

  overlayfs: set ctime when setting mtime and atime (2023-09-14 10:24:36 +0200)

Please consider pulling these changes from the signed v6.6-rc2.vfs.ctime tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-rc2.vfs.ctime

----------------------------------------------------------------
Jeff Layton (4):
      fs: have setattr_copy handle multigrain timestamps appropriately
      fs: initialize inode->__i_ctime to the epoch
      fs: don't update the atime if existing atime is newer than "now"
      overlayfs: set ctime when setting mtime and atime

 fs/attr.c              | 52 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/inode.c             |  6 ++++--
 fs/overlayfs/copy_up.c |  2 +-
 3 files changed, 51 insertions(+), 9 deletions(-)
