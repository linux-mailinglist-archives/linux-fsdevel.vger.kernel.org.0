Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91B69B702
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBRAnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBRAnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373218ABF;
        Fri, 17 Feb 2023 16:43:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1ADF6207E;
        Sat, 18 Feb 2023 00:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2611BC433EF;
        Sat, 18 Feb 2023 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680424;
        bh=lXhsoutPECxKV3nX3JhNGjme2nqA5IIggiW3j7Todqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GStguZfzTZmY9/0+uqzLErEw1TejVU0fhuxl//reMls8miLIU91W/7TLvimRuiGHf
         XePD67lej6yLD5XJh0y7TNJJ1DSudwUpuk79+AwNgYZwwciuwJ6WUApJ18mfTlIaYO
         UiGgS9G+zDI0voHtEpJb8EaOu3t1lKkz8v8RQJssPykqXwao9fSskaKKxH+Lr+Rl7F
         ctqFm79kJvDFnWfuB5KNEX1ZbGycAgjELErU7MSo8Ye0IQ/XoAgpbc6SklW66MF1Ig
         UqUq6UcEKHFcB4qMiIqed9Y0FJ6S2Tsob64qOAm1L9GprL5YU+4Px2CizqSnt82M0d
         3U9q1K7lXvdQQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 00/11] Performance fixes for 9p filesystem
Date:   Sat, 18 Feb 2023 00:33:12 +0000
Message-Id: <20230218003323.2322580-1-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the fourth version of a patch series which adds a number
of features to improve read/write performance in the 9p filesystem.
Mostly it focuses on fixing caching to help utilize the recently
increased MSIZE limits and also fixes some problematic behavior
within the writeback code.

All together, these show roughly 10x speed increases on simple
file transfers over no caching for readahead mode.  Future patch
sets will improve cache consistency and directory caching, which
should benefit loose mode.

This iteration of the patch incorporates an important fix for
writeback which uses a stronger mechanism to flush writeback on
close of files and addresses observed bugs in previous versions of
the patch for writeback, mmap, and loose cache modes.

These patches are also available on github:
https://github.com/v9fs/linux/tree/ericvh/for-next
and on kernel.org:
https://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git

Tested against qemu, cpu, and diod with fsx, dbench, and postmark
in every caching mode.

I'm gonna definitely submit the first couple patches as they are
fairly harmless - but would like to submit the whole series to the
upcoming merge window.  Would appreciate reviews.

Eric Van Hensbergen (11):
  net/9p: Adjust maximum MSIZE to account for p9 header
  fs/9p: Expand setup of writeback cache to all levels
  fs/9p: Consolidate file operations and add readahead and writeback
  fs/9p: Remove unnecessary superblock flags
  fs/9p: allow disable of xattr support on mount
  net/9p: fix bug in client create for .L
  9p: Add additional debug flags and open modes
  fs/9p: Add new mount modes
  fs/9p: fix error reporting in v9fs_dir_release
  fs/9p: writeback mode fixes
  fs/9p: Fix revalidate

 Documentation/filesystems/9p.rst |  26 ++--
 fs/9p/fid.c                      |  49 +++-----
 fs/9p/fid.h                      |  33 ++++-
 fs/9p/v9fs.c                     |  49 +++++---
 fs/9p/v9fs.h                     |  10 +-
 fs/9p/v9fs_vfs.h                 |   4 -
 fs/9p/vfs_addr.c                 |  24 ++--
 fs/9p/vfs_dentry.c               |   3 +-
 fs/9p/vfs_dir.c                  |  10 +-
 fs/9p/vfs_file.c                 | 205 +++++++------------------------
 fs/9p/vfs_inode.c                | 102 +++++++--------
 fs/9p/vfs_inode_dotl.c           |  69 ++++++-----
 fs/9p/vfs_super.c                |  28 +++--
 include/net/9p/9p.h              |   5 +
 net/9p/client.c                  |   8 +-
 15 files changed, 284 insertions(+), 341 deletions(-)

--
2.37.2

