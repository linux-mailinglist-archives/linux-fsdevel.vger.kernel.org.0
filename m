Return-Path: <linux-fsdevel+bounces-71957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CCCD83DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05E39301399E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F32F619A;
	Tue, 23 Dec 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rmxzna8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B39238C33
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470932; cv=none; b=op28DvbJjvEUw9e/fIhWVWXtbQOOR/JpQ7329+Pw7prevg/+sRcwbyFJhglwP4lqm0qNFQQSH8OO7V6HObIyBGynHYcITl104z4elEGYeeegRTX0J2UJglL1ur+RpndlSLxA0wdm9NoLscMnCQRvqkya9UqwUa2Ts+ezzuyo/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470932; c=relaxed/simple;
	bh=ii3tKR+4BjiW44lmltitk7q4UioocLQVYvSPZpv3Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL7saA+BFcL+tNdtufJRezHPFXZCkIcxL18e0q/K/a6Vpf8RqnI33QYBkKCB9tlFAuio1oxO8COsf3nxCgJPY44V0DnmKWjX8EgROvq/0lN9JQb6PwFxttnN0TvHicA872haTdYm4x2cER8m6v2MCCU5Eve8IV0iTjRiIkIMWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rmxzna8g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a09d981507so33735145ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1766470930; x=1767075730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHjVs+ePCiPAolPHVFOqDlm6Kow86qZw302+wVnuJm4=;
        b=Rmxzna8gzpY8/aoNmVQ5oM2j4oE4FqWK3h0OX8rdJkUKrM+AAYbQsS243AcJDwvtmf
         4lG8G/xP0s90CuYCtd/rFaVXwNUNS2yb889xlUgVVkXg5lmxcWFzHmjsXzcfj568jUZD
         N5U2938/PFE+py3G1OPxXw1fVlboo7G7yC/mZuwshel/pD/LYpup9ozaKTeMRLlM+zYE
         VGP9pTgKLIYI/d6/AmVPPkgoJ64Ws0ErCIuBTDcX2gF+JvguLa7Sscu1s1WiFI9x1ahz
         /IvR0F4RahDMPqhPydCCUzqH7oLxrx8vdHO2bjRfD4PNsC2UfQ5LxpxEQpoezxBWQOtB
         I8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470930; x=1767075730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHjVs+ePCiPAolPHVFOqDlm6Kow86qZw302+wVnuJm4=;
        b=p46H6CVL84xvTHoqdgakx1pemiN/+m29VRBN7hYj31CC5c4GibUoypaY+rkSspvjlb
         KIwaTvT8LAMBIx9RlyoG5sJ9pnFQS5NpOnLC6OnYSrVuILQr2pJtMbh1IFp6lCbV+oiN
         7llnAuK5tPPJZ2PI7kUnad/0hnntYBSkW/B04mOKy3P7abxOfu+mBX413JKfRiysF+tY
         8Lcx7KnfoHK9cc4+z06tM5wrIBV+/Ni0zfo89Cs5iDMpK8KKPXyA4TpJc5EM56z7Ng+i
         iXP3l4FlRM2NG1Eib/LBISmL8+Cpnhi+3tdbemAK6Pe9JXMgvIbzCXhqCQ4AOvUN+vTu
         4ReA==
X-Gm-Message-State: AOJu0YzTn3rBixWNhct3ouGnXEb2yPPpwAmbYMHa651lR3LiINFVpQye
	LUjNOkF/wPrh6RwQjIlLotJa8fgE4JDFVMmeSHbmsS5BZ1QnkGumb/G86Bx/l9K1YH0=
X-Gm-Gg: AY/fxX6qIMwpvGcWXdijXOE9HWQ0qcER5snzcES943UTj/KOub+59t+ItTeZ8BIpqdp
	MS/yIaQNeMxMFwg+Lg85X4UQrVmU90WpZ95BrPUcITny1llp0aDtZAFuYPl7Q2R8IB2MPyLjTwJ
	aF1kOjYi+rmQJXapXIqCptiU1J+MGfTinDUAzInolPTdWczrni4EnDlyKBmDKGlLS5+Cpl+T18j
	Fc8GO5F+eNjEnFjcsavYmIO6/v47cbWhJ6QIuLTY6+VSW0yf0wF+UHs2jA0vFlbC9FZro7K9lL4
	g+Aba2dwkZYeKJ92peWY/FIiZGiRPRfXseZkgdYvoEOK5mzZSOWXMF9c4yBJQg2c886Omzj6EbQ
	AtCFSLjZ6GE43HL1rh4U5/G4oAf64tCDTmGzjHG4Wkd8Tt9u1Q2aRhhPISCUim0AR2eZoTOJe/B
	+xjjyndqLorASjLn+s+4vaer6Ve+w3WUloPV0HgX9oSpz/+fg/8vA=
