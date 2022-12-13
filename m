Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B620564B389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 11:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiLMKsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 05:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiLMKsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:48:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418E31E700;
        Tue, 13 Dec 2022 02:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA94CB810CC;
        Tue, 13 Dec 2022 10:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA63C433D2;
        Tue, 13 Dec 2022 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670928426;
        bh=n1hDnyLATu1NrxJXGrzGdJ+OhzBscdwZGmuwCYDV9TM=;
        h=From:To:Cc:Subject:Date:From;
        b=ut9wwf1CoQ9ZU5rnlqQGxvTPOPCTwbNrSWjI0r9s4OSBeBhKOrqDr3fp6YJ45Uk/+
         +tV81FMtj/6cy64cwJkat/4saR6oQ/LWCeR1H2XGCI46RXMyOXMmZRMhRNISIPft/I
         8nxGUUh2Hu+GciYhmuqWZCn+0XL76TEZ2Jtn0TNm+bt6MQMKl4dPwfte5DBxg0yZyn
         cWH5Sc3YSRhr+pdn+hXQ4jZCgGRjGWfvdK8+DmRk9U8jIN/95yj2D7bOBE22/oiRYm
         xgmuQBVhzwqgTx14IC8eRxzoMuyXJQ80qyOPfGomgrKNFCez74qdP90/smW29AY2C5
         pNrAPCfYA0j2w==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] simple xattr updates for v6.2
Date:   Tue, 13 Dec 2022 11:46:44 +0100
Message-Id: <20221213104643.238650-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4798; i=brauner@kernel.org; h=from:subject; bh=n1hDnyLATu1NrxJXGrzGdJ+OhzBscdwZGmuwCYDV9TM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTPCL+ifvjIzNZF6m99epqzpi3Znv1xyizWxT5rhJg+ewt8 TI2p7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6AmG/74LvJdkSDC9ef1/zZ0Ptg oZk9tnXlVR6XyxKvbaXe1s3peMDFumhH97XzNd+c278zGRHPozJX//Fo72kErLKllYfJD3Mz8A
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

(I thought I had sent this one yesterday but I only did my usual --dry-run
 routine. So this one is one day late.)

/* Summary */
This ports the simple xattr infrastucture to rely on a simple rbtree protected
by a read-write lock instead of a linked list protected by a spinlock.

A while ago we received reports about scaling issues for filesystems using the
simple xattr infrastructure that also support setting a larger number of
xattrs. Specifically, cgroups and tmpfs.

Both cgroupfs and tmpfs can be mounted by unprivileged users in unprivileged
containers and root in an unprivileged container can set an unrestricted number
of security.* xattrs and privileged users can also set unlimited trusted.*
xattrs. A few more words on further that below. Other xattrs such as user.* are
restricted for kernfs-based instances to a fairly limited number.

As there are apparently users that have a fairly large number of xattrs we
should scale a bit better. Using a simple linked list protected by a spinlock
used for set, get, and list operations doesn't scale well if users use a lot of
xattrs even if it's not a crazy number.

Let's switch to a simple rbtree protected by a rwlock. It scales way better and
gets rid of the perf issues some people reported. We originally had fancier
solutions even using an rcu+seqlock protected rbtree but we had concerns about
being to clever and also that deletion from an rbtree with rcu+seqlock isn't
entirely safe.

The rbtree plus rwlock is perfectly fine. By far the most common operation is
getting an xattr. While setting an xattr is not and should be comparatively
rare. And listxattr() often only happens when copying xattrs between files or
together with the contents to a new file.

Holding a lock across listxattr() is unproblematic because it doesn't list the
values of xattrs. It can only be used to list the names of all xattrs set on a
file. And the number of xattr names that can be listed with listxattr() is
limited to XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed then
vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names are found it
will return -E2BIG. In short, the maximum amount of memory that can be
retrieved via listxattr() is limited and thus listxattr() bounded.

Of course, the API is broken as documented on xattr(7) already. While I have no
idea how the xattr api ended up in this state we should probably try to come up
with something here at some point. An iterator pattern similar to readdir() as
an alternative to listxattr() or something else.

Right now it is extremly strange that users can set millions of xattrs but then
can't use listxattr() to know which xattrs are actually set. And it's really
trivial to do:
for i in {1..1000000}; do setfattr -n security.$i -v $i ./file1; done
And around 5000 xattrs it's impossible to use listxattr() to figure out which
xattrs are actually set. So I have suggested that we try to limit the number of
xattrs for simple xattrs at least. But that's a future patch and I don't
consider it very urgent.

A bonus of this port to rbtree+rwlock is that we shrink the memory consumption
for users of the simple xattr infrastructure.

This also adds kernel documentation to all the functions.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.1-rc1 and have been sitting in linux-next. No build
failures or warnings were observed. All old and new tests in fstests,
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.xattr.simple.rework.rbtree.rwlock.v6.2

for you to fetch changes up to 3b4c7bc01727e3a465759236eeac03d0dd686da3:

  xattr: use rbtree for simple_xattrs (2022-11-12 10:49:26 +0100)

Please consider pulling these changes from the signed fs.xattr.simple.rework.rbtree.rwlock.v6.2 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.xattr.simple.rework.rbtree.rwlock.v6.2

----------------------------------------------------------------
Christian Brauner (1):
      xattr: use rbtree for simple_xattrs

 fs/xattr.c            | 317 +++++++++++++++++++++++++++++++++++++++-----------
 include/linux/xattr.h |  38 ++----
 mm/shmem.c            |   2 +-
 3 files changed, 260 insertions(+), 97 deletions(-)
