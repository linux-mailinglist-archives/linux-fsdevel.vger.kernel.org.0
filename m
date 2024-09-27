Return-Path: <linux-fsdevel+bounces-30278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3247988B6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B581C210B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348F1C32E1;
	Fri, 27 Sep 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EhXCAxLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572E1C32E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469951; cv=none; b=nrc6S684ooCjawj7Q8ZoprbSu+PS1ry4jS529V3CkWF2iwQfFisgVXhPdqk2ifMUx1F0/J35VuAGtbtNv82A4uR7IVi2h6z3tGtF/25rtCUiZ6x9IhwIjy87/izfJ2/bdK1zTDHf7MLCGMALuWdXRmoNMGqCqSS7gFQGeymmL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469951; c=relaxed/simple;
	bh=QjhWXX99YcYZggtkS3ASVI5vIztmbk1Bj4ji8EO1PCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCekxXal3UEEcowLIxqCACVxTE2q7JRBQXj9foHtUKB78NHeGAbz0D9MGFoo5rwG3YTfesKgBk3A2pd27+kwqdVcuJjZjhhawYubzvzbyJSSHUUrircZLN5D3852IXCxpAmnz7dgOgiR1VfvpzTDlzWpafivYlNWpFAu1nEQ6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EhXCAxLy; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so2527234276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469949; x=1728074749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5zjhaIoS4x1gFV18KSzw13Nd3fOQvJvqPRXABTSAZU=;
        b=EhXCAxLyfS4AMbUQp7pPGFvjLUB1t4/E6ozNg6lKz3k3oveJgm/goBZd1nCBpYjX31
         jU+Y5ARhX8iHJbDDBxdXthUWeft/fbGxcc7BzHRVK4dPX9B0WLP/XZPIlx8A/M52bTl+
         lynuNaJpN/bzlv3m89H6eR0/SEp1m845Fs+xedUfzRB2EMuea8UYx6psSFVE6MI+BFNA
         OXFnO2I6hbhm6elp1qOnuDwjsSkZ7/xf72RPy13O7giZZV54FHwZPZNzlfWxWzQsDPCM
         OGwfwFr8wSodb+J9Nea48o4mOoZWuzizTVH6hpfkkj5rOKif5dJKNaff7lWB9zKrN+Ts
         ocUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469949; x=1728074749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5zjhaIoS4x1gFV18KSzw13Nd3fOQvJvqPRXABTSAZU=;
        b=EIKpbixTsqOjzPIWqFRnPIxtkemhMFuvjmAjVk7TyDqT1O60ytL5NgMjCp8Nm+iQ9e
         8FBXBrjzLdJ3PEGjm6XVXycrOzY3Z7NdE6h9K19mp3bMFnfxNCv6Mb7gTJJ4dzhIGFqC
         AqbjC9sZsndyF7AcyZgRR2NKe07ymgRBnKGffjnnhfE6DYnYQmBn/sGg+/Rm84Mmv7fy
         h5D4/KlMw73XH2bV/vOyfuvKE+IOpiHB5pMkTQKDg1C0+gF+r1QB3+MmU1xP6FYqRFs4
         QIAKNEeXqb7SpraHutOzx6f+OWbxGwtrmxGPig6t8zxC6Oaj2t0ZBpxgpQ0m6Hn9N3hV
         x5xQ==
X-Gm-Message-State: AOJu0Yz9AH/E6Xc6GNKTWARaix4Qj+Wr4E9k9TANQN34G+SsbZokGW6g
	t4i/Me5Rkgi1RwdSAsN9sClemKyzYGCGU0nq57qI8ArzLYYYgKSjLjm/O9Q58ShsHSmPrEdI4Z6
	n
X-Google-Smtp-Source: AGHT+IEUl2rAqLTJowUGpAubeo27o6bs8QghQOREFbkHBdeg4V2jCRcHhazP+c9CU5L5XAhtHJ71XQ==
X-Received: by 2002:a05:6902:1ac4:b0:e22:5ede:3f29 with SMTP id 3f1490d57ef6-e2604b157a3mr3934087276.2.1727469948799;
        Fri, 27 Sep 2024 13:45:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e260f96cb5csm12273276.2.2024.09.27.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 05/10] fuse: use kiocb_modified in buffered write path
Date: Fri, 27 Sep 2024 16:44:56 -0400
Message-ID: <e33fd426ffd0448c69020f372df4e200846f1115.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This combines the file_remove_privs() and file_update_time() call into
one call.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c8a5fa579615..2af9ec67a8e7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1455,11 +1455,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	task_io_account_write(count);
 
-	err = file_remove_privs(file);
-	if (err)
-		goto out;
-
-	err = file_update_time(file);
+	err = kiocb_modified(iocb);
 	if (err)
 		goto out;
 
-- 
2.43.0


