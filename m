Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C234BCA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC1Ooz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhC1OoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:44:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4EC061756;
        Sun, 28 Mar 2021 07:44:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C1F5E1F42808
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     krisman@collabora.com, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/3] fs: Fix dangling dentries on casefold directories
Date:   Sun, 28 Mar 2021 11:43:53 -0300
Message-Id: <20210328144356.12866-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patchset fixes a bug in case-insensitive directories. When I
submitted a patchset for adding case-insensitive support for tmpfs[0],
Al Viro noted that my implementation didn't take in account previous
dentries that the directory could have created before being changed.
Further investigation showed that neither ext4 or f2fs also doesn't take
this case in consideration as well.

* Why can't we have negative dentries with casefold?

The assumption that the directory has no dentries can lead to a buggy
behavior (note that since the directory must be empty when setting the
casefold flag, all dentries there are negative). Imagine the following
operation on a mounted ext4 with casefold support enabled:

mkdir dir
mkdir dir/C	# creates a dentry for `C` (dentry D)
rm -r dir/C	# makes dentry D a negative one

Now, let's make it case-insensitive:

chattr +F dir/	# now dir/ is a casefold directory
mkdir dir/c	# if hash for `c` collides with dentry D
		# d_compare does a case-insensitive compare
		# and assumes that dentry D is the one to be used
ls dir/		# VFS uses the name at dentry D for the final file
C		# and here's the bug

In that way, all negative dentries at dir/ will become dangling dentries
that can't be trusted to be used an will just waste memory.

The problem with negative dentries is well-know, and both the current
code and commits documents it, but this case hasn't been taken in
consideration so far.

* Reproducing

Given that the bug only happens with a hash collision, I added the
following snippet at the beginning of generic_ci_d_hash():

str->hash = 0;
return 0;

This means that all dentries will have the same hash. This is not good
for performance, but it should not break anything AFAIK. Then, just run
the example showed in the latter section.

* Fixing

To fix this bug, I added a function that, given an inode, for each alias
of it, will remove all the sub-dentries at that directory. Given that
they are all negative dentries, we don't need to do the whole d_walk,
since they don't have children and are also ready to be d_droped and
dputed.

Then, at ext4 and f2fs, when a dir is going to turn on the casefold
flag, we call this function.

Thanks,
	André

[0] https://lore.kernel.org/linux-fsdevel/20210323195941.69720-1-andrealmeid@collabora.com/T/#m3265579197095b792ee8b8e8b7f84a58c25c456b

André Almeida (3):
  fs/dcache: Add d_clear_dir_neg_dentries()
  ext4: Prevent dangling dentries on casefold directories
  f2fs: Prevent dangling dentries on casefold directories

 fs/dcache.c            | 27 +++++++++++++++++++++++++++
 fs/ext4/ioctl.c        |  3 +++
 fs/f2fs/file.c         |  4 ++++
 include/linux/dcache.h |  1 +
 4 files changed, 35 insertions(+)

-- 
2.31.0

