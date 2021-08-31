Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCB3FC55D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbhHaKDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:03:19 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52746
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234263AbhHaKDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:03:19 -0400
Received: from wittgenstein.fritz.box (i577BC18B.versanet.de [87.123.193.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1717E3F22F;
        Tue, 31 Aug 2021 10:02:22 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] move_mount updates
Date:   Tue, 31 Aug 2021 12:01:20 +0200
Message-Id: <20210831100119.2297736-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This contains an extension to the move_mount() syscall making it possible to
add a single private mount into an existing propagation tree.
The use-case comes from the criu folks which have been struggling with
restoring complex mount trees for a long time. Variations of this work have
been discussed at Plumbers before (e.g.,
https://www.linuxplumbersconf.org/event/7/contributions/640/).
The extension to move_mount() enables criu to restore any set of mount
namespaces, mount trees and sharing group trees without introducing yet more
complexity into mount propagation itself. The changes required to criu to make
use of this and restore complex propagation trees are available at
https://github.com/Snorch/criu/commits/mount-v2-poc. A cleaned-up version of
this will go up for merging into the main criu repo after this lands.

(In case any question come up I'll be on vacation next week so responding might
 take a while.)

/* Testing */
All patches are based on v5.14-rc3 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.move_mount.move_mount_set_group.v5.15

for you to fetch changes up to 8374f43123a5957326095d108a12c49ae509624f:

  tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest (2021-07-26 14:45:19 +0200)

Please consider pulling these changes from the signed fs.move_mount.move_mount_set_group.v5.15 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.move_mount.move_mount_set_group.v5.15

----------------------------------------------------------------
Pavel Tikhomirov (2):
      move_mount: allow to add a mount into an existing group
      tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest

 fs/namespace.c                                     |  77 ++++-
 include/uapi/linux/mount.h                         |   3 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/move_mount_set_group/.gitignore      |   1 +
 .../selftests/move_mount_set_group/Makefile        |   7 +
 .../testing/selftests/move_mount_set_group/config  |   1 +
 .../move_mount_set_group_test.c                    | 375 +++++++++++++++++++++
 7 files changed, 463 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/move_mount_set_group/.gitignore
 create mode 100644 tools/testing/selftests/move_mount_set_group/Makefile
 create mode 100644 tools/testing/selftests/move_mount_set_group/config
 create mode 100644 tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
