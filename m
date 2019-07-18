Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BD6D727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfGRXK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 19:10:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42149 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfGRXK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:10:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so13548882pgb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4Bh3i6WETjmo2gyscMLqDfoKBlO0O1C7LBrFVC3WzwM=;
        b=A2OQZovNRceZTr0qvqRWA+vvSU0W8aBl7wly3yLkbkIHZUeYJAtJQTzRAPjfB0QiP7
         BLkaNNWPXS38CuOrGw7tP/rIX2i/CahcuukE3O/+iiFAUg+tNY431SacXuFB3Z0NqQxv
         Qt/x6dIoS+nu0xB2FIOh0Leo/ZlL3/JJTE1ff84W2a1l/BUsslte3rSOxOh6yy4fI52E
         fYbcMoaWmQayMWjLXTaR+OqTe/GUawChy0OTfdcdZ5dFGXkR8e7QocydqMkoK71VfJ73
         u6of+gYDyfkxe60FwCZOoNQnHg907/TdQdliWws+9Pc28mWdRcIvQxPAYrwlQ7Lu/1uD
         oLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Bh3i6WETjmo2gyscMLqDfoKBlO0O1C7LBrFVC3WzwM=;
        b=G0O+8U4yP/3asvPWiFKug/1/FYWn1StXfConj9qEIvESWgNdOYQyRZOznyA+HLn07L
         g+C+oM70srr7iwkm6jE6KOLTHFGC2AVxCe3dX74qtLSm57UFasUA4OwoutPJ3BQ4Jw90
         n4jpeGkqLSaWnsqqa00zFqJopdptQ3euCav5SNyf1z1iyc3vPzV2E5FqMq9pf1y2jkLv
         /K6ZAbDDS/sgWP3aDOOk7dJWFV6jL7jZF5Nr9PqWeMRNB6C6tadU9ASFG+aNN5ygAQ+P
         gYX4iDeehENda7fUSR6PHPAlAvedpLwfbo+6IoGtAgNnRwJ9YJUxDgOL+LEBcuWCRVqF
         aHag==
X-Gm-Message-State: APjAAAVx3Em/9hya4oVLJTPzliiZEisx8NpuA52L4ognd2Fjt7QBeccY
        2/DRp3xGR7ADjnru2cs7cOcTuPuXjqE=
X-Google-Smtp-Source: APXvYqw/bJd5fIdOZX8VM/Gc828lajZHC2R/8+xosrp/+5HCYJ+Mwj3/LYfDYZc5xg/XWCxPKMcZeg==
X-Received: by 2002:a65:4844:: with SMTP id i4mr51178039pgs.113.1563491458290;
        Thu, 18 Jul 2019 16:10:58 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w14sm32502763pfn.47.2019.07.18.16.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 16:10:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: Support read/write with non-iter file-ops
Date:   Thu, 18 Jul 2019 16:10:54 -0700
Message-Id: <20190718231054.8175-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a wrapper for aio_read()/write() to allow async IO on files
not implementing the iter version of read/write, such as sysfs. This
mimics how readv/writev uses non-iter ops in do_loop_readv_writev().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 fs/aio.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f9f441b59966..0137a1a9bef1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1514,12 +1514,44 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+static ssize_t aio_iter_readv_writev(struct file *file, struct kiocb *req,
+				     struct iov_iter *iter, int type)
+{
+	ssize_t ret = 0;
+	ssize_t nr;
+
+	while (iov_iter_count(iter)) {
+		struct iovec iovec = iov_iter_iovec(iter);
+
+		if (type == READ) {
+			nr = file->f_op->read(file, iovec.iov_base,
+					      iovec.iov_len, &req->ki_pos);
+		} else {
+			nr = file->f_op->write(file, iovec.iov_base,
+					       iovec.iov_len, &req->ki_pos);
+		}
+
+		if (nr < 0) {
+			ret = nr;
+			break;
+		}
+
+		ret += nr;
+		if (nr != iovec.iov_len)
+			break;
+		iov_iter_advance(iter, nr);
+	}
+
+	return ret;
+}
+
 static int aio_read(struct kiocb *req, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
+	ssize_t count;
 	int ret;
 
 	ret = aio_prep_rw(req, iocb);
@@ -1529,15 +1561,18 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
 	ret = -EINVAL;
-	if (unlikely(!file->f_op->read_iter))
-		return -EINVAL;
 
 	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+	if (!ret) {
+		if (likely(file->f_op->read_iter))
+			count = call_read_iter(file, req, &iter);
+		else
+			count = aio_iter_readv_writev(file, req, &iter, READ);
+		aio_rw_done(req, count);
+	}
 	kfree(iovec);
 	return ret;
 }
@@ -1548,6 +1583,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
+	ssize_t count;
 	int ret;
 
 	ret = aio_prep_rw(req, iocb);
@@ -1557,8 +1593,6 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	if (unlikely(!file->f_op->write_iter))
-		return -EINVAL;
 
 	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
@@ -1577,7 +1611,11 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		if (likely(file->f_op->write_iter))
+			count = call_write_iter(file, req, &iter);
+		else
+			count = aio_iter_readv_writev(file, req, &iter, WRITE);
+		aio_rw_done(req, count);
 	}
 	kfree(iovec);
 	return ret;
-- 
2.18.0

