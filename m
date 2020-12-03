Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016112CCBD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 02:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgLCBuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 20:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLCBt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:49:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8AC061A4D;
        Wed,  2 Dec 2020 17:49:19 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so219052wrb.9;
        Wed, 02 Dec 2020 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOG+3W1/WPBrVFvTxhEtyD+QbD+e1E8wQqqpYfy4mUg=;
        b=EiDSqHzjFGpIlPpFn3xHJAOJo7xNlSAtFjgI15EvJWzlvIfmm2T0p5GRNrZkBCEpqw
         Naq5gZ/ZUlGiJt41lKhcCGvfb6d8gBbQti5WhtvEygvYEsGwv09a8iQ0ePqsCs3Tjw26
         sOkCOaKyS7ITRirZsPFGZBYb61DruXVhTvBZczIKPdEGjriBTKvdaTc4j2G5N2+zjtLG
         l6uWeQ00vpoNSb3FL8x9bwe36RQgHDkooC/hpCh+6mSQSME1KyTNSXlVs5UIdwhx1UlC
         svxfHAtX/Ledl0Sibe/KBuOHGQ+wjklH98s9YTU9OM2BUaQaaWPN/XD6M/F57JgG389Q
         2aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOG+3W1/WPBrVFvTxhEtyD+QbD+e1E8wQqqpYfy4mUg=;
        b=PHp2+Lw/Vb0CKI2N9INj8DFmGH8+wWPst1zUxk7TRsYx3SS0C03NGoMiUebRaGdXmv
         Ap17L1Z49bCqROiV0Jvtv4FdwCaITilh5s9N5Q/XgK1dkSXI2i/SlEBY2vp6Sd4NmCi4
         ezn2XserTfQSgbiwWloBJ4+yVNaYv7fJqm3DFhVVIXNCUntlujn8Zm9z7r3WbMWNph2T
         DNpvNjcdTO+CFEE/4TwBR9icMWPC4ymk+Ol3oIGijwBayWwwSdNub13VXALnQfJQQiQD
         agXAAmuQm8uPEzGMTU2TY3jE+7b/0jiGIxymKbb0O4WBOYa8YYOhXRuM88JVvAPKw2Xm
         X+Ew==
X-Gm-Message-State: AOAM530v8bN8HECNNXWdGRwUQUrArpBtMoNniKv3grvz/VhF4HnyvGI8
        1Kr6tp3Pr31ouGnefSQOzkdqOutF9zh+4g==
X-Google-Smtp-Source: ABdhPJz6uId5ZfhwyX5sqWHdqx2kFsKhYip4LqvWbPmerK5pjdt70lX9dXz/hODi1A+5SAGiWNL6Hg==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr914381wrm.159.1606960157013;
        Wed, 02 Dec 2020 17:49:17 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id y18sm521496wrr.67.2020.12.02.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:49:16 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iov_iter: optimise bvec iov_iter_advance()
Date:   Thu,  3 Dec 2020 01:45:54 +0000
Message-Id: <21b78c2f256e513b9eb3f22c7c1f55fc88992600.1606957658.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iov_iter_advance() is heavily used, but implemented through generic
iteration. As bvecs have a specifically crafted advance() function, i.e.
bvec_iter_advance(), which is faster and slimmer, use it instead.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/iov_iter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..7fbdd9ef3ff0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1077,6 +1077,20 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		i->count -= size;
 		return;
 	}
+	if (iov_iter_is_bvec(i)) {
+		struct bvec_iter bi;
+
+		bi.bi_size = i->count;
+		bi.bi_bvec_done = i->iov_offset;
+		bi.bi_idx = 0;
+		bvec_iter_advance(i->bvec, &bi, size);
+
+		i->bvec += bi.bi_idx;
+		i->nr_segs -= bi.bi_idx;
+		i->count = bi.bi_size;
+		i->iov_offset = bi.bi_bvec_done;
+		return;
+	}
 	iterate_and_advance(i, size, v, 0, 0, 0)
 }
 EXPORT_SYMBOL(iov_iter_advance);
-- 
2.24.0

