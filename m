Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181F6150205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 08:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgBCHhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 02:37:43 -0500
Received: from m12-11.163.com ([220.181.12.11]:52557 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgBCHhm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 02:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o3Tkh
        9ug+o/6puv66scuZdDiGZSDYt1HdEg9ceqFI74=; b=eZQl/EcPQzzY4GyQRBsqo
        VDRzNpAdE7TthZnwLNu44F/Nlcgk4rRaxMZ0Zca6+HE6lqmwrM+/YUfEX/u9mKOs
        dfZvrJR/cQBs061n8hNm0QTNtvCHqo+vpBmBcR70PBHptk58VHiDGVwmLwSsePeV
        6sUknayCoZA5vYoV8GZ42M=
Received: from localhost.localdomain (unknown [183.211.129.68])
        by smtp7 (Coremail) with SMTP id C8CowAA3PSGWzTdefosHJQ--.43826S2;
        Mon, 03 Feb 2020 15:36:56 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, yangx.jy@cn.fujitsu.com,
        Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] fuse: Don't make buffered read forward overflow value to a userspace process
Date:   Mon,  3 Feb 2020 15:36:52 +0800
Message-Id: <20200203073652.12067-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3PSGWzTdefosHJQ--.43826S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kXr1UJFy3Zw15tr4Utwb_yoW5urWfpF
        ZxJ3W3AayxJFy3CrsrArn5Zr1fCwn3GFWIqrWxW3yrX3W2yF9Yk3ZIgF1rury8WrWkCr12
        qr4DKr17ur1DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC385UUUUU=
X-Originating-IP: [183.211.129.68]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqBm+Xlc7NRQeiAAAsK
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Buffered read in fuse normally goes via:
-> generic_file_buffered_read()
  ------------------------------
  -> fuse_readpages()
    -> fuse_send_readpages()
  or
  -> fuse_readpage() [if fuse_readpages() fails to get page]
    -> fuse_do_readpage()
  ------------------------------
      -> fuse_simple_request()

Buffered read changes original offset to page-aligned length by left-shift
and extends original count to be multiples of PAGE_SIZE and then fuse
forwards these new parameters to a userspace process, so it is possible
for the resulting offset(e.g page-aligned offset + extended count) to
exceed the whole file size(even the max value of off_t) when the userspace
process does read with new parameters.

xfstests generic/525 gets "pread: Invalid argument" error on virtiofs
because it triggers this issue.  See the following explanation:
PAGE_SIZE: 4096, file size: 2^63 - 1
Original: offset: 2^63 - 2, count: 1
Changed by buffered read: offset: 2^63 - 4096, count: 4096
New offset + new count exceeds the file size as well as LLONG_MAX

Make fuse calculate the number of bytes of data pages contain as
nfs_page_length() and generic_file_buffered_read() do, and then forward
page-aligned offset and normal count to a userspace process.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 fs/fuse/file.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce715380143c..5afc4b623eaf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,23 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 
+static unsigned int fuse_page_length(struct page *page)
+{
+	loff_t i_size = i_size_read(page->mapping->host);
+
+	if (i_size > 0) {
+		pgoff_t index = page_index(page);
+		pgoff_t end_index = (i_size - 1) >> PAGE_SHIFT;
+
+		if (index < end_index)
+			return PAGE_SIZE;
+		if (index == end_index)
+			return ((i_size - 1) & ~PAGE_MASK) + 1;
+	}
+
+	return 0;
+}
+
 static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 				      struct fuse_page_desc **desc)
 {
@@ -783,7 +800,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	struct inode *inode = page->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t pos = page_offset(page);
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct fuse_page_desc desc = { .length = fuse_page_length(page) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
@@ -881,9 +898,12 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	struct fuse_conn *fc = ff->fc;
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = page_offset(ap->pages[0]);
-	size_t count = ap->num_pages << PAGE_SHIFT;
+	size_t count = 0;
 	ssize_t res;
-	int err;
+	int err, i;
+
+	for (i = 0; i < ap->num_pages; i++)
+		count += ap->descs[i].length;
 
 	ap->args.out_pages = true;
 	ap->args.page_zeroing = true;
@@ -944,7 +964,7 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 
 	get_page(page);
 	ap->pages[ap->num_pages] = page;
-	ap->descs[ap->num_pages].length = PAGE_SIZE;
+	ap->descs[ap->num_pages].length = fuse_page_length(page);
 	ap->num_pages++;
 	data->nr_pages--;
 	return 0;
-- 
2.21.0


