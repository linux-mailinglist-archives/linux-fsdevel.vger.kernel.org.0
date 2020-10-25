Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D654B297FF4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766971AbgJYDm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:29 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17125 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766957AbgJYDm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597308; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FNVGXDhxZoz6Ul9AFcfLJybNp8YiNd159aqzNaSEyoLtg6yx2ToBcUVuOHyqVHAcV5ss/QW+00msL5QYQxUrbEuZRvp1Q6EUN1KVbapVZP3Pp2Fd//s/7GaxO9sR16nbuX2A9bn8l8dQgsX7SpKgGVhEa8giw148wS5va+p/dEU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=amR8D51nArECdFOuV4RT+qjPLX4OfYmT1sVy0jub5v8=; 
        b=Bh1ik6xw6qBAY55fcomy/hqvOasQY+bvIPDizv8Xng+XfrACPbvPXQEyEvwxAyV/PPzhTn1MvWQyQuvV0BjjeXDDO4CvrpuoDjDaRsbU1VIhGy0d7a6698ODuEReWSqHthNEUiGk3Ye3KuWoKObAjNsyF55bELA3lP4EJ8Lawrg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597308;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=amR8D51nArECdFOuV4RT+qjPLX4OfYmT1sVy0jub5v8=;
        b=EEdRFOFINDS0E6DKeDGaErw/3HdMLSs4kK3jL47u20sUCfK2GvkdZywCn2IedjHt
        zlEMICMHp9mtv8OwsFEAw9B/+1ndMtFrSN8v+LPVTPnVWgS26wOyKaii+9k0lq0Cm8O
        MA8j6SKDvABKuMDqg+XtPrhNvsva4VR9mNvN7Abw=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597305591527.8547126485264; Sun, 25 Oct 2020 11:41:45 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-1-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 0/8] implement containerized syncfs for overlayfs
Date:   Sun, 25 Oct 2020 11:41:09 +0800
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
will not seriously impact IO performance of unrelated processes.=20

v1->v2:
- Mark overlayfs' inode dirty itself instead of adding notification
  mechanism to vfs inode.

Chengguang Xu (8):
  ovl: setup overlayfs' private bdi
  ovl: implement ->writepages operation
  ovl: implement overlayfs' ->evict_inode operation
  ovl: mark overlayfs' inode dirty on modification
  ovl: mark overlayfs' inode dirty on shared writable mmap
  ovl: implement overlayfs' ->write_inode operation
  ovl: cache dirty overlayfs' inode
  ovl: implement containerized syncfs for overlayfs

 fs/overlayfs/file.c      |  4 +++
 fs/overlayfs/inode.c     | 27 +++++++++++++++++++
 fs/overlayfs/overlayfs.h |  4 +++
 fs/overlayfs/super.c     | 57 +++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/util.c      | 14 ++++++++++
 5 files changed, 102 insertions(+), 4 deletions(-)

--=20
2.26.2


