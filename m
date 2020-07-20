Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE1226991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgGTQ1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbgGTP7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF8C061794;
        Mon, 20 Jul 2020 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8WMr775OKc+w+2ldEn4WWV+SQn2SLI1PrMvnX71j+C0=; b=UKSsUzwoy8t6wMpgrR0bsIkcgk
        hgMjoxfQXXJnoZa4p60Ijs7XYiv3164you6uOchAfAOna3PT3PPHM71kvi/PlJgcrYi2Y5F15T0qN
        adXNXmqO1x5Hgm0WNIQlQyEdNQqS4iBWneOe/ObjeytNCbMaAPmQyaKvdud6Txl+hkWsB1neLji4u
        Vha8wemXgSW9EDw/E2xM3nuzTCFY2NzdxXDwQH/hGnDUfLje6Qs7iDqRrw9huzmTIOvC4j338F/0c
        eeNqIr8RIFaok+nRuf7vnwWPLTUSaN2W6nOocTEry9FAegHD8eLClwvPrqsm1SZGzf+OeC5l/IVy2
        Rx0PGZ8A==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCb-0007s4-Vs; Mon, 20 Jul 2020 15:59:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 22/24] fs: remove vfs_stat_set_lookup_flags
Date:   Mon, 20 Jul 2020 17:59:00 +0200
Message-Id: <20200720155902.181712-23-hch@lst.de>
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
2.27.0

