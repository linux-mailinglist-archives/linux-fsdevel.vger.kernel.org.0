Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBE1FF510
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgFROoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgFROoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4599FC061795
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so2633345pjb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=HUMIpAnpDXTm7durxzsxq78uIppsf6NP0VS0tAu1naU=;
        b=uL0fwmVf7za35bF7WmhIeuLwTRYPYomNz3qpWAcNPJ4MG8GTRnh40j/G/FSQGZeqHn
         yQkV1IezTLpFjD50TYMgv1HY78G4RgY498zLaJMuA+l8xEee6zj/2I82z6xH0BShFzod
         Jw88wuY/pILeFUtVbhY9sbTrVoWY7AC3u3FJAQooqqxLaL58sSt1DjQd+DiakJiej111
         3QKNAaz9kpVK0JkkwmB/tU2PK7EUI1l3/XQW2Hhdy1LlQkxSISsyAWXCpJiSM6HpaavS
         QcI6gfKDo0Ou2qvSuNEV0Pw2sksh+dDzkS5v9GpxMofkwta1H+6MYdHHM9azIlc5CFhg
         lSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=HUMIpAnpDXTm7durxzsxq78uIppsf6NP0VS0tAu1naU=;
        b=gPLMzfRRD0eYpLH5DUR/AD6Pe1KTvb12wXQTtv6WmJdkMzHQGef+QV/e25KAtI3AeH
         jXRxjcG4SwhAWYOdeewMCNYeA+bcZkiu8XXFM4HSdOxLQykNq1UdT0WiT5GavmNFxj/O
         paLjWAjRWmSYbrzNQJF5pAmAWodHsnWDqZa7L1hzRgLnX4sRQIW+YROOPHpmTs3irV4R
         vbVsszPdqVm6K8adu+oY3uSmqQIzpdAGnCkhml50W40UOOEOF+lV025xS0o9jWt64MbC
         lcyNRtNVYThk6f1W3Pk2lzuUo1f4Y8h8A6ifU5AZAzO28Ksj3sZZ957aEy0M1SR2L8LP
         9xRQ==
X-Gm-Message-State: AOAM530nKzVwrUz5R9XrhgBe/RIHPd9ppR8IOSIXOrBOmcrCkWACZS5v
        u4wyyEEMVL8lhiZfC/XOEFNNFQ==
X-Google-Smtp-Source: ABdhPJzURLyFzMozy7yIPWEvSTKNlwHInRbt5PeVmy/Fa+Ew58olXOewrYlOoVFbj5T5wAt30tH4HQ==
X-Received: by 2002:a17:90a:de1:: with SMTP id 88mr4809422pjv.124.1592491443796;
        Thu, 18 Jun 2020 07:44:03 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/15] io_uring: catch -EIO from buffered issue request failure
Date:   Thu, 18 Jun 2020 08:43:43 -0600
Message-Id: <20200618144355.17324-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-EIO bubbles up like -EAGAIN if we fail to allocate a request at the
lower level. Play it safe and treat it like -EAGAIN in terms of sync
retry, to avoid passing back an errant -EIO.

Catch some of these early for block based file, as non-mq devices
generally do not support NOWAIT. That saves us some overhead by
not first trying, then retrying from async context. We can go straight
to async punt instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca78dd7c79da..2e257c5a1866 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2088,6 +2088,15 @@ static struct file *__io_file_get(struct io_submit_state *state, int fd)
 	return state->file;
 }
 
+static bool io_bdev_nowait(struct block_device *bdev)
+{
+#ifdef CONFIG_BLOCK
+	return !bdev || queue_is_mq(bdev_get_queue(bdev));
+#else
+	return true;
+#endif
+}
+
 /*
  * If we tracked the file through the SCM inflight mechanism, we could support
  * any file. For now, just ensure that anything potentially problematic is done
@@ -2097,10 +2106,19 @@ static bool io_file_supports_async(struct file *file, int rw)
 {
 	umode_t mode = file_inode(file)->i_mode;
 
-	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISSOCK(mode))
-		return true;
-	if (S_ISREG(mode) && file->f_op != &io_uring_fops)
+	if (S_ISBLK(mode)) {
+		if (io_bdev_nowait(file->f_inode->i_bdev))
+			return true;
+		return false;
+	}
+	if (S_ISCHR(mode) || S_ISSOCK(mode))
 		return true;
+	if (S_ISREG(mode)) {
+		if (io_bdev_nowait(file->f_inode->i_sb->s_bdev) &&
+		    file->f_op != &io_uring_fops)
+			return true;
+		return false;
+	}
 
 	/* any ->read/write should understand O_NONBLOCK */
 	if (file->f_flags & O_NONBLOCK)
@@ -2650,7 +2668,7 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, req->file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
-		ssize_t ret2;
+		ssize_t ret2 = 0;
 
 		if (req->file->f_op->read_iter)
 			ret2 = call_read_iter(req->file, kiocb, &iter);
@@ -2658,7 +2676,7 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 			ret2 = loop_rw_iter(READ, req->file, kiocb, &iter);
 
 		/* Catch -EAGAIN return for forced non-blocking submission */
-		if (!force_nonblock || ret2 != -EAGAIN) {
+		if (!force_nonblock || (ret2 != -EAGAIN && ret2 != -EIO)) {
 			kiocb_done(kiocb, ret2);
 		} else {
 copy_iov:
-- 
2.27.0

