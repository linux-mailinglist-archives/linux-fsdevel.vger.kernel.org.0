Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB061220588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgGOGyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgGOGyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E3C061755;
        Tue, 14 Jul 2020 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5t6+luwKoh6eUzMZdud0EvMp4/Modr6v/0J1FflxXVc=; b=igzDs+hj0//g0GMEu47+NMGn9o
        I3zX3KRx6ZVMQnMjSFYIxiWrPzFqsY7ki+KSgEi7oP7YaRngrAFsu8JDTc0wb+dZGsHlhPrleOr84
        7r+5199ueV/dL+uQIXSnTybuv9Qm4EhtJtpggYPVZQbQHiVhI0gE1HxyJIiZv0R2pBtfZWKbkYQ+O
        YnjBgEbbBDX8r+DVZLJW2Rtv3JGqBkVdPmt+AWIuoWiF5hF1/n7D2+HEjr4b80KxkKDpDKsqVAIym
        Z0ltIEmuFJqRdjiugNKBbzRjTwrhU5xYi4bWf+Uk+gP7KdHtTqEm1tGBdfNdoZqviwCuFCSqaY8iW
        ivt2dzkw==;
Received: from [2001:4bb8:105:4a81:1c8f:d581:a5f2:bdb7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbJO-0001k7-MO; Wed, 15 Jul 2020 06:54:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs: move timespec validation into utimes_common
Date:   Wed, 15 Jul 2020 08:54:32 +0200
Message-Id: <20200715065434.2550-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715065434.2550-1-hch@lst.de>
References: <20200715065434.2550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the validation of the timespec from the two callers into
utimes_common.  That means it is done a little later (e.g. after the
path lookup), but I can't find anything that requires a specific
order of processing the errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/utimes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index c667517b6eb110..441c7fb54053ca 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -27,9 +27,14 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 	if (error)
 		goto out;
 
-	if (times && times[0].tv_nsec == UTIME_NOW &&
-		     times[1].tv_nsec == UTIME_NOW)
-		times = NULL;
+	if (times) {
+		if (!nsec_valid(times[0].tv_nsec) ||
+		    !nsec_valid(times[1].tv_nsec))
+			return -EINVAL;
+		if (times[0].tv_nsec == UTIME_NOW &&
+		    times[1].tv_nsec == UTIME_NOW)
+			times = NULL;
+	}
 
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
@@ -76,9 +81,6 @@ static int do_utimes_path(int dfd, const char __user *filename,
 	struct path path;
 	int lookup_flags = 0, error;
 
-	if (times &&
-	    (!nsec_valid(times[0].tv_nsec) || !nsec_valid(times[1].tv_nsec)))
-		return -EINVAL;
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 		return -EINVAL;
 
@@ -107,9 +109,6 @@ static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 	struct fd f;
 	int error;
 
-	if (times &&
-	    (!nsec_valid(times[0].tv_nsec) || !nsec_valid(times[1].tv_nsec)))
-		return -EINVAL;
 	if (flags)
 		return -EINVAL;
 
-- 
2.27.0

