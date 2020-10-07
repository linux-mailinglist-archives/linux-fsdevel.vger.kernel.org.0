Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3C2855EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgJGBH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727390AbgJGBHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zymcGZSrOWXVIpJx2uixJqx927t3AJNvb6Oa2OBEwDQ=;
        b=im7hQvUismsePCIrF9pSsn1+qgGS95aWIrsaBH004jzb03pPsDqaxwtywlSRbSG/tumed6
        0B11eYvnVcGPvKf1dPo3ZTMVnU76+7AgsRQ6qL3OWYxwcXK+SxemYE0MwDGcLVb1SMhzNF
        Ubfe/fAtWKUyALemKfhBd7HuzGsHXpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-FMDSZ2F_MUODxG3u9BoL1g-1; Tue, 06 Oct 2020 21:07:43 -0400
X-MC-Unique: FMDSZ2F_MUODxG3u9BoL1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 494A5425CB;
        Wed,  7 Oct 2020 01:07:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD3B5D9D2;
        Wed,  7 Oct 2020 01:07:41 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 11/14] mm: add struct address_space to launder_page() callback
Date:   Tue,  6 Oct 2020 21:06:00 -0400
Message-Id: <20201007010603.3452458-12-jglisse@redhat.com>
In-Reply-To: <20201007010603.3452458-1-jglisse@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This is part of patchset to remove dependency on struct page.mapping
field so that we can temporarily update it to point to a special
structure tracking temporary page state (note that original mapping
pointer is preserved and can still be accessed but at a cost).

Add struct address_space to launder_page() callback arguments.

Note that this patch does not make use of the new argument, nor does
it use a valid one at call site (by default this patch just use NULL
for new argument value).

Use following script (from root of linux kernel tree):

./that-script.sh that-semantic-patch.spatch

%<--------------------------------------------------------------------
#!/bin/sh
spatch_file=$1

echo PART1 ===========================================================

# P1 find callback functions name
spatch  --dir . --no-includes -D part1 --sp-file $spatch_file

echo PART2 ===========================================================

# P2 change callback function prototype
cat /tmp/unicorn-functions | sort | uniq | while read func ; do
    for file in $( git grep -l $func -- '*.[ch]' ) ; do
        echo $file
        spatch --no-includes --in-place -D part2 \
               -D fn=$func --sp-file $spatch_file $file
    done
done

echo PART 3 ==========================================================

# P3 find all function which call the callback
spatch --dir . --include-headers -D part3 --sp-file $spatch_file

echo PART 4===========================================================

# P4 change all funcitons which call the callback
cat /tmp/unicorn-files | sort | uniq | while read file ; do
    echo $file
    spatch --no-includes --in-place -D part4 \
           --sp-file $spatch_file $file
done
-------------------------------------------------------------------->%

With the following semantic patch:

%<--------------------------------------------------------------------
virtual part1, part2, part3, part4

// ----------------------------------------------------------------------------
// Part 1 is grepping all function that are use as callback for launder_page.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .launder_page = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (launder_page callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
int fn(
+struct address_space *__mapping,
T1 I1) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
int fn(
+struct address_space *__mapping,
T1 I1);

@p2r3 depends on part2@
identifier virtual.fn;
type T1;
@@
int fn(
+struct address_space *__mapping,
T1);

@p2r4 depends on part2@
identifier virtual.fn;
expression E1;
@@
fn(
+MAPPING_NULL,
E1)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for launder_page.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part3@
@@
file=open('/tmp/unicorn-files', 'w')
file.write("./include/linux/pagemap.h\n")
file.write("./include/linux/mm.h\n")
file.write("./include/linux/fs.h\n")
file.write("./mm/readahead.c\n")
file.write("./mm/filemap.c\n")
file.close()

@p3r1 depends on part3 exists@
expression E1, E2;
identifier FN;
position P;
@@
FN@P(...) {...
(
E1.a_ops->launder_page(E2)
|
E1->a_ops->launder_page(E2)
)
...}

@script:python p3r2 depends on p3r1@
P << p3r1.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

// -------------------------------------------------------------------
// Part 4 generic modification
@p4r1 depends on part4@
@@
struct address_space_operations { ... int (*launder_page)(
+struct address_space *,
struct page *); ... };

@p4r2 depends on part4@
expression E1, E2;
@@
E1.a_ops->launder_page(
+MAPPING_NULL,
E2)

