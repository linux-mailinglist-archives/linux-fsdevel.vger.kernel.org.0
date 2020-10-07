Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD32855FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgJGBIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbgJGBHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLLucBCIBAYY4T9k9PCSfZE+b/O6EDJMq0Cb0JZZegg=;
        b=AyyscSuEP/4AlLmauFJjeiDIzjgua4ddGCHsWLc+0+hpYVYz5q8//gRHwjVIszkt5UMVz/
        pSoNovO1exIklLobVoJE7qjaqryZGDeLVInWSFUOV0u4mDz7qYCSuYs5+bsUPyYuH8qGAP
        h8nKkCGwW4a9/24MkBp+nwjX8og0lSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-XUQrriEnOvquDgeLVrPR9g-1; Tue, 06 Oct 2020 21:07:38 -0400
X-MC-Unique: XUQrriEnOvquDgeLVrPR9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D52480400C;
        Wed,  7 Oct 2020 01:07:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45B455D9DD;
        Wed,  7 Oct 2020 01:07:36 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 09/14] mm: add struct address_space to freepage() callback
Date:   Tue,  6 Oct 2020 21:05:58 -0400
Message-Id: <20201007010603.3452458-10-jglisse@redhat.com>
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

Add struct address_space to freepage() callback arguments.

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
// Part 1 is grepping all function that are use as callback for freepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .freepage = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (freepage callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
void fn(
+struct address_space *__mapping,
T1 I1) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
void fn(
+struct address_space *__mapping,
T1 I1);

@p2r3 depends on part2@
identifier virtual.fn;
expression E1;
@@
fn(
+MAPPING_NULL,
E1)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that use the callback for freepage.

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
E1.a_ops->freepage(E2)
|
E1->a_ops->freepage(E2)
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
struct address_space_operations { ... void (*freepage)(
+struct address_space *,
struct page *, ...); ... };

@p4r2 depends on part4@
expression E1, E2;
@@
E1.a_ops->freepage(
+MAPPING_NULL,
E2)

@p4r3 depends on part4@
expression E1, E2;
@@
E1->a_ops->freepage(
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
 fs/nfs/dir.c        | 9 +++++----
 fs/orangefs/inode.c | 3 ++-
 include/linux/fs.h  | 2 +-
 mm/filemap.c        | 4 ++--
 mm/truncate.c       | 2 +-
 mm/vmscan.c         | 2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5a5c021967d3f..d8e66c98db3ea 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -53,7 +53,7 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
-static void nfs_readdir_clear_array(struct page*);
+static void nfs_readdir_clear_array(struct address_space *, struct page*);
 
 const struct file_operations nfs_dir_operations = {
 	.llseek		= nfs_llseek_dir,
@@ -177,7 +177,8 @@ void nfs_readdir_init_array(struct page *page)
  * we are freeing strings created by nfs_add_to_readdir_array()
  */
 static
-void nfs_readdir_clear_array(struct page *page)
+void nfs_readdir_clear_array(struct address_space *__mapping,
+			     struct page *page)
 {
 	struct nfs_cache_array *array;
 	int i;
@@ -725,7 +726,7 @@ int nfs_readdir_filler(void *data, struct address_space *__mapping,
 	unlock_page(page);
 	return 0;
  error:
-	nfs_readdir_clear_array(page);
+	nfs_readdir_clear_array(MAPPING_NULL, page);
 	unlock_page(page);
 	return ret;
 }
@@ -875,7 +876,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	status = nfs_do_filldir(desc);
 
  out_release:
-	nfs_readdir_clear_array(desc->page);
+	nfs_readdir_clear_array(MAPPING_NULL, desc->page);
 	cache_page_release(desc);
  out:
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 1534dc2df6e5c..8b47bcbf0ca4d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -526,7 +526,8 @@ static int orangefs_releasepage(struct address_space *__mapping,
 	return !PagePrivate(page);
 }
 
-static void orangefs_freepage(struct page *page)
+static void orangefs_freepage(struct address_space *__mapping,
+			      struct page *page)
 {
 	kfree(detach_page_private(page));
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 989e505de9182..a952aa9d93e7f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -400,7 +400,7 @@ struct address_space_operations {
 	void (*invalidatepage) (struct address_space *, struct page *,
 				unsigned int, unsigned int);
 	int (*releasepage) (struct address_space *, struct page *, gfp_t);
-	void (*freepage)(struct page *);
+	void (*freepage)(struct address_space *, struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a page to the specified target. If
diff --git a/mm/filemap.c b/mm/filemap.c
index eccd5d0554851..faa190598cba8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -243,7 +243,7 @@ static void page_cache_free_page(struct address_space *mapping,
 				struct page *page)
 {
 	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(page);
+		mapping->a_ops->freepage(MAPPING_NULL, page);
 
 	if (PageTransHuge(page) && !PageHuge(page)) {
 		page_ref_sub(page, HPAGE_PMD_NR);
@@ -816,7 +816,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 		__inc_lruvec_page_state(new, NR_SHMEM);
 	xas_unlock_irqrestore(&xas, flags);
 	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(old);
+		mapping->a_ops->freepage(MAPPING_NULL, old);
 	put_page(old);
 
 	return 0;
diff --git a/mm/truncate.c b/mm/truncate.c
index e26b232b66c01..e24688115c903 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -653,7 +653,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 	if (mapping->a_ops->freepage)
-		mapping->a_ops->freepage(page);
+		mapping->a_ops->freepage(MAPPING_NULL, page);
 
 	put_page(page);	/* pagecache ref */
 	return 1;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4322bc5ee2d84..bae7fb9c3512a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -926,7 +926,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
 		if (mapping->a_ops->freepage != NULL)
-			mapping->a_ops->freepage(page);
+			mapping->a_ops->freepage(MAPPING_NULL, page);
 	}
 
 	return 1;
-- 
2.26.2

