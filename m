Return-Path: <linux-fsdevel+bounces-26932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C922F95D34F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FC281B51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC918BC04;
	Fri, 23 Aug 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP9r+LjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FB18BBB4
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430462; cv=none; b=bxJ8f1vEsUnIIbB8UZzTLy4FPOcWhiqvIzZNdrQiN/rRPKSRB3E3sQCBsQwoa/4EpNUd2NdyeEM8hYibDJGYiYAi1WxrwEqEeEOGqzwAix9Lqwq/Mx/+pZyPb0qgxKcYq1e1am5b5rqgKSnyrYMWcp4wp+n1f9byHMlfQbWwCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430462; c=relaxed/simple;
	bh=d1sw3RklYepjEi8jrs758o0Ste9SePDfyolWUw0Jdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL+3pXKh4uLxT+gyBtch1ZAr95TM7LBVlMy0ug3fYr5clNXThYy1zelWkYdVH5YWh1PtFbgpPHJLjSvHM2qkt54uwW3xxEgDBRyTp4UoTszxUDYmtplMhp6PLjrSc6Ta7Cby63ZEIWHtSDh1vmbXCdmjGxRrB50+m856Zo7jWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP9r+LjB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b44dd520ceso22053117b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430459; x=1725035259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=BP9r+LjBjyVHlSc+6B5aL4MLjfFBctnytxVKok9o7OQiUC1OI9HVuWOCuf1owcunia
         uZB7AQTPLPfZRr9ZSjw4Ez62IvbORcHicu9DHK1SwStvjmdeWL0zl42twndDtQo9CWtW
         /unz9Rqms0TocuX4zD4S5NU/1yiW0g8t//kvtnryZpX33NA+7FfPxddRWfFbKH+MH9YE
         EzD868tvplBnG3BXmiWg03WW/aL9bcTvy7Bgzj2W8TMJU7gLDoRMO/w1XlnmbWe1i/FQ
         vG/On1c6g9KfkrTXrdzO2VUwBVcG3VpklV/QaB4wiJIw47JzcnSkES3JSI0e4wz3WHYm
         tXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430459; x=1725035259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grTnWehlIm/aEMMtVTYddChEg6d1BbxYt+fz0gv8hQY=;
        b=mfjK6tAqFseb5uy4FkaiPUZe09mduk2Y1Rdd97zHPvJmgc9MiUI5TVliEvhUiOWvHO
         QRFL75m3BivRIyN1ckucptBoOVgXLbh5vis+uSv2d1C9Jyh/2EEo5L5y6mK8gwaOPpge
         E5YDBjq6N1UoUInX6DQJKEVDSqLLO8oelsrOVIAPG9tWTl0ffCy+HI0L2yGrvUxB+V4P
         zdKG1mqEiIObr1xTFMxaliuYEcTwvl0pYGhCufmWn++Ahyxknjn2IHWLUldP5ba+UWLS
         AHmBrnGp3NB5LKFrXlbSeYKKF3XTdJpDAOsaQ1QaYg9m6sHQZxx3CUdGYDho8Wjfiq5e
         6R/A==
X-Forwarded-Encrypted: i=1; AJvYcCXxGHKZvn6yHt+XUkhd2fBAZ/0NGViSIL/m/mXHyAb/4GXNzRlcPa6fnBT3vbn8ajHkYHWVu/tQOvtfSSQa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kRAJ28uFdIbO9urAf6p6pOamdAdzaLzzisj7DW/XubETqsLY
	lgR4AFLTxqC9OYrBzVzOS02rxhKs8eTYOPEcF4CuuLSNqkn1zqx4
X-Google-Smtp-Source: AGHT+IE+sd7E9TfB5HXfBx8aY+Bblz+XZNP6avoo9xtGPYZi9/Ef5L5WjVtGuRpjDdXCnOKPxagOCw==
X-Received: by 2002:a05:690c:428c:b0:6b0:12fc:71fb with SMTP id 00721157ae682-6c6258612c6mr25742777b3.18.1724430458945;
        Fri, 23 Aug 2024 09:27:38 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb5345sm5940667b3.10.2024.08.23.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 1/9] fuse: drop unused fuse_mount arg in fuse_writepage_finish()
Date: Fri, 23 Aug 2024 09:27:22 -0700
Message-ID: <20240823162730.521499-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the unused "struct fuse_mount *fm" arg in
fuse_writepage_finish().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..63fd5fc6872e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,8 +1769,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish(struct fuse_mount *fm,
-				  struct fuse_writepage_args *wpa)
+static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
@@ -1829,7 +1828,7 @@ __acquires(fi->lock)
  out_free:
 	fi->writectr--;
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
 	/* After fuse_writepage_finish() aux request list is private */
@@ -1959,7 +1958,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
 	}
 	fi->writectr--;
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 	fuse_writepage_free(wpa);
 }
-- 
2.43.5


