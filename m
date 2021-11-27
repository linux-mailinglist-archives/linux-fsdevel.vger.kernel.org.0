Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154784608F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhK1S2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 13:28:25 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17296 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359320AbhK1S0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:26:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638005196; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=n3tN4S2pUQeHcaidBskaxPvMtDHKVAxGlzpV4gGhKRw0ZRPexTpe+9491ASfmg0HTmlzpcGklxp+HMRiNT0nz7WB3yRDEgMXIVlbk6nppF5tsd9+xwYvYa+sqjKuO3IG1VFKI2d/3UUUTEAStZqRuO2G7fPvidPxfb9wuISL+GM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638005196; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=Gx78nwaiX6IcgNHFjD7iZoX/9w5JdvaOCjUYq7EIGF8=; 
        b=L+x/I3014bH31MUiJjwlMUIA0OFhsckS6h6hv6axN+6zUKZ3hEWIrtJxc9FBqQ6Qibg6YP4JsjtX6NX4JOTcEAN2havNabHJChd8GNBZB0Un8LvTEUsJdciVm1vdlMiA5HCTyeHhT3WETZ5Uv7oleWAWjCIqSZgTHB0xWTty7g8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638005196;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Gx78nwaiX6IcgNHFjD7iZoX/9w5JdvaOCjUYq7EIGF8=;
        b=AOUteeEka8coVmSi4zQzORqE5JY1MaV08/LAMtbTc27DCvaprB+pMimMaBupCWxB
        O+FA0+jbAUUvYwibbnxdThAmY5Ue8tUKtJFxMKJfWYfyRApCoywzOrqMRC2+ZkgXx95
        aD4148NrPXGMaIDIGuyGKpO95c4vIFvh8io47D5E=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638005193699274.15327156530714; Sat, 27 Nov 2021 17:26:33 +0800 (CST)
Date:   Sat, 27 Nov 2021 17:26:33 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "miklos" <miklos@szeredi.hu>
Cc:     "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Chengguang Xu" <charliecgxu@tencent.com>,
        "ronyjin" <ronyjin@tencent.com>, "amir73il" <amir73il@gmail.com>,
        "jack" <jack@suse.cz>
Message-ID: <17d60b7bbc2.caee608a13298.8366222634423039066@mykernel.net>
In-Reply-To: <20211122030038.1938875-1-cgxu519@mykernel.net>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[RFC_PATCH_V6_0/7]_implement_c?=
 =?UTF-8?Q?ontainerized_syncfs_for_overlayfs?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2021-11-22 11:00:31 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > From: Chengguang Xu <charliecgxu@tencent.com>
 >=20
 > Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
 > on upper_sb to synchronize whole dirty inodes in upper filesystem
 > regardless of the overlay ownership of the inode. In the use case of
 > container, when multiple containers using the same underlying upper
 > filesystem, it has some shortcomings as below.
 >=20
 > (1) Performance
 > Synchronization is probably heavy because it actually syncs unnecessary
 > inodes for target overlayfs.
 >=20
 > (2) Interference
 > Unplanned synchronization will probably impact IO performance of
 > unrelated container processes on the other overlayfs.
 >=20
 > This series try to implement containerized syncfs for overlayfs so that
 > only sync target dirty upper inodes which are belong to specific overlay=
fs
 > instance. By doing this, it is able to reduce cost of synchronization an=
d=20
 > will not seriously impact IO performance of unrelated processes.
 >=20
 > v1->v2:
 > - Mark overlayfs' inode dirty itself instead of adding notification
 > mechanism to vfs inode.
 >=20
 > v2->v3:
 > - Introduce overlayfs' extra syncfs wait list to wait target upper inode=
s
 > in ->sync_fs.
 >=20
 > v3->v4:
 > - Using wait_sb_inodes() to wait syncing upper inodes.
 > - Mark overlay inode dirty only when having upper inode and VM_SHARED
 > flag in ovl_mmap().
 > - Check upper i_state after checking upper mmap state
 > in ovl_write_inode.
 >=20
 > v4->v5:
 > - Add underlying inode dirtiness check after mnt_drop_write().
 > - Handle both wait/no-wait mode of syncfs(2) in overlayfs' ->sync_fs().
 >=20
 > v5->v6:
 > - Rebase to latest overlayfs-next tree.
 > - Mark oerlay inode dirty when it has upper instead of marking dirty on
 >   modification.
 > - Trigger dirty page writeback in overlayfs' ->write_inode().
 > - Mark overlay inode 'DONTCACHE' flag.
 > - Delete overlayfs' ->writepages() and ->evict_inode() operations.


Hi Miklos,

Have you got time to have a look at this V6 series? I think this version ha=
s already fixed
the issues in previous feedbacks of you guys and passed fstests (generic/ov=
erlay cases).

I did some stress long time tests (tar & syncfs & diff on w/wo copy-up) and=
 found no obvious problem.
For syncfs time with 1M clean upper inodes, there was extra 1.3s wasted on =
waiting scheduling.
I guess this 1.3s will not bring significant impact to container instance i=
n most cases, I also
agree with Jack that we can start with this approach and do some improvemen=
ts afterwards if there is
complain from any real users.



Thanks,
Chengguang


 >=20
 > Chengguang Xu (7):
 >   ovl: setup overlayfs' private bdi
 >   ovl: mark overlayfs inode dirty when it has upper
 >   ovl: implement overlayfs' own ->write_inode operation
 >   ovl: set 'DONTCACHE' flag for overlayfs inode
 >   fs: export wait_sb_inodes()
 >   ovl: introduce ovl_sync_upper_blockdev()
 >   ovl: implement containerized syncfs for overlayfs
 >=20
 >  fs/fs-writeback.c         |  3 ++-
 >  fs/overlayfs/inode.c      |  5 +++-
 >  fs/overlayfs/super.c      | 49 ++++++++++++++++++++++++++++++++-------
 >  fs/overlayfs/util.c       |  1 +
 >  include/linux/writeback.h |  1 +
 >  5 files changed, 48 insertions(+), 11 deletions(-)
 >=20
 > --=20
 > 2.27.0
 >=20
 >=20
