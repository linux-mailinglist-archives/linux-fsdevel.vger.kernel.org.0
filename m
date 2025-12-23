Return-Path: <linux-fsdevel+bounces-71910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF78CD7848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ED133052E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C61DF736;
	Tue, 23 Dec 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RblAxF72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912D1F63D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450222; cv=none; b=MylTLhTV82G91XxvGqf7CdFjW0wyPa5S4lpRCgOB3wO9n253BfSLCWlWUjOMFqJejTc2q9ulQFdxhrzbzW3LH9ZkcM74IDVB6MwX2n5LfrlXOIWv2GRDQO7LQ76p7v/cFJdOZtTIFtxTe4b2UvgnUcvTeUAVPSSnyrqwS4s9ZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450222; c=relaxed/simple;
	bh=UvxGykMLagJodFF82NAYTU28hUSWK6gDUTcLTRmQJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9gveg23PihCYMI6cO0TpNN3Xi9h/aTvCfXapCRguLozcyNm/HuvYtu6U4rWh6OqczjyZMrUz+gVR9rzRHsaaD3F7ztgY0EhmRVlfGTPrY9Jm06qFFssaWdUPQzk2J+LAZvHflwVWPzFT7RyM40jOJnbOiYobQxZx6PEQsV/nJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RblAxF72; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0eaf55d58so32618245ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450219; x=1767055019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMsOqo9v937yP4fh4eba7UqfVJcPSIWogxrx4HYNtHk=;
        b=RblAxF72s/5y9FTxhHh5AtQDsZo4kRRQzWpDV/9Q+INC5GmKwhIDXF2yWgYqexbmBg
         VfDFMc/teI+O8dObTSfismhGcJ1k4tmlKuS9suBFWVkfi78mcQ4gPNEAisCgU7+v0vya
         efA3VscDiNqodCNViuXxlgx+jujWuqypq83cBEoSCD5B/EBQYR4PoeV3U/Hc4Wf0493S
         M45UaNlsIj+1uHFXa3w/Ow04zhULuS3iN1oA+ngoTT2YxGw1atewXiXu9Y5ziYffLwl1
         tQmTlCoLZaDG6EdfpEem7GwvisXB0E1GEQPLnxVsrKmMIldXK5xEa3bcUozwmzWjGo9S
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450219; x=1767055019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMsOqo9v937yP4fh4eba7UqfVJcPSIWogxrx4HYNtHk=;
        b=drDfAlZ66U02jmUVFjza7kawrxpOWX+na3DbTDgFd4tMBXlOlsxtssBkncSGWmKvzL
         xwKP7kc5eSYMS2/DHaKS/I+uiEyG45X9HzsOf2kf02hnOy/dHu2+gagumnddY3FeCBI0
         CBOJVbKDZzdpQS/7NUoKpNXRKj5zy5j6Z3Bx1hrcDf6/JL4nOtOnm1u2sAutqoigrD7Y
         2Xwmpt3XR1PA/uofsWLIjZ67IUQDwehA+n7OhIR4cP8wWXNVhPj6orlFU63aVn36wMi7
         gxnTIVFsRLheUzlFDkDkfqF/tUIf68LEPP6rFuksJ13G23HrpyNrUkwoZbs4+XPureoE
         U24w==
X-Forwarded-Encrypted: i=1; AJvYcCV7A7T3sZvTSS2a2F7GtiGYTIVkTNbT/N4X/QJTMBT1mKzJtHie1U3SaMmJiI6OCmpzoGIQjjfKy7j2wiCl@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXZlYm0i1TrUTYxmkiug8aTGla/U+RL6r23pWAa2uCj+nYCFN
	RySHcbwljbySr+em6L1Ht9DbREH91nNsWD7bmbXKObCjTkW855It4qrs
X-Gm-Gg: AY/fxX60/o6uVkS9O7dQBSEu8AAv3iYM+bO84bzBvSZjjih7T+qQmlQMys2RoCw62xY
	T6Yt8SOFaUIIo0rGPfWwnEp11xnPXjyD6r0+rWYPand8/LYl6WDTYRLVpxG0BdThUSooVjR7v8o
	mIb99wiNy6RBAAC7ejmEvCheg9TBIamyAKYxLt2uaCaw1qADjWdzUxZhcoN24MrJ5PlbysG632+
	ZK4GuAiurhns4p/xDqSpIRThQ5G+5zI/6J+V9jjaaym93o6CISry32lorkwDdvVNFxM8TjhcxpI
	a7B3HFNhgZ+WrjyM0PHlD2JChC42wPgPkNkviw6eruvIsNyvqAtPhENEVxRsceZC9aY6qpQijzG
	epzg+usYbkcR0Se3kezmqzph1hELsoD9/WmeXbnOAHiq2hbSG0Nzn8KF2bfBjGQSojdrohcS+aJ
	boNSZTz3MmVHlybRyKBQ==
X-Google-Smtp-Source: AGHT+IGS9kDV+zjcE7owjWevYZAaixuXB9xb7aXsVaiLybjoH20QmzQIGgkD14xrPgseN2OB0doXdw==
X-Received: by 2002:a17:902:e845:b0:2a0:7f8b:c0cb with SMTP id d9443c01a7336-2a2f0caa42amr147167365ad.4.1766450219528;
        Mon, 22 Dec 2025 16:36:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82858sm107593345ad.29.2025.12.22.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 22/25] io_uring/rsrc: Allow buffer release callback to be optional
Date: Mon, 22 Dec 2025 16:35:19 -0800
Message-ID: <20251223003522.3055912-23-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory patch for supporting kernel-populated buffers in
fuse io-uring, which does not need a release callback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5fe2695dafb6..5a708cecba4a 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -148,7 +148,8 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 
 	if (imu->acct_pages)
 		io_unaccount_mem(ctx->user, ctx->mm_account, imu->acct_pages);
-	imu->release(imu->priv);
+	if (imu->release)
+		imu->release(imu->priv);
 	io_free_imu(ctx, imu);
 }
 
-- 
2.47.3


