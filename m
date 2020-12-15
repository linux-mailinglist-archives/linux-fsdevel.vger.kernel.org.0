Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1EE2DB1AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgLOQmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLOQmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:42:14 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012BC06179C;
        Tue, 15 Dec 2020 08:41:33 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s26so6351201lfc.8;
        Tue, 15 Dec 2020 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piepAd/SOcQL/7YpFzndO+yj9/9SRxKOm/1zBPtAyNU=;
        b=aImOHYRHjfSVgHyEY//nzY7lyNIQkOAv8bAEcxHrSdPEtCcF7+vaQC364QhiUEGbRY
         0S/VZql7ZIT7rDmHja6BSR2kCu3y6ccJPJgqR3iQs8BdkmY/1qJgyXD7WsGWfLOXJtI8
         62R21MwPBq2noPNeQJQGjRWic+Khvo31146Qrm88a61KOK6a7+qfzugkn55zHK371wbv
         BVoDRan+xXt5yfQirWKzm4JrdR//lZgK52zrwO+amZqhx7L1ZtxNjBSPBlcgD+Yz4uVA
         i6IzZ/8Mr2b+B2qlGv4jhQ6sXH09LCQDxCYwY0XTQSKR1MG7+2rUQRWV/rwRVBMBTI4h
         /VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piepAd/SOcQL/7YpFzndO+yj9/9SRxKOm/1zBPtAyNU=;
        b=k6GzeUXMhRc4KS/iHm0Pboz0n3zj+2BVKwbZ6fBj7vhx7HELDs4Z8+Kjwx0WqpZV/h
         xDyflD2WHhULoz3eqVJX4bKG4sj9YwQgh4+btw7yOWRYmGhSQ+T4Gh1lLosypD8JFEQs
         bm/4nRHJNai078HHN8yii4WVFFEsIC9sZmGwqCIQC/ltl/B+7hK8OujpiR4rexQlBGsL
         REftmx1iYrtlfHaGoCgXfAecOuzzfRvUJZkwGbQtnqoatModsPha4ecmbGe/cG72lCFQ
         PUngiM/7Q/dpPje8tJoHNjTkBPAdV74p1OqA9sd9vhl3IJ0ZdYVrq+xIl3dOnsW4qgow
         uJGQ==
X-Gm-Message-State: AOAM533SrZAKPDrl6gKXXIiwsyslYFphomqExAFRo76Rwx1K2sVwswnv
        p15rthBuGYGgO4F950g8FZWPWaPhesKFhgcG
X-Google-Smtp-Source: ABdhPJz6Sv4h9V/euaaE4EbAIs9KqichrRM8CcR6WfGkY7yI9Q5IRIxqZblSNAHYlHDIjtkRPg58HA==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr12401139ljj.73.1608050492403;
        Tue, 15 Dec 2020 08:41:32 -0800 (PST)
Received: from localhost.localdomain (109-252-202-142.dynamic.spd-mgts.ru. [109.252.202.142])
        by smtp.gmail.com with ESMTPSA id y3sm263287lfy.73.2020.12.15.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:41:31 -0800 (PST)
From:   Sergey Temerkhanov <s.temerkhanov@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: [PATCH] fget: Do not loop with rcu lock held
Date:   Tue, 15 Dec 2020 19:41:23 +0300
Message-Id: <20201215164123.609980-1-s.temerkhanov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlock RCU before running another loop iteration

Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
---
 fs/file.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4559b5fec3bd..49d57752e7a6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -823,21 +823,27 @@ static struct file *__fget_files(struct files_struct *files, unsigned int fd,
 				 fmode_t mask, unsigned int refs)
 {
 	struct file *file;
+	bool again = false;
 
-	rcu_read_lock();
-loop:
-	file = fcheck_files(files, fd);
-	if (file) {
-		/* File object ref couldn't be taken.
-		 * dup2() atomicity guarantee is the reason
-		 * we loop to catch the new file (or NULL pointer)
-		 */
-		if (file->f_mode & mask)
-			file = NULL;
-		else if (!get_file_rcu_many(file, refs))
-			goto loop;
-	}
-	rcu_read_unlock();
+	do {
+		rcu_read_lock();
+
+		file = fcheck_files(files, fd);
+		if (file) {
+			/* File object ref couldn't be taken.
+			 * dup2() atomicity guarantee is the reason
+			 * we loop to catch the new file (or NULL pointer)
+			 */
+			if (file->f_mode & mask)
+				file = NULL;
+			else if (!get_file_rcu_many(file, refs))
+				again = true;
+		}
+		rcu_read_unlock();
+
+		if (unlikely(again))
+			schedule();
+	} while (again);
 
 	return file;
 }
-- 
2.25.1

