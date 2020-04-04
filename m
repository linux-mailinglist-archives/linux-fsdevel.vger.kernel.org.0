Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB319E672
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDQ2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 12:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgDDQ2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:28:31 -0400
Received: from hubcapsc.localdomain (adsl-074-187-100-237.sip.mia.bellsouth.net [74.187.100.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AC4206F8;
        Sat,  4 Apr 2020 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586017710;
        bh=WzDhFqDQ9Y4gcqnR72QzYKnuRNnWJC4Ptee4yjtI+lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DRKpzn+63+h8WGjktcUR8YGjmLd/4vyVMl9oHvzo9ADlmowFe087AhW56K3029Jf
         kZqPZMnzaLjPK3JQmabSd0BJgw8dITkR7QULoWhPHiFz4J/zVOWnT2BDz+cbNBoG/W
         Ojms22Zr0F2nIjGiMes8TRZLnQQVhBZqTsu33GmQ=
From:   hubcap@kernel.org
To:     hch@lst.de
Cc:     Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] orangefs: complete Christoph's "remember count" reversion.
Date:   Sat,  4 Apr 2020 12:28:26 -0400
Message-Id: <20200404162826.181808-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326170705.1552562-2-hch@lst.de>
References: <20200326170705.1552562-2-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>

---------- added text for this mail message ----------------
Here's a related patch. Something like this needs to be added
to Christoph's reversion in order for Orangefs to compile and
keep working. Using this static read size rather than using
the reverted logic to determine a read size seems faster in
my tests anyhow.

I accept Christoph's assertion that there would be a race, and
I looked at some of the vfs code (vfs_read, new_sync_read and
related). I guess the race Christoph sees would happen in
a threaded userspace program? I would be a better maintainer
if I saw the race more clearly, if anyone wants to go into
it. 

I guess I could employ a locking scheme if I wanted keep the
reverted code (I don't) instead of getting rid of it?

As an aside, the page cache has been a blessing and a curse
for us. Since we started using it, small IO has improved
incredibly, but our max speed hits a plateau before it otherwise
would have. I think because of all the page size copies we have
to do to fill our 4 meg native buffers. I try to read about all
the new work going into the page cache in lwn, and make some
sense of the new code :-). One thing I remember is when
Christoph Lameter said "the page cache does not scale", but
I know the new work is focused on that. If anyone has any
thoughts about how we could make improvments on filling our
native buffers from the page cache (larger page sizes?),
feel free to offer any help...

Anywho... thanks and I'll try to get this patch and
Christoph's two pulled if nobody sees a problem with them...

-Mike
------------------------------------------------------------

Logically, optimal Orangefs "pages" are 4 megabytes. Reading large Orangefs
files 4096 bytes at a time is like trying to kick a dead whale
down the beach. Before Christoph's "Revert orangefs: remember
count when reading." I tried to give users a knob whereby they could,
for example, use "count" in read(2) or bs with dd(1) to get
whatever they considered an appropriate amount of bytes at
a time from Orangefs and fill as many page cache pages as they
could at once.

Without the racy code that Christoph reverted Orangefs won't
even compile, much less work. So this replaces the logic that
used the private file data that Christoph reverted with
a static number of bytes to read from Orangefs.

I ran tests like the following to determine what a
reasonable static number of bytes might be:

dd if=/pvfsmnt/asdf of=/dev/null count=128 bs=4194304
dd if=/pvfsmnt/asdf of=/dev/null count=256 bs=2097152
dd if=/pvfsmnt/asdf of=/dev/null count=512 bs=1048576
                          .
                          .
                          .
dd if=/pvfsmnt/asdf of=/dev/null count=4194304 bs=128

Reads seem faster using the static number, so my "knob code"
wasn't just racy, it wasn't even a good idea...

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 961c0fd8675a..fb0884626d18 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -259,46 +259,19 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	pgoff_t index; /* which page */
 	struct page *next_page;
 	char *kaddr;
-	struct orangefs_read_options *ro = file->private_data;
 	loff_t read_size;
-	loff_t roundedup;
 	int buffer_index = -1; /* orangefs shared memory slot */
 	int slot_index;   /* index into slot */
 	int remaining;
 
 	/*
-	 * If they set some miniscule size for "count" in read(2)
-	 * (for example) then let's try to read a page, or the whole file
-	 * if it is smaller than a page. Once "count" goes over a page
-	 * then lets round up to the highest page size multiple that is
-	 * less than or equal to "count" and do that much orangefs IO and
-	 * try to fill as many pages as we can from it.
-	 *
-	 * "count" should be represented in ro->blksiz.
-	 *
-	 * inode->i_size = file size.
+	 * Get up to this many bytes from Orangefs at a time and try
+	 * to fill them into the page cache at once.
+	 * Tests with dd made this seem like a reasonable static
+	 * number, if there was interest perhaps this number could
+	 * be made setable through sysfs...
 	 */
-	if (ro) {
-		if (ro->blksiz < PAGE_SIZE) {
-			if (inode->i_size < PAGE_SIZE)
-				read_size = inode->i_size;
-			else
-				read_size = PAGE_SIZE;
-		} else {
-			roundedup = ((PAGE_SIZE - 1) & ro->blksiz) ?
-				((ro->blksiz + PAGE_SIZE) & ~(PAGE_SIZE -1)) :
-				ro->blksiz;
-			if (roundedup > inode->i_size)
-				read_size = inode->i_size;
-			else
-				read_size = roundedup;
-
-		}
-	} else {
-		read_size = PAGE_SIZE;
-	}
-	if (!read_size)
-		read_size = PAGE_SIZE;
+	read_size = 524288;
 
 	if (PageDirty(page))
 		orangefs_launder_page(page);
-- 
2.25.1

