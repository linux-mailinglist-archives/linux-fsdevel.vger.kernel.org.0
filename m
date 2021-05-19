Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946C8388EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353597AbhESNWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 09:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353577AbhESNWn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 09:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABACE610CC;
        Wed, 19 May 2021 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621430483;
        bh=QuyMOe40CI9MGzlkDgeXFl4uCNLHSfIU/9ysWfLrdSk=;
        h=From:To:Cc:Subject:Date:From;
        b=LfH+D4OB3x9rKdkYPxTBQB1t9IvRKG3xjdbFfeSnfhSfi5Ke9zzPxk4sRVGvyvvPM
         M1cLGvav9yrUGvcYwdHUTEpbJgeLNoYnsH2vb4xOvt5CiB6ElxCN2YMUSdIBhQDCkq
         UhqvY5VDEvNjE9dOgwqpctvSUYsGilzzc5nKumuCoirjNHe+IFjE1ZdRRu1iipcdZP
         x4+TPJQMdnFRDhebyfVLTm08Y+5p9RDxOBIJuS9G1CQ7YPL6K0DGEJkkdh88O7aazR
         WJSb7s0wUnws4J+NppgK2CONNrNzV6rP7cEYYzKQQTyE40DhdJIFAygwclOnyRSvyI
         0WzoR3ilKepFQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fs mount_setattr fix
Date:   Wed, 19 May 2021 15:20:55 +0200
Message-Id: <20210519132055.682958-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/* Summary */
This simple change makes an underlying assumption more explicit. We currently
don't have any filesystems that support idmapped mounts which are mountable
inside a user namespace, i.e. where s_user_ns != init_user_ns. That was a
deliberate decision for now as userns root can just mount the filesystem
themselves.
Express this restriction explicitly and enforce it until there's a real
use-case for this. This way we can notice it and will have a chance to adapt
and audit our translation helpers and fstests appropriately if we need to
support such filesystems.

On a general note, we're seeing idmapped mounts being adopted rapidly. Since
5.12 was released systemd has already merged full support for idmapped mounts.
Discussions have kicked off for Docker/Moby, k8s, runC, and the containerd
patchset is about to be reworked. Requests for more filesystems are coming in
including btrfs and overlayfs and we're discussing fanotify making us of
idmapped mounts to implement filtered filesystems marks which will be a great
addition as well. We won't be able to please everyone's desire or design of
course but it feels like we hit the right direction with this patchset.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.mount_setattr.v5.13-rc3

for you to fetch changes up to 2ca4dcc4909d787ee153272f7efc2bff3b498720:

  fs/mount_setattr: tighten permission checks (2021-05-12 14:13:16 +0200)

/* Testing */
All patches are based on v5.13-rc1 and have been sitting in linux-next. No
build failures or warnings were observed. All fstests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

Please consider pulling these changes from the signed fs.idmapped.mount_setattr.v5.13-rc3 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.idmapped.mount_setattr.v5.13-rc3

----------------------------------------------------------------
Christian Brauner (1):
      fs/mount_setattr: tighten permission checks

 fs/namespace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
