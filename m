Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D59A220582
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGOGyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgGOGyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E6C061755;
        Tue, 14 Jul 2020 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ztUPD3J99ykCA9e2Tw30BI6WHAb5fF8/h2Ak1r3sLT4=; b=tWfgmfpFxqYUgB0M3OO4nChfz3
        Ptti61joGF8hJlmOz/6QDIkBa8g05eFs+2OaenIa7oLEu81qcP/wW8icXdae4hQ1TIrZbJ+bEt6I6
        rYBZnNerKe4xESB7C+uTblbE9TDHhNgoBdACmrjx/BsLrG7VA9kJTN9u6teBN5iVoYHXsLEvFfuTK
        zzKmQHzCmaUdaDcOvQuezzM08kCcEQRXgz4a0myKnv8exO/mvGAP2rzqlIO7XbtC+SPGJAVnRWJRs
        KwgWncQRX4+O8micRimMgrnVWaKGgjmbidUSClrOXimyAt5b5nyGyw2fu2tkvkX6GMLu//alc2aLc
        C5I5fqoA==;
Received: from [2001:4bb8:105:4a81:1c8f:d581:a5f2:bdb7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbJN-0001k1-8D; Wed, 15 Jul 2020 06:54:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] fs: refactor do_utimes
Date:   Wed, 15 Jul 2020 08:54:31 +0200
Message-Id: <20200715065434.2550-2-hch@lst.de>
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

Split out one helper each for path vs fd based operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/utimes.c | 100 ++++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index b7b927502d6e43..c667517b6eb110 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -70,6 +70,57 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 	return error;
 }
 
+static int do_utimes_path(int dfd, const char __user *filename,
+		struct timespec64 *times, int flags)
+{
+	struct path path;
+	int lookup_flags = 0, error;
+
+	if (times &&
+	    (!nsec_valid(times[0].tv_nsec) || !nsec_valid(times[1].tv_nsec)))
+		return -EINVAL;
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
+		return -EINVAL;
+
+	if (!(flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+retry:
+	error = user_path_at(dfd, filename, lookup_flags, &path);
+	if (error)
+		return error;
+
+	error = utimes_common(&path, times);
+	path_put(&path);
+	if (retry_estale(error, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
+	}
+
+	return error;
+}
+
+static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
+{
+	struct fd f;
+	int error;
+
+	if (times &&
+	    (!nsec_valid(times[0].tv_nsec) || !nsec_valid(times[1].tv_nsec)))
+		return -EINVAL;
+	if (flags)
+		return -EINVAL;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+	error = utimes_common(&f.file->f_path, times);
+	fdput(f);
+	return error;
+}
+
 /*
  * do_utimes - change times on filename or file descriptor
  * @dfd: open file descriptor, -1 or AT_FDCWD
@@ -88,52 +139,9 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 	       int flags)
 {
-	int error = -EINVAL;
-
-	if (times && (!nsec_valid(times[0].tv_nsec) ||
-		      !nsec_valid(times[1].tv_nsec))) {
-		goto out;
-	}
-
-	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
-		goto out;
-
-	if (filename == NULL && dfd != AT_FDCWD) {
-		struct fd f;
-
-		if (flags)
-			goto out;
-
-		f = fdget(dfd);
-		error = -EBADF;
-		if (!f.file)
-			goto out;
-
-		error = utimes_common(&f.file->f_path, times);
-		fdput(f);
-	} else {
-		struct path path;
-		int lookup_flags = 0;
-
-		if (!(flags & AT_SYMLINK_NOFOLLOW))
-			lookup_flags |= LOOKUP_FOLLOW;
-		if (flags & AT_EMPTY_PATH)
-			lookup_flags |= LOOKUP_EMPTY;
-retry:
-		error = user_path_at(dfd, filename, lookup_flags, &path);
-		if (error)
-			goto out;
-
-		error = utimes_common(&path, times);
-		path_put(&path);
-		if (retry_estale(error, lookup_flags)) {
-			lookup_flags |= LOOKUP_REVAL;
-			goto retry;
-		}
-	}
-
-out:
-	return error;
+	if (filename == NULL && dfd != AT_FDCWD)
+		return do_utimes_fd(dfd, times, flags);
+	return do_utimes_path(dfd, filename, times, flags);
 }
 
 SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
-- 
2.27.0

