Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DBD1C99AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgEGSsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGSsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:48:10 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9DB21BE5;
        Thu,  7 May 2020 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877290;
        bh=AxvzuzDKenbxdxSwMZ81Tti9EFJdvLy5rkNw8nUbXbE=;
        h=Date:From:To:Cc:Subject:From;
        b=N+n0EjnpoI7ZMob1e6IE0Z6XvIrEvOmhe6qhLS9wNRPxbayQYhThYdNZq5aE8tsX2
         nFTeD3nkblfBq7ti7dtk6C/p6KDw+2tiidWxlKEjPcM4m1XfPzVM+fi5PF9+UOVSVK
         YDpMFG1ATX8NPy0Tdy/rTH5Yl2E8JL8ah9h83c00=
Date:   Thu, 7 May 2020 13:52:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf.c: Replace zero-length array with
 flexible-array
Message-ID: <20200507185236.GA14250@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/binfmt_elf.c         |    2 +-
 fs/hfs/btree.h          |    2 +-
 fs/hfsplus/hfsplus_fs.h |    2 +-
 fs/isofs/rock.h         |    8 ++++----
 fs/select.c             |    4 ++--
 include/linux/fs.h      |    4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..6a7f1fc26eb1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1664,7 +1664,7 @@ struct elf_thread_core_info {
 	struct elf_thread_core_info *next;
 	struct task_struct *task;
 	struct elf_prstatus prstatus;
-	struct memelfnote notes[0];
+	struct memelfnote notes[];
 };
 
 struct elf_note_info {
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index dcc2aab1b2c4..4ba45caf5939 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -60,7 +60,7 @@ struct hfs_bnode {
 	wait_queue_head_t lock_wq;
 	atomic_t refcnt;
 	unsigned int page_offset;
-	struct page *page[0];
+	struct page *page[];
 };
 
 #define HFS_BNODE_ERROR		0
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3b03fff68543..a92de5199ec3 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -117,7 +117,7 @@ struct hfs_bnode {
 	wait_queue_head_t lock_wq;
 	atomic_t refcnt;
 	unsigned int page_offset;
-	struct page *page[0];
+	struct page *page[];
 };
 
 #define HFS_BNODE_LOCK		0
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index 1558cf22ef8a..ee9660e9671c 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -22,7 +22,7 @@ struct SU_ER_s {
 	__u8 len_des;
 	__u8 len_src;
 	__u8 ext_ver;
-	__u8 data[0];
+	__u8 data[];
 } __attribute__ ((packed));
 
 struct RR_RR_s {
@@ -44,7 +44,7 @@ struct RR_PN_s {
 struct SL_component {
 	__u8 flags;
 	__u8 len;
-	__u8 text[0];
+	__u8 text[];
 } __attribute__ ((packed));
 
 struct RR_SL_s {
@@ -54,7 +54,7 @@ struct RR_SL_s {
 
 struct RR_NM_s {
 	__u8 flags;
-	char name[0];
+	char name[];
 } __attribute__ ((packed));
 
 struct RR_CL_s {
@@ -71,7 +71,7 @@ struct stamp {
 
 struct RR_TF_s {
 	__u8 flags;
-	struct stamp times[0];	/* Variable number of these beasts */
+	struct stamp times[];	/* Variable number of these beasts */
 } __attribute__ ((packed));
 
 /* Linux-specific extension for transparent decompression */
diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..f38a8a7480f7 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -97,7 +97,7 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 struct poll_table_page {
 	struct poll_table_page * next;
 	struct poll_table_entry * entry;
-	struct poll_table_entry entries[0];
+	struct poll_table_entry entries[];
 };
 
 #define POLL_TABLE_FULL(table) \
@@ -826,7 +826,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 struct poll_list {
 	struct poll_list *next;
 	int len;
-	struct pollfd entries[0];
+	struct pollfd entries[];
 };
 
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..f14635d58813 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -983,7 +983,7 @@ struct file_handle {
 	__u32 handle_bytes;
 	int handle_type;
 	/* file identifier */
-	unsigned char f_handle[0];
+	unsigned char f_handle[];
 };
 
 static inline struct file *get_file(struct file *f)
@@ -3475,7 +3475,7 @@ static inline ino_t parent_ino(struct dentry *dentry)
  */
 struct simple_transaction_argresp {
 	ssize_t size;
-	char data[0];
+	char data[];
 };
 
 #define SIMPLE_TRANSACTION_LIMIT (PAGE_SIZE - sizeof(struct simple_transaction_argresp))

