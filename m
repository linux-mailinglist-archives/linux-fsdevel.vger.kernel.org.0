Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F7415F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhIWNZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:36 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17274 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241252AbhIWNZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402521; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=L1v9aJ10+Cg+LJ2ZbCif6XWkIptsXu5lucWEt9Drkp7JdZm2GH2N3moGZSN4HNHglwtPFxKR0ZC924CsoeSGbDxEERGuzuzacIw8/K9Ud97EzMc8EaNHOskbFrWQ6hir/zsNhFaVeXx6a7ijPyA4Z95OWYIOZtMuKNzoI3Tn2rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402521; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=q/ZniZvEQNR9QMjyUGnqhtU4K3+28Lsctqx6fnG5LiE=; 
        b=PMxgor99S9g4BKqAeG9F1Y6buycIqPC3U2jAPE2XStUZ6CtxFnQ7j1FDqxOcBrR06A0h//j9KFoAuctOxcnz1RYuwHaVJN7W8YWryu34Yqvxa6rOqhZtolUhU0EZvnhXFbTv2gD6gSuVVyXTIp1FEO19WPU1W/xfyz50sejlSl4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402521;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=q/ZniZvEQNR9QMjyUGnqhtU4K3+28Lsctqx6fnG5LiE=;
        b=NjilX8d3wa3bTRR0ftONhPLUW3ClZ4ZT4AjNY4/G9Oy5qIE+SArx5y0AzSdNTT6x
        ATqxD5vlusfbfeb4Z4pfMUgsyDMTC9KcCSm80guqKs8g/o2cESFeqSAJfEdH60RjOmr
        /pPXXKKbPBWvsE5apRv+4jbUzUg0mJFAQrfE8rO0=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 163240251969041.52353362646056; Thu, 23 Sep 2021 21:08:39 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-6-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 05/10] ovl: mark overlayfs' inode dirty on shared mmap
Date:   Thu, 23 Sep 2021 21:08:09 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
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
 fs/overlayfs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d081faa55e83..f9dc5249c183 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -482,6 +482,12 @@ static int ovl_mmap(struct file *file, struct vm_area_=
struct *vma)
 =09revert_creds(old_cred);
 =09ovl_file_accessed(file);
=20
+=09if (!ret) {
+=09=09if (ovl_inode_upper(file_inode(file)) &&
+=09=09    vma->vm_flags & VM_SHARED)
+=09=09=09ovl_mark_inode_dirty(file_inode(file));
+=09}
+
 =09return ret;
 }
=20
--=20
2.27.0


