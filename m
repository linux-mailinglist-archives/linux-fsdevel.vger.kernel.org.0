Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1911D226985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgGTQ04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbgGTP7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F62C061794;
        Mon, 20 Jul 2020 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oBh0/na3isreBgMz5fpFIl71o0/kBU7V3ZRggI9ypgA=; b=ZHcPToNOeCDpSZ3gmrGXuCjqzC
        +z+j/CYcdOGAAB14WmzG8rb/HwhEv1D+UC1aoNMMWUDqvz6rmaDc4BMqRvMkM6qsRWKzsYPNCO+zc
        aHYpdxreBb7AaO25T14haozqdakT4r2XLfpF5J88toMDWOb93q+bHpCzgsGjYPydUDdptm7UFwsEu
        GyHtBAHky3+SaxT6+W9aasK0KXp7xmQR/VVbgsVUVkJv/Wztu8F76ySK1H2jAmESmnmevIHQyhqpN
        9BUjGwNJCjNARInq2/tGztUVZs3Mh/0VravApnxYE1OWEssQGu2Amfih0l3ELZn9ohGJ7uTqXk867
        w0b46wJA==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCd-0007sA-JJ; Mon, 20 Jul 2020 15:59:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 23/24] fs: remove KSTAT_QUERY_FLAGS
Date:   Mon, 20 Jul 2020 17:59:01 +0200
Message-Id: <20200720155902.181712-24-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KSTAT_QUERY_FLAGS expands to AT_STATX_SYNC_TYPE, which itself already
is a mask.  Remove the double name, especially given that the prefix
is a little confusing vs the normal AT_* flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 8acc4b14ac24c9..dacecdda2e7967 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(generic_fillattr);
  * @path: file to get attributes from
  * @stat: structure to return attributes in
  * @request_mask: STATX_xxx flags indicating what the caller wants
- * @query_flags: Query mode (KSTAT_QUERY_FLAGS)
+ * @query_flags: Query mode (AT_STATX_SYNC_TYPE)
  *
  * Get attributes without calling security_inode_getattr.
  *
@@ -71,7 +71,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
-	query_flags &= KSTAT_QUERY_FLAGS;
+	query_flags &= AT_STATX_SYNC_TYPE;
 
 	/* allow the fs to override these if it really wants to */
 	/* SB_NOATIME means filesystem supplies dummy atime value */
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(vfs_getattr_nosec);
  * @path: The file of interest
  * @stat: Where to return the statistics
  * @request_mask: STATX_xxx flags indicating what the caller wants
- * @query_flags: Query mode (KSTAT_QUERY_FLAGS)
+ * @query_flags: Query mode (AT_STATX_SYNC_TYPE)
  *
  * Ask the filesystem for a file's attributes.  The caller must indicate in
  * request_mask and query_flags to indicate what they want.
@@ -171,7 +171,7 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-		      KSTAT_QUERY_FLAGS))
+		      AT_STATX_SYNC_TYPE))
 		return -EINVAL;
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
-- 
2.27.0

