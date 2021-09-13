Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD640840A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhIMFuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhIMFun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:50:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE79C061574;
        Sun, 12 Sep 2021 22:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZlNshhcRbh7TTTSVkfYJWF8qycoraf4MAz4lP9XUHsc=; b=qEssEVXa3xjHznRIrCx8lBb2XD
        DS2hJrDQ+w2Bs6gJiCZ7Ft0fC60K+uApT2CiWS5kwhkWQKeLBCJWqv6Gpy3Nl8tyrkDDx2ID16Ib2
        GKd50AkDLlJFnUurQiM/EbVjIz6Su/aqsCoK9gljUPQErhxUG3wDPUNLPG3ZhGe218bj8h+0YwrhN
        uhtD+YDRtput2x1HRqiN8Wc2NRwqseWwpC0vN/htGCSXyU3jzUvPyL/HSjd9GJsNV5ZxOSdQM5xJd
        lfjal3NT/3xqF61gehnyXbiPzsTEn75IC8aZn7aOi3L77BshpSU9duXbl1D++4lEKOy+Kd68ZbzvD
        g/cTh6tg==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPeoy-00DCpG-FY; Mon, 13 Sep 2021 05:48:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] sysfs: add ->seq_show support to sysfs_ops
Date:   Mon, 13 Sep 2021 07:41:15 +0200
Message-Id: <20210913054121.616001-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow attributes to directly use the seq_file method instead of
carving out a buffer that can easily lead to buffer overflows.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/sysfs/file.c       | 19 ++++++++++++++-----
 include/linux/sysfs.h |  9 +++++++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96881b68..12e0bfe40a2b4 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -45,6 +45,9 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	ssize_t count;
 	char *buf;
 
+	if (ops->seq_show)
+		return ops->seq_show(kobj, of->kn->priv, sf);
+
 	if (WARN_ON_ONCE(!ops->show))
 		return -EINVAL;
 
@@ -268,6 +271,10 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		return -EINVAL;
 
 	if (mode & SYSFS_PREALLOC) {
+		if (WARN(sysfs_ops->seq_show, KERN_ERR
+				"seq_show not supported on prealloc file: %s\n",
+				kobject_name(kobj)))
+			return -EINVAL;
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_rw;
 		else if (sysfs_ops->show)
@@ -275,12 +282,14 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
 	} else {
-		if (sysfs_ops->show && sysfs_ops->store)
-			ops = &sysfs_file_kfops_rw;
-		else if (sysfs_ops->show)
-			ops = &sysfs_file_kfops_ro;
-		else if (sysfs_ops->store)
+		if (sysfs_ops->seq_show || sysfs_ops->show) {
+			if (sysfs_ops->store)
+				ops = &sysfs_file_kfops_rw;
+			else
+				ops = &sysfs_file_kfops_ro;
+		} else if (sysfs_ops->store) {
 			ops = &sysfs_file_kfops_wo;
+		}
 	}
 
 	if (!ops)
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85b..e1ab4da716730 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -236,8 +236,13 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
 struct sysfs_ops {
-	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
-	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
+	int	(*seq_show)(struct kobject *kobj, struct attribute *attr,
+			struct seq_file *sf);
+	ssize_t	(*store)(struct kobject *kobj, struct attribute *attr,
+			const char *buf, size_t size);
+
+	/* deprecated except for preallocated attributes: */
+	ssize_t	(*show)(struct kobject *kob, struct attribute *attr, char *buf);
 };
 
 #ifdef CONFIG_SYSFS
-- 
2.30.2

