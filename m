Return-Path: <linux-fsdevel+bounces-27444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFE9618B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0199284665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174001D364D;
	Tue, 27 Aug 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ABaq6hPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAC1D2795
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791586; cv=none; b=nKql5VDPe7kSrgDoM4Rd8mbUdxC+mphdwja5ZSNHGHtJyoOdGpd+mUS5uUUvHWM9bZu6wVS2+JOPfWI12pxGdYYuM5vMP52dCWSyFlmy+KbsAq9EqpfAJ+zVq9CDpFd5sLmNe26R1TOiOoSe7LxOyblIoYOIq2DrqgCh3kOJ9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791586; c=relaxed/simple;
	bh=8TyThD08zTc1r9IX1xYb2/J+wPW9gQTNMKoeurIRzXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEorvEMu3ukAFzXU8geN2vGjQq3aO6jTtZnh8pBFdwinhGTpvdQ8LbDlDIzHS1Uv9xIusZil7Gal/PX5P0Z3IjFkjFGIFpYdwARzyjUPF/p/67vIdKQaW+jxdVhWr3LG3fPfmDS8xvHTQIzCjJSnj+mAkPbJwa7zF41p3HqmLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ABaq6hPQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d436c95fso356718585a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791583; x=1725396383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAn6We4TZxLVLRIbIvzp2bUFCY2LSbhSBcMD+QTACdk=;
        b=ABaq6hPQcxeehNTPUixxmxb5FiAuTy88mnj2vn1nIoWiVhnpw9s++eq/yurJhUQdOP
         qqVYnaIFEqqGJtXhxqiz3lT6ztbS7Ctot9eeWQ6Iy4TywNvP7PMIYXzqWd+2qprL3re7
         3BVC3HjPOKNsaa6FafvizcAQ8/+ddGgALCvHuktzlAtJTYbfUruo6/EwFXLsn65+jueH
         AOW7HEn2E+e2npeTsnz880R0NYiPzixoMot3HQr4+EIO+5zGWDHDU5Fk5fg/lf5OqRA+
         AuJ3IeenGyNfiNEq0DuXBGQUOuEFd/dX5X3KVSRcTwRPPwJNJdqsvp6rlbaCH7oHeHHW
         ybTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791583; x=1725396383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAn6We4TZxLVLRIbIvzp2bUFCY2LSbhSBcMD+QTACdk=;
        b=tSQUxceOLykFeoo4QeKXaioaeWZD4Vf4a3cAWVfCOeW+CzmB/qV3WTu5KPBB4AwM12
         odhhDzaJA6LBNz1rSGcudHgilftZev3GfWqJjM+lWRt+EAeMcuhugZgYgNQDwgVlnvV0
         pElTj67RF3O6UtO9Gg00w6sZiZ66N/po12O1rAFCipM00l8IwWOtgDNv7UYnWIE7PGJq
         Py2H4xjQlUuS2+SA6OuwKdApAUFohSg3E9/mV8Fw17vlV6hek/6mEv9xz959jaYnaa1U
         APppcUM9DufWyL1W2YXjPhSG6M5SAgBbE+A4NbV+Ny5ZONnuMrgJE7m0/hXqRlB+EtK2
         ewnw==
X-Gm-Message-State: AOJu0Yzs5/ZPsep/iReEonp8oD5Gpg0M+JQ518uXLBcKlmFNdzcj364P
	5QP/Fgmgy2eOQOaCqqlQesjv5X4LtZRErqp0DFt57rjoESOWJ7d97holHzyqao/ozHb0qAUJViN
	x
X-Google-Smtp-Source: AGHT+IFI/Z32K//+PzrPY5mUFV45DWi33MLmi4NVBhNOyUCazHncC1fYPP1Ems8IkyKjXQaOQF9CLw==
X-Received: by 2002:a05:620a:4046:b0:79d:781d:3f5d with SMTP id af79cd13be357-7a6897ac809mr1941147385a.51.1724791583639;
        Tue, 27 Aug 2024 13:46:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3d5cd2sm583854685a.82.2024.08.27.13.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 05/11] fuse: use kiocb_modified in buffered write path
Date: Tue, 27 Aug 2024 16:45:18 -0400
Message-ID: <0cb400723ac0ccd1b496d9511fd2d6c5537e19d8.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
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
index 3cc1917fd1b9..b259d4db0ff1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1453,11 +1453,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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


