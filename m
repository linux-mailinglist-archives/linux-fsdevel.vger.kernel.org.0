Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65C4E50F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbiCWLEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 07:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiCWLEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524BAA1AA;
        Wed, 23 Mar 2022 04:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E175760EE1;
        Wed, 23 Mar 2022 11:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA50C340E8;
        Wed, 23 Mar 2022 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648033384;
        bh=oVbJJ9QFdFD559joI5q5oY5bEqqLMOcsKNGU0WOb/hY=;
        h=From:To:Cc:Subject:Date:From;
        b=ht3WKiXFMUjUyltHPG1endz5CGlYxo8pnysW7VKfsDj5T6L+aFrmfeEqjab6qzCz5
         1unGXR8hyldmQB8rNMqt+eIvbI9aq7RTobgDyxrYX4N3cgadPKB21VBb2+6+RG23K+
         ozyz8XLDrBowNo/0V9W/Pm2K35Q7Y9MuH5RPjxUAGLiNi0dWe++cotfcLBjnG1eWYe
         2wyGAj7ghAHOC5VeVtB5XhvmFVBiArwl/GDIbH5gJr0yrtwH4AIh22oit6yRW8RmMx
         kXbX5g8QvuO1eAv8YCd4cmG0VzGBPxveH7IEdWe41e4vArkBaEy2Socnhlf8xEd5VA
         hwxP3KxbSjeyg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs preempt_rt fix
Date:   Wed, 23 Mar 2022 12:02:49 +0100
Message-Id: <20220323110248.858156-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
This contains Sebastian's fix to make changing mount attributes/getting write
access compatible with CONFIG_PREEMPT_RT. The change only applies when users
explicitly opt-in to real-time via CONFIG_PREEMPT_RT otherwise things are
exactly as before. We've waited quite a long time with this to make sure folks
could take a good look.

/* Testing */
All patches are based on v5.16-rc2 and have been sitting in linux-next. No
build failures or warnings were observed and fstests and selftests have seen no
regressions caused by this patchset.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.rt.v5.18

for you to fetch changes up to 0f8821da48458982cf379eb4432f23958f2e3a6c:

  fs/namespace: Boost the mount_lock.lock owner instead of spinning on PREEMPT_RT. (2021-11-26 12:09:09 +0100)

Please consider pulling these changes from the signed fs.rt.v5.18 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.rt.v5.18

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      fs/namespace: Boost the mount_lock.lock owner instead of spinning on PREEMPT_RT.

 fs/namespace.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
