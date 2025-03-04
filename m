Return-Path: <linux-fsdevel+bounces-43154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12442A4ECD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FB18C51A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7B277001;
	Tue,  4 Mar 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alX1RNYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F725F979;
	Tue,  4 Mar 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113325; cv=none; b=iPeoMKxHupqxjlkvWSGUtVw8XdFhpSFwqA60sR7uW5MJVpU85PH00z469p27ZPJ1wdZ4h+b3+IhSnQAR9EIx3Eionp416rbINk2wtfhIKCNCIeFtmCQjzlkA+RWY7cDN/qxbLbpgZJrdnZOcCZcYZvaOP/Yo2LG31gL6ZJyR7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113325; c=relaxed/simple;
	bh=IZKkII3GsTbBpXvb55aEojomBZ87Acjg3RlbkVqzuKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIBaoKL+kODCfFTeTmyItQ4ki/Z+nJLb2uy5taiZ774sUsZwYrvYKFCWag87/8+osF54h2xJXe4GfavD9RqAJjYOEGMC7u09QRK0vBT+58ai2M/wTXpJsCqxZ3WgTsTr136wAudieRKL9u8P9s3lge0nPw9DiubOyk+EHJGJ10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alX1RNYG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so10521921a12.0;
        Tue, 04 Mar 2025 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113321; x=1741718121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG+p+/aCZFjlwhK8PkbgiMPAkrT2FwPNvQL1x2aok6M=;
        b=alX1RNYG4xM31Dch1EXIsFF6wX5Z/i0Qr+EkStQjDLtqq2M38DwdPDJlZnsN//swsj
         feIyOzF/uKtYCDFJh315ajeB9C25FPOyJjXX9rn+uD9xL3cRwrD5FiQUuzVS2K3/6hRm
         JwAs08jAywdSKLmE7cjXqoGHob0XvQGNTYdTHZNqaAfqV5wcxGm6PIt+BoYHZShGk4dt
         82kgSb9pTpLfTRrjvwweIQcbPOrq9BfTMgdWcPWsL/9DyWB2xfHZKXwiLGWiqSbT9Wyc
         pf6oO0AfhEB0Y6gGfuAFof8f0tziof50m+656o5rs+68VILzJVzVz3hZMJuqb0dKmO3I
         hxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113321; x=1741718121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG+p+/aCZFjlwhK8PkbgiMPAkrT2FwPNvQL1x2aok6M=;
        b=nGxRF5UwuMPm7mLsi0T7dw/+cgZLHGz42ux+HGxsIYOB/6ALCqeuwImr703Os0ybsJ
         T2sE9maXvbRsXvQ0GCvinj4/MXKTWgo9nhvXOPr8+QFoVuRqZe80YMXxGEFoShRvbI/x
         9fXb/NXnX72i7sCA31LkfqpbFqtiq/ganVZFWKvvw397BsQ5xBooMfmUKldKVIgb1z5u
         I91cBb3SSJ41mMtarAe3O6/TAcVaFioO45XitXl4n+kmK52FFxVFYCrjBnjlArM+zU5e
         QSIst8/LMUcagtWGezzinPJ0lvuWIrpBySos/gCM524tOPUORdfuAfyPjdpCVll3TZVD
         FCWw==
X-Forwarded-Encrypted: i=1; AJvYcCUbN89aJrnrR3Cw1lM9Wkc+0n8sgqpDMZ7OpLEDOTuDP9frct9QW/OMzRmsfyabD/k1T6oxpAFxDKkm9qIx@vger.kernel.org, AJvYcCXrwl/vRuEyg+QrbLsvZ4dGnpcxG+m/yc+Htd5Hk1LzGYUhBqlwQy75ffvbCwbssFxZb1+vLnfQOq/YzkWh@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+vDgz9BpXjnjSStQV1Uffzt/yqfmfdjHX7hHEfEEYO/cpNCN
	Bjx6s/g3/k4+E6l9LGdr632iPIQjRAQXNnAV3L0wYIm+E5NG4d+lamuJFDAE
X-Gm-Gg: ASbGnctbeybxVSUgmZx2nQl8y8bWg8VXjN51tIJLGy5mJf3lnZtQ+3VJYA5p1j5wdG0
	90QjDx0pFswteeBkI0ea1cA0/2BOPqvnunbS9rnPY9mBHizO+qDxpAawFjbwjRKpLXrgKPAY9Vz
	tOHX+hKG7sll20GNxu2rpybfgOWXQFP5m1u/qoBbdzKHb+gbZzgQMPo+9khf2Ho2csYHASzfO7I
	BVtf4J5ynDtyV78FUHtiQ1A74Te6TfVXWHInEUVN9C3zfknyFy8oDlJOwCWM3oT2JHOdSlpV6Sn
	ohrkJhJl9xoBhNNJjkGgNka1wCaZq6MEIAWzj0tuetjpHt5lR3Yiy8vtjNwo
X-Google-Smtp-Source: AGHT+IGUIWSwHVfcDcQvsbiCwWGuUvD/8uXd+Bh3JnzxRg9cW1ilahu5HftYqLnVLbxT1yE6vABlVg==
X-Received: by 2002:a05:6402:2811:b0:5e5:35d1:87d with SMTP id 4fb4d7f45d1cf-5e59f4cc3a0mr83969a12.20.1741113321208;
        Tue, 04 Mar 2025 10:35:21 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm8691328a12.42.2025.03.04.10.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:35:20 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/4] fs: use fput_close_sync() in close()
Date: Tue,  4 Mar 2025 19:35:04 +0100
Message-ID: <20250304183506.498724-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>
References: <20250304183506.498724-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bumps open+close rate by 1% on Sapphire Rapids by eliding one
atomic.

It would be higher if it was not for several other slowdowns of the same
nature.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 57e088c01ea4..fc1c6118eb30 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1615,7 +1615,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	 * We're returning to user space. Don't bother
 	 * with any delayed fput() cases.
 	 */
-	__fput_sync(file);
+	fput_close_sync(file);
 
 	if (likely(retval == 0))
 		return 0;
-- 
2.43.0


