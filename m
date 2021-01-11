Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF752F1C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbhAKRU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbhAKRU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:20:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7AC0617A3;
        Mon, 11 Jan 2021 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fGWE+6L8dR25kvQMXj/ucZZNMyHjJC96zTfZ8s5MdcA=; b=o9ecJiUENKTk6X8kOuFJF6C2Tv
        gnrRbrfxZAYL7RvIPGpNUwx1cDzZcAdYnD1Im2U7ZCIxN/BdMKs2pgeRIa8xuh6fEt8aIUOuqjkEe
        y6QjWV3naervYSmQGpQ3uS4H2lYGUIiqQv5eqd4S3bWb6kdOtBRraLiIeZvb3UmoEQhvRUY0ilZqs
        tRv1RS+OH3jzPNl3GCOfltHSDedOwCYPCAslmrLKAImtjtTXYW8nNNWfSojWJP3BAHolqIRDrbgmB
        8vzXeMW+oS9GgRIHHYA3AQCUX5BkWRtch7gezUmaLMocjCYk5SYoDdCIE2wQcCkMK+gEv9RxwDTXI
        3CC6dc0Q==;
Received: from [2001:4bb8:19b:e528:814e:4181:3d37:5818] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kz0qm-003Y8c-Le; Mon, 11 Jan 2021 17:19:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] iov_iter: fix the uaccess area in copy_compat_iovec_from_user
Date:   Mon, 11 Jan 2021 18:19:26 +0100
Message-Id: <20210111171926.1528615-1-hch@lst.de>
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
index 1635111c5bd2af..586215aa0f15ce 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1658,7 +1658,7 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
 		(const struct compat_iovec __user *)uvec;
 	int ret = -EFAULT, i;
 
-	if (!user_access_begin(uvec, nr_segs * sizeof(*uvec)))
+	if (!user_access_begin(uvec, nr_segs * sizeof(*uiov)))
 		return -EFAULT;
 
 	for (i = 0; i < nr_segs; i++) {
-- 
2.29.2

