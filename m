Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91C4842AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiADNmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 08:42:12 -0500
Received: from mail-m2838.qiye.163.com ([103.74.28.38]:60538 "EHLO
        mail-m2838.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiADNmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:42:11 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 08:42:11 EST
Received: from localhost.localdomain (unknown [106.75.220.2])
        by mail-m2838.qiye.163.com (Hmail) with ESMTPA id A99833C01A5;
        Tue,  4 Jan 2022 21:34:05 +0800 (CST)
From:   wanghonghui <wanghonghui@ucloud.cn>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, wanghonghui <wanghonghui@ucloud.cn>
Subject: [PATCH 1/1] fuse: fix memleak in fuse_writepage_locked
Date:   Tue,  4 Jan 2022 21:34:04 +0800
Message-Id: <20220104133404.69073-1-wanghonghui@ucloud.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlCN1dZLVlBSVdZDwkaFQgSH1lBWUMdTh5WSEpCTk9LSB1DSU
        1DVRkRExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Hhw6NjI8OENPSx0xLRlR
        HQwKCyFVSlVKTU9KSEtISU9NSEJPVTMWGhIXVQwaFRwTFBUcEw4SOw4YFxQOH1UYFUVZV1kSC1lB
        WUpLTVVMTlVJSUtVSVlXWQgBWUFKT0lKNwY+
X-HM-Tid: 0a7e254c04c78420kuqwa99833c01a5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In function fuse_writepage_args_alloc, both wpa's memory and
wpa->ia.ap->pages's memory were allocated，but when failed
it only free wpa's memory

We need free wpa->ia.ap->pages's memory before free wpa

Signed-off-by: Wang Honghui <wanghonghui@ucloud.cn>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..c89966d7dbcc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1949,6 +1949,7 @@ static int fuse_writepage_locked(struct page *page)
 err_nofile:
 	__free_page(tmp_page);
 err_free:
+	kfree(ap->pages);
 	kfree(wpa);
 err:
 	mapping_set_error(page->mapping, error);
-- 
2.25.1

