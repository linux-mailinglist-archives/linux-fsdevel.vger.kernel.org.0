Return-Path: <linux-fsdevel+bounces-23652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF94930E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29DE1C21157
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A674A1836EF;
	Mon, 15 Jul 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkBnLTmO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9C13A252;
	Mon, 15 Jul 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721027623; cv=none; b=CxhWv4MVdSbz1aNrvKLTI1wRqiyjrL1GRS4Trkqg2Uoqa9e4cLZ52sSl0X0CdZZil0Rl5N/WzFNY67FSnVdOhM/5nnvJKrXFz76W3SRnXloOYCdn/5brvlbMi8LPOVNS1u8JFLqV+A75SG9s7PTqjdld6fDjxMTrLl0yvmAerdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721027623; c=relaxed/simple;
	bh=ThT2zjKQ34nQcBrdLJSCBb9UnMNd0LBUSmafeqnmS9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVqRnvE/9g93cf4oVv9gM4KQYub7aLqfGBC6wL/dXEAcCPFVQwAcvOgq6v0O+oEmtjf/V0lRTjGIaYtIyTGa/RTqW/7mHMgM0r21+D2JRf8vF74hALSWPdwCtIChjyNpqoA9qP5B6rM8iNZJKtUSnfmeBg31w+10Y6FNVC59WTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkBnLTmO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so618489266b.0;
        Mon, 15 Jul 2024 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721027620; x=1721632420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujN/ieyyUkcuW3zn2vZ+suXdWN83dY2OeESw1J6dHcs=;
        b=LkBnLTmOcbrDpjgSsSy2IG0b6S/7SwuUjGLjqPXBiKkyfgAvVU+feIipmE2D/VImVU
         5KeEWH+R4Pobt5F+7mhS3NCI2OwTt3NfjGxEQLdhcCdrGNJC/ZUxVKZHjnScvz12gtfq
         pqExg43GKLOsLnLZMDKavG0cqwC9NWYu/iCdFt/ZT3oDi8EpUJ+HkQrI4OD6UOVS0GzX
         89rRH5WPIh+uK7JnRosl0MNT2vvW3LI3prLoIvM42EnYniKIjTwpzC9djzgvz2w2DK+F
         s+nwExQi29PSE7/3XZ39SLOLEwSXl7MAn+vu6SgpzHAC5amq814t1cmBDroMmcwIFjMM
         k5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721027620; x=1721632420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujN/ieyyUkcuW3zn2vZ+suXdWN83dY2OeESw1J6dHcs=;
        b=iJW2YQ55VW3NsNuRSXrhQPufUbb5lqDj7+YTxRkpX8TcuGu/qheQ3FQtGjhiQE0xiy
         gkvIrE1aClVFZn6e+V1o8Bc7EnF5PUsdIwUGtucX+2pgFIlEqDCYfQExCU8atZ+sQHYH
         U9XHuHUMh48BuvmYntIjPfRci1AjV/mlclZmwdFysZIQu2Yh8ekZOv3Q2TkA6TT6gluM
         Pozkmgkztkvhp3ABSqiGUNxhkl8/7s5ex0kmSqjzfZBNn+FnjsWbDwaTZu9kWFEPHJVG
         7/vAxzOUyMVSvViiLwfXYU99VuCYQmOZRL8ft5hXAi6l7FAOiusI+sbO2m+36LIUOxpb
         RawA==
X-Forwarded-Encrypted: i=1; AJvYcCV4tF5ZKspT2lVWqm1CXUGklQxX01Um2M+FILAZ3Q1Fs/P8WgYRQFGXEPWwf/1fcC2RrnESmeNnWJJFwt5uAcsmvAVNtNNYYDRsy14viJZruhNz1X22nI2Ka4e3VBXnN1ZgoifXk9bOZJbTdw==
X-Gm-Message-State: AOJu0YxpShLx+pgKvkzStDU5NqkJeh2lO9EYeM1ysc6EQkhSntV0D6NU
	MyK2OZHEOv1zReMTJpcWB/qnssFo6Q/p6c+0V3VVP/eB3NcM3eX+N8MkHkTB
X-Google-Smtp-Source: AGHT+IFOqJPXaLqwWQTKgteZzt+DSzfAYB6rEEYbtvGcTRxXW4i67p3HNmocgeijIzh2kryzCBFveA==
X-Received: by 2002:a17:907:3f08:b0:a6f:e699:a9f8 with SMTP id a640c23a62f3a-a799cc6ab1amr857770366b.18.1721027619641;
        Mon, 15 Jul 2024 00:13:39 -0700 (PDT)
Received: from f.. (cst-prg-84-191.cust.vodafone.cz. [46.135.84.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7eeasm187135466b.71.2024.07.15.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:13:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bharata@amd.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: use RCU in ilookup
Date: Mon, 15 Jul 2024 09:13:24 +0200
Message-ID: <20240715071324.265879-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A soft lockup in ilookup was reported when stress-testing a 512-way
system [1] (see [2] for full context) and it was verified that not
taking the lock shifts issues back to mm.

[1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595bcc@amd.com/
[2] https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

fwiw the originally sent patch to the reporter performs a lockless
lookup first and falls back to the locked variant, but that was me
playing overfly safe.

I would add tested-by but patches are not the same in the end.

This is the only spot which can get this fixup, everything else taking
the lock is also using custom callbacks, so filesystems invoking such
code will need to get patched up on case-by-case basis (but
realistically they probably already can do RCU-only operation).

 fs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f356fe2ec2b6..52ca063c552c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1525,9 +1525,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino, true);
-	spin_unlock(&inode_hash_lock);
+	inode = find_inode_fast(sb, head, ino, false);
 
 	if (inode) {
 		if (IS_ERR(inode))
-- 
2.43.0


