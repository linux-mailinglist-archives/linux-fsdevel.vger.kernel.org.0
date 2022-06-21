Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3463553445
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350641AbiFUOPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347885AbiFUOPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A32201A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73A8AB8125A
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5C8C3411C;
        Tue, 21 Jun 2022 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820907;
        bh=ZVywcm5c8+6LhQtIeO9Op6ke+WoMXns0rwWVo+bW1T4=;
        h=From:To:Cc:Subject:Date:From;
        b=FI+ho/mHz/a5Fa9sQSBZdvY042A30/cvyNDoRLxIbc4+qwZzirZTeE+FZEJxVG54e
         /HmBHL9o8Lo1T49IMzSl7ZPRLqK0rRX3GjR/2dEQyDc0DqH2rM0jpXPPfHhgVAx142
         TTcXf0fJKLaUILZxR/KifJhLpONPFsnbJ5st/Uqy/Invc0mbnkANrNdleSX99EPLe0
         T3QwqlnLyMXPM9cDZIh9T2epsUutYI/HDY2m7Y6j2pUapcY9ii/OF4f3gkn6Tiq7c1
         6kDTTfFUoGf7eulpiTLwUANyQsyDuCv/f23b3OlVbIno9z7IHKAyPlJkCoqGQMUBuz
         zqi6BsHq1oDRQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 0/8] introduce dedicated type for idmapped mounts
Date:   Tue, 21 Jun 2022 16:14:46 +0200
Message-Id: <20220621141454.2914719-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; h=from:subject; bh=1/UVDCzw935TixZzCyIGSfLMBz7wZP9pEcBe3vH3Z+I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBR2Nkh17reLzAy3Fm5e/sXF23+bq+zkrqojWpP9Gjas 9Iw62VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRwq0M/zSnzEyyfNgSH2Hfw3tl6r s+mT0VeQfysqp2v9DJfLgu7C0jw6XbRdcOlrA0FHnfCd4uGZ6hryO76r7kopAGJynOKYv7uQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey everyone,

/* v2 */
No major changes. The type got renamed since we agreed that the initial
name wasn't great. There are some typo fixes in the commit messages and
a few tweaks to the last commit and added Jan's rvb.

This series starts to introduce a new vfs{g,u}id_t type. It allows to
distinguish {g,u}ids on idmapped mounts from filesystem k{g,u}ids.

We leverage the type framework to increase the safety for filesystems
and the vfs when dealing with idmapped mounts.

The series introduces the type and converts the setattr codepaths to
use the new type and associated helpers.

Currently these codepaths place the value that will ultimately be
written to inode->i_{g,u}id into attr->ia_{g,u}id which allows to avoid
changing a few callsites. But there are drawbacks to this approach.

As Linus rightly points out it makes some of the permission checks in
the attribute code harder to understand than they need and should be and
increases the probability for further issues.

This series makes it so that the values will always be treated as being
mapped into the idmapped mount. Only when the filesystem object is
actually updated will the value be mapped into the filesystem idmapping.

I first looked into this about ~7 months ago but put it on hold to focus
on the testsuite. Linus expressed the desire for something like this
last week so I got back to working on this.

I'd like to get at least this first series in for v5.20. The conversion
can the continue until we can remove all the regular non-type safe
helpers and will only be left with the type safe helpers.

Thanks!
Christian

Christian Brauner (8):
  mnt_idmapping: add vfs{g,u}id_t
  fs: add two type safe mapping helpers
  fs: use mount types in iattr
  fs: introduce tiny iattr ownership update helpers
  fs: port to iattr ownership update helpers
  quota: port quota helpers mount ids
  security: pass down mount idmapping to setattr hook
  attr: port attribute changes to new types

 fs/attr.c                         |  70 +++++------
 fs/ext2/inode.c                   |   8 +-
 fs/ext4/inode.c                   |  14 +--
 fs/f2fs/file.c                    |  22 ++--
 fs/f2fs/recovery.c                |  10 +-
 fs/fat/file.c                     |  11 +-
 fs/jfs/file.c                     |   4 +-
 fs/ocfs2/file.c                   |   2 +-
 fs/open.c                         |  60 ++++++---
 fs/overlayfs/copy_up.c            |   4 +-
 fs/overlayfs/overlayfs.h          |  12 +-
 fs/quota/dquot.c                  |  17 ++-
 fs/reiserfs/inode.c               |   4 +-
 fs/xfs/xfs_iops.c                 |  14 ++-
 fs/zonefs/super.c                 |   2 +-
 include/linux/evm.h               |   6 +-
 include/linux/fs.h                | 132 +++++++++++++++++++-
 include/linux/mnt_idmapping.h     | 195 ++++++++++++++++++++++++++++++
 include/linux/quotaops.h          |  15 ++-
 include/linux/security.h          |   8 +-
 security/integrity/evm/evm_main.c |  12 +-
 security/security.c               |   5 +-
 22 files changed, 490 insertions(+), 137 deletions(-)


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.34.1

