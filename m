Return-Path: <linux-fsdevel+bounces-24179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A793AD05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D51C20EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745DE6CDC0;
	Wed, 24 Jul 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcAd1x7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C60D29E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805136; cv=none; b=An0E+M6650/m7D5ZqToyD+26w/8brnYzmnR+6LgJKu8CQ+i9QjF1o2fpJ3n17/KlXB2yuWtduywPa2btGG7gIclxpK0Ytkde5SXcnTyr1x6VdUvd02CgJSUlTD7TkvocjVbjtDhlfN5hMOlXJVoZbbhou+GpLshs7Hs55rWgRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805136; c=relaxed/simple;
	bh=aLiteNOyJdfK24UMxr9OGDyQfqCn+haD8SUOtGcYBj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIfXkN7HsLY9PbR6Tzu3Amd1srWFDfXsoTvFb6BQZVyhGqpWOgC5q8RZO2nEGDAocyEFWLkhS7f+zr62JsX60yoYrMBp9SBIBh6QRgi4d5qNM1go5M6kOnhJ2Q8scxTmmwnxhSrs8IgOvBJfioJNVLpe9CbpXD6/o1knHC203vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcAd1x7q; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260f863109cso3358744fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721805134; x=1722409934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vefBD6huXZ2/Z9w18nUiA7vgWJOXvgETJXelGXjG7eQ=;
        b=bcAd1x7qGt0v02U4U4koyyqpQaxWaMB8hQ+6NsrMhrw4xVBu1ADDo4HUi82ji99HX2
         ouuGjtsnfrUUj6HpG5hIHbMS7A5gznrF9OO8IwrWsf5+vHz6TZy59AZanfFctNalGDHs
         Ts/CrOSivNFVHd1kH8ATsrSMScoNEIQLYWyM3DMlYXD1EbfYrzu+Or2W3cxGSNeDbVku
         qH0lj1h9HekcJm/2GjXS/JAKUlrfmnzOfS8ScE2abisafoJEyX+jMcmmdFWk8RYT7A1+
         F8Jq7EUrYH77TmFGzo93EobE263dAhoJBDzzXzVRRiBnOeEMOym7Ju1gFmtBKls5b0bJ
         Hokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805134; x=1722409934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vefBD6huXZ2/Z9w18nUiA7vgWJOXvgETJXelGXjG7eQ=;
        b=QGn4hb7IJhu+CbKK/JT77P/rU98MNtUp1lIYQj9ONeSgKQlXO2Vv83f68qScgrh1sH
         X9qK44R65JhaX6ggIagiMUB1Yql54A52DHEE4YOp0da1d419OSteiLBQl8y6oRKl2MBO
         vba56cXRaTXZIlVp2zVsIsMJxTZJejIFxgHvCn64uVJ+/PiX36stH39tzsiOCvIjbSEn
         6B587xyT10vAzpwzzTjZSaIryaOU42RUmBi25LefmPvRUaPyZLNougTL8FzclIFDjRqi
         toU7KxtJ0BNt2WJRclLewq3ThNDmFeyx+tmKrwJLQ7yQe2ryUciP4okMI767RfNaN9Y1
         +tuQ==
X-Gm-Message-State: AOJu0YyFG53FKbTtKPlSnZOWIowlf6akmLcanWOuzQiTUA+7m9cLUqjF
	5l5nXrVW3/Yi/QdtBS5ASpvCA2iN12J6QICih9Pcu3B2GIfzv3TcGu2QonAHtMM=
X-Google-Smtp-Source: AGHT+IF3BYCQMqxESTgXz8ovBVrE8boRyJ5eqa1Z7Vf89ke2dqx/GrxeA5q/f0KpCDb+1uGazycjCg==
X-Received: by 2002:a05:6870:ac2b:b0:260:e48b:62d8 with SMTP id 586e51a60fabf-2648cb0aaffmr1271111fac.29.1721805134317;
        Wed, 24 Jul 2024 00:12:14 -0700 (PDT)
