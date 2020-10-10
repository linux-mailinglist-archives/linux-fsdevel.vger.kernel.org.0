Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37128A3FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbgJJWzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17115 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732382AbgJJWb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602339873; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bPFdI5lmODAmNuVN03rvV9d5Z58EQdVV3Z7Cbz7Hw7EZgCA91IEzHl+ObmbAxae8np6t/cagtH0Mo5yp+yZZL8z++Xov7shNdz43uM1PH45I/ZqOE0Wd5UNtVn3Ce4wqivV6z9rlFnKAukVkhk1IQo1qGV+V0m5kgWjsOm+TmKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602339873; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=2WezVly39CQFkXB4lbgvDcPDlLIRYLTPNO7O33eQLyQ=; 
        b=hBzXd5VCNxk2+qTi0Qo1L/i1Sp2hHg5RAU49nmDFQuyswivdQSFC8NXC7woh9hPuRQMlysXLTegGYJ54PUDwp8Z2oJ5qBwkVhDgO60u+OMvITN+CMIV9PhWnhW+D2Knb5QEdP0xSj9Yzy2QYBwyhZAgvuoBLp3bzeQvT/RsSa54=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602339873;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=2WezVly39CQFkXB4lbgvDcPDlLIRYLTPNO7O33eQLyQ=;
        b=dppto3P4yNNiO4Who0YhUE3cgUHLpIj0hOw95pE5Ck6Kc8vZkPtBtlP3Az5lPzpE
        /RMTm3oE09ttD9XCOlAKj1o+zOn9NcD7wl/6BfSQGLKF3jUD4hGb5XjSIZZK5TWcCpp
        iJWTpeIjqaUxogElPMqeFy1iSyaZczAumq11/mZo=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602339870186975.2760882460268; Sat, 10 Oct 2020 22:24:30 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010142355.741645-1-cgxu519@mykernel.net>
Subject: [RFC PATCH 0/5] implement containerized syncfs for overlayfs
Date:   Sat, 10 Oct 2020 22:23:50 +0800
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

Chengguang Xu (5):
  fs: introduce notifier list for vfs inode
  fs: export symbol of writeback_single_inode()
  ovl: setup overlayfs' private bdi
  ovl: monitor marking dirty activity of underlying upper inode
  ovl: impement containerized syncfs for overlayfs

 fs/fs-writeback.c         |  7 ++++-
 fs/inode.c                |  5 ++++
 fs/overlayfs/inode.c      | 28 +++++++++++++++++++-
 fs/overlayfs/overlayfs.h  |  2 ++
 fs/overlayfs/ovl_entry.h  |  2 ++
 fs/overlayfs/super.c      | 65 +++++++++++++++++++++++++++++++++++++++++++=
+---
 fs/overlayfs/util.c       | 33 ++++++++++++++++++++++++
 include/linux/fs.h        |  6 +++++
 include/linux/writeback.h |  1 +
 9 files changed, 143 insertions(+), 6 deletions(-)

--=20
1.8.3.1


