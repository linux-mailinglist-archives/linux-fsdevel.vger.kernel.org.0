Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09B2B15FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKMG5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:06 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17153 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgKMG5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250595; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=d8SVfRMlRvTv/gvVU0n0D5yum+27aMzwqAk6cgLKW3KBr5BzoYZK4KMxiABYblYkXXzSCgampD6BcAeIyGs7m+nkrR/tPXo3xKrs0JfH9F+Sa3KErVzWjL+2ZVEaYz1yAhy1PKZ8u+907fnlIPFXPA7dubSGaYQmhKCSG2bziYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250595; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=HxnW2o/ZiMA0JoKkrGmmcEKfxuMUeWTTJ+LdciOaLEA=; 
        b=L7eQyCNHm70b5Ny+rOHHoXEWEHv4HCx7v0WrwoPdJKqzKOjGla2W8A6iuaH0fyJx6FvgHdCQKMbY0yDCPajIhUu7FVCQNoRmv0KHPchM3Kfcu13XNzKjkFT9jWTSUB98ii1MWWVHRxBZw7kKwHim3meo1q/zLd4SYskAIffan/Q=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250595;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=HxnW2o/ZiMA0JoKkrGmmcEKfxuMUeWTTJ+LdciOaLEA=;
        b=VeUW74lJ57ZC3ln+7wf3I7Zn5WMf46MR5lnBjV7VAaljhR8o02HhOSx2b169/jrT
        qGLtKPJyq8yvDsxaXvizQvTUlKKpSHOziU1OzCd6taPLfgVYPp05a8rZKsR+QVQIPVa
        ek5ONwmj27X36YnysC62QKGlaquOfNoMRmRbryoQ=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250593882528.8161161598881; Fri, 13 Nov 2020 14:56:33 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-1-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 0/9] implement containerized syncfs for overlayfs
Date:   Fri, 13 Nov 2020 14:55:46 +0800
X-Mailer: git-send-email 2.26.2
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

Chengguang Xu (9):
  ovl: setup overlayfs' private bdi
  ovl: implement ->writepages operation
  ovl: implement overlayfs' ->evict_inode operation
  ovl: mark overlayfs' inode dirty on modification
  ovl: mark overlayfs' inode dirty on shared mmap
  ovl: implement overlayfs' ->write_inode operation
  ovl: cache dirty overlayfs' inode
  fs: export wait_sb_inodes()
  ovl: implement containerized syncfs for overlayfs

 fs/fs-writeback.c         |  3 +-
 fs/overlayfs/file.c       |  3 ++
 fs/overlayfs/inode.c      | 15 ++++++++++
 fs/overlayfs/overlayfs.h  |  4 +++
 fs/overlayfs/super.c      | 63 ++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/util.c       | 14 +++++++++
 include/linux/writeback.h |  1 +
 7 files changed, 98 insertions(+), 5 deletions(-)

--=20
2.26.2


