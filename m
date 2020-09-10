Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7944263DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIJGxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgIJGwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC25C061786
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G5DjZWIno3FaRn8f6l4VfdQbCAzY4Ys08lCIh0jKDVo=; b=aoEtqlsSsinCJplz6p3AAWTML+
        olvdXsplSl6T6ry2+WLWxlsVt++jtmsqprzL6CgyaU3bLLNY0XCVfz1ZBtF+4f9qvS4VyDlGSy85Z
        kWFL9+kXjCwW7e7dkplR3IpM+5GOtqcoVH8zERjGR6Q6XTvFVBHmCOUX88YP7HJ361O09bRhdkhnq
        TjgO5XvvM5WfVe6zLhwEtKW3oFMWwX4/MPqDOLEgHVi1Rpt6byePK16YQ6gyK4b0NRATqvtPiOqw7
        t1pMtDGUv668F+PEPSQjValLW84CxIZ/SO6hb922rnnUbvPkVW8eLUJPkqwlHC2ZEQiOjrgphhSIr
        1MeB3njA==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGGIF-0000CL-Ck; Thu, 10 Sep 2020 06:42:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] fs: remove vfs_stat_set_lookup_flags
Date:   Thu, 10 Sep 2020 08:42:42 +0200
Message-Id: <20200910064244.346913-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910064244.346913-1-hch@lst.de>
References: <20200910064244.346913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
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

