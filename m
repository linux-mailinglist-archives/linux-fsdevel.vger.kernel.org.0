Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABC40B064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhINOTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhINOTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:19:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1FC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 07:17:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g9so17249546ioq.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7c8syQSjn5yBCKSSFtxNAKMp+iDYztMNgRmqIUn/y4=;
        b=ot4kB+Ih3QhytiaAfiLfEBF0Igh+Z2lvHWRkckVTvNJwEqmcJ/J1Vu9OAEa44SAd+J
         7+HPo2kLRSDdZFK97efrKeLZ9ucPXeCut16oOePaS5gtMCeBNmi+LZIVpBy8srXdin2u
         1p1vemZiAsGj4p9qBMCwYUYecc5m1fbXhBd9JmL8SGyyGaI0kOjFTEWxIjKyjb588yn/
         j9bQW78HkWFbcvcTAOSt8gSwoqb5G/bJng3dqqYDCvfaR6nq1sOTtlfXH0MWfjm+U6xf
         S9BBNadbk/bELyDBwb6R287yv+jEm7xkk3R1V7duDv+yzi9t2/Evv4DBhvZTQh/aLRsr
         Gbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7c8syQSjn5yBCKSSFtxNAKMp+iDYztMNgRmqIUn/y4=;
        b=3XI4/b7BKJTK+wm1bEVxLChS/2pAVJkL5zweaWDN+2hDa0l/BEGxEObCUIRG2vqy3d
         4CzQEAb2QIY+VynDJsvWyvJ8ruxEhPs2WfaaxApNEgFieX7geh4Q47XBFyNQ54xWWfIM
         7PATATEBeVpp2kTHUIoQI9a9N6RZqQtpi1qwkHzebPV/TYPqKxevhpnwOoRuGVFbfgvf
         v1Kt2YS1OB2ntkPkCa8k+aNdk0gJ7u+kvNJN7WaKj3o3ezL3ocoJHeBHOAUSc1yNW0Mx
         OaxppCQJDeTIZvaT9jMDH5fk0zz+wZVHp8hdODGsC5st6BC9/mThosUJksMoNl2oP52r
         GJdw==
X-Gm-Message-State: AOAM531RjV6PULe/UZz9N4MaJvy6MANI2UJOtpL+RoJOMiLeDEGKEOC/
        lgk8UuAdazioJGJNBGRT2EozGA==
X-Google-Smtp-Source: ABdhPJwHJDdCWKE4tIBEqkfAhQtAcMRw/R/WoKebKZMWNAPpX4dOsCBr92Sms5Kzb0IRQ9Y2wbj9RA==
X-Received: by 2002:a6b:5c17:: with SMTP id z23mr13746798ioh.3.1631629075962;
        Tue, 14 Sep 2021 07:17:55 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p135sm6673803iod.26.2021.09.14.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:17:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] iov_iter: add helper to save iov_iter state
Date:   Tue, 14 Sep 2021 08:17:48 -0600
Message-Id: <20210914141750.261568-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914141750.261568-1-axboe@kernel.dk>
References: <20210914141750.261568-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In an ideal world, when someone is passed an iov_iter and returns X bytes,
then X bytes would have been consumed/advanced from the iov_iter. But we
have use cases that always consume the entire iterator, a few examples
of that are iomap and bdev O_DIRECT. This means we cannot rely on the
state of the iov_iter once we've called ->read_iter() or ->write_iter().

This would be easier if we didn't always have to deal with truncate of
the iov_iter, as rewinding would be trivial without that. We recently
added a commit to track the truncate state, but that grew the iov_iter
by 8 bytes and wasn't the best solution.

Implement a helper to save enough of the iov_iter state to sanely restore
it after we've called the read/write iterator helpers. This currently
only works for IOVEC/BVEC/KVEC as that's all we need, support for other
iterator types are left as an exercise for the reader.

Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 15 +++++++++++++++
 lib/iov_iter.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5265024e8b90..984c4ab74859 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -27,6 +27,12 @@ enum iter_type {
 	ITER_DISCARD,
 };
 
+struct iov_iter_state {
+	size_t iov_offset;
+	size_t count;
+	unsigned long nr_segs;
+};
+
 struct iov_iter {
 	u8 iter_type;
 	bool data_source;
@@ -55,6 +61,14 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 	return i->iter_type;
 }
 
+static inline void iov_iter_save_state(struct iov_iter *iter,
+				       struct iov_iter_state *state)
+{
+	state->iov_offset = iter->iov_offset;
+	state->count = iter->count;
+	state->nr_segs = iter->nr_segs;
+}
+
 static inline bool iter_is_iovec(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_IOVEC;
@@ -233,6 +247,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
+void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f2d50d69a6c3..755c10c5138c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1972,3 +1972,39 @@ int import_single_range(int rw, void __user *buf, size_t len,
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
+
+/**
+ * iov_iter_restore() - Restore a &struct iov_iter to the same state as when
+ *     iov_iter_save_state() was called.
+ *
+ * @i: &struct iov_iter to restore
+ * @state: state to restore from
+ *
+ * Used after iov_iter_save_state() to bring restore @i, if operations may
+ * have advanced it.
+ *
+ * Note: only works on ITER_IOVEC, ITER_BVEC, and ITER_KVEC
+ */
+void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
+{
+	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i)) &&
+			 !iov_iter_is_kvec(i))
+		return;
+	i->iov_offset = state->iov_offset;
+	i->count = state->count;
+	/*
+	 * For the *vec iters, nr_segs + iov is constant - if we increment
+	 * the vec, then we also decrement the nr_segs count. Hence we don't
+	 * need to track both of these, just one is enough and we can deduct
+	 * the other from that. ITER_KVEC and ITER_IOVEC are the same struct
+	 * size, so we can just increment the iov pointer as they are unionzed.
+	 * ITER_BVEC _may_ be the same size on some archs, but on others it is
+	 * not. Be safe and handle it separately.
+	 */
+	BUILD_BUG_ON(sizeof(struct iovec) != sizeof(struct kvec));
+	if (iov_iter_is_bvec(i))
+		i->bvec -= state->nr_segs - i->nr_segs;
+	else
+		i->iov -= state->nr_segs - i->nr_segs;
+	i->nr_segs = state->nr_segs;
+}
-- 
2.33.0

