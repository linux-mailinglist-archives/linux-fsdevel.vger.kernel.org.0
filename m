Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36ABB57C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfIQVsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 17:48:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfIQVsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:48:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DA1361213; Tue, 17 Sep 2019 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568756931;
        bh=X3NzP2/OYfzCgk/ZWQD94QYMs+1Ua5L9ueXra2kQULY=;
        h=From:To:Cc:Subject:Date:From;
        b=khpfHqSaFrHXavw8/J+fb+ITv0RESQd6ED4bU3KDprajNO7Oj1vnw/wD9hIOr5zxi
         64r+VrjPpvX1FPA5JIxcJocHDc0OrKqshyM0jgK9mKpy3RuVFXUiLVPrKuUHWzAUDt
         ts0jjHHZDcK89yTOAYpr8Mh9F0ZC9vTkEPGpOJEg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B8E3602F2;
        Tue, 17 Sep 2019 21:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568756930;
        bh=X3NzP2/OYfzCgk/ZWQD94QYMs+1Ua5L9ueXra2kQULY=;
        h=From:To:Cc:Subject:Date:From;
        b=kHu0LIZD5zPhs2oNSz7DbpAMoX25nskyMUXcyYDKnfzR+1LL5ck9jd5bdIro7EJnx
         oDVP/ORHzdU87q3Dru7c7rcka2raGkjEN9x7Z6KCjnSVir/RzKJzePPt/N5Xttp5M5
         FC6CXQhSm0fYkCw3mnq3gvLqnot1AtVKy1B0y1TY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B8E3602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] idr: Prevent unintended underflow for the idr index
Date:   Tue, 17 Sep 2019 15:48:42 -0600
Message-Id: <1568756922-2829-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is possible for unaware callers of several idr functions to accidentally
underflow the index by specifying a id that is less than the idr base.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 lib/idr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/idr.c b/lib/idr.c
index 66a3748..d9e180c 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -151,6 +151,9 @@ EXPORT_SYMBOL(idr_alloc_cyclic);
  */
 void *idr_remove(struct idr *idr, unsigned long id)
 {
+	if (id < idr->idr_base)
+		return NULL;
+
 	return radix_tree_delete_item(&idr->idr_rt, id - idr->idr_base, NULL);
 }
 EXPORT_SYMBOL_GPL(idr_remove);
@@ -171,6 +174,9 @@ EXPORT_SYMBOL_GPL(idr_remove);
  */
 void *idr_find(const struct idr *idr, unsigned long id)
 {
+	if (id < idr->idr_base)
+		return NULL;
+
 	return radix_tree_lookup(&idr->idr_rt, id - idr->idr_base);
 }
 EXPORT_SYMBOL_GPL(idr_find);
@@ -302,6 +308,9 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
 	void __rcu **slot = NULL;
 	void *entry;
 
+	if (id < idr->idr_base)
+		return ERR_PTR(-ENOENT);
+
 	id -= idr->idr_base;
 
 	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);
-- 
2.7.4

