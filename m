Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67E773B5D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFWLD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFWLD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E07122;
        Fri, 23 Jun 2023 04:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF8561A24;
        Fri, 23 Jun 2023 11:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7636BC433C0;
        Fri, 23 Jun 2023 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687518204;
        bh=MMGjpOEua7jLGCXGS4y6BIkirEFGtAnmtFN36zX7JEc=;
        h=From:To:Cc:Subject:Date:From;
        b=rSrSkqSEmIX1jd3vzt2LmUa5L9XobG8OiHs9ljOfZRn7j8DNHX6vyV0NYnSK69lgP
         ToDv3DgOdSLEUxLMkRQcdWFII4Q5psdrIb275UjTellz6ThDc3fBS7HAOo4VX7d7ha
         qGB4CMbIuiAWxg3kFxfOphCUH1E9VqVMmr4HTo6+kqWHJedb+/8+SwQPn7j/aFAxT6
         T4LgEjDJAH6ADJEr9eHHwL5pxalY3FlHP8+pDH1GlnCUvKMGHHt6W7woS6cmIjM+jk
         StX6QSlVULdhDcDbx9az1T8NKMx40u9//ej0SDEZEfYeHFcusBYEKcx02n+OEqb6P9
         /7BtjZLHacemA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs: file
Date:   Fri, 23 Jun 2023 13:03:18 +0200
Message-Id: <20230623-waldarbeiten-normung-c160bb98bf10@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5331; i=brauner@kernel.org; h=from:subject:message-id; bh=MMGjpOEua7jLGCXGS4y6BIkirEFGtAnmtFN36zX7JEc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMrf5401hf8cPtBRkt02Qrthw4NCFH/NtC7zeeWxZImn1L 1VM/21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRCUIM/8xELoudP8ZiWBe5IuLqK9 Pk28ff7rioIdFSvKDM992SfwcYGf75/H2fxn33gvR8I20WTpeDh5Ry3ARUd0zj85+48PEWbW4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
This contains Amir's work to fix a long-standing problem where an
unprivileged overlayfs mount can be used to avoid fanotify permission
events that were requested for an inode or superblock on the underlying
filesystem.

Some background about files opened in overlayfs. If a file is opened in
overlayfs @file->f_path will refer to a "fake" path. What this means is
that while @file->f_inode will refer to inode of the underlying layer,
@file->f_path refers to an overlayfs {dentry,vfsmount} pair. The reasons
for doing this are out of scope here but it is the reason why the vfs
has been providing the open_with_fake_path() helper for overlayfs for
very long time now. So nothing new here.

This is for sure not very elegant and everyone including the overlayfs
maintainers agree. Improving this significantly would involve more
fragile and potentially rather invasive changes.

In various codepaths access to the path of the underlying
filesystem is needed for such hybrid file. The best example is fsnotify
where this becomes security relevant. Passing the overlayfs
@file->f_path->dentry will cause fsnotify to skip generating fsnotify
events registered on the underlying inode or superblock.

To fix this we extend the vfs provided open_with_fake_path() concept for
overlayfs to create a backing file container that holds the real path
and to expose a helper that can be used by relevant callers to get
access to the path of the underlying filesystem through the new
file_real_path() helper. This pattern is similar to what we do in
d_real() and d_real_inode().

The first beneficiary is fsnotify and fixes the security sensitive
problem mentioned above.

There's a couple of nice cleanups included as well.

Over time, the old open_with_fake_path() helper added specifically for
overlayfs a long time ago started to get used in other places such as
cachefiles. Even though cachefiles have nothing to do with hybrid files.

The only reason cachefiles used that concept was that files opened with
open_with_fake_path() aren't charged against the caller's open file
limit by raising FMODE_NOACCOUNT. It's just mere coincidence that both
overlayfs and cachefiles need to ensure to not overcharge the caller for
their internal open calls.

So this work disentangles FMODE_NOACCOUNT use cases and backing file
use-cases by adding the FMODE_BACKING flag which indicates that the file
can be used to retrieve the backing file of another filesystem. (Fyi,
Jens will be sending you a really nice cleanup from Christoph that gets
rid of 3 FMODE_* flags otherwise this would be the last fmode_t bit we'd
be using.)

So now overlayfs becomes the sole user of the renamed
open_with_fake_path() helper which is now named backing_file_open(). For
internal kernel users such as cachefiles that are only interested in
FMODE_NOACCOUNT but not in FMODE_BACKING we add a new kernel_file_open()
helper which opens a file without being charged against the caller's
open file limit. All new helpers are properly documented and clearly
annotated to mention their special uses.

We also rename vfs_tmpfile_open() to kernel_tmpfile_open() to clearly
distinguish it from vfs_tmpfile() and align it the other kernel_*()
internal helpers.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
There has one merge conflict:

(1) This will cause a minor merge conflict with my v6.5/vfs.misc pull
    request as we rename an internal helper that's used in cachefiles.
    I would suggest to merge v6.5/vfs.misc first.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.file

for you to fetch changes up to bc2473c90fca55bf95b2ab6af1dacee26a4f92f6:

  ovl: enable fsnotify events on underlying real files (2023-06-19 18:18:04 +0200)

Please consider pulling these changes from the signed v6.5/vfs.file tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/vfs.file

----------------------------------------------------------------
Amir Goldstein (5):
      fs: rename {vfs,kernel}_tmpfile_open()
      fs: use a helper for opening kernel internal files
      fs: move kmem_cache_zalloc() into alloc_empty_file*() helpers
      fs: use backing_file container for internal files with "fake" f_path
      ovl: enable fsnotify events on underlying real files

 fs/cachefiles/namei.c    | 10 +++---
 fs/file_table.c          | 91 +++++++++++++++++++++++++++++++++++++++---------
 fs/internal.h            |  5 +--
 fs/namei.c               | 24 +++++++------
 fs/open.c                | 76 ++++++++++++++++++++++++++++++++++------
 fs/overlayfs/file.c      |  8 ++---
 fs/overlayfs/overlayfs.h |  5 +--
 include/linux/fs.h       | 42 +++++++++++++++++-----
 include/linux/fsnotify.h |  4 ++-
 9 files changed, 204 insertions(+), 61 deletions(-)
