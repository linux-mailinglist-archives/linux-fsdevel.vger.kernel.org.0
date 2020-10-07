Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0852855F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgJGBIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbgJGBHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Al92MyeBChT8tzOQ+O0pHpVNfPLYQ6PQt7R8QJetTew=;
        b=YiNG3SiG/3TDb1DOBT5QnsACOP6AHZ4n5ptZroi34jbxIwdQee2UC5KJWneJgkv/D2PEn+
        FEtVPm/UHCtAQ1mhIm8BQsz6h8n3nmdkSWW53dhhVJ8u3i8UjuHpaXRO3hbeAFd0b4dSoK
        26dImIlK9vv28NpthWy+RhaQtMRdjJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-1erG1MQUPYSzK0pI4Ow4ow-1; Tue, 06 Oct 2020 21:07:47 -0400
X-MC-Unique: 1erG1MQUPYSzK0pI4Ow4ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D89CD803F5B;
        Wed,  7 Oct 2020 01:07:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03E95D9D2;
        Wed,  7 Oct 2020 01:07:44 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/14] mm: add struct address_space to is_dirty_writeback() callback
Date:   Tue,  6 Oct 2020 21:06:03 -0400
Message-Id: <20201007010603.3452458-15-jglisse@redhat.com>
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

Add struct address_space to is_dirty_writeback() callback arguments.

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
// Part 1 is grepping all function that are use as callback for is_dirty_writeback.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .is_dirty_writeback = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

@p2r1 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
void fn(
+struct address_space *__mapping,
T1 I1, T2 I2, T3 I3) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
void fn(
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
// Part 3 is grepping all function that are use the callback for is_dirty_writeback.

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
E1.a_ops->is_dirty_writeback(E2, E3, E4)
|
E1->a_ops->is_dirty_writeback(E2, E3, E4)
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
struct address_space_operations { ... void (*is_dirty_writeback)(
+struct address_space *,
struct page *, ...); ... };

@p4r2 depends on part4@
expression E1, E2, E3, E4;
@@
E1.a_ops->is_dirty_writeback(
+MAPPING_NULL,
E2, E3, E4)

@p4r3 depends on part4@
expression E1, E2, E3, E4;
@@
E1->a_ops->is_dirty_writeback(
+MAPPING_NULL,
E2, E3, E4)
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
 fs/nfs/file.c               | 5 +++--
 include/linux/buffer_head.h | 3 ++-
 include/linux/fs.h          | 3 ++-
 mm/vmscan.c                 | 3 ++-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7adf0af7530ba..d050ef5bf9d7b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -83,7 +83,8 @@ EXPORT_SYMBOL(unlock_buffer);
  * are unlocked and clean then the PageDirty information is stale. If
  * any of the pages are locked, it is assumed they are locked for IO.
  */
-void buffer_check_dirty_writeback(struct page *page,
+void buffer_check_dirty_writeback(struct address_space *__mapping,
+				     struct page *page,
 				     bool *dirty, bool *writeback)
 {
 	struct buffer_head *head, *bh;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index b1ba143de48d9..d99b2db7ba3a3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -437,8 +437,9 @@ static int nfs_release_page(struct address_space *__mapping,
 	return nfs_fscache_release_page(page, gfp);
 }
 
-static void nfs_check_dirty_writeback(struct page *page,
-				bool *dirty, bool *writeback)
+static void nfs_check_dirty_writeback(struct address_space *__mapping,
+				      struct page *page,
+				      bool *dirty, bool *writeback)
 {
 	struct nfs_inode *nfsi;
 	struct address_space *mapping = page_file_mapping(page);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 89a3758531889..b19998fa8e4d4 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -145,7 +145,8 @@ BUFFER_FNS(Defer_Completion, defer_completion)
 	})
 #define page_has_buffers(page)	PagePrivate(page)
 
-void buffer_check_dirty_writeback(struct page *page,
+void buffer_check_dirty_writeback(struct address_space *__mapping,
+				     struct page *page,
 				     bool *dirty, bool *writeback);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6798a13e3c980..ebdb961016925 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -415,7 +415,8 @@ struct address_space_operations {
 	int (*is_partially_uptodate) (struct address_space *, struct page *,
 					unsigned long,
 					unsigned long);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
+	void (*is_dirty_writeback) (struct address_space *, struct page *,
+				    bool *, bool *);
 	int (*error_remove_page)(struct address_space *, struct page *);
 
 	/* swapfile support */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bae7fb9c3512a..d402f94e14f2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1058,7 +1058,8 @@ static void page_check_dirty_writeback(struct page *page,
 
 	mapping = page_mapping(page);
 	if (mapping && mapping->a_ops->is_dirty_writeback)
-		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
+		mapping->a_ops->is_dirty_writeback(MAPPING_NULL, page, dirty,
+						   writeback);
 }
 
 /*
-- 
2.26.2

