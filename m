Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B42257F93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgHaRZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgHaRZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:25:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC670C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:25:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so5277247qtj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fnA8K+R9uRAtPbIClqpnQmt6aI2BGemHnr+qjEwk03s=;
        b=jB0W7yIkL0REurWxQ1jZXa0LpbHczNTZuRXFeoD7GZOgWmS7aYW8JljyxGfaC/MyAq
         K1Q9dxj7aerkz5nEh8T7JpCNNoxyun71YQO1ao8Sm4MDFrON5gkiYh3d9KlGJwrLZ9vD
         87+/fRnmLGozPS6XGVaug/SFVWq0mrq4Es+tuBbP/r20fAHAebsJYexMZblv4froMIeW
         z3PRxv4GfviGat0QvHkItzSsKihq+Qx4TZzBsEiOXJhkmRWeRGJxQHMIvcJo0vrqDQ7E
         nK6IYGAcy1fmf30b6YQrmNP+JiVePkFsJiA0yPi8t5NgXXbHPw2fKlf94Yl59524D+zh
         70GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnA8K+R9uRAtPbIClqpnQmt6aI2BGemHnr+qjEwk03s=;
        b=nZZiOOaN2T2WI0QAC03V/ylgt3pILFmnA0QZI5Hnz2fGIRe4Pe7R+7ofI9zbMZBJwj
         Zbdt9OUatwFeHGKmKnHyGDNrTVL+vLApWEZyhqsI79QjI8/BMivjcHbGggrHSE3KHLEe
         HpRiLu5yi3NQFcKynchtWqaNk8WfEMrxnoHBu9eZAQRwZjHSOSQJovFZzFSdUN1FSi1v
         iXI/xslIKw4AUgOZa2vEpfiTLjcbdKJYd14PhDfjDqm8ieS2Po0RDBrGwLKUFBU9S7wB
         Wq3V+2dlPXgWDEImMWHLpsXnmeCWZ09rVn4sNEOPDDo51DgCGGTsfKwI8HQg+3lof1LC
         lPtA==
X-Gm-Message-State: AOAM530Kwxoig6+7nTLpyBHD54a/8XI4i8Ieox2QLRSoMZfw/gN3n0Jj
        AHZA9lUCd50Z9ftJxNvRv75xbQ==
X-Google-Smtp-Source: ABdhPJzndCINloToTJBaTxvizaZ7Y4/r3EDZ5f9QDqyzeqFaLlr2qrxR9CnOSy/h3pSwxfPRNB3Mzg==
X-Received: by 2002:ac8:581:: with SMTP id a1mr2285747qth.161.1598894745819;
        Mon, 31 Aug 2020 10:25:45 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m66sm10143899qkf.86.2020.08.31.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:25:45 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] iomap: Fix WARN_ON_ONCE() from unprivileged users
Date:   Mon, 31 Aug 2020 13:25:34 -0400
Message-Id: <20200831172534.12464-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
unprivileged users which would taint the kernel, or worse - panic if
panic_on_warn or panic_on_taint is set. Hence, just convert it to
pr_warn_ratelimited() to let users know their workloads are racing.
Thank Dave Chinner for the initial analysis of the racing reproducers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
v3: Keep the default case and update the message.
v2: Record the path, pid and command as well.

 fs/iomap/direct-io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..b7f3311569bd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -374,6 +374,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_dio *dio = data;
+	char pathname[128], *path;
 
 	switch (iomap->type) {
 	case IOMAP_HOLE:
@@ -388,6 +389,21 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
 	case IOMAP_INLINE:
 		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+	case IOMAP_DELALLOC:
+		/*
+		 * DIO is not serialised against mmap() access at all, and so
+		 * if the page_mkwrite occurs between the writeback and the
+		 * iomap_apply() call in the DIO path, then it will see the
+		 * DELALLOC block that the page-mkwrite allocated.
+		 */
+		path = file_path(dio->iocb->ki_filp, pathname,
+				 sizeof(pathname));
+		if (IS_ERR(path))
+			path = "(unknown)";
+
+		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %s Comm: %.20s\n",
+				    path, current->comm);
+		return -EIO;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-- 
2.18.4

