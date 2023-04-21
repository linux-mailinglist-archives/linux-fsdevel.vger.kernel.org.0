Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8026EABEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjDUNnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjDUNmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201861386C;
        Fri, 21 Apr 2023 06:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E7A616E9;
        Fri, 21 Apr 2023 13:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32791C433EF;
        Fri, 21 Apr 2023 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682084521;
        bh=jsN16Cs8YsE77h9jjLEg6GRIme2CQpBrwqLQqDJd2TQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JNn1DqAbNx/sCs/osw5eIeOedCZVdloVIQo9EhPsYfTNj3HmFkVv/m43vOH5beif6
         vaYLCAtdjcIF6mod/8BpKqSg7Dqhpvs9L0+UH68IZ8RGWVv6AdrDEDANMd/x+AdRKL
         5nwqm4HJRu9y3RLi2PY/NVlciFSQv0+fhS02th9Jw7yMru8lHNc5VSM8tyBN61dCA+
         usXloyPOuciyHmpABQk8tKSykCsGT8r1MKlaILdk+5zdmIIDso+C8xWz1gfWArJw8V
         k6qsAopG5fhOlg+QqbjyXJHiR0toLNZCoYbk6RkXQ+c4ntim1hKzj1XLPforMFlEJH
         SmC/QhxcC0cbQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pidfd updates
Date:   Fri, 21 Apr 2023 15:41:10 +0200
Message-Id: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=brauner@kernel.org; h=from:subject:message-id; bh=jsN16Cs8YsE77h9jjLEg6GRIme2CQpBrwqLQqDJd2TQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ4Tfy1OuXJjEcvXBwfnbry4m3250vnTTL4LSOr/1+12yez fOLeix2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATsZNi+O8YtvTPjkVFjsvevOw6c3 pTt8G639cM+X7t77yZKH/UKTaPkeGL1hPBYuHrt37ePcE6wdp4Rc+ilPR3kgd3eRWuW/9mfTQHAA==
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
This adds a new pidfd_prepare() helper which allows the caller to
reserve a pidfd number and allocates a new pidfd file that stashes the
provided struct pid.

It should be avoided installing a file descriptor into a task's file
descriptor table just to close it again via close_fd() in case an
error occurs. The fd has been visible to userspace and might already be
in use. Instead, a file descriptor should be reserved but not installed
into the caller's file descriptor table.

If another failure path is hit then the reserved file descriptor and
file can just be put without any userspace visible side-effects. And if
all failure paths are cleared the file descriptor and file can be
installed into the task's file descriptor table.

This helper is now used in all places that open coded this functionality
before. For example, this is currently done during copy_process() and
fanotify used pidfd_create(), which returns a pidfd that has already
been made visibile in the caller's file descriptor table, but then
closed it using close_fd().

In one of the next merge windows there is also new functionality coming
to unix domain sockets that will have to rely on pidfd_prepare().

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc4 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/pidfd.file

for you to fetch changes up to eee3a0e93924f2aab8ebaa7f2e26fd0f3b33f9e7:

  fanotify: use pidfd_prepare() (2023-04-03 11:16:57 +0200)

Please consider pulling these changes from the signed v6.4/pidfd.file tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/pidfd.file

----------------------------------------------------------------
Christian Brauner (3):
      pid: add pidfd_prepare()
      fork: use pidfd_prepare()
      fanotify: use pidfd_prepare()

 fs/notify/fanotify/fanotify_user.c | 13 +++--
 include/linux/pid.h                |  1 +
 kernel/fork.c                      | 98 +++++++++++++++++++++++++++++++++-----
 kernel/pid.c                       | 19 +++-----
 4 files changed, 104 insertions(+), 27 deletions(-)
