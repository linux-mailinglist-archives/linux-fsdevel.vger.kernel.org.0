Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CC28A3FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbgJJWzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:31 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17181 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732273AbgJJW3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602339876; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ld5axifpYmggLMNKwjpSiHMQv3zHxPROcfCfY31kgcrMjblGARNtYjQvDSU8NwOU2lk0sFxqobEzhMIlNiZkL0fs8SwGF1bupNaWwcGkRkYYpi1/4VCXu5Ia8NoD7/nECRk0PYvNeum7Z3fYe5fw3od4hvzAcaPAFlBINK+MrqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602339876; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ob6gtty8CKcWnyhHF51iR2Jm1W5BIkv8XCbcpwIKzR4=; 
        b=nEavnOoinZPqFEcTPz8iStxhszHWrMgA38MUdaYAiAN3rCc3JUQmc6TwejlEclGNcLl4E9LpRvRF3TLZFoenwLzuqP/PfYfr+LAVuPA0XJH9SnfpsMhmiVbVYxKCQQaQezQ29tGObIhP91BMUlQD8XkAosL+FgFi/oQgyRrJsXw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602339876;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Ob6gtty8CKcWnyhHF51iR2Jm1W5BIkv8XCbcpwIKzR4=;
        b=CbRSjn0uXvUvklyXUDbv0KxabNG2QjVN7Xy5iarp6pbg2culca2bUdEyVtQKRG61
        3ZfX7dIQPXVZlvYUGyeTahrmcQcIvbUdswUiQAL4jzxNFHNAu9io23d0u9pdhpvyhnq
        ug1B7ebFQG/CsLawQ7OpGQjGt+FZMFEWyPxKbEDY=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602339873451692.2946213139279; Sat, 10 Oct 2020 22:24:33 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010142355.741645-2-cgxu519@mykernel.net>
Subject: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
Date:   Sat, 10 Oct 2020 22:23:51 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010142355.741645-1-cgxu519@mykernel.net>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there is no notification api for kernel about modification
of vfs inode, in some use cases like overlayfs, this kind of notification
will be very helpful to implement containerized syncfs functionality.
As the first attempt, we introduce marking inode dirty notification so that
overlay's inode could mark itself dirty as well and then only sync dirty
overlay inode while syncfs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/fs-writeback.c  | 4 ++++
 fs/inode.c         | 5 +++++
 include/linux/fs.h | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1492271..657cceb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2246,9 +2246,13 @@ void __mark_inode_dirty(struct inode *inode, int fla=
gs)
 {
 =09struct super_block *sb =3D inode->i_sb;
 =09int dirtytime;
+=09int copy_flags =3D flags;
=20
 =09trace_writeback_mark_inode_dirty(inode, flags);
=20
+=09blocking_notifier_call_chain(
+=09=09&inode->notifier_lists[MARK_INODE_DIRTY_NOTIFIER],
+=09=090, &copy_flags);
 =09/*
 =09 * Don't do this for I_DIRTY_PAGES - that doesn't actually
 =09 * dirty the inode itself
diff --git a/fs/inode.c b/fs/inode.c
index 72c4c34..84e82db 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -388,12 +388,17 @@ void address_space_init_once(struct address_space *ma=
pping)
  */
 void inode_init_once(struct inode *inode)
 {
+=09int i;
+
 =09memset(inode, 0, sizeof(*inode));
 =09INIT_HLIST_NODE(&inode->i_hash);
 =09INIT_LIST_HEAD(&inode->i_devices);
 =09INIT_LIST_HEAD(&inode->i_io_list);
 =09INIT_LIST_HEAD(&inode->i_wb_list);
 =09INIT_LIST_HEAD(&inode->i_lru);
+=09for (i =3D 0; i < INODE_MAX_NOTIFIER; i++)
+=09=09BLOCKING_INIT_NOTIFIER_HEAD(
+=09=09=09&inode->notifier_lists[MARK_INODE_DIRTY_NOTIFIER]);
 =09__address_space_init_once(&inode->i_data);
 =09i_size_ordered_init(inode);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae0..42f0750 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -607,6 +607,11 @@ static inline void mapping_allow_writable(struct addre=
ss_space *mapping)
=20
 struct fsnotify_mark_connector;
=20
+enum {
+=09MARK_INODE_DIRTY_NOTIFIER,
+=09INODE_MAX_NOTIFIER,
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -723,6 +728,7 @@ struct inode {
 #endif
=20
 =09void=09=09=09*i_private; /* fs or device private pointer */
+=09struct=09blocking_notifier_head notifier_lists[INODE_MAX_NOTIFIER];
 } __randomize_layout;
=20
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *in=
ode);
--=20
1.8.3.1