Received: from localhost.localdomain ([117.136.120.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a2163d7d3csm4096841a12.13.2024.07.24.00.12.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:12:13 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 2/2] fuse: Enhance each fuse connection with timeout support
Date: Wed, 24 Jul 2024 15:11:56 +0800
Message-Id: <20240724071156.97188-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240724071156.97188-1-laoar.shao@gmail.com>
References: <20240724071156.97188-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In our experience with fuse.hdfs, we encountered a challenge where, if the
HDFS server encounters an issue, the fuse.hdfs daemon—responsible for
sending requests to the HDFS server—can get stuck indefinitely.
Consequently, access to the fuse.hdfs directory becomes unresponsive.
The current workaround involves manually aborting the fuse connection,
which is unreliable in automatically addressing the abnormal connection
issue. To alleviate this pain point, we have implemented a timeout
mechanism that automatically handles such abnormal cases, thereby
streamlining the process and enhancing reliability.

The timeout value is configurable by the user, allowing them to tailor it
according to their specific workload requirements.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/fuse/dev.c    | 57 +++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h |  2 ++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..ff9c55bcfb3d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -369,10 +369,27 @@ static void request_wait_answer(struct fuse_req *req)
 
 	if (!fc->no_interrupt) {
 		/* Any signal may interrupt this */
-		err = wait_event_interruptible(req->waitq,
-					test_bit(FR_FINISHED, &req->flags));
-		if (!err)
-			return;
+		if (!fc->timeout) {
+			err = wait_event_interruptible(req->waitq,
+						       test_bit(FR_FINISHED, &req->flags));
+			if (!err)
+				return;
+		} else {
+			err = wait_event_interruptible_timeout(req->waitq,
+							       test_bit(FR_FINISHED, &req->flags),
+							       (long)fc->timeout * HZ);
+			if (err > 0)
+				return;
+
+			/* timeout */
+			if (!err) {
+				req->out.h.error = -EAGAIN;
+				set_bit(FR_TIMEOUT, &req->flags);
+				/* matches barrier in fuse_dev_do_write() */
+				smp_mb__after_atomic();
+				return;
+			}
+		}
 
 		set_bit(FR_INTERRUPTED, &req->flags);
 		/* matches barrier in fuse_dev_do_read() */
@@ -383,10 +400,27 @@ static void request_wait_answer(struct fuse_req *req)
 
 	if (!test_bit(FR_FORCE, &req->flags)) {
 		/* Only fatal signals may interrupt this */
-		err = wait_event_killable(req->waitq,
-					test_bit(FR_FINISHED, &req->flags));
-		if (!err)
-			return;
+		if (!fc->timeout) {
+			err = wait_event_killable(req->waitq,
+						  test_bit(FR_FINISHED, &req->flags));
+			if (!err)
+				return;
+		} else {
+			err = wait_event_killable_timeout(req->waitq,
+							  test_bit(FR_FINISHED, &req->flags),
+							  (long)fc->timeout * HZ);
+			if (err > 0)
+				return;
+
+			/* timeout */
+			if (!err) {
+				req->out.h.error = -EAGAIN;
+				set_bit(FR_TIMEOUT, &req->flags);
+				/* matches barrier in fuse_dev_do_write() */
+				smp_mb__after_atomic();
+				return;
+			}
+		}
 
 		spin_lock(&fiq->lock);
 		/* Request is not yet in userspace, bail out */
@@ -1951,6 +1985,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		goto copy_finish;
 	}
 
+	/* matches barrier in request_wait_answer() */
+	smp_mb__after_atomic();
+	if (test_and_clear_bit(FR_TIMEOUT, &req->flags)) {
+		spin_unlock(&fpq->lock);
+		goto copy_finish;
+	}
+
 	/* Is it an interrupt reply ID? */
 	if (oh.unique & FUSE_INT_REQ_BIT) {
 		__fuse_get_request(req);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 367601bf7285..c1467eb8c2e9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -375,6 +375,7 @@ struct fuse_io_priv {
  * FR_FINISHED:		request is finished
  * FR_PRIVATE:		request is on private list
  * FR_ASYNC:		request is asynchronous
+ * FR_TIMEOUT:		request is timeout
  */
 enum fuse_req_flag {
 	FR_ISREPLY,
@@ -389,6 +390,7 @@ enum fuse_req_flag {
 	FR_FINISHED,
 	FR_PRIVATE,
 	FR_ASYNC,
+	FR_TIMEOUT,
 };
 
 /**
-- 
2.43.5


