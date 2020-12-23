Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F412E1CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgLWNvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 08:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728717AbgLWNvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608731376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWSTwe7BO+IAn1kJ/m6kiyZFGVqqtNUwNHZYMDzC0Vo=;
        b=FMCmy31Co5RHrb0A3je+0FkgrLk84SS+laAo5XaCo5RiFPwkYizZjvG9P22/G9zLdPQ9WX
        ZT6ICKUy8rRyvGdz6Yfhj2v3wrwGWYpFDv7IpyAfT8pzMTKCWoIXPN0dBAEIm4TCL1a8df
        hRohxQx4F+CoW47gqlbnErez7lzdN4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-AtMNMQXBNQGx9kshQLoCuw-1; Wed, 23 Dec 2020 08:49:34 -0500
X-MC-Unique: AtMNMQXBNQGx9kshQLoCuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 508AD800D53;
        Wed, 23 Dec 2020 13:49:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-204.rdu2.redhat.com [10.10.112.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B16863BA7;
        Wed, 23 Dec 2020 13:49:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] afs: Fix directory entry size calculation
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Dec 2020 13:49:31 +0000
Message-ID: <160873137145.834177.6619912921657158513.stgit@warthog.procyon.org.uk>
In-Reply-To: <160873136449.834177.8213549315585633735.stgit@warthog.procyon.org.uk>
References: <160873136449.834177.8213549315585633735.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of dirent records used by an AFS directory entry should be
calculated using the assumption that there is a 16-byte name field in the
first block, rather than a 20-byte name field (which is actually the case).
This miscalculation is historic and effectively standard, so we have to use
it.

The calculation we need to use is:

	1 + (((strlen(name) + 1) + 15) >> 5)

where we are adding one to the strlen() result to account for the NUL
termination.

