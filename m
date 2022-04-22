Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99750B597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446888AbiDVKzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiDVKzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D15548C;
        Fri, 22 Apr 2022 03:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D3D61EFC;
        Fri, 22 Apr 2022 10:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EABDC385A0;
        Fri, 22 Apr 2022 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650624761;
        bh=5VwyYniTmCuQGdWotOwqSqZfCYpUDVP0/iwsTYfqbVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qgO14iWVtksDIiVwfqIB09zIwGVrKZWHCeJrfjJcsOTOkAIO0FfTcervnhUsWXnIi
         5K8RPQenrDqA8r8z2oUbykCcngz4THZiT4LNdUGq8YNe9hodk7GeMmqOVvLuBUHCGK
         Befb+s7cz9x+oxZBv/uyb/crKJn6r+lnbbVIlwUxXHYG8UbyJ/2hy6ULKfLMhSTr3Z
         vRIyPmMb/0E1+vdzt7wtjDuHwVv4lYuGAR9IowSlxt1SPsJhy0b734T+kFIrLih308
         Zq+NybQXNDfxUqzpvmpWLtNZvT4W6fuPnmxoyqgdhVredf+w8dyLgFhkogee7NRSx5
         I5VJKgiQNQm4g==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs: MNT_WRITE_HOLD fix
Date:   Fri, 22 Apr 2022 12:52:31 +0200
Message-Id: <20220422105231.197721-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Linus,

/* Summary */
The recent cleanup in e257039f0fc7 ("mount_setattr(): clean the control flow
and calling conventions") switched the mount attribute codepaths from do-while
to for loops as they are more idiomatic when walking mounts.

However, we did originally choose do-while constructs because if we request a
mount or mount tree to be made read-only we need to hold writers in the
following way: The mount attribute code will grab lock_mount_hash() and then
call mnt_hold_writers() which will _unconditionally_ set MNT_WRITE_HOLD on the
mount.

Any callers that need write access have to call mnt_want_write(). They will
immediately see that MNT_WRITE_HOLD is set on the mount and the caller will
then either spin (on non-preempt-rt) or wait on lock_mount_hash() (on
preempt-rt).

The fact that MNT_WRITE_HOLD is set unconditionally means that once
mnt_hold_writers() returns we need to _always_ pair it with
mnt_unhold_writers() in both the failure and success paths.

The do-while constructs did take care of this. But Al's change to a for loop in
the failure path stops on the first mount we failed to change mount attributes
_without_ going into the loop to call mnt_unhold_writers().

This in turn means that once we failed to make a mount read-only via
mount_setattr() - i.e. there are already writers on that mount - we will block
any writers indefinitely. Fix this by ensuring that the for loop always unsets
MNT_WRITE_HOLD including the first mount we failed to change to read-only. Also
sprinkle a few comments into the cleanup code to remind people about what is
happening including myself. After all, I didn't catch it during review.

This is only relevant on mainline and was reported by syzbot. Details about the
syzbot reports are all in the commit message.

/* Testing */
All patches are based on v5.18-rc3 and have been sitting in linux-next. No
build failures or warnings were observed. Syzbot was unable to reproduce the
issue with this patch applied.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.fixes.v5.18-rc4

for you to fetch changes up to 0014edaedfd804dbf35b009808789325ca615716:

  fs: unset MNT_WRITE_HOLD on failure (2022-04-21 17:57:37 +0200)

Please consider pulling these changes from the signed fs.fixes.v5.18-rc4 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.fixes.v5.18-rc4

----------------------------------------------------------------
Christian Brauner (1):
      fs: unset MNT_WRITE_HOLD on failure

 fs/namespace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)
