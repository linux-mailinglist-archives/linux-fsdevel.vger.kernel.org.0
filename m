Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492959E4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiHWOFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 10:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbiHWODN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BC246D1B;
        Tue, 23 Aug 2022 04:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AACC1B81CDF;
        Tue, 23 Aug 2022 11:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9F5C433C1;
        Tue, 23 Aug 2022 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661253086;
        bh=Cr71rbw2QKa1GgTguWD1/W1clah6GGFBnmaf1zDGog4=;
        h=From:To:Cc:Subject:Date:From;
        b=W4p9Pt2Z1RqzeMPYwkaxh7JLcaOoVn/rmPJG0ZdkASFPi17sxQTGq2mpxXUFVoQbP
         kFZHjNokpMedp4LcQL3IfaNZto5h99eV6lj8NTxvmMG01QpkS3ESNIcJfwjw3iURZ6
         nUU6IjcEU+Nq0EytwU0AGrZcPZ5RRU3GVuW+l8tx95tzSc5el1qrvEt9UbEvJJ6Orh
         ytbOwfO1mCp+bqLUfDw7/lRq3gcSdXpASkL6aipVcmTauCp89bIzsFsYbqfIP2UUmy
         HF3OOVh4b//98AyuABg/7BMZQX3kfqWdqdpzjqAiJoLUMqlGZe6/0hlv8ZAlI5w75V
         MFj6Ru7b9eocg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] file_remove_privs() fix for v6.0-rc3
Date:   Tue, 23 Aug 2022 13:10:56 +0200
Message-Id: <20220823111056.858797-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=brauner@kernel.org; h=from:subject; bh=Cr71rbw2QKa1GgTguWD1/W1clah6GGFBnmaf1zDGog4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSzbN0u/mhH58L/MWseqG9+bfKhb+o3y5dzn5wIfMqd9Kra 6EHW/Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3F/I8N+nr/P5iW6XfzO3Bu/T1c qwvvvaPqVnfl3U+j8HKtaV3E9i+B+0gFvtldbmyGhF4+/3n7xyzOL8dvzhI3ZDZradDT3MLpwA
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
As part of Stefan's and Jens' work to add async buffered write support to xfs
we refactored file_remove_privs() and added __file_remove_privs() to avoid
calling __remove_privs() when IOCB_NOWAIT is passed.

While debugging a recent performance regression report I found that during
review we missed that faf99b563558 ("fs: add __remove_file_privs() with flags
parameter") accidently changed behavior when dentry_needs_remove_privs()
returns zero. Before the commit it would still call inode_has_no_xattr()
setting the S_NOSEC bit and thereby avoiding even calling into
dentry_needs_remove_privs() the next time this function is called. After that
commit inode_has_no_xattr() would only be called if __remove_privs() had to be
called. Restore the old behavior. This is likely the cause of the performance
regression.

/* Testing */
All patches are based on v6.0-rc1 and have been sitting in linux-next. No build
failures or warnings were observed and fstests, selftests, and LTP have seen no
regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc3

for you to fetch changes up to 41191cf6bf565f4139046d7be68ec30c290af92d:

  fs: __file_remove_privs(): restore call to inode_has_no_xattr() (2022-08-18 09:39:33 +0200)

Please consider pulling these changes from the signed fs.fixes.v6.0-rc3 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.fixes.v6.0-rc3

----------------------------------------------------------------
Stefan Roesch (1):
      fs: __file_remove_privs(): restore call to inode_has_no_xattr()

 fs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
