Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E94BC853
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiBSL4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 06:56:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbiBSL4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:56:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5714838F;
        Sat, 19 Feb 2022 03:55:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEAC0CE3511;
        Sat, 19 Feb 2022 11:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525BDC004E1;
        Sat, 19 Feb 2022 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645271743;
        bh=P5bMGViFQATYGNW7coVx5woNHyLgyqDagrUfjkU24+s=;
        h=From:To:Cc:Subject:Date:From;
        b=Ohe4zpH+388At8/83N0p2OlU8w5kYXVWcR80OABGUi9vcxl9s3QcH2hVKqLE7KVMp
         RZQOqdZUVE4gp6dMyUX0z38011/t1JKvKtIirsg3P233cotRhEdAzaAhMjieZ68egR
         syvN+sNp7fk4des4AWNGeV5UI4jSyHTTrx1R9FjzB4RlCLeaFUUyLWq7ZEkP5tAkYZ
         w28/dhpMHKdHHC5dfE7iA2YWExWHQul3B0FtSuBXZhxqmEOPRP7dmyz1RBsGlw520Q
         tirLMgH5ZlgYnjcnAdsmBU6lO52864fIXgYQYsyxpAwR8Ui0RQnCHL2AGtJT8lR7jv
         ADN+mISnkNmLg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs mount_setattr for v5.17-rc4
Date:   Sat, 19 Feb 2022 12:53:29 +0100
Message-Id: <20220219115327.3635609-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This contains a fix for one of the selftests for the mount_setattr syscall to
create idmapped mounts, an entry for idmapped mounts for maintainers, and
missing kernel documentation for the helper we split out some time ago to get
and yield write access to a mount when changing mount properties.
There's additional cleanup to simplify the codeflow when (recursively) changing
mount properties which can simply be delayed until the next merge window. I've
been traveling so sending PRs is a bit delayed.

/* Testing */
All patches are based on v5.17-rc2 and have been sitting in linux-next. No
build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts showed up doing a test-merge
with current mainline.

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.v5.17-rc4

for you to fetch changes up to 538f4f022a4612f969d5324ee227403c9f8b1d72:

  fs: add kernel doc for mnt_{hold,unhold}_writers() (2022-02-14 08:35:32 +0100)

Please consider pulling these changes from the signed fs.mount_setattr.v5.17-rc4 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.mount_setattr.v5.17-rc4

----------------------------------------------------------------
Christian Brauner (3):
      tests: fix idmapped mount_setattr test
      MAINTAINERS: add entry for idmapped mounts
      fs: add kernel doc for mnt_{hold,unhold}_writers()

 MAINTAINERS                                        |  9 +++++++
 fs/namespace.c                                     | 30 ++++++++++++++++++++++
 .../selftests/mount_setattr/mount_setattr_test.c   |  4 +--
 3 files changed, 41 insertions(+), 2 deletions(-)
