Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986F022DCDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGZHOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGZHOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C40C0619D2;
        Sun, 26 Jul 2020 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yblbXsy32g8hzD+BR7Pi2OP6YCbDPlnhYl7Ly/sIpoI=; b=V7CADSORo5/RGmLvbRmuzOk7oL
        W2m8TkGO47Mi1Tf1/YxUu927Ykra7PjRPzeneidvWHx9cBTy1jhPxOIIkTPKs0KkLKMN7TllA8wRL
        7eIteiP9Atp6yRaczp55M0OOnCzXnEKSNjQnRSrQsv0wv6VBnQ1cnBnWl2YHxc/M3vh3EJRRT4ZYH
        FenNBIK1miDjRUdnoFMcKO1R90JsO010oC9WQZF5UJW4PnrOd49+0uoniXX47JwhTn/vjH0DilH71
        AVrsw3VQU61Gxd4TdVxsw3R1zk8s+U3jh9onsmWgGUPXd4C+ZVTZ6nXXLM7NYO2VzJfwAN1Ed3tcI
        xkrmAHSQ==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarF-0002OY-6g; Sun, 26 Jul 2020 07:14:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 04/21] devtmpfs: refactor devtmpfsd()
Date:   Sun, 26 Jul 2020 09:13:39 +0200
Message-Id: <20200726071356.287160-5-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the main worker loop into a separate function.  This allows
devtmpfsd itself and devtmpfsd_setup to be marked __init, which will
allows us to call __init routines for the setup work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c | 47 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9017e0584c003..a103ee7e229930 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -378,7 +378,30 @@ static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 		return handle_remove(name, dev);
 }
 
-static int devtmpfs_setup(void *p)
+static void __noreturn devtmpfs_work_loop(void)
+{
+	while (1) {
+		spin_lock(&req_lock);
+		while (requests) {
+			struct req *req = requests;
+			requests = NULL;
+			spin_unlock(&req_lock);
+			while (req) {
+				struct req *next = req->next;
+				req->err = handle(req->name, req->mode,
+						  req->uid, req->gid, req->dev);
+				complete(&req->done);
+				req = next;
+			}
+			spin_lock(&req_lock);
+		}
+		__set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock(&req_lock);
+		schedule();
+	}
+}
+
+static int __init devtmpfs_setup(void *p)
 {
 	int err;
 
@@ -396,31 +419,13 @@ static int devtmpfs_setup(void *p)
 	return err;
 }
 
-static int devtmpfsd(void *p)
+static int __init devtmpfsd(void *p)
 {
 	int err = devtmpfs_setup(p);
 
 	if (err)
 		return err;
-	while (1) {
-		spin_lock(&req_lock);
-		while (requests) {
-			struct req *req = requests;
-			requests = NULL;
-			spin_unlock(&req_lock);
-			while (req) {
-				struct req *next = req->next;
-				req->err = handle(req->name, req->mode,
-						  req->uid, req->gid, req->dev);
-				complete(&req->done);
-				req = next;
-			}
-			spin_lock(&req_lock);
-		}
-		__set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock(&req_lock);
-		schedule();
-	}
+	devtmpfs_work_loop();
 	return 0;
 }
 
-- 
2.27.0

