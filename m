Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB98C2942CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438031AbgJTTPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437999AbgJTTPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:15:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2D5C0613CE;
        Tue, 20 Oct 2020 12:15:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 94E161F44C1F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 0/7] Superblock notifications
Date:   Tue, 20 Oct 2020 15:15:36 -0400
Message-Id: <20201020191543.601784-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Google has been using an out-of-tree mechanism for error notification in
Ext4 and we decided it is time to push for an upstream solution.  This
would surely fit on top of David's notification work.

This patchset is an attempt to restart that discussion.  It forward ports
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

  https://gitlab.collabora.com/krisman/linux.git -b ext4-error-notifications

And there is an example code at:

  https://gitlab.collabora.com/krisman/ext4-watcher

I'm Cc'ing Khazhismel Kumykov, from Google, who can provide more
information about their use case, if requested.

David Howells (3):
  watch_queue: Make watch_sizeof() check record size
  security: Add hooks to rule on setting a watch for superblock
  vfs: Add superblock notifications

Gabriel Krisman Bertazi (4):
  watch_queue: Support a text field at the end of the notification
  vfs: Include origin of the SB error notification
  fs: Add more superblock error subtypes
  ext4: Implement SB error notification through watch_sb

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/Kconfig                             |  12 ++
 fs/ext4/super.c                        |  32 +++-
 fs/super.c                             | 127 +++++++++++++++
 include/linux/fs.h                     | 207 +++++++++++++++++++++++++
 include/linux/lsm_hook_defs.h          |   1 +
 include/linux/lsm_hooks.h              |   4 +
 include/linux/security.h               |  13 ++
 include/linux/syscalls.h               |   2 +
 include/linux/watch_queue.h            |  21 ++-
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/watch_queue.h       |  68 +++++++-
 kernel/sys_ni.c                        |   3 +
 kernel/watch_queue.c                   |  29 +++-
 security/security.c                    |   7 +
 16 files changed, 514 insertions(+), 18 deletions(-)

-- 
2.28.0

