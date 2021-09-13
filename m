Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C596408404
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhIMFts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhIMFtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:49:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB6C061574;
        Sun, 12 Sep 2021 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iPSg9fzhb7ugDsun1O8XdsG/v81d56clxIVC4PupvcU=; b=BylZxWILvx+YFJGWUCLciodiR1
        Z4qK/AvTb7/s9GucyqBm3cYi0tYVJcq5cf2aMgvN77HrH0i91g9w4bGY8IY5g0WGzcRIsnhWEvBPG
        h+SWN0E+bMe2br+DsVPPDJx7v0fKdwd3OaLNaCUU8CNB0VArETFtFN4k1zu/rf4Q1xwzJ9NUCyCqM
        FCNhMgdSDite0x1fAI/Lnbvv7yu2BIjq6j2G07iW4U0ntHc9bcUSfav+fRH+Er+6Ici+2MsITgEy8
        +5g+P43FBMvJVke5GQE1VBSXoGQC6Zly9KKZZ6c3io5Sqrk5fVV5CGVF5qcnzCjV2xYt0hfoyT9ug
        3xtxsZow==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPeoN-00DCnV-Ci; Mon, 13 Sep 2021 05:47:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] sysfs: simplify sysfs_kf_seq_show
Date:   Mon, 13 Sep 2021 07:41:14 +0200
Message-Id: <20210913054121.616001-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Contrary to the comment ->show is never called from lseek for sysfs,
given that sysfs does not use seq_lseek.  So remove the NULL ->show
case and just WARN and return an error if some future code path ends
up here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/sysfs/file.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 74a2a8021c8bb..42dcf96881b68 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -45,6 +45,9 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	ssize_t count;
 	char *buf;
 
+	if (WARN_ON_ONCE(!ops->show))
+		return -EINVAL;
+
 	/* acquire buffer and ensure that it's >= PAGE_SIZE and clear */
 	count = seq_get_buf(sf, &buf);
 	if (count < PAGE_SIZE) {
@@ -53,15 +56,9 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	}
 	memset(buf, 0, PAGE_SIZE);
 
-	/*
-	 * Invoke show().  Control may reach here via seq file lseek even
-	 * if @ops->show() isn't implemented.
-	 */
-	if (ops->show) {
-		count = ops->show(kobj, of->kn->priv, buf);
-		if (count < 0)
-			return count;
-	}
+	count = ops->show(kobj, of->kn->priv, buf);
+	if (count < 0)
+		return count;
 
 	/*
 	 * The code works fine with PAGE_SIZE return but it's likely to
-- 
2.30.2

