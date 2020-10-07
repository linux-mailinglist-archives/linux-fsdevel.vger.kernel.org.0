Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0B2855FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgJGBIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbgJGBHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/gySTvyIg2FbPgK8ua0K1ezPjK1C2VUOyDmAGNu+G4=;
        b=EVdk2ISFaWPJQIO6KYTeZ5Je5cti3mJUf0a68MvDXsRw47CiA6hRqGuRbCDjykoyAwZv7w
        Bn/nxy+VYRYiJDgUJV1NR1duuJHMmXWG82gp35YAbSLQLsocm/CCfCzDizOjLV4grvcsvq
        atqHQk0jnJXlI9K10op4v3aRn/Ykb/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-NbX_8FHGPOa522ijy9A8bg-1; Tue, 06 Oct 2020 21:07:42 -0400
X-MC-Unique: NbX_8FHGPOa522ijy9A8bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17D6D425D5;
        Wed,  7 Oct 2020 01:07:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 736A55D9D2;
        Wed,  7 Oct 2020 01:07:37 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 10/14] mm: add struct address_space to putback_page() callback
Date:   Tue,  6 Oct 2020 21:05:59 -0400
Message-Id: <20201007010603.3452458-11-jglisse@redhat.com>
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

Add struct address_space to putback_page() callback arguments.

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
// Part 1 is grepping all function that are use as callback for putback_page.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .putback_page = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (putback_page callback one)
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
// Part 3 is grepping all function that are use the callback for putback_page.

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
E1.a_ops->putback_page(E2)
|
E1->a_ops->putback_page(E2)
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
struct address_space_operations { ... void (*putback_page)(
+struct address_space *,
struct page *); ... };

@p4r2 depends on part4@
expression E1, E2;
@@
E1.a_ops->putback_page(
+MAPPING_NULL,
E2)

@p4r3 depends on part4@
expression E1, E2;
@@
E1->a_ops->putback_page(
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
 include/linux/balloon_compaction.h | 6 ++++--
 include/linux/fs.h                 | 2 +-
 mm/balloon_compaction.c            | 2 +-
 mm/migrate.c                       | 2 +-
 mm/z3fold.c                        | 3 ++-
 mm/zsmalloc.c                      | 3 ++-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27e4773b..07b235161d040 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -82,7 +82,8 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 extern const struct address_space_operations balloon_aops;
 extern bool balloon_page_isolate(struct page *page,
 				isolate_mode_t mode);
-extern void balloon_page_putback(struct page *page);
+extern void balloon_page_putback(struct address_space *__mapping,
+				 struct page *page);
 extern int balloon_page_migrate(struct address_space *mapping,
 				struct page *newpage,
 				struct page *page, enum migrate_mode mode);
@@ -160,7 +161,8 @@ static inline bool balloon_page_isolate(struct page *page)
 	return false;
 }
 
-static inline void balloon_page_putback(struct page *page)
+static inline void balloon_page_putback(struct address_space *__mapping,
+					struct page *page)
 {
 	return;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a952aa9d93e7f..4d0b9c14a5017 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -409,7 +409,7 @@ struct address_space_operations {
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *, enum migrate_mode);
 	bool (*isolate_page)(struct page *, isolate_mode_t);
-	void (*putback_page)(struct page *);
+	void (*putback_page)(struct address_space *, struct page *);
 	int (*launder_page) (struct page *);
 	int (*is_partially_uptodate) (struct page *, unsigned long,
 					unsigned long);
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b4..abc4a63df9903 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -217,7 +217,7 @@ bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-void balloon_page_putback(struct page *page)
+void balloon_page_putback(struct address_space *__mapping, struct page *page)
 {
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
diff --git a/mm/migrate.c b/mm/migrate.c
index 21beb45356760..3fba7429151bf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -154,7 +154,7 @@ void putback_movable_page(struct page *page)
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	mapping = page_mapping(page);
-	mapping->a_ops->putback_page(page);
+	mapping->a_ops->putback_page(MAPPING_NULL, page);
 	__ClearPageIsolated(page);
 }
 
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 460b0feced26a..37453a14257a4 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1668,7 +1668,8 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	return 0;
 }
 
-static void z3fold_page_putback(struct page *page)
+static void z3fold_page_putback(struct address_space *__mapping,
+				struct page *page)
 {
 	struct z3fold_header *zhdr;
 	struct z3fold_pool *pool;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c36fdff9a3713..99d74c6e98216 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2099,7 +2099,8 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	return ret;
 }
 
-static void zs_page_putback(struct page *page)
+static void zs_page_putback(struct address_space *__mapping,
+			    struct page *page)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
-- 
2.26.2

