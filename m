Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE90D1F9633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgFOMNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgFOMNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829ACC061A0E;
        Mon, 15 Jun 2020 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PF4bzIK4C6pn8fyYVupIOSqczJ5WF2NO/8H9ENbmrME=; b=E+eWHfg8isJ5VnITgvQWL3PrTo
        CDP0ntDNh+D+4Y08c8n8h6tHp2L9c9d/GgR/kYjjigllS6cMvUNBnKSyB2L7sPJdVG1xFLXFu9dyW
        Iym0Uuru+rhilWJlPJB3/dGxZw7NdKubcyQyXGhIiznynOkFlDx+iuJOyFfHzOQnV4C1f47dLYPG4
        ldy+u85fJelGMj9wn7XQ59dTHR3794/tzkjF4hErxrs3cls381N+ryJYL6Yg4AceK14tMkjB218eK
        9jkbhkpcH8PUkqwWO5arDXrWC/D6KfxnRK3nmVcpvHozawoTwmEkslU3GmBNAy/5DsKsgM9KbJwoe
        g9qLP+bQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknze-00075s-L2; Mon, 15 Jun 2020 12:13:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 13/13] fs: don't change the address limit for ->read_iter in __kernel_read
Date:   Mon, 15 Jun 2020 14:12:57 +0200
Message-Id: <20200615121257.798894-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615121257.798894-1-hch@lst.de>
References: <20200615121257.798894-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we read to a file that implements ->read_iter there is no need
to change the address limit if we send a kvec down.  Implement that
case, and prefer it over using plain ->read with a changed address
limit if available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1d43da8554dc0d..3bde37aa63db6c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -421,7 +421,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs = get_fs();
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_CAN_READ))
@@ -429,14 +428,25 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	set_fs(KERNEL_DS);
-	if (file->f_op->read)
+	if (file->f_op->read_iter) {
+		struct kvec iov = { .iov_base = buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, READ, &iov, 1, count);
+		ret = file->f_op->read_iter(&kiocb, &iter);
+		*pos = kiocb.ki_pos;
+	} else if (file->f_op->read) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
 		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-	else if (file->f_op->read_iter)
-		ret = new_sync_read(file, (void __user *)buf, count, pos);
-	else
+		set_fs(old_fs);
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_access(file);
 		add_rchar(current, ret);
-- 
2.26.2

