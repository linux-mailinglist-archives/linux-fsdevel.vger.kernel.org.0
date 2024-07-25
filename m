Return-Path: <linux-fsdevel+bounces-24264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440693C7DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 19:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10963B22255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD226286;
	Thu, 25 Jul 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZADBbqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AF3AC01
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930024; cv=none; b=udZzVaLWfXWfMyx3GgumScROCYwhvo0/N4uxROgTJ2It0Ffq5v5epPzYCudtuMq2aRPO9kbF9rivFY5SwNQZ+y9CvcnNGEgyabwzEMuA0s13vPTiMBrWAWQ8/BH4jqCNmzoCaKeFqkYXwckQi4Bh28IrQTRLHEwNb4SgpSHUQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930024; c=relaxed/simple;
	bh=HrIIsuJase9x0nJFddLeKlCF1tH1kUD6fTQrBPirF2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7dgj39JhLUwl9qe/jHvbQTY1kCnXgpctwdWMd2HOAt9C+x1GsTjSK+yctl/i42RLzVU3gwhGDTpVuzZDPc2AHAl8lJdwGQynqArB+UDp3e4VoOjNX79WgmnwZ5vyD4gaSkNXsTtEbNj06dzmsNkI5ZAPIQaDlRFTS+lvZDNXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZADBbqw; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-661d7e68e89so9580727b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721930022; x=1722534822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fW3Cnstyq+JyCGW69QJROpVqqnGfyy938FUdOQBpN8=;
        b=kZADBbqw9utM8+mA+4NXccDfqAGgdCmGvlJMZ9NmdH8F+iYXRUcBr22WyAID397oC7
         qnq2YXUC8m1w/vh2lXxU+hSrXClBuPz8HzLmmZIp1Jb9+p19EvUYGYoLIj2MNEvoNwzv
         FK2ZzTVMimDycuawCC7kUxms4mZt/j/4Zo8fpDoK8mCOPhRjaPMByUGentQdNZUda90S
         mmlq0GtrzZbb2Sjn9jvZjIbMvt2GXQ36ND2sI7ivYUPCEd/wt2b3423DfIYj4qCTAHl1
         i2y1+IWc8DTmaESbbZ6jws9pjLgd9nVMpCiEX97o2evxjCs/2dXbMHmgGjcYfh/Q/jlT
         vhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930022; x=1722534822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fW3Cnstyq+JyCGW69QJROpVqqnGfyy938FUdOQBpN8=;
        b=I4e+2AViuaMGDICXZLY6OsR437Cxdj3O1KkZ1T2MVarxWjT0RTIHd7frIkKJizdgMi
         x5mqm5kSXn5RFZfs6CcNxwV2lCmLXJE1GFZmetF2RNY9bPS+B8j0fXYUahXB5Mu5eDLK
         Wgpb12k1ufWqzOSvzMdXX3ML3dv82y0E+RsCGQyUCKteNIgMb9243ZyDkz0S3AIE+oaN
         lDMXVr18BoCg4afQLWTFzKhIDHYXu5mksD6eBCW2biGLHyzCwQ9vlivc4GqGX6A2Q4FS
         8ZMMn0V8K7Pss+7y5iPcWY5yBklnpf3zhwYC4ihXfxqfBZgC1SPzw4ZDmV69U1EWUrJ0
         5/BA==
X-Forwarded-Encrypted: i=1; AJvYcCVbSq4MGMPWpst8fvLQokIVmAcwv7V8+rMRPaKgD6atfSp5nbhkaJ4dY9w1dsoD9bbWYlA1jDmcfxzaRoza1a58GYI0sUeGu5NHDwrLJg==
X-Gm-Message-State: AOJu0Yz4DFDN9Kqg3bnN+3qpHvM8zg/LvBgIytYGBb31K7ECzxieSujp
	1VZGM8g29/eZfbgw2z91xUk9vtTpJi4Ik71nJf0BbsClHA0wELzc
X-Google-Smtp-Source: AGHT+IEZ4yrndXMBjlImqKMWQd2XhJDux+oM6mvV18htiy4vow8DXGb9xk0fkIjwLva5MDF7xZLUMg==
X-Received: by 2002:a0d:f507:0:b0:652:e900:550a with SMTP id 00721157ae682-674e5f4c708mr29569737b3.19.1721930022029;
        Thu, 25 Jul 2024 10:53:42 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8fd6sm4947167b3.7.2024.07.25.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:53:41 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: winters.zc@antgroup.com,
	josef@toxicpanda.com,
	bs_lists@aakef.fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH] fuse: check aborted connection before adding requests to pending list for resending
Date: Thu, 25 Jul 2024 10:53:34 -0700
Message-ID: <20240725175334.473546-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition where inflight requests will not be aborted if
they are in the middle of being re-sent when the connection is aborted.

If fuse_resend has already moved all the requests in the fpq->processing
lists to its private queue ("to_queue") and then the connection starts
and finishes aborting, these requests will be added to the pending queue
and remain on it indefinitely.

Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..a11461ef6022 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
 
 static struct kmem_cache *fuse_req_cachep;
 
+static void end_requests(struct list_head *head);
+
 static struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*
@@ -1820,6 +1822,13 @@ static void fuse_resend(struct fuse_conn *fc)
 	}
 
 	spin_lock(&fiq->lock);
+	if (!fiq->connected) {
+		spin_unlock(&fiq->lock);
+		list_for_each_entry(req, &to_queue, list)
+			clear_bit(FR_PENDING, &req->flags);
+		end_requests(&to_queue);
+		return;
+	}
 	/* iq and pq requests are both oldest to newest */
 	list_splice(&to_queue, &fiq->pending);
 	fiq->ops->wake_pending_and_unlock(fiq);
-- 
2.43.0


