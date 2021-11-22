Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2645884F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhKVDTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:44 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17262 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238641AbhKVDTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550055; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SQ4HznWkzxNzbiGpThM6yk0xH2hNm1Zw6oMu1lXCI9i7aUb6zB5/dst5s4WZhQ+4hitgVMosItNKXtDALUm/64VKTAspOk665Pskm9UfD08FwoppMx8sYGQOOGdcw2lqgcoV3u0E47CSgPyMWedC2nDvVwBVPfvM5tMXwGlka7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550055; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=BgufH6WwCixRjbj4dwf1Rqs1qZmdzDxvnYVfr7T13V0=; 
        b=kwPWe05wABZhXZ6rYo27kz5GuLZLDCiZcD4XNdQveWj5HzsqDCoCRK4AGhFK8S4uZvIsuv7sdLc2gHhTseadFQAQ9dge+g4mctmQfkhUEcEqMBaLDCjq6+EBjghri0qdtICwoj9ao8bO9ScCyTfX8ZkDhUbVNgQ4bgyF9H1YOr4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550055;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=BgufH6WwCixRjbj4dwf1Rqs1qZmdzDxvnYVfr7T13V0=;
        b=GHgDgbScnnz8kcon/45tZcZ2Tr5rw5Ews4IW+5JtHkj5oTKl8PhVVQcH8x7aYsTe
        oMXxkwcF16GXUSWg4vVirBWVcZ/K8NKNxXNNHctUM9hrfZi+421ZS7WemvEZbkntr7N
        fyG4ALxonuenwmrLKDQYb/ukaFwM/6Wgs7LgcbZQ=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550053957227.19268519972252; Mon, 22 Nov 2021 11:00:53 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-1-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 0/7] implement containerized syncfs for overlayfs
Date:   Mon, 22 Nov 2021 11:00:31 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chengguang Xu <charliecgxu@tencent.com>

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
instance. By doing this, it is able to reduce cost of synchronization and=
=20
will not seriously impact IO performance of unrelated processes.

v1->v2:
- Mark overlayfs' inode dirty itself instead of adding notification
mechanism to vfs inode.

v2->v3:
- Introduce overlayfs' extra syncfs wait list to wait target upper inodes
in ->sync_fs.

v3->v4:
- Using wait_sb_inodes() to wait syncing upper inodes.
- Mark overlay inode dirty only when having upper inode and VM_SHARED
flag in ovl_mmap().
- Check upper i_state after checking upper mmap state
in ovl_write_inode.

v4->v5:
- Add underlying inode dirtiness check after mnt_drop_write().
- Handle both wait/no-wait mode of syncfs(2) in overlayfs' ->sync_fs().

v5->v6:
- Rebase to latest overlayfs-next tree.
- Mark oerlay inode dirty when it has upper instead of marking dirty on
  modification.
- Trigger dirty page writeback in overlayfs' ->write_inode().
- Mark overlay inode 'DONTCACHE' flag.
- Delete overlayfs' ->writepages() and ->evict_inode() operations.

Chengguang Xu (7):
  ovl: setup overlayfs' private bdi
  ovl: mark overlayfs inode dirty when it has upper
  ovl: implement overlayfs' own ->write_inode operation
  ovl: set 'DONTCACHE' flag for overlayfs inode
  fs: export wait_sb_inodes()
  ovl: introduce ovl_sync_upper_blockdev()
  ovl: implement containerized syncfs for overlayfs

 fs/fs-writeback.c         |  3 ++-
 fs/overlayfs/inode.c      |  5 +++-
 fs/overlayfs/super.c      | 49 ++++++++++++++++++++++++++++++++-------
 fs/overlayfs/util.c       |  1 +
 include/linux/writeback.h |  1 +
 5 files changed, 48 insertions(+), 11 deletions(-)

--=20
2.27.0


