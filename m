Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA0297FF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766974AbgJYDmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:31 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17199 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762999AbgJYDma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597313; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=OXNIMd6e44eQsDLxJ5RrF753isJteQQLy2C7tHD3npEbJMvfjgpjUhrsHwRh1MdOpi7UZ5gsma2L7Ej2rdqXHrRA0LB+sL6Yg2Q2MBa69NI2+i7yMMvdEPqB8aQTLndP9NdVrgKxl9+h4nGOtms7IP0hCNZQ2jzSLozjUNtlvpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597313; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qENuAASwi2X1PpN6zhOfZQmsRqffxawsli97zMDsaBw=; 
        b=X8wgJjnpl/vqPBpUw1mGjdxefGJ/HnXXUW3x2p7wB1ZJRKNH+41FX0HMkpztnJeyDqTY1JlUIyQ44C28IWuQzSSL73GlacgdfuXo6rVHzKaM1V0pnDuvHGCUBB4I69EKDS/TTaupudYDsElutuBlx7bMbYLvzliS7W59+OLr4+o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597313;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=qENuAASwi2X1PpN6zhOfZQmsRqffxawsli97zMDsaBw=;
        b=SVpGgyM2DqAK0A217fGIwG80M/r6vQ1gZYST9G2lAoGa+LvgA+G0hHM/WJcDCpdI
        vSgGjVzkkv5pUSxjzHWWRMFGAx84HHJC/PlPSASD/r/TOqaIAaZj6rxzfz67JAtrRrE
        F+jgUafLpZ5W3LUZmewkoh6ZGdnf2PGD2fzGMExM=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597312402239.5387742402878; Sun, 25 Oct 2020 11:41:52 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-6-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared writable mmap
Date:   Sun, 25 Oct 2020 11:41:14 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025034117.4918-1-cgxu519@mykernel.net>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs cannot be notified when mmapped area gets dirty,
so we need to proactively mark inode dirty in ->mmap operation.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..cd6fcdfd81a9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, struct vm_area_=
struct *vma)
 =09=09/* Drop reference count from new vm_file value */
 =09=09fput(realfile);
 =09} else {
+=09=09if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
+=09=09    vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
+=09=09=09ovl_mark_inode_dirty(file_inode(file));
+
 =09=09/* Drop reference count from previous vm_file value */
 =09=09fput(file);
 =09}
--=20
2.26.2


