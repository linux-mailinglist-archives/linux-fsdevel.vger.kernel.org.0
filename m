Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7BE2B1605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKMG5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:21 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17162 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgKMG5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250627; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=GAi4+scx30iIHDnQN8YCi8kPmibojRiC1FboyzwiUs3piRyG31gttKNs1SKzfEXDgFayZCYtauq5ks1MYGardyeSv0cnlsfStvpmkzkE1cyw6P4oLSN8G5uVWFqsJbsSM3MW1R8Af14P8A20nL68vepomrrLootZKZ6HtYV2AF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250627; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1rMQp9IOJti8/XXgWXenT0wQ+WQ0Zev3weD9o9T459I=; 
        b=QP85FMNbWwqOXKdfH6a86uUAjNbKK+sWeUcXLyumyO1aBCnWZ3iakaqiydT4t5fa7vpS/O68V7X0znLRGd8R3W1Kb6LhG/15YChfH6Y6OBcvJkoDv7iy3BYA8I1q5xnbVLlrSlJV6LeSVWMmgVzBP46hK7Gof2kfo9LXJa1IbT8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250627;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=1rMQp9IOJti8/XXgWXenT0wQ+WQ0Zev3weD9o9T459I=;
        b=fN1p3qHEb+RkQXh5kATudlJLkscCBLjZJF9XA2CpOcYW4FqUcz5GkqG/0PLe1myh
        O1hpTb6RjClskoKM16lFtpbXkKrD9s6Lkr/HSO5Luee3lPq0/dTBQNxkgJ9X+9BLaks
        J8aJPww2KCevNyii3xXDb01qTT+NJinq+cSn6DGE=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250625956931.8249748923657; Fri, 13 Nov 2020 14:57:05 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-6-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 5/9] ovl: mark overlayfs' inode dirty on shared mmap
Date:   Fri, 13 Nov 2020 14:55:51 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113065555.147276-1-cgxu519@mykernel.net>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
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
 fs/overlayfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..3f9de5343513 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -486,6 +486,9 @@ static int ovl_mmap(struct file *file, struct vm_area_s=
truct *vma)
 =09=09/* Drop reference count from new vm_file value */
 =09=09fput(realfile);
 =09} else {
+=09=09if (ovl_inode_upper(file_inode(file)) &&
+=09=09    vma->vm_flags & VM_SHARED)
+=09=09=09ovl_mark_inode_dirty(file_inode(file));
 =09=09/* Drop reference count from previous vm_file value */
 =09=09fput(file);
 =09}
--=20
2.26.2


