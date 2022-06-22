Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC85541D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiFVEoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiFVEog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:44:36 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5813333E17;
        Tue, 21 Jun 2022 21:44:35 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 16CF8C01E; Wed, 22 Jun 2022 06:44:33 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C1B91C009;
        Wed, 22 Jun 2022 06:44:30 +0200 (CEST)
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id da68f758;
        Wed, 22 Jun 2022 04:44:27 +0000 (UTC)
Date:   Wed, 22 Jun 2022 13:44:12 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p fixes for 5.19-rc4
Message-ID: <YrKeHMRfXTNw3vTE@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks to Tyler and Christian for the patch/reviews/tests!


The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.19-rc4

for you to fetch changes up to b0017602fdf6bd3f344dd49eaee8b6ffeed6dbac:

  9p: fix EBADF errors in cached mode (2022-06-17 06:03:30 +0900)

----------------------------------------------------------------
9p-for-5.19-rc4: fid refcount and fscache fixes

This contains a couple of fixes:
 - fid refcounting was incorrect in some corner cases and would
leak resources, only freed at umount time. The first three commits
fix three such cases
 - cache=loose or fscache was broken when trying to write a partial
page to a file with no read permission since the rework a few releases
ago. The fix taken here is just to restore old behavior of using the
special 'writeback_fid' for such reads, which is open as root/RDWR
and such not get complains that we try to read on a WRONLY fid.
Long-term it'd be nice to get rid of this and not issue the read at
all (skip cache?) in such cases, but that direction hasn't progressed

----------------------------------------------------------------
Dominique Martinet (3):
      9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
      9p: fix fid refcount leak in v9fs_vfs_get_link
      9p: fix EBADF errors in cached mode

Tyler Hicks (1):
      9p: Fix refcounting during full path walks for fid lookups

 fs/9p/fid.c            | 22 +++++++++-------------
 fs/9p/vfs_addr.c       | 13 +++++++++++++
 fs/9p/vfs_inode.c      |  8 ++++----
 fs/9p/vfs_inode_dotl.c |  3 +++
 4 files changed, 29 insertions(+), 17 deletions(-)

--
Dominique
