Return-Path: <linux-fsdevel+bounces-31472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476A99762E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC8B1F23844
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F91E1C35;
	Wed,  9 Oct 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="EYTWaAxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111C1E1A0A
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504406; cv=none; b=QkCIguW6V4Fh2wmysdb+8t+wrknjTHlt96U8+j78zMGF1n7nW12o0buNd4sAmoqhWEoGpQYra/odrJV2l2Ezr78KEXZzcBNKFQ8W9PONnSBbZwOKjNU1cXaaXUbyab3m67Xa0iF8oDndz/s2SgtI2J+V/9NoStP4a48n8Kwwgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504406; c=relaxed/simple;
	bh=XFi+RqFT5+j80M42gY/7c4z0iCnHBg0JREA8YPoKvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7i/u7VuZr4MZ6eaNTkPJj5ouqzz8sCFcMgiEoIYEfkUAYnAa8VHemYaylUW9EVsUeuF3mKnEBDxEXv7TOVOtRRKy41SGbGh956byKfVUYrdFKM1z2sM4PFlp4Uh8tOPvEaWbC8TN3H1yLJCfaXmkyEvLfrz+CP1JEJVMjV3o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=EYTWaAxy reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b8be13cb1so1441495ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728504404; x=1729109204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DjaCaDp/okFCfeMJXA4A2P6cPB6rstyymwpNX601YQ=;
        b=EYTWaAxywweOjp68+2I3kKlc5k/cuqvjfy47mM67UoFFSX0EZwpzJaWL8wrgKGUOL0
         uicGDCSfUreH3vs/K2shfDjcmmyiilOc48uELby5BBb9Eomv90tJk2h/Q4CyJeI3B7Un
         Oxx6pvQAKL8SkevRx7HwvKtvJs/i9WmBW4V7QJkkTJmX/WUELXX+K4dFMTr12AqpBaC/
         Ym9bcE/FCCVclTdjIVBcr1rtbMpAki0LxG4s17KRs1jmag6Jr2fAC8/iATxJ5hoFRdHl
         tJBZEqzqSgVgKUsoLYzytyqIUPFGVEa3d60tfrhsm5e0qukGWmZ1gqdC+gl1yPCpsE5l
         7W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728504404; x=1729109204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DjaCaDp/okFCfeMJXA4A2P6cPB6rstyymwpNX601YQ=;
        b=nxMf1yi1UGdU1YySlL7WxX4lIgh+8GeYdiEUxCBk+8S9wiFYHvu/BtFjDg74xiJ++D
         xZXIIhLUGh9GAJScZJB2CBY9UgE0RqDznRmfvw4BS3x7J+t9STuC/5BM8gJ8co1KPpLD
         GVcPlVpVWgIz+G5XPOS2W2M8qne/RkiN+L+2CZIP1J761d7e4inOTaPunmVEhz+cX4xI
         V18Gidnka7B2FgJiKP8nWrd9/0vLfKmPlL2IKoIgsV8IVFZgulsVNCfZO6FD3HNW14Ef
         YVHyzBkwJeAx3oOA+elXFWuZxD+UsP4Hkt+bnn8e2YbOlDY+R2OtAmqvglNbPDAIuFYM
         cJjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rHKj2qHmhl7bEvtRG7ataucLsZDsTrOuRmZrcWEEH/H0gR6Q80epbsAnOy9B8hP8/0w64WXqNcwEjjmy@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvoGDse83SfLPoFgO9QbP7rjqiSVrmeRU8T7FYDElbiMnsaCK
	KWs2XSNFv95jHX6apJ41GCr1blKoZJxP7SGhrK78LQyCd4E5m5PT+NZRKkDGTsA=
X-Google-Smtp-Source: AGHT+IGw72IuCgKZTon0L4NG/cp8LBY5FD+t/9q3IAT29KYNY7TgAB5WSdK+rvKnlxikbob5YYdwdQ==
X-Received: by 2002:a17:902:f650:b0:20b:7a31:4522 with SMTP id d9443c01a7336-20c637f781dmr54819615ad.42.1728504404159;
        Wed, 09 Oct 2024 13:06:44 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.158])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c7e8a05aesm3504825ad.54.2024.10.09.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:06:43 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: Fix uninitialized scalar variable now
Date: Wed,  9 Oct 2024 14:05:25 -0600
Message-ID: <20241009200528.36343-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable `now` is declared without initialization. The variable
could be accessed inside the if-else statements following the
variable declaration, before it has been initialized.

This patch initializes the variable to
`inode_set_ctime_current(inode)` by default.

This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 fs/attr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index c614b954bda5..77523af2e62d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
 static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
-	struct timespec64 now;
+	struct timespec64 now = inode_set_ctime_current(inode);
 
 	if (ia_valid & ATTR_CTIME) {
 		/*
@@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 		 */
 		if (ia_valid & ATTR_DELEG)
 			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			now = inode_set_ctime_current(inode);
 	} else {
 		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
 		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
-- 
2.43.0


