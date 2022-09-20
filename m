Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314B5BE3DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiITKyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiITKyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501D6BCE1;
        Tue, 20 Sep 2022 03:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DED62554;
        Tue, 20 Sep 2022 10:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90244C433C1;
        Tue, 20 Sep 2022 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663671239;
        bh=4s+A0uYH2NDzk3cUu+6aMBlQzRJ+8g45TxmZX6PVPBU=;
        h=From:To:Cc:Subject:Date:From;
        b=qyzjAcNb1I81boB5q8hZQCXLbH+Su0haoR1d1jkh4RJWt4c14qfWDl4P28Cdemdv0
         8qNp8lCMe3SS4AbnyFFcjy+VnuRiaE/2UBHlYrIvJRS/hcerAWsf6lLm6/6BMOFYNk
         zu/5BgysySw6HDwSuCQoO32+rA6GogetvMQL5S6rguPRs8+Vdh2i91tVxPpHzZJRwY
         reni+zMPukY8tWfyd+F5C1CUPqFyAt9HeLSVO/2z30pszek1pERzfk9lH7qtnwSmCz
         msCU6Y494mHh1VpWkclB/VynDz+vKf3Zr19STYF/eOyzsHX7hK98KqlM/COw+po7JF
         ZtVqryhvEVFgw==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs fixes for v6.0-rc7
Date:   Tue, 20 Sep 2022 12:51:10 +0200
Message-Id: <20220920105109.1315345-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; i=brauner@kernel.org; h=from:subject; bh=4s+A0uYH2NDzk3cUu+6aMBlQzRJ+8g45TxmZX6PVPBU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRrzhZ391nSY8Dw2e72To7Xtd+8iovO7lm/clbEk3qurbPX 7T39p6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiAaWMDCtnq3ZMOtTctUt+q/kGJm HbHSy5kYqrmx0iU+rs709KS2Bk2F6UHXuGdd2tFNdnv1yrLQIOun/89Zih2//TuQgztaxP/AA=
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
Beginning of the merge window we introduced the vfs{g,u}id_t types in
b27c82e12965 ("attr: port attribute changes to new types") and changed various
codepaths over including chown_common().

When userspace passes -1 for an ownership change the ownership fields in struct
iattr stay uninitialized. Usually this is fine because any code making use of
any fields in struct iattr must check the ->ia_valid field whether the value of
interest has been initialized. That's true for all struct iattr passing code.

However, over the course of the last year with more heavy use of KMSAN we found
quite a few places that got this wrong. A recent one I fixed was 3cb6ee991496
("9p: only copy valid iattrs in 9P2000.L setattr implementation").

But we also have LSM hooks. Actually we have two. The first one is
security_inode_setattr() in notify_change() which does the right thing and
passes the full struct iattr down to LSMs and thus LSMs can check whether it is
initialized.

But then we also have security_path_chown() which passes down a path argument
and the target ownership as the filesystem would see it. For the latter we now
generate the target values based on struct iattr and pass it down. However,
when userspace passes -1 then struct iattr isn't initialized. This patch simply
initializes ->ia_vfs{g,u}id with INVALID_VFS{G,U}ID so the hook continue to see
invalid ownership when -1 is passed from userspace. The only LSM that cares
about the actual values is Tomoyo.

The vfs codepaths don't look at these fields without ->ia_valid being set so
there's no harm in initializing ->ia_vfs{g,u}id. Arguably this is also safer
since we can't end up copying valid ownership values when invalid ownership
values should be passed.

This only affects mainline. No kernel has been released with this and thus no
backport is needed. The commit is thus marked with a Fixes: tag but annotated
with "# mainline only" (I didn't quite remember what Greg said about how to
tell stable autoselect to not bother with fixes for mainline only.).

/* Testing */
All patches are based on v6.0-rc3. No build failures or warnings were observed
and fstests, selftests, and LTP have seen no regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.fixes.v6.0-rc7

for you to fetch changes up to f52d74b190f8d10ec01cd5774eca77c2186c8ab7:

  open: always initialize ownership fields (2022-09-20 11:57:57 +0200)

Please consider pulling these changes from the signed fs.fixes.v6.0-rc7 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.fixes.v6.0-rc7

----------------------------------------------------------------
Tetsuo Handa (1):
      open: always initialize ownership fields

 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)
