Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27052D1EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLHAcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:32:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:32:09 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 62A9B1F44AF4;
        Tue,  8 Dec 2020 00:31:26 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/8] Superblock Notifications
Date:   Mon,  7 Dec 2020 21:31:09 -0300
Message-Id: <20201208003117.342047-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

After the two previous RFCs this is an attempt to get the ball spinning
again.

The problem I'm trying to solve is providing an interface to monitor
filesystem errors.  This patchset includes an example implementation of
ext4 error notification.  This goes obviously on top of the watch_queue
mechanism.

Regarding the buffer overrun issue that would require fsinfo or another
method to expose counters, I think they can be added at a later date
with no change to what this patch series attempts to do, therefore I'm
proposing we don't wait for fsinfo before getting this merged.

I mostly tested this with the samples program I have published in the
last patch.  In addition I will be sharing a patchset shortly with
proper documentation and some selftests for the feature.

David, can you please reply to this patchset? What do you think about
the watch_queue modifications I'm proposing?  I really don't want to
waste more time on this code if it doesn't fit the watch_queue API.  Can
I have some guidance in having this upstreamed?

In addition, I'm carrying "watch_queue: Make watch_sizeof() check record
size" on this patchset for now, but is it in anyone's tree going to
Linus any time soon?  I haven't found it.

I also shared this patchset in a branch at:

  Repo: https://gitlab.collabora.com/krisman/linux.git -b notifications

Previous RFC submissions can be found at:

RFC: https://www.spinics.net/lists/linux-ext4/msg74596.html
RFC v2:
https://lore.kernel.org/linux-fsdevel/20201111215213.4152354-1-krisman@collabora.com/

Original cover letter:
======================

Google has been using an out-of-tree mechanism for error notification in
Ext4 and we decided it is time to push for an upstream solution.  This
would surely fit on top of David's notification work.

This patchset is an attempt to restart that discussion.  It forward
ports
some code from David on top of Linus tree, adds features to
watch_queue and implements ext4 support.

The new notifications are designed after ext4 messages, so it exposes
notifications types to fit that filesystem, but it doesn't change much
to other filesystems, so it should be easily extensible.

I'm aware of the discussion around fsinfo, but I'd like to ask if there
are other missing pieces and what we could do to help that work go
upstream.  From a previous mailing list discussion, Linus complained
about lack of users as a main reason for it to not be merged, so hey! :)

In addition, I'd like to ask for feedback on the current implementation,
specifically regarding the passing of extra unformatted information at
the end of the notification and the ext4 support.

The work, as shared on this patchset can be found at:

  https://gitlab.collabora.com/krisman/linux.git -b
  ext4-error-notifications

And there is an example code at:

  https://gitlab.collabora.com/krisman/ext4-watcher

I'm Cc'ing Khazhismel Kumykov, from Google, who can provide more
information about their use case, if requested.

David Howells (3):
  watch_queue: Make watch_sizeof() check record size
  security: Add hooks to rule on setting a watch for superblock
  vfs: Add superblock notifications

Gabriel Krisman Bertazi (5):
  watch_queue: Support a text field at the end of the notification
  vfs: Include origin of the SB error notification
  fs: Add more superblock error subtypes
  ext4: Implement SB error notification through watch_sb
  samples: watch_queue: Add sample of SB notifications

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/Kconfig                             |  12 ++
 fs/ext4/super.c                        |  31 +++--
 fs/super.c                             | 127 +++++++++++++++++++++
 include/linux/fs.h                     | 150 +++++++++++++++++++++++++
 include/linux/lsm_hook_defs.h          |   1 +
 include/linux/lsm_hooks.h              |   4 +
 include/linux/security.h               |  13 +++
 include/linux/syscalls.h               |   2 +
 include/linux/watch_queue.h            |  21 +++-
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/watch_queue.h       |  54 ++++++++-
 kernel/sys_ni.c                        |   3 +
 kernel/watch_queue.c                   |  29 ++++-
 samples/watch_queue/Makefile           |   2 +-
 samples/watch_queue/watch_sb.c         | 114 +++++++++++++++++++
 security/security.c                    |   6 +
 18 files changed, 556 insertions(+), 19 deletions(-)
 create mode 100644 samples/watch_queue/watch_sb.c

-- 
2.29.2