@p4r3 depends on part4@
expression E1, E2;
@@
E1->a_ops->launder_page(
+MAPPING_NULL,
E2)
-------------------------------------------------------------------->%

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
---
 fs/9p/vfs_addr.c    |  3 ++-
 fs/afs/internal.h   |  2 +-
 fs/afs/write.c      |  2 +-
 fs/cifs/file.c      |  3 ++-
 fs/fuse/file.c      |  3 ++-
 fs/nfs/file.c       |  3 ++-
 fs/orangefs/inode.c | 17 +++++++++--------
 include/linux/fs.h  |  2 +-
 mm/truncate.c       |  2 +-
 9 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 0ae4f31b3d7f2..0cbf9a9050d0c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -209,7 +209,8 @@ static int v9fs_vfs_writepage(struct address_space *__mapping,
  * Returns 0 on success.
  */
 
-static int v9fs_launder_page(struct page *page)
+static int v9fs_launder_page(struct address_space *__mapping,
+			     struct page *page)
 {
 	int retval;
 	struct inode *inode = page->mapping->host;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 264f28759c737..2cdf86d4200a8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1436,7 +1436,7 @@ extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
-extern int afs_launder_page(struct page *);
+extern int afs_launder_page(struct address_space *__mapping, struct page *);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 199cbf73b9be4..652b783cd280c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -890,7 +890,7 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
 /*
  * Clean up a page during invalidation.
  */
-int afs_launder_page(struct page *page)
+int afs_launder_page(struct address_space *__mapping, struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 38d79a9eafa76..c6cd5ce627e22 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4713,7 +4713,8 @@ static void cifs_invalidate_page(struct address_space *__mapping,
 		cifs_fscache_invalidate_page(page, &cifsi->vfs_inode);
 }
 
-static int cifs_launder_page(struct page *page)
+static int cifs_launder_page(struct address_space *__mapping,
+			     struct page *page)
 {
 	int rc = 0;
 	loff_t range_start = page_offset(page);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 66b31387e878f..4b0f85d0a0641 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2256,7 +2256,8 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-static int fuse_launder_page(struct page *page)
+static int fuse_launder_page(struct address_space *__mapping,
+			     struct page *page)
 {
 	int err = 0;
 	if (clear_page_dirty_for_io(page)) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ddfe95d3da057..b1ba143de48d9 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -474,7 +474,8 @@ static void nfs_check_dirty_writeback(struct page *page,
  * - Caller holds page lock
  * - Return 0 if successful, -error otherwise
  */
-static int nfs_launder_page(struct page *page)
+static int nfs_launder_page(struct address_space *__mapping,
+			    struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_inode *nfsi = NFS_I(inode);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 8b47bcbf0ca4d..883f78b5c9fcb 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,7 +244,7 @@ static int orangefs_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int orangefs_launder_page(struct page *);
+static int orangefs_launder_page(struct address_space *, struct page *);
 
 static int orangefs_readpage(struct file *file,
 			     struct address_space *__mapping,
@@ -273,7 +273,7 @@ static int orangefs_readpage(struct file *file,
 	read_size = 524288;
 
 	if (PageDirty(page))
-		orangefs_launder_page(page);
+		orangefs_launder_page(MAPPING_NULL, page);
 
 	off = page_offset(page);
 	index = off >> PAGE_SHIFT;
@@ -381,7 +381,7 @@ static int orangefs_write_begin(struct file *file,
 		 * since we don't know what's dirty.  This will WARN in
 		 * orangefs_writepage_locked.
 		 */
-		ret = orangefs_launder_page(page);
+		ret = orangefs_launder_page(MAPPING_NULL, page);
 		if (ret)
 			return ret;
 	}
@@ -394,7 +394,7 @@ static int orangefs_write_begin(struct file *file,
 			wr->len += len;
 			goto okay;
 		} else {
-			ret = orangefs_launder_page(page);
+			ret = orangefs_launder_page(MAPPING_NULL, page);
 			if (ret)
 				return ret;
 		}
@@ -517,7 +517,7 @@ static void orangefs_invalidatepage(struct address_space *__mapping,
 	 * Thus the following runs if wr was modified above.
 	 */
 
-	orangefs_launder_page(page);
+	orangefs_launder_page(MAPPING_NULL, page);
 }
 
 static int orangefs_releasepage(struct address_space *__mapping,
@@ -532,7 +532,8 @@ static void orangefs_freepage(struct address_space *__mapping,
 	kfree(detach_page_private(page));
 }
 
-static int orangefs_launder_page(struct page *page)
+static int orangefs_launder_page(struct address_space *__mapping,
+				 struct page *page)
 {
 	int r = 0;
 	struct writeback_control wbc = {
@@ -701,7 +702,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 		 * since we don't know what's dirty.  This will WARN in
 		 * orangefs_writepage_locked.
 		 */
-		if (orangefs_launder_page(page)) {
+		if (orangefs_launder_page(MAPPING_NULL, page)) {
 			ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 			goto out;
 		}
@@ -714,7 +715,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 			wr->len = PAGE_SIZE;
 			goto okay;
 		} else {
-			if (orangefs_launder_page(page)) {
+			if (orangefs_launder_page(MAPPING_NULL, page)) {
 				ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 				goto out;
 			}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4d0b9c14a5017..3854da5a1bcb9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -410,7 +410,7 @@ struct address_space_operations {
 			struct page *, struct page *, enum migrate_mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct address_space *, struct page *);
-	int (*launder_page) (struct page *);
+	int (*launder_page) (struct address_space *, struct page *);
 	int (*is_partially_uptodate) (struct page *, unsigned long,
 					unsigned long);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
diff --git a/mm/truncate.c b/mm/truncate.c
index e24688115c903..c0719e141e34e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -668,7 +668,7 @@ static int do_launder_page(struct address_space *mapping, struct page *page)
 		return 0;
 	if (page->mapping != mapping || mapping->a_ops->launder_page == NULL)
 		return 0;
-	return mapping->a_ops->launder_page(page);
+	return mapping->a_ops->launder_page(MAPPING_NULL, page);
 }
 
 /**
-- 
2.26.2

