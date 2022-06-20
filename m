Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494B551EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiFTOfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiFTOeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBB2193
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA69DB80EA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F48CC3411C;
        Mon, 20 Jun 2022 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733000;
        bh=rU0xBkCfgabhtJue3XetRKzaZrKEadh7TnBOzedoWyw=;
        h=From:To:Cc:Subject:Date:From;
        b=YoDmGkcgNhUa2LvqXuOH3um1LwmA9WIFOtPlhnUCiMhF+viIW2HhDAauTF+VRXdzW
         W0jFornIVl7yuT/8HB1ruUSqpbxuLn5r73ZKQZE+twd+S50UopNQUSKdw5+0g/pe34
         Nk/yTMZR8+g2s6rSbQuQkO89/m3P5CGfWilLjtJnVTt0Pk9CyiZ/a7pOOJj2kMpEM1
         jwzFmoycJHoJWiMyUxCoedW1SQTY9wkZYFs9K3NY9NmaxgDroxjdZKDQ4wRFssPr7y
         zrHowNwmMJBrBCrkUehUuC/CtECllJqUZhx4uzDLHW5r7VCFB35CM7fHHLbXYaLouY
         mPktiTdXINM8Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/8] introduce dedicated type for idmapped mounts
Date:   Mon, 20 Jun 2022 15:49:39 +0200
Message-Id: <20220620134947.2772863-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; h=from:subject; bh=wh/bttgoARuPpfSCA19TFf+LGqk7lENQO3DQKmdBMGs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHo9O2/SU+mTgd0ZR3v+c7psetmyfYPcV5PZj/++6DW/ Jn9Fr6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAinCsY/lcf0KuY0vPOt6446sXW+A /egSmnj+65XnxgTlLbL8cdosEM/0w4GEXZ3TIX/uI58vWAinxV77tfdeILhJu/yv2z9HplyAIA
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

This series starts to introduce a new kmnt{g,u}id_t type. It allows to
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

Ideally I'd like to get at least this first series in for v5.20. The
conversion can the continue until we can remove all the regular non-type
safe helpers and will only be left with the type safe helpers.

Thanks!
Christian

Christian Brauner (8):
  mnt_idmapping: add kmnt{g,u}id_t
  fs: add two type safe mapping helpers
  fs: use mount types in iattr
  fs: introduce tiny iattr ownership update helpers
  fs: port to iattr ownership update helpers
  quota: port quota helpers mount ids
  security: pass down mount idmapping to setattr hook
  attr: port attribute changes to new types

 fs/attr.c                         |  69 +++++------
 fs/ext2/inode.c                   |   8 +-
 fs/ext4/inode.c                   |  14 +--
 fs/f2fs/file.c                    |  22 ++--
 fs/f2fs/recovery.c                |   2 +-
 fs/fat/file.c                     |   7 +-
 fs/jfs/file.c                     |   4 +-
 fs/ocfs2/file.c                   |   2 +-
 fs/open.c                         |  65 +++++++---
 fs/overlayfs/copy_up.c            |   4 +-
 fs/overlayfs/overlayfs.h          |  12 +-
 fs/quota/dquot.c                  |  17 ++-
 fs/reiserfs/inode.c               |   4 +-
 fs/xfs/xfs_iops.c                 |  11 +-
 fs/zonefs/super.c                 |   2 +-
 include/linux/evm.h               |   6 +-
 include/linux/fs.h                | 135 ++++++++++++++++++++-
 include/linux/mnt_idmapping.h     | 195 ++++++++++++++++++++++++++++++
 include/linux/quotaops.h          |  15 ++-
 include/linux/security.h          |   8 +-
 security/integrity/evm/evm_main.c |  12 +-
 security/security.c               |   5 +-
 22 files changed, 488 insertions(+), 131 deletions(-)


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.34.1

