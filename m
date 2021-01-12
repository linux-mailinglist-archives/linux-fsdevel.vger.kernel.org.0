Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A92F29E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 09:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbhALITw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 03:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbhALITv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:19:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247AAC061795;
        Tue, 12 Jan 2021 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7Pzq6TuGwXUDAswNF2KAxKpKkyNEbwc9g8zfo4UjVAA=; b=ThxcvXGMUV2HbxpX68F7p7k3Ye
        xCfNW4RqCxuBppwuTsPtgZCzvRWlTnYBc8WyjWH0u4N/J1RNlIQqvzXA2zccIBdGCV8RXHXm0fHs3
        8M/+ny/7XqXMFiSX2hElXb8sXw23K1+4YLx93oxJ36T+Z5RTuii2WzMxsY26/Hyjmscaf0ybU0n7y
        RABbqh9oE+Fzdx5bMv1uXMyAjOYwJ6p4n1HfpBGVg6mK5NRuGBqPoZJ9mPqySZM2d4R8IIoFGe62r
        TDORqXUBW2Fmv3TrMKIu8N/Lhd2f0S+4fILM2izjS479RcC8qxnfwK2Ze8yW8pZtYqebUV0g8rOj/
        85Mi0XRQ==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzEtP-004VjD-7N; Tue, 12 Jan 2021 08:19:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] iov_iter: fix the uaccess area in copy_compat_iovec_from_user
Date:   Tue, 12 Jan 2021 09:19:05 +0100
Message-Id: <20210112081905.1736581-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sizeof needs to be called on the compat pointer, not the native one.

Fixes: 89cd35c58bc2 ("iov_iter: transparently handle compat iovecs in import_iovec")
Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2af..a21e6a5792c5a5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1658,7 +1658,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 		(const struct compat_iovec __user *)uvec;
 	int ret = -EFAULT, i;
 
-	if (!user_access_begin(uvec, nr_segs * sizeof(*uvec)))
+	if (!user_access_begin(uiov, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	for (i = 0; i < nr_segs; i++) {
-- 
2.29.2

