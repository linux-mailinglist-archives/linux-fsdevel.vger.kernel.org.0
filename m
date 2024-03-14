Return-Path: <linux-fsdevel+bounces-14389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4D87BB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185602821CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9DC57314;
	Thu, 14 Mar 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AS1IFd1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88557330
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412458; cv=none; b=Daoj5xohQI40p87u1C5TZrUiPIonPS82CDYc20Fch7MY5OLeE3YSK7wzpg8B6xR/BEKgdQnLkaR0Vw+UO+PzNTMUUydsr+JwSGJ9MpPoBitRXTyDgWJGx5OMbSv7ddk1kCs7PSQtj6BOYaWZI0HbhLA1oH+YmD+nnSzpvrNLfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412458; c=relaxed/simple;
	bh=zno2KBRudPT5YcPnE7ddaFOMuOfX1ebtFyrTqzSClRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSySaBaQaIhVHJdFqGqMw+gXoNCQdH7WwBkMqzHSUAb5vTFa6HFHqFaC5ewSy4dMy46dMfm1D0qbn+4Fy2lqRgSlvqb5UAzKk3kInUhar6Ht5WRxLQM+qBmaSogkGvpg3JWMaEcvUcW1tK5JutC2JIssnpl5rcIZhAsHilU3Vgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AS1IFd1j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so644698a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710412456; x=1711017256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoVtz+CArwbPjVRIWHaFXW/cXc6DUa8ml9YC0f3yU/0=;
        b=AS1IFd1jAe8Jljc3/HGaJIcT+jNIV20zEQMv8aFIgAk1C9PT4Kl9w+a6Gxrnn0HDQO
         57DlNw+CVcpBorp/QiNtxaPxNnabXVSf9A2XHTfXPeJApvbo5+VIJ+fWBU7EIXZZDBpp
         efaPj3fBJsYi2mcOQfMeIe3jAfAJOn55h63m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412456; x=1711017256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoVtz+CArwbPjVRIWHaFXW/cXc6DUa8ml9YC0f3yU/0=;
        b=uLzltPculDy1RYXSCH5EoqoQwkLvyUdbMt7O2UMiCn8lF44YrxeASpSWTG0Y4cqedI
         giXsV2+9fHqZC6efnY8gxz8rTbModv72VBMTd8LrqBNVh1xEpAzMPkcgt3LZ+SrS+1Un
         YwoplKP5WMviW0ZYf3sxjBOKkT3+GUY8rP7abE4avtSRMeJ1gjIpJXvdw042Nx2TDwTI
         gxJbBrxVgy33r0EvUA8S7Bv1i/yjw9vga4/h/y8E+sKBW+xiwSsrKqbvPHRngeraHgxu
         6h9lwHTYhAvIC2ZalU2mgAe9IEU4NEpJE2LarLP7s2X+BptqMG5thva4jZ8QLddlwlz+
         tIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFa5+3HywcOSV2HPzpqBznPQ3YsXavHcs7CLCDBfeyP5H10e265UAuNJxG4ixwF4yFRFxJA+BjTLYBkxwyG0YTp4ZYqCN7diQHluEtA==
X-Gm-Message-State: AOJu0YzXMjBczkv5katyKdjcuL1NC2Xx3QD4poqXZ4kcUJg+y/L110tV
	NKnYwl9jy7/PEaW8vMmKDqD/fV/uet/2blMJUPikOBR12GOmTssYSgmFkdvlwQ==
X-Google-Smtp-Source: AGHT+IGx/BcpN+TV5OsPDJCj+4d4MoQ2v0i0VycGs/EBNE2Kx6L+09wK+NnCx3RHopl3bZUjXqL9Hw==
X-Received: by 2002:a17:90a:d14a:b0:29b:efcb:7e83 with SMTP id t10-20020a17090ad14a00b0029befcb7e83mr1258089pjw.3.1710412456299;
        Thu, 14 Mar 2024 03:34:16 -0700 (PDT)
Received: from keiichiw1.c.googlers.com.com (60.66.87.34.bc.googleusercontent.com. [34.87.66.60])
        by smtp.gmail.com with ESMTPSA id fz15-20020a17090b024f00b0029ddac03effsm555424pjb.11.2024.03.14.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:34:15 -0700 (PDT)
From: Keiichi Watanabe <keiichiw@chromium.org>
To: bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	miklos@szeredi.hu,
	dsingh@ddn.com,
	hbirthelmer@ddn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	yuanyaogoog@chromium.org,
	Keiichi Watanabe <keiichiw@chromium.org>
Subject: [PATCH] fuse: Do NULL check instead of IS_ERR in atomic_open
Date: Thu, 14 Mar 2024 19:34:04 +0900
Message-ID: <20240314103404.2457718-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20231023183035.11035-3-bschubert@ddn.com>
References: <20231023183035.11035-3-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since d_splice_alias returns NULL on error, we need to do NUL check
instead of IS_ERR.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 fs/fuse/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4ae89f428243..4843a749dd91 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -914,7 +914,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		alias = d_exact_alias(entry, inode);
 		if (!alias) {
 			alias = d_splice_alias(inode, entry);
-			if (IS_ERR(alias)) {
+			if (!alias) {
 				/*
 				 * Close the file in user space, but do not unlink it,
 				 * if it was created - with network file systems other
@@ -928,8 +928,7 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			}
 		}
 
-		if (alias)
-			entry = alias;
+		entry = alias; // alias must not be NULL here.
 	}
 
 	fuse_change_entry_timeout(entry, &outentry);
-- 
2.44.0.291.gc1ea87d7ee-goog


