Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA3D0568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfJICIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 22:08:07 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:37540 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJICIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:08:07 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 22:08:07 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 809B51A40559; Tue,  8 Oct 2019 19:02:05 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:02:05 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file: move seq_read() flushing into a function
Message-ID: <20191009020205.2ezkdwzisnhtoau4@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate some duplicated bookkeeping from seq_read() into a
function.

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 fs/seq_file.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..e5d2bccf5ac4 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -141,6 +141,25 @@ static int traverse(struct seq_file *m, loff_t offset)
 	return !m->buf ? -ENOMEM : -EAGAIN;
 }
 
+static int flush(struct seq_file *m, char __user **buf, size_t *size, size_t *copied)
+{
+	int err = 0;
+	size_t n;
+
+	if (!m->count)
+		return err;
+	n = min(m->count, *size);
+	err = copy_to_user(*buf, m->buf + m->from, n);
+	if (err)
+		return err;
+	m->count -= n;
+	m->from += n;
+	*size -= n;
+	*buf += n;
+	*copied += n;
+	return err;
+}
+
 /**
  *	seq_read -	->read() method for sequential files.
  *	@file: the file to read from
@@ -154,7 +173,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 {
 	struct seq_file *m = file->private_data;
 	size_t copied = 0;
-	size_t n;
 	void *p;
 	int err = 0;
 
@@ -207,15 +225,9 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	}
 	/* if not empty - flush it first */
 	if (m->count) {
-		n = min(m->count, size);
-		err = copy_to_user(buf, m->buf + m->from, n);
+		err = flush(m, &buf, &size, &copied);
 		if (err)
 			goto Efault;
-		m->count -= n;
-		m->from += n;
-		size -= n;
-		buf += n;
-		copied += n;
 		if (!size)
 			goto Done;
 	}
@@ -273,13 +285,9 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		}
 	}
 	m->op->stop(m, p);
-	n = min(m->count, size);
-	err = copy_to_user(buf, m->buf, n);
+	err = flush(m, &buf, &size, &copied);
 	if (err)
 		goto Efault;
-	copied += n;
-	m->count -= n;
-	m->from = n;
 Done:
 	if (!copied)
 		copied = err;
-- 
2.11.0

