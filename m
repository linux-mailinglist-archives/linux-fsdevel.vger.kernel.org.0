Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0928A400
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbgJJWzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17154 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732238AbgJJWa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602339876; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=o0XgfDzrLhaLolAC+Fo1Cq1ZVQUT7wOj/2MLhRYrWnbAALCmTTyjSdPhRQA4akZUDU8yTE1f+xoeI7cD7YZ0/z8UUui8x9wpFVVIe7IIhH43MMzpwkjtgFnyDuWrRJAaHOj4ILAVRHMEyPuv3u3FOtKpe5fDtgIoLhr1pAKvhPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602339876; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=PKNKgablcu7j3TI+7ffDpQgt0x5QI9ih4uFalISl4Oc=; 
        b=eEJRyO9UOnPM/BEmeyyGZPWTpl8NKRItRoJ8tecmvrCZqQdZepz6LRBT1n0ERRmJ+h5B+7/3lhU6Ludiql80u7N9/VaAYLB7gIcxI0eutibF1M6UjkXJj7AnFogwSOHA08y2snGtT84Kb5ZaLz05+6llSSWhYve9TtGVDvzZRJU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602339876;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=PKNKgablcu7j3TI+7ffDpQgt0x5QI9ih4uFalISl4Oc=;
        b=PwkeX51ZEOemqmnz1tmjJX9mW2FGt5FSEKkUNWUUbhhaM6GqxQOh7quq/T9h2/du
        poRSJdlVCuz9hB393jJusA6zQGmdcO+1ZcFQdjaYlQyGWr/0hcFmC/hb2Vd0/DXYekH
        duWxleY643e6SfpN6DcAZPORyudkvxhZG/+2q3+U=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602339875640752.6640053551042; Sat, 10 Oct 2020 22:24:35 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010142355.741645-3-cgxu519@mykernel.net>
Subject: [RFC PATCH 2/5] fs: export symbol of writeback_single_inode()
Date:   Sat, 10 Oct 2020 22:23:52 +0800
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

Export symbol of writeback_single_inode() in order to call it
from overlayfs' ->writepages when sync single inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/fs-writeback.c         | 3 ++-
 include/linux/writeback.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 657cceb..4fed058 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1529,7 +1529,7 @@ static void requeue_inode(struct inode *inode, struct=
 bdi_writeback *wb,
  * we go e.g. from filesystem. Flusher thread uses __writeback_single_inod=
e()
  * and does more profound writeback list handling in writeback_sb_inodes()=
.
  */
-static int writeback_single_inode(struct inode *inode,
+int writeback_single_inode(struct inode *inode,
 =09=09=09=09  struct writeback_control *wbc)
 {
 =09struct bdi_writeback *wb;
@@ -1585,6 +1585,7 @@ static int writeback_single_inode(struct inode *inode=
,
 =09spin_unlock(&inode->i_lock);
 =09return ret;
 }
+EXPORT_SYMBOL(writeback_single_inode);
=20
 static long writeback_chunk_size(struct bdi_writeback *wb,
 =09=09=09=09 struct wb_writeback_work *work)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8e5c5bb..78e3b10 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -403,4 +403,5 @@ void tag_pages_for_writeback(struct address_space *mapp=
ing,
 void sb_mark_inode_writeback(struct inode *inode);
 void sb_clear_inode_writeback(struct inode *inode);
=20
+int writeback_single_inode(struct inode *inode, struct writeback_control *=
wbc);
 #endif=09=09/* WRITEBACK_H */
--=20
1.8.3.1