X-Google-Smtp-Source: AGHT+IHkR80oZPE/nGAYfrvytYdflPvZplf9xx+aFYkbbPKy0wtYSX190VZI/iJQ8MAj/w4fLfaBGA==
X-Received: by 2002:a17:902:e845:b0:2a0:7f8b:c0cb with SMTP id d9443c01a7336-2a2f0caa42amr155169735ad.4.1766470929914;
        Mon, 22 Dec 2025 22:22:09 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm117632915ad.19.2025.12.22.22.22.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Dec 2025 22:22:09 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	zhujia.zj@bytedance.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH] fuse: add hang check in request_wait_answer()
Date: Tue, 23 Dec 2025 14:21:13 +0800
Message-ID: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the FUSEDaemon fails to respond to FUSE requests
due to certain reasons (e.g., deadlock), the kernel
can detect this situation and issue an alert via logging.
Based on monitoring of such alerts in the kernel logs,
we can configure hang event alerts for large-scale deployed
FUSEDaemon clusters.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/dev.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6a..7b3d4160647a2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -30,6 +30,9 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
+static unsigned long hang_complain_secs = 60;
+module_param(hang_complain_secs, ulong, 0644);
+
 static struct kmem_cache *fuse_req_cachep;
 
 const unsigned long fuse_timeout_timer_freq =
@@ -545,14 +548,24 @@ static void request_wait_answer(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	unsigned int hang_check_time = 0;
 	int err;
 
 	if (!fc->no_interrupt) {
-		/* Any signal may interrupt this */
-		err = wait_event_interruptible(req->waitq,
-					test_bit(FR_FINISHED, &req->flags));
-		if (!err)
-			return;
+		while (true) {
+			/* Any signal may interrupt this */
+			err = wait_event_interruptible_timeout(
+				req->waitq, test_bit(FR_FINISHED, &req->flags),
+				READ_ONCE(hang_complain_secs) * HZ);
+			if (err > 0)
+				goto out;
+			if (err == -ERESTARTSYS)
+				break;
+			if (hang_check_time++ == 0) {
+				pr_debug("fuse conn %u req %llu (opcode %u) may hang.\n",
+					fc->dev, req->in.h.unique, req->args->opcode);
+			}
+		}
 
 		set_bit(FR_INTERRUPTED, &req->flags);
 		/* matches barrier in fuse_dev_do_read() */
@@ -568,21 +581,38 @@ static void request_wait_answer(struct fuse_req *req)
 		err = wait_event_killable(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
 		if (!err)
-			return;
+			goto out;
 
 		if (test_bit(FR_URING, &req->flags))
 			removed = fuse_uring_remove_pending_req(req);
 		else
 			removed = fuse_remove_pending_req(req, &fiq->lock);
 		if (removed)
-			return;
+			goto out;
 	}
 
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
 	 */
-	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
+	while (true) {
+		err = wait_event_timeout(req->waitq, test_bit(FR_FINISHED, &req->flags),
+				 READ_ONCE(hang_complain_secs) * HZ);
+		if (err > 0)
+			goto out;
+		if (err == -ERESTARTSYS)
+			break;
+		if (hang_check_time++ == 0) {
+			pr_debug("fuse conn %u req %llu (opcode %u) may hang.\n",
+				fc->dev, req->in.h.unique, req->args->opcode);
+		}
+	}
+out:
+	if (hang_check_time) {
+		pr_debug("fuse conn %u req %llu (opcode %u) recovery after %lu seconds\n",
+			fc->dev, req->in.h.unique, req->args->opcode,
+			hang_check_time * READ_ONCE(hang_complain_secs));
+	}
 }
 
 static void __fuse_request_send(struct fuse_req *req)
-- 
2.39.5


