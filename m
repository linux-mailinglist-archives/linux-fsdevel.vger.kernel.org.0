Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8B403B84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbhIHOaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:14 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41480 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349052AbhIHOaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:13 -0400
X-Greylist: delayed 1555 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2021 10:30:13 EDT
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAP-0004rv-1j; Wed, 08 Sep 2021 10:03:09 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH 8/9] coda: Use vmemdup_user to replace the open code
Date:   Wed,  8 Sep 2021 10:03:07 -0400
Message-Id: <20210908140308.18491-9-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

vmemdup_user is better than duplicating its implementation,
So just replace the open code.

./fs/coda/psdev.c:125:10-18:WARNING:opportunity for vmemdup_user

The issue is detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 240669f51eac..7e23cb22d394 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -122,14 +122,10 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		        nbytes = size;
 		}
-		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
-		if (!dcbuf) {
-			retval = -ENOMEM;
-			goto out;
-		}
-		if (copy_from_user(dcbuf, buf, nbytes)) {
-			kvfree(dcbuf);
-			retval = -EFAULT;
+
+		dcbuf = vmemdup_user(buf, nbytes);
+		if (IS_ERR(dcbuf)) {
+			retval = PTR_ERR(dcbuf);
 			goto out;
 		}
 
-- 
2.25.1

