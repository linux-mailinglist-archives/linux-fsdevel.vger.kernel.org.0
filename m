Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3D53D90C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 03:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiFEBVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 21:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiFEBV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:21:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3121242;
        Sat,  4 Jun 2022 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=l2OavNKpmnckPuq3iC/4G7QnYlN6LN1gkJR+8Famj5k=; b=AbnoUzo1MslubWXXBjB8Ix4ud+
        Y1z0jk4n65jHonFwsYGgwAU2qP9YxVU8gBb2d8mTusmuD0biIhjn8kV4Ae3JjlTTheH8sTPofNWJw
        4XlyeEiesomhbrw2fhLse9EpHN/qHXV5QVH/UmT+MFbnOj49wYS/G8y8y9q6fupjgrupmx3wdd5Ek
        ENn91xgwry8dTtWOyd4TAYGVGkvQEMr5AWUiimuviNlIqU7X9T/OA97aJMpn/FBoV+xa+GXl/cWa3
        i2PAZdqGKceUqZ4AwI7jWjkLIVKtWSXLTPi2dECWchRfAlC0PWjkAN1kVbMQnfKZvsKcbbzBVvbqQ
        8To9jUCg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxexH-003ds0-8R; Sun, 05 Jun 2022 01:21:23 +0000
Date:   Sun, 5 Jun 2022 01:21:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] descriptor handling stuff
Message-ID: <YpwFEwDJXAvbGuyn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.fd

for you to fetch changes up to 6319194ec57b0452dcda4589d24c4e7db299c5bf:

  Unify the primitives for file descriptor closing (2022-05-14 18:49:01 -0400)

----------------------------------------------------------------
Descriptor handling cleanups

----------------------------------------------------------------

trivial conflict in fs/io_uring.c (this branch makes fdput() unconditional in there,
mainline modifies return statement immediately after that; changes are independent).

Al Viro (2):
      io_uring_enter(): don't leave f.flags uninitialized
      Unify the primitives for file descriptor closing

Gou Hao (1):
      fs: remove fget_many and fput_many interface

 drivers/android/binder.c |   2 +-
 fs/file.c                | 110 ++++++++++++++++++-----------------------------
 fs/file_table.c          |   9 +---
 fs/internal.h            |   2 +-
 fs/io_uring.c            |  18 +++-----
 include/linux/fdtable.h  |   2 +-
 include/linux/file.h     |   2 -
 include/linux/fs.h       |   4 +-
 8 files changed, 55 insertions(+), 94 deletions(-)
