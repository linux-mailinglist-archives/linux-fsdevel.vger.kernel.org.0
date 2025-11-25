Return-Path: <linux-fsdevel+bounces-69827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56758C8685E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F17D03528DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733732D443;
	Tue, 25 Nov 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH1qniOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87D32BF42
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094517; cv=none; b=cDKNlZ+hYzitKL63rW9Q7MzfA7CJbVMQgRWbh2pJCZczmpFUoZZeI8Ckh7vR0+1pF/a8P2tW53rcDxPRYDY25IMncE/iJFzT07vQxTkA8LpIWdGReTuc9SkAwg+Ltuw4QpE06at5zOEwodE4Ycxh7V0cN3rWgBY4lBq3URTQjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094517; c=relaxed/simple;
	bh=Pf1ccGQ8k1fvDK2lsgupkd5IdGzj7ox/VESOZPM9Rfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoGV5MUQSsxWKnOJTpiRAaKResxc6Ast3DpZ+bKcEPhux+U5mBFJKymUbCljr8QiuiJ9Y82OfMJnFidwUwAyUBp90kqIygobYBnTcBXQq+HNSuwQMVglQ1zHkmk6iA4llwor6mp7XPPFN0sgMcdPTrJ9oau/WWC8v3wPrKZolJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH1qniOM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2957850c63bso721805ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764094516; x=1764699316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sso79OfNMvfv00Pm6bcCDda+fUEEoSaW6UDcGt5ve70=;
        b=UH1qniOMFqWSXjOCPS4Kj1aMQCcYPrxB0WcOXtq5A+nP0EBhPRsCAb4B6AQKV7Whov
         npLPGLVYPdkMY0C1//b5ioVT3MYM/UWPjgV6StEI53981EbLT1CfS+H1d5PsVvbcqoK8
         EcyQKkwcDKnoQwzduafrWd7yVENMwRkfYAI0NcVwN0rXwIlwcQvN2aSSJe8Ng3/BhsfT
         B6bFX7n9WObJFeUUukO2GnWtSWjmCvwvApVwwodQRmQvitdHlCSIFU/lI5UBOc9Z+ae3
         ZlFI8NM5X91kRzvP7WZCZybNuavMa3CxLv5iMsaZ5expCX5GM5nFDYkkn64wLC94RT9G
         RgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094516; x=1764699316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sso79OfNMvfv00Pm6bcCDda+fUEEoSaW6UDcGt5ve70=;
        b=CJjJX+JxS13TYjfYnDLm0OcnhFH9Iw3CCvSLbe9s9BI9uMG+7OcPyA5gW3aXYTvdqh
         IPVnD3DvC+V9C4khMHG80hyPwXmvAnHyR4wTmA0S01CSj7j+6brPGG4wHElS4Blx43oU
         UYZaDEaR4Y+14ksTKED3Y9kjQUGzWMMNXtzIwW6s4AyY45iXk5TmO2l4bT4yW64g4Uo5
         koBogrbuOujv6ojM6bxbOsM7/2U3RT5HXD3o4l9hRn4znaKKqPZ5FXVdguDdCf27F0iA
         mbPxeafxLWYBfwHmBnFMKEDBayWxkjGR7UXhJ6SBLzEwgnY3azemriYJergQRWa5ieps
         pKhg==
X-Forwarded-Encrypted: i=1; AJvYcCXb+DQ+5rSjI9A9hUhjUua7WTOC8M5GU8MfdZykUuJS7S9cCaxP6I0t9sXiHuVy9EGnSsm9RYGkZ/1fY2JZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5QtPjiqPASnK+OkJjByq5SebqopaxPAJbLh7M39d7Yf3QKqq
	NQTy/xF7rtpCmpuQ9t4tNtt83/gm2tF0K5GWSg1kGf7SQzFgpOWNpCaz+jZm5w==
X-Gm-Gg: ASbGncsYiO/0scpSyo/+VRhdfW9jyR7yry+ieKG4MjHwTnSplj3+Ezjq3O5EWyQwdh2
	OMnkOXSyr1RngXEUl2PPu5sX6wt4E8NrECsAdrNO/wCR2uMil0CQDEnWTAmThGzx6T45YTSaAAF
	ev/O4sATlxQQ7i4N99zgeiYshw5FACh96wXPhWeAkLPdhqdQBjJeE3nOeTADDXW/comB916Gqni
	sK2I8jEM0Ng2lIiQfXrmVcOy4sX1GH0RJezGHowGmbVX3aPwTvIBxaQuwKPpAN3UF4AW1YTcdKP
	NH+idLdcyL3co8dyJ4jQTszBvYUaYBWQWp5kGjKQe8EDHCHVYBras/UBH4r0nLnaUGyaRVgNMOV
	uIC2C2xUkO9XXbiLN7gN2JGmVwyF7QC3xaRD/sUbOKZF4zWt6V1z7LxlG/3idoFLUUccgU7ttdB
	bWDEA=
X-Google-Smtp-Source: AGHT+IHhwnSH+EhbzLqopvG289UORJlZF0L/iuRleVeBYeQo/a5WAwb4633Or+wV1k8pHUs2duWVkg==
X-Received: by 2002:a17:902:d4cc:b0:24b:270e:56d4 with SMTP id d9443c01a7336-29b6beede43mr168710035ad.4.1764094515607;
        Tue, 25 Nov 2025 10:15:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b787406f8sm114918475ad.52.2025.11.25.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:15:14 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fix io-uring list corruption for terminated non-committed requests
Date: Tue, 25 Nov 2025 10:13:47 -0800
Message-ID: <20251125181347.667883-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a request is terminated before it has been committed, the request
is not removed from the queue's list. This leaves a dangling list entry
that leads to list corruption and use-after-free issues.

Remove the request from the queue's list for terminated non-committed
requests.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
---
 fs/fuse/dev_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 0066c9c0a5d5..7760fe4e1f9e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -86,6 +86,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
 	ent->fuse_req = NULL;
+	list_del_init(&req->list);
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
-- 
2.47.3


