Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C364415F97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbhIWNZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:37 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17270 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241269AbhIWNZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402517; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=QEEITetxp1KdUF3UTM/ee3rbezGxhy9H2yMiiG3wK54nC60d0c9BUiC5KeVkHlVWwxtj3AosbPHN04aysB/ACB2fF3fdYBzdwPOjGWaoaOvcUAhgh3tAmXjwOpm5Ih4huR9vtY6bfY76H+EXIzH9641O7wy6a31YI1KHS1X4+zM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402517; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=nzuO9db+SWL+uI8mD5Cj6/bYdT9zgt12KRFdhPHa4C8=; 
        b=fuEBgFrQ/O1i6S5zx7Vpo5/spDqL0YNjTQLwFIl4EtDeR65qrdZX0rMEu1mhkhSR0acB47AGtXo3K3vYZeHnZYC4I6k2aourj1Q4pAFl4X4OyV0+TJImSAnRuADCLGagolh39tv7fE1xgYPKQaQriZRDXk34MRboXTDyrwED6ZI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402517;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=nzuO9db+SWL+uI8mD5Cj6/bYdT9zgt12KRFdhPHa4C8=;
        b=ff3PytOohXhRoq0TJHWw4MwlnjUEnXgRzlEkTajzyeMkAHXEEgX1+znnORMSeJf3
        VF9ukkfBaE0uCqC2pGAJmRFsKDSkl7uEwRf/2qxfDFL1W+ju2x00gDgtUB4rh2Mv3ij
        XrQcC1yEcON62voe5GqDXdb2qgqG/EYE7ygJ+a20=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 163240251605690.26904563646679; Thu, 23 Sep 2021 21:08:36 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-1-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 00/10] implement containerized syncfs for overlayfs
Date:   Thu, 23 Sep 2021 21:08:04 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
on upper_sb to synchronize whole dirty inodes in upper filesystem
regardless of the overlay ownership of the inode. In the use case of
container, when multiple containers using the same underlying upper
filesystem, it has some shortcomings as below.

(1) Performance
Synchronization is probably heavy because it actually syncs unnecessary
inodes for target overlayfs.

(2) Interference
Unplanned synchronization will probably impact IO performance of
unrelated container processes on the other overlayfs.

This series try to implement containerized syncfs for overlayfs so that
only sync target dirty upper inodes which are belong to specific overlayfs
instance. By doing this, it is able to reduce cost of synchronization and
will not seriously impact IO performance of unrelated processes.

v1->v2:
- Mark overlayfs' inode dirty itself instead of adding notification
  mechanism to vfs inode.

v2->v3:
- Introduce overlayfs' extra syncfs wait list to wait target upper inodes
in ->sync_fs.

v3->v4:
- Using wait_sb_inodes() to wait syncing upper inodes.
- Mark overlay inode dirty only when having upper inode and  VM_SHARED
flag in ovl_mmap().
- Check upper i_state after checking upper mmap state
in ovl_write_inode.

v4->v5:
- Add underlying inode dirtiness check after mnt_drop_write().
- Handle both wait/no-wait mode of syncfs(2) in overlayfs' ->sync_fs().

Chengguang Xu (10):
  ovl: setup overlayfs' private bdi
  ovl: implement ->writepages operation
  ovl: implement overlayfs' ->evict_inode operation
  ovl: mark overlayfs' inode dirty on modification
  ovl: mark overlayfs' inode dirty on shared mmap
  ovl: implement overlayfs' ->write_inode operation
  ovl: cache dirty overlayfs' inode
  fs: export wait_sb_inodes()
  fs: introduce new helper sync_fs_and_blockdev()
  ovl: implement containerized syncfs for overlayfs

 fs/fs-writeback.c         |  3 +-
 fs/overlayfs/file.c       |  6 ++++
 fs/overlayfs/inode.c      | 14 ++++++++
 fs/overlayfs/overlayfs.h  |  4 +++
 fs/overlayfs/super.c      | 69 ++++++++++++++++++++++++++++++++++-----
 fs/overlayfs/util.c       | 21 ++++++++++++
 fs/sync.c                 | 14 +++++---
 include/linux/fs.h        |  1 +
 include/linux/writeback.h |  1 +
 9 files changed, 120 insertions(+), 13 deletions(-)

--=20
2.27.0


