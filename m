Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143185F47F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 18:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJDQzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJDQy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:54:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F21ADA3;
        Tue,  4 Oct 2022 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AsTuUOYILwvkkbCujqdmHs6n+Rpe+EW6I7v3NG7bw4o=; b=Yr59Bjm9ZC4uRx5sohE6zKmVfl
        3cfGNAxeCcZE9UpGsy9GfFIa2CZ7VlhBaj8kpKnop8pxOMuyNrbIfQBr+CY3vhNYB1FQYp6ojFfq9
        SdF2a9/tBlZCoob1YlgU3qtmTPnQcbYAoSkuTZOX6aUipJj3avVNvdOj4rney46b1r7ROb+/BkrDo
        ueZYDH0xJljmHuEWYLXmKTifzo2GO07y36SEK+hJ5rK0yaPfuRKYBrJRUjanZ3Bqt361JyRak+iqa
        Cg21KEm4J5/ybug79BaP4H2jld72fNsHlBLmoAMWiYyjHQXyo3MNmXxg+wzprtJMRA/m7Wbs4BmL2
        WYLgiMVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oflC4-0072Im-1a;
        Tue, 04 Oct 2022 16:54:56 +0000
Date:   Tue, 4 Oct 2022 17:54:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 3 (file)
Message-ID: <YzxlYFiWmx5nK+gT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The non-trivial part here is filldir_t calling conventions change.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file

for you to fetch changes up to 47091e4ed9af648d6cfa3a5f0809ece371294ecb:

  dma_buf_getfile(): don't bother with ->f_flags reassignments (2022-08-17 17:25:54 -0400)

----------------------------------------------------------------
struct file-related stuff

----------------------------------------------------------------
Al Viro (2):
      Change calling conventions for filldir_t
      dma_buf_getfile(): don't bother with ->f_flags reassignments

Amir Goldstein (1):
      locks: fix TOCTOU race when granting write lease

 Documentation/filesystems/porting.rst | 11 ++++++
 arch/alpha/kernel/osf_sys.c           | 10 +++---
 drivers/dma-buf/dma-buf.c             |  2 +-
 fs/afs/dir.c                          | 23 ++++++------
 fs/ecryptfs/file.c                    | 38 +++++++++-----------
 fs/exportfs/expfs.c                   |  7 ++--
 fs/fat/dir.c                          |  8 ++---
 fs/file_table.c                       |  7 +---
 fs/gfs2/export.c                      |  6 ++--
 fs/internal.h                         | 10 ++++++
 fs/ksmbd/smb2pdu.c                    | 16 ++++-----
 fs/ksmbd/vfs.c                        | 14 ++++----
 fs/nfsd/nfs4recover.c                 |  8 ++---
 fs/nfsd/vfs.c                         |  6 ++--
 fs/ocfs2/dir.c                        | 10 +++---
 fs/ocfs2/journal.c                    | 14 ++++----
 fs/open.c                             | 11 +++---
 fs/overlayfs/readdir.c                | 28 +++++++--------
 fs/readdir.c                          | 68 +++++++++++++++++------------------
 fs/reiserfs/xattr.c                   | 20 +++++------
 fs/xfs/scrub/dir.c                    |  8 ++---
 fs/xfs/scrub/parent.c                 |  4 +--
 include/linux/fs.h                    |  9 ++---
 23 files changed, 169 insertions(+), 169 deletions(-)
