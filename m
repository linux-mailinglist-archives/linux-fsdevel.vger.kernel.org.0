Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5A297FF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766967AbgJYDm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:28 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17197 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766958AbgJYDm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597312; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=QTdiBc2C9xce0IadyMG5t2XEq2sv9BMm1TUGZVSDvfTeVdm1Jf/8sdDmjcRSL23zj5uojnzm6Yix574oTTDwRWmzi5Jk/uMvFxjpR7+UzXoB5YK7wMJhc9aQiQF5nayzIRbvsbvIJu5QVbSAN1j2WUyJ9U9FJMDIdcunVDT7UxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597312; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=whkdWBX4YYmNu9HrxGNBjvSFZHvEVO3fka8tRUjbQVI=; 
        b=m6iA4zWa4rHDG8VZQ7mSv6cVGyCGFvcfqE4ONDMWluIRL937lnhbD8JxRVbINQKgEW30Z2cG7WL+xnJ7tF+DU83WqHzKqsRgIRCxuez49nv+zmr2UHZkSLepL+po1gvsOVu49JHK8JRAVGlfxtfG57Le8aD7iezrypbzAmAgm30=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597312;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=whkdWBX4YYmNu9HrxGNBjvSFZHvEVO3fka8tRUjbQVI=;
        b=VfMVGjzglsaAttXGU5EwrIRylXVpa4Bfu75hxsBlOTSCxavrdNDUZdVrAPnckHbF
        vMVKYKR371sFbEo8dMneONOiwuq9UrPJhNmptynkV1MwFkNwE6VE3A4gE65J/X3NPhR
        VClRjjTx4PWHFm8brSEFjhNfEmzlx4+EKRp0J7m4=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597310890707.4740275305193; Sun, 25 Oct 2020 11:41:50 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-4-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 3/8] ovl: implement overlayfs' ->evict_inode operation
Date:   Sun, 25 Oct 2020 11:41:12 +0800
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

Implement overlayfs' ->evict_inode operation,
so that we can clear all inode dirty flags.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d1e546abce87..5d7e12b8bd1f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -390,11 +390,18 @@ static int ovl_remount(struct super_block *sb, int *f=
lags, char *data)
 =09return ret;
 }
=20
+static void ovl_evict_inode(struct inode *inode)
+{
+=09inode->i_state &=3D ~I_DIRTY_ALL;
+=09clear_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
+=09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.26.2


