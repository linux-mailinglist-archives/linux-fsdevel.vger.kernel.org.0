Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD52AAB4A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKHOEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:13 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17140 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbgKHOEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844202; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=OY/YQ4ncezO8yTI0WBbqoKwCStdzVa+lkK9SADbjc8mmFIBHjShPJkKbZsy4mvxqaGmMILzlB1dLcLxFls3O73Si4pkuI3i1d15Ljr0FTC7sby/dEewpxMfy5h8yVN4w9+/D1cZNoTcs/zjrNN1ZfflWMQdSzqowhCJK3wzOlg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844202; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=fH3HIuDNajiZe/artUoBVrSDA5bDaJNcUJlijZpON/I=; 
        b=j01H4/Pe1tY43agljPA5ZzYJbC4lcYZnWHaIefMUEhY0kPH6yqwMiKyvQW5rznqPC63bSfXR4P0wLiX/FnWYBsiF16WSGgCdbAXY0BSibJEQ0iEwlZJpIwBIqA24ZFLWvdRXK/KYQvvBnATT4H/hHvnnDlfOXFX47ZDxv8GHyV0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844202;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=fH3HIuDNajiZe/artUoBVrSDA5bDaJNcUJlijZpON/I=;
        b=cx/6V2/tAXWeXJHcZDmctUNWWrv4VbUU3Zl7Emj9Yz50zOtaZx/Y/Vji8rL8NT3z
        OKLTSECrwqe+XmC1dPkFmhI1rNbt8mF/159TYkfThlOQJ9kDeWF7I79ni3POgZfiqeE
        LPKWBAvOtf1bMpznDqpZyDSuOaNlFoMTiOvLbJlE=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844200825124.94649116380526; Sun, 8 Nov 2020 22:03:20 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-1-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 00/10] implement containerized syncfs for overlayfs
Date:   Sun,  8 Nov 2020 22:02:57 +0800
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

Chengguang Xu (10):
  ovl: setup overlayfs' private bdi
  ovl: introduce waiting list for syncfs
  ovl: implement ->writepages operation
  ovl: implement overlayfs' ->evict_inode operation
  ovl: mark overlayfs' inode dirty on modification
  ovl: mark overlayfs' inode dirty on shared mmap
  ovl: implement overlayfs' ->write_inode operation
  ovl: cache dirty overlayfs' inode
  ovl: introduce helper of syncfs writeback inode waiting
  ovl: implement containerized syncfs for overlayfs

 fs/overlayfs/file.c      |   2 +
 fs/overlayfs/inode.c     |  25 ++++++++++
 fs/overlayfs/overlayfs.h |   4 ++
 fs/overlayfs/ovl_entry.h |   5 ++
 fs/overlayfs/super.c     | 104 +++++++++++++++++++++++++++++++++++++--
 fs/overlayfs/util.c      |  14 ++++++
 6 files changed, 150 insertions(+), 4 deletions(-)

--=20
2.26.2


