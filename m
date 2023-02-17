Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40E69A697
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 09:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQIIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 03:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBQIIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400F83DB;
        Fri, 17 Feb 2023 00:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB5DF61367;
        Fri, 17 Feb 2023 08:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ACCC433EF;
        Fri, 17 Feb 2023 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676621292;
        bh=1tZ+3TFecSQ3IVEtut7zhCs7lc946Ne7uuPQLtmfjFk=;
        h=From:To:Cc:Subject:Date:From;
        b=i0vEldRgfcs738LMN75oq4/6ImXq6u2NV4qrJjXv7X8CtBGk28CphX7zdxr8Q9y4J
         24WRcMvVGCjegm1DgQXHkmTo/vgscQqicahD4yT2poHv2fKfEvHlsMxBg0kq7FA1Bj
         DOCnPANYcSFwhv5AQ+Frf+UYaWydZ1oZMwGzkKll8TiqTXdXz9x93ie2L+vWlpdbwI
         kvd9QUAIbVbD37UNB+/vPb21/l6xr+GcKqr9BNlmbVQO7AQm0EU3rmFVkyWxjvKxoT
         ceF/wQNNKwjTPdIbhJFlbmWc5NdB2A0UCqJAYAqaHS3dRl6LlB4E7wl+wIPYHcX8DI
         W1UCnavjpcZRA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs updates for v6.3
Date:   Fri, 17 Feb 2023 09:07:55 +0100
Message-Id: <20230217080755.1628990-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=brauner@kernel.org; h=from:subject; bh=1tZ+3TFecSQ3IVEtut7zhCs7lc946Ne7uuPQLtmfjFk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS/N52xYF15WDHjvByWf7pViXs/28S5bg0zrs9P2h33pOB2 euTrjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImw/GP47/v0ou9cI7Wjiuq/ulg9WM 1MZ7VrzLggKno7acfebQGV+gx/xXKEJu1xrPY3Nbw4lUnNI6dCMkX82pk78nd9bqmn77NkBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
Jan pointed out that during shutdown both filp_close() and super block
destruction will use basic printk logging when bugs are detected. This
causes issues in a few scenarios:

* Tools like syzkaller cannot figure out that the logged message
  indicates a bug.
* Users that explicitly opt in to have the kernel bug on data corruption
  by selecting CONFIG_BUG_ON_DATA_CORRUPTION should see the kernel crash
  when they did actually select that option.
* When there are busy inodes after the superblock is shut down later
  access to such a busy inodes walks through freed memory. It would be
  better to cleanly crash instead.

All of this can be addressed by using the already existing
CHECK_DATA_CORRUPTION() macro in these places when kernel bugs are
detected. Its logging improvement is useful for all users.

Otherwise this only has a meaningful behavioral effect when users do
select CONFIG_BUG_ON_DATA_CORRUPTION which means this is backward
compatible for regular users.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.2-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.v6.3

for you to fetch changes up to 47d586913f2abec4d240bae33417f537fda987ec:

  fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are detected (2023-01-27 14:17:22 +0100)

Please consider pulling these changes from the signed fs.v6.3 tag.

I'm on vacation until v6.2 is released this Sunday but Amir or Seth know
how to reach me quite easily before that in case anything goes wrong.

Thanks!
Christian

----------------------------------------------------------------
fs.v6.3

----------------------------------------------------------------
Jann Horn (1):
      fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are detected

 fs/open.c              |  5 +++--
 fs/super.c             | 21 +++++++++++++++++----
 include/linux/poison.h |  3 +++
 3 files changed, 23 insertions(+), 6 deletions(-)