Fix this by the following means:

 (1) Create an inline function to do the calculation for a given name
     length.

 (2) Use the function to calculate the number of records used for a dirent
     in afs_dir_iterate_block().

     Use this to move the over-end check out of the loop since it only
     needs to be done once.

     Further use this to only go through the loop for the 2nd+ records
     composing an entry.  The only test there now is for if the record is
     allocated - and we already checked the first block at the top of the
     outer loop.

 (3) Add a max name length check in afs_dir_iterate_block().

 (4) Make afs_edit_dir_add() and afs_edit_dir_remove() use the function
     from (1) to calculate the number of blocks rather than doing it
     incorrectly themselves.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |   49 +++++++++++++++++++++++---------------------
 fs/afs/dir_edit.c          |    6 ++---
 fs/afs/xdr_fs.h            |   14 ++++++++++++-
 include/trace/events/afs.h |    2 ++
 4 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9068d5578a26..7bd659ad959e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -350,7 +350,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 				 unsigned blkoff)
 {
 	union afs_xdr_dirent *dire;
-	unsigned offset, next, curr;
+	unsigned offset, next, curr, nr_slots;
 	size_t nlen;
 	int tmp;
 
@@ -363,13 +363,12 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 	     offset < AFS_DIR_SLOTS_PER_BLOCK;
 	     offset = next
 	     ) {
-		next = offset + 1;
-
 		/* skip entries marked unused in the bitmap */
 		if (!(block->hdr.bitmap[offset / 8] &
 		      (1 << (offset % 8)))) {
 			_debug("ENT[%zu.%u]: unused",
 			       blkoff / sizeof(union afs_xdr_dir_block), offset);
+			next = offset + 1;
 			if (offset >= curr)
 				ctx->pos = blkoff +
 					next * sizeof(union afs_xdr_dirent);
@@ -381,35 +380,39 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		nlen = strnlen(dire->u.name,
 			       sizeof(*block) -
 			       offset * sizeof(union afs_xdr_dirent));
+		if (nlen > AFSNAMEMAX - 1) {
+			_debug("ENT[%zu]: name too long (len %u/%zu)",
+			       blkoff / sizeof(union afs_xdr_dir_block),
+			       offset, nlen);
+			return afs_bad(dvnode, afs_file_error_dir_name_too_long);
+		}
 
 		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
 		       blkoff / sizeof(union afs_xdr_dir_block), offset,
 		       (offset < curr ? "skip" : "fill"),
 		       nlen, dire->u.name);
 
-		/* work out where the next possible entry is */
-		for (tmp = nlen; tmp > 15; tmp -= sizeof(union afs_xdr_dirent)) {
-			if (next >= AFS_DIR_SLOTS_PER_BLOCK) {
-				_debug("ENT[%zu.%u]:"
-				       " %u travelled beyond end dir block"
-				       " (len %u/%zu)",
-				       blkoff / sizeof(union afs_xdr_dir_block),
-				       offset, next, tmp, nlen);
-				return afs_bad(dvnode, afs_file_error_dir_over_end);
-			}
-			if (!(block->hdr.bitmap[next / 8] &
-			      (1 << (next % 8)))) {
-				_debug("ENT[%zu.%u]:"
-				       " %u unmarked extension (len %u/%zu)",
+		nr_slots = afs_dir_calc_slots(nlen);
+		next = offset + nr_slots;
+		if (next > AFS_DIR_SLOTS_PER_BLOCK) {
+			_debug("ENT[%zu.%u]:"
+			       " %u extends beyond end dir block"
+			       " (len %zu)",
+			       blkoff / sizeof(union afs_xdr_dir_block),
+			       offset, next, nlen);
+			return afs_bad(dvnode, afs_file_error_dir_over_end);
+		}
+
+		/* Check that the name-extension dirents are all allocated */
+		for (tmp = 1; tmp < nr_slots; tmp++) {
+			unsigned int ix = offset + tmp;
+			if (!(block->hdr.bitmap[ix / 8] & (1 << (ix % 8)))) {
+				_debug("ENT[%zu.u]:"
+				       " %u unmarked extension (%u/%u)",
 				       blkoff / sizeof(union afs_xdr_dir_block),
-				       offset, next, tmp, nlen);
+				       offset, tmp, nr_slots);
 				return afs_bad(dvnode, afs_file_error_dir_unmarked_ext);
 			}
-
-			_debug("ENT[%zu.%u]: ext %u/%zu",
-			       blkoff / sizeof(union afs_xdr_dir_block),
-			       next, tmp, nlen);
-			next++;
 		}
 
 		/* skip if starts before the current position */
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 2ffe09abae7f..f4600c1353ad 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -215,8 +215,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	}
 
 	/* Work out how many slots we're going to need. */
-	need_slots = round_up(12 + name->len + 1 + 4, AFS_DIR_DIRENT_SIZE);
-	need_slots /= AFS_DIR_DIRENT_SIZE;
+	need_slots = afs_dir_calc_slots(name->len);
 
 	meta_page = kmap(page0);
 	meta = &meta_page->blocks[0];
@@ -393,8 +392,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	}
 
 	/* Work out how many slots we're going to discard. */
-	need_slots = round_up(12 + name->len + 1 + 4, AFS_DIR_DIRENT_SIZE);
-	need_slots /= AFS_DIR_DIRENT_SIZE;
+	need_slots = afs_dir_calc_slots(name->len);
 
 	meta_page = kmap(page0);
 	meta = &meta_page->blocks[0];
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index c926430fd08a..8ca868164507 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -58,7 +58,8 @@ union afs_xdr_dirent {
 		/* When determining the number of dirent slots needed to
 		 * represent a directory entry, name should be assumed to be 16
 		 * bytes, due to a now-standardised (mis)calculation, but it is
-		 * in fact 20 bytes in size.
+		 * in fact 20 bytes in size.  afs_dir_calc_slots() should be
+		 * used for this.
 		 *
 		 * For names longer than (16 or) 20 bytes, extra slots should
 		 * be annexed to this one using the extended_name format.
@@ -101,4 +102,15 @@ struct afs_xdr_dir_page {
 	union afs_xdr_dir_block	blocks[AFS_DIR_BLOCKS_PER_PAGE];
 };
 
+/*
+ * Calculate the number of dirent slots required for any given name length.
+ * The calculation is made assuming the part of the name in the first slot is
+ * 16 bytes, rather than 20, but this miscalculation is now standardised.
+ */
+static inline unsigned int afs_dir_calc_slots(size_t name_len)
+{
+	name_len++; /* NUL-terminated */
+	return 1 + ((name_len + 15) / AFS_DIR_DIRENT_SIZE);
+}
+
 #endif /* XDR_FS_H */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 4eef374d4413..4a5cc8c64be3 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -231,6 +231,7 @@ enum afs_file_error {
 	afs_file_error_dir_bad_magic,
 	afs_file_error_dir_big,
 	afs_file_error_dir_missing_page,
+	afs_file_error_dir_name_too_long,
 	afs_file_error_dir_over_end,
 	afs_file_error_dir_small,
 	afs_file_error_dir_unmarked_ext,
@@ -488,6 +489,7 @@ enum afs_cb_break_reason {
 	EM(afs_file_error_dir_bad_magic,	"DIR_BAD_MAGIC")	\
 	EM(afs_file_error_dir_big,		"DIR_BIG")		\
 	EM(afs_file_error_dir_missing_page,	"DIR_MISSING_PAGE")	\
+	EM(afs_file_error_dir_name_too_long,	"DIR_NAME_TOO_LONG")	\
 	EM(afs_file_error_dir_over_end,		"DIR_ENT_OVER_END")	\
 	EM(afs_file_error_dir_small,		"DIR_SMALL")		\
 	EM(afs_file_error_dir_unmarked_ext,	"DIR_UNMARKED_EXT")	\


