Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39D41FF50D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgFROoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730931AbgFROoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691AC06174E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so2649903pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=aZaDFCszZJWwvw+YU15551W6DS/tp5Q0zZ/e2mzcPKg=;
        b=yzp2+WvVYDYAjxYEzGcL7PkavHxDy3cpr9qzW1IWcotTTR9f4VhesgN5dhZI94+PsU
         D9XrCxqsfO+3+KrzN5/i59EGbZklLXhJ8EEfRkcKjS+RSy9l3JJAAb3DNGy49QESvyup
         y+54KKaMpJCnfzL+F+KC8Nq7RiZ+0vIr9IiDsumf++0aVkCJenAnaKTtA3JP5ygXQhYB
         2HbmH52rlEtjDxPlJY6OwsA0PBg77wgg7/2VGxIMl44vnzaycw7+hUNxlA6Vq9Gzvp1p
         BDytFguC2D8/8IQpvQ3NiTjxRjsGSXn+74N6mA5zAWSn0EOSGif2RsltVaUOkZ/y9GnI
         oyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=aZaDFCszZJWwvw+YU15551W6DS/tp5Q0zZ/e2mzcPKg=;
        b=XlZrXGmqzi2rBP8ICJYkvoVtMt3KpogxEnVF+OghrM2UP3EnLuy6KXP2GFhixGjPHR
         N2q3RnMkk4xOinKugp+IRL1AJvmFUBWfCe0nMfOB/12+mcpOKT4fkr4MmXqmEW2wyp34
         X6Bgv9QUjAZY2GvFR3TbHE4RSDKd0jxv+juJWZAaj3k9BmLtuvMp8doBWBQsWHqbZRLR
         C3HiwQCovdyKN0Dhq+lyGXqXXQwlj60+YEy+RzpALIkYfobWAUlr9BZsSEgLh8H4bvgB
         fJhFjbwhDZaxr9sosYepU0brOM8lyM5stNWPDJsE+Y8s5mfiq4KZPRaaC0LFhGiYNQwn
         Y19Q==
X-Gm-Message-State: AOAM531JXkxj7LtxJ7pW7j7rs/Z89hRVjzadd2L/Tm+C+2+Zz4kqzOci
        A+7Pq+db47lNXiEb7oWbbwl0sQ==
X-Google-Smtp-Source: ABdhPJwcpBuWJToBprbE+kBnwBY9JxdUaCcM4SRk7uPRoXVsDbkErSY+i9Q0PI2mKLg9/3NhPQrRsQ==
X-Received: by 2002:a17:90b:915:: with SMTP id bo21mr4702163pjb.52.1592491442581;
        Thu, 18 Jun 2020 07:44:02 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/15] io_uring: always plug for any number of IOs
Date:   Thu, 18 Jun 2020 08:43:42 -0600
Message-Id: <20200618144355.17324-3-axboe@kernel.dk>
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

Currently we only plug if we're doing more than two request. We're going
to be relying on always having the plug there to pass down information,
so plug unconditionally.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b14a8e6a0e15..ca78dd7c79da 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -676,7 +676,6 @@ struct io_kiocb {
 	};
 };
 
-#define IO_PLUG_THRESHOLD		2
 #define IO_IOPOLL_BATCH			8
 
 struct io_submit_state {
@@ -5914,7 +5913,7 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			  struct file *ring_file, int ring_fd)
 {
-	struct io_submit_state state, *statep = NULL;
+	struct io_submit_state state;
 	struct io_kiocb *link = NULL;
 	int i, submitted = 0;
 
@@ -5931,10 +5930,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	if (!percpu_ref_tryget_many(&ctx->refs, nr))
 		return -EAGAIN;
 
-	if (nr > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, nr);
-		statep = &state;
-	}
+	io_submit_state_start(&state, nr);
 
 	ctx->ring_fd = ring_fd;
 	ctx->ring_file = ring_file;
@@ -5949,14 +5945,14 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			io_consume_sqe(ctx);
 			break;
 		}
-		req = io_alloc_req(ctx, statep);
+		req = io_alloc_req(ctx, &state);
 		if (unlikely(!req)) {
 			if (!submitted)
 				submitted = -EAGAIN;
 			break;
 		}
 
-		err = io_init_req(ctx, req, sqe, statep);
+		err = io_init_req(ctx, req, sqe, &state);
 		io_consume_sqe(ctx);
 		/* will complete beyond this point, count as submitted */
 		submitted++;
@@ -5982,8 +5978,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	}
 	if (link)
 		io_queue_link_head(link);
-	if (statep)
-		io_submit_state_end(&state);
+	io_submit_state_end(&state);
 
 	 /* Commit SQ ring head once we've consumed and submitted all SQEs */
 	io_commit_sqring(ctx);
-- 
2.27.0

