Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2442855F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgJGBH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbgJGBHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8JlkirHab7R6tb/5VeyHeLb4GW/ljQVqPPREaFgnMY=;
        b=bdkFfaZltr0G+yYruCceXigivYtbp62y1WFFevUbPs4l7Dn8VJbUQ4Q76/lrieHMbmL+3/
        QGCWKz840LUmawJXqy46g9KOXqTp4ktcPq4rRAfbr90hBrX9dnaPuFfq7yM44/+DDPGtDt
        T6dYU+ZpOrHWvcUE0yeHI/Vjku6Gfjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-74yG6wIeMJetf6EgMEydjg-1; Tue, 06 Oct 2020 21:07:45 -0400
X-MC-Unique: 74yG6wIeMJetf6EgMEydjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7999E1009442;
        Wed,  7 Oct 2020 01:07:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0385D9D2;
        Wed,  7 Oct 2020 01:07:42 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 12/14] mm: add struct address_space to is_partially_uptodate() callback
Date:   Tue,  6 Oct 2020 21:06:01 -0400
Message-Id: <20201007010603.3452458-13-jglisse@redhat.com>
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

Add struct address_space to is_partially_uptodate() callback arguments.

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
// Part 1 is grepping all function that are use as callback for is_partially_uptodate.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .is_partially_uptodate = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (is_partially_uptodate callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
int fn(
+struct address_space *__mapping,
T1 I1, T2 I2, T3 I3) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
int fn(
+struct address_space *__mapping,
T1 I1, T2 I2, T3 I3);

@p2r3 depends on part2@
identifier virtual.fn;
expression E1, E2, E3;
@@
fn(
+MAPPING_NULL,
E1, E2, E3)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for is_partially_uptodate.

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
expression E1, E2, E3, E4;
identifier FN;
position P;
@@
FN@P(...) {...
(
E1.a_ops->is_partially_uptodate(E2, E3, E4)
|
E1->a_ops->is_partially_uptodate(E2, E3, E4)
)
...}

@script:python p3r2 depends on p3r1@
P << p3r1.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

@p3r3 depends on part3 exists@
struct address_space_operations *AOPS;
expression E1, E2, E3;
identifier FN;
position P;
@@
FN@P(...) {...
AOPS->is_partially_uptodate(E1, E2, E3)
...}

@script:python p3r4 depends on p3r3@
P << p3r3.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

// -------------------------------------------------------------------
// Part 4 generic modification
@p4r1 depends on part4@
@@
struct address_space_operations { ... int (*is_partially_uptodate)(
+struct address_space *,
struct page *, ...); ... };

@p4r2 depends on part4@
expression E1, E2, E3, E4;
@@
E1.a_ops->is_partially_uptodate(
+MAPPING_NULL,
E2, E3, E4)

@p4r3 depends on part4@
expression E1, E2, E3, E4;
@@
E1->a_ops->is_partially_uptodate(
+MAPPING_NULL,
E2, E3, E4)

@p4r4 depends on part4 exists@
struct address_space_operations *AOPS;
expression E1, E2, E3;
@@
{...
AOPS->is_partially_uptodate(
+MAPPING_NULL,
E1, E2, E3)
...}
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
 fs/buffer.c                 | 3 ++-
 fs/iomap/buffered-io.c      | 5 +++--
 fs/iomap/seek.c             | 2 +-
 include/linux/buffer_head.h | 3 ++-
 include/linux/fs.h          | 3 ++-
 include/linux/iomap.h       | 5 +++--
 mm/filemap.c                | 4 ++--
 7 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1f0f72b76fc2a..7adf0af7530ba 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2213,7 +2213,8 @@ EXPORT_SYMBOL(generic_write_end);
  * Returns true if all buffers which correspond to a file portion
  * we want to read are uptodate.
  */
-int block_is_partially_uptodate(struct page *page, unsigned long from,
+int block_is_partially_uptodate(struct address_space *__mapping,
+				struct page *page, unsigned long from,
 					unsigned long count)
 {
 	unsigned block_start, block_end, blocksize;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 091f6656f3d6b..c2c8b3f173443 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -449,8 +449,9 @@ EXPORT_SYMBOL_GPL(iomap_readahead);
  * we want to read within the page are uptodate.
  */
 int
-iomap_is_partially_uptodate(struct page *page, unsigned long from,
-		unsigned long count)
+iomap_is_partially_uptodate(struct address_space *__mapping,
+			    struct page *page, unsigned long from,
+			    unsigned long count)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 	struct inode *inode = page->mapping->host;
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 107ee80c35683..3f09cc0979a4a 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -49,7 +49,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
 	for (off = 0; off < PAGE_SIZE; off += bsize) {
 		if (offset_in_page(*lastoff) >= off + bsize)
 			continue;
-		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
+		if (ops->is_partially_uptodate(MAPPING_NULL, page, off, bsize) == seek_data) {
 			unlock_page(page);
 			return true;
 		}
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0902142e93f0d..89a3758531889 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -223,7 +223,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
 int block_read_full_page(struct page*, get_block_t*);
-int block_is_partially_uptodate(struct page *page, unsigned long from,
+int block_is_partially_uptodate(struct address_space *__mapping,
+				struct page *page, unsigned long from,
 				unsigned long count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		unsigned flags, struct page **pagep, get_block_t *get_block);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3854da5a1bcb9..21f179e7c5daa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -411,7 +411,8 @@ struct address_space_operations {
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct address_space *, struct page *);
 	int (*launder_page) (struct address_space *, struct page *);
-	int (*is_partially_uptodate) (struct page *, unsigned long,
+	int (*is_partially_uptodate) (struct address_space *, struct page *,
+					unsigned long,
 					unsigned long);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
 	int (*error_remove_page)(struct address_space *, struct page *);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cb4b207974756..53b94e35b02fd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -157,8 +157,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct address_space *__mapping, struct page *page);
-int iomap_is_partially_uptodate(struct page *page, unsigned long from,
-		unsigned long count);
+int iomap_is_partially_uptodate(struct address_space *__mapping,
+				struct page *page, unsigned long from,
+				unsigned long count);
 int iomap_releasepage(struct address_space *__mapping, struct page *page,
 		      gfp_t gfp_mask);
 void iomap_invalidatepage(struct address_space *__mapping, struct page *page,
diff --git a/mm/filemap.c b/mm/filemap.c
index faa190598cba8..951af134e0bf0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2244,8 +2244,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			/* Did it get truncated before we got the lock? */
 			if (!page->mapping)
 				goto page_not_up_to_date_locked;
-			if (!mapping->a_ops->is_partially_uptodate(page,
-							offset, iter->count))
+			if (!mapping->a_ops->is_partially_uptodate(MAPPING_NULL, page,
+								   offset, iter->count))
 				goto page_not_up_to_date_locked;
 			unlock_page(page);
 		}
-- 
2.26.2

