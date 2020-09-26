Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8766279771
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgIZHEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgIZHEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D5C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G5DjZWIno3FaRn8f6l4VfdQbCAzY4Ys08lCIh0jKDVo=; b=P7AoyeysmlTxqPL39jxRg4CS+A
        1WYqsjKjCEUZ+QY7sJseqOZqZci0q+I6NboJp+sb8BHANZBCAIoTEona0ZL5vni51n14jD9Q+R52c
        NO50cKieo9FCmAE42x/O49mui+T18H8eAAM/vA+WKqvURlnVf43L/EsapIGZjWZuAZHmW64xSB/ts
        xoaRpX2TI97Ba6UahtHj7TFVi7cD/Y3sd8m//8L8X7eFMtERkxvHo1+VQ/DwQx3S5gmHxtLyaR3iB
        PQbP6SE6jVFqp4o5VRuIgi+vKAEauQ/oRtF+WrfVuFFnRXotye1lkkFCTrnwkB3N32kIEzkOkwA6S
        qZZFKXVA==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FY-0003vt-Ri; Sat, 26 Sep 2020 07:04:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] fs: remove vfs_stat_set_lookup_flags
Date:   Sat, 26 Sep 2020 09:04:00 +0200
Message-Id: <20200926070401.11816-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function really obsfucates checking for valid flags and setting the
lookup flags.  The fact that it returns -EINVAL through and unsigned
return value, which is then used as boolean really doesn't help either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/stat.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index ddf0176d4dbcd7..8acc4b14ac24c9 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -148,24 +148,6 @@ int vfs_fstat(int fd, struct kstat *stat)
 	return error;
 }
 
-static inline unsigned vfs_stat_set_lookup_flags(unsigned *lookup_flags,
-						 int flags)
-{
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
-		       AT_EMPTY_PATH | KSTAT_QUERY_FLAGS)) != 0)
-		return -EINVAL;
-
-	*lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
-	if (flags & AT_SYMLINK_NOFOLLOW)
-		*lookup_flags &= ~LOOKUP_FOLLOW;
-	if (flags & AT_NO_AUTOMOUNT)
-		*lookup_flags &= ~LOOKUP_AUTOMOUNT;
-	if (flags & AT_EMPTY_PATH)
-		*lookup_flags |= LOOKUP_EMPTY;
-
-	return 0;
-}
-
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
@@ -185,11 +167,20 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
-	int error = -EINVAL;
-	unsigned lookup_flags;
+	unsigned lookup_flags = 0;
+	int error;
 
-	if (vfs_stat_set_lookup_flags(&lookup_flags, flags))
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
+		      KSTAT_QUERY_FLAGS))
 		return -EINVAL;
+
+	if (!(flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+	if (!(flags & AT_NO_AUTOMOUNT))
+		lookup_flags |= LOOKUP_AUTOMOUNT;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (error)
-- 
2.28.0

