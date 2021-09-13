Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D45408449
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhIMF7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbhIMF7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9307C061574;
        Sun, 12 Sep 2021 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SDg0Mwos9YPZVttdSdsXikDW9x/t9+tGLWXXq2nNYAU=; b=KgyQ1sxek7HKAbyrIIBlyyLLf1
        0cBAx2qctdhqpVYPHuoQ+DFsqB4lrOqlBo79gyAzpFy6erREbV1avl5/LoDkaTcSGRf+Ou+7AiZJU
        w+yc58++nId3BfoAKKPSC/jiwzXWAALFwmGPkCD8WHs6XaL2eAVA8nKpGcHTF01mFuUSgS9lYYhLq
        DR4ZLNMPCYipmG8/Zx9PMlZKPczPtrOO/CF1VKMIfKI56LYdmATB2olm/W8Kim+Zzg76qrVKbXu2P
        WTcNTKD43OItXeYHxgX1tYZThkKD/Gkvq5FykXNp8488aVud4tcjTq4RCihkk83NlZemW28Kn3AUp
        bCdf57WQ==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPeuj-00DD4H-50; Mon, 13 Sep 2021 05:55:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] xfs: convert xfs_errortag attrs to use ->seq_show
Date:   Mon, 13 Sep 2021 07:41:20 +0200
Message-Id: <20210913054121.616001-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial conversion to the seq_file based sysfs attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_error.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 81c445e9489bd..143a1e0b12ffe 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -104,22 +104,22 @@ xfs_errortag_attr_store(
 	return count;
 }
 
-STATIC ssize_t
-xfs_errortag_attr_show(
+STATIC int
+xfs_errortag_attr_seq_show(
 	struct kobject		*kobject,
 	struct attribute	*attr,
-	char			*buf)
+	struct seq_file		*sf)
 {
 	struct xfs_mount	*mp = to_mp(kobject);
 	struct xfs_errortag_attr *xfs_attr = to_attr(attr);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			xfs_errortag_get(mp, xfs_attr->tag));
+	seq_printf(sf, "%u\n", xfs_errortag_get(mp, xfs_attr->tag));
+	return 0;
 }
 
 static const struct sysfs_ops xfs_errortag_sysfs_ops = {
-	.show = xfs_errortag_attr_show,
-	.store = xfs_errortag_attr_store,
+	.seq_show	= xfs_errortag_attr_seq_show,
+	.store		= xfs_errortag_attr_store,
 };
 
 #define XFS_ERRORTAG_ATTR_RW(_name, _tag) \
-- 
2.30.2

