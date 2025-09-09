Return-Path: <linux-fsdevel+bounces-60620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B3B4A447
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731BB1897D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AA23D7EA;
	Tue,  9 Sep 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKsJ01Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A0236435;
	Tue,  9 Sep 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404515; cv=none; b=UkiVTfLo/ntv15F8vGAcKlzvrkcBkgXrl5k91zAnJqD/xlWbMo1tiEuTrIf6hfCwJCFD0VBApQmAwPSmtyF7ePQBz8s/1Glx9e4IpfnUjlez9KQEOth+EUpkjZ0aostdU2Nw+NyxtPpF6Yc8NQU13wDjFkNEt64a+jrxZNvwgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404515; c=relaxed/simple;
	bh=u31N1JXIm1J7Xs3YB5Cvd2NIBRAjKkIoOY64/6C1R4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQf6rbpFGkswWDXIfF6IqzIb/c+TS26d0Wn90as/Oqhi+Dsw+pIL7R8IZKtW2GD99Fp9f/C9B3DnRa4T1QxcIYNPfxdrxXQJjDRm9bpkZ6AtoCqayZypLPtUDMpnWDKN3A8SCHgvXU5YwPvSfizWYA4+4dCHF33VxNNuDKaaGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKsJ01Cf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so3214024f8f.0;
        Tue, 09 Sep 2025 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757404512; x=1758009312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNW8BXWdzPCuJC0DkrhXczBpwKlgqLqxI0mpk89iRf0=;
        b=PKsJ01CfeulCEvX4UVj16cJCEb79ayZfEn3cYQah08UNtVPQjY88Eq+mjsCoucae98
         Q474sU12gQIsbW+lWxPQioj/2WePiBw/od/VYNjfo5zTblL/o0qIOdyBIyqki4FFk8/W
         tU9suufgqlYJKu683zcs/tn3vldaNZYeOA70wc13EIuO3Js6QQESldO9GFPTp3qWk1Hy
         W84QuOFFhsrj+Oh6D0bWunTBkm/doAbBxhUUjfsPKWCc3DzwDZaTeDG/ma7+436dRUPb
         PSJD8JAiRzmT1vxw7zT00VC9TbnnThFDEgTMdEKcno/8jVFM/wxNzf1pFEuKiaxBsMog
         ft4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404512; x=1758009312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNW8BXWdzPCuJC0DkrhXczBpwKlgqLqxI0mpk89iRf0=;
        b=DMw8n5V/m3bbosbFVnQbPXTbmAR/Hloccl78v+nm2lqgu8y6kFj2V3AkhmiLgyte8i
         ptuBhZ6Wf7E/r1H4W15o+i+zlfh6+2X6zgNrtLfrv7KXi3BRe7g319ZLhD25Xo5uA+6n
         OKkUWpE57PklMXjd4SkFUtk3SiKz9Vhgo6z1L4QXcR5qc/ymaLKDPj7ruApNcY46HC0f
         2qRNG1tMZhKbhyOkdvxUktcR3oWrrQUADbicrxmoPlB8lfjaA810oIDSXxu2EXai3LUj
         IovOe4CnnwGmGaL8faEHvRXeD19dBWOxQJPPoWGxJnT+oquZgD6zOneqshjhwadSJr/K
         EIgw==
X-Forwarded-Encrypted: i=1; AJvYcCUyoVFAI8/2Cgr4WL42h1ITk8D/rU+PEkdA5LGjrJHf30raStALaeyBdKf0VB+ZX+UERY9KZjtIQZ5HVl1f@vger.kernel.org, AJvYcCXLE4GvbqwNFfhyGjnWMQR528R9/y9Yf9yy/quNhN6FVR/fPX+6ZiFHdLB8geIrhP8kUpnWxeiahuIDwpRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci934AOiTjqgNL6RwelcMqN74rBosI0aGiM291Rxn4JCmU/4U
	NWE++A/p2K7XBA4BmAJf3zoBhRi47dGax/G5NQmyS9gjYc3s+yfhjHQ+
X-Gm-Gg: ASbGnct+2R4HIaJUMp9+fmvOqpAufMDruKF49RZjOS5RXUtg54h2Fm4FDq4nbCnkmJ/
	210mPT8tHhFrYplAJgCm46K18QFExM/prdTxMbHQ3N8h4t5LIjnlXuVmc/V9oH8UtuXtnhdX8L2
	dEuyFJapPPgdJ3Zi8zAOQ2IczPEidzdL924/40eZYOcdVN1i1vy/JqMrjvNh17OueasDMKZlaEW
	x/T+MjjiM/Utj+L0MRPNYY7HVKsvV+HqjK78+U6aAPULkz6sHOqnsBXcw3p1HdJme+LGEaoHh46
	xYTAuPpZPwTr9TFUb5CcCOQPu1YD74nTocyfS6hHWlByiSYQMvCYpL6+BQLBXYXx5C2WsBA8bnX
	hzj61cYavmZ8tZAYvWh60NNk1bWa+vQtrsqwD/TPTeciKc0WI314=
X-Google-Smtp-Source: AGHT+IFdSKsn1nP46bIpwbnutCuI8EWKtbfzf1w6hJ/yzC+ab69QblWoVqAH7vFEboAjQEvZ5igHTg==
X-Received: by 2002:a05:6000:4023:b0:3d9:b028:e278 with SMTP id ffacd0b85a97d-3e64bfd62c9mr7508169f8f.51.1757404511623;
        Tue, 09 Sep 2025 00:55:11 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223e99csm1527413f8f.43.2025.09.09.00.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:55:11 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: use the switch statement in init_special_inode()
Date: Tue,  9 Sep 2025 09:54:58 +0200
Message-ID: <20250909075459.1291686-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to may_open().

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..8c520a22afba 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2519,21 +2519,28 @@ void __init inode_init(void)
 void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 {
 	inode->i_mode = mode;
-	if (S_ISCHR(mode)) {
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR:
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = rdev;
-	} else if (S_ISBLK(mode)) {
+		break;
+	case S_IFBLK:
 		if (IS_ENABLED(CONFIG_BLOCK))
 			inode->i_fop = &def_blk_fops;
 		inode->i_rdev = rdev;
-	} else if (S_ISFIFO(mode))
+		break;
+	case S_IFIFO:
 		inode->i_fop = &pipefifo_fops;
-	else if (S_ISSOCK(mode))
-		;	/* leave it no_open_fops */
-	else
+		break;
+	case S_IFSOCK:
+		/* leave it no_open_fops */
+		break;
+	default:
 		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o) for"
 				  " inode %s:%lu\n", mode, inode->i_sb->s_id,
 				  inode->i_ino);
+		break;
+	}
 }
 EXPORT_SYMBOL(init_special_inode);
 
-- 
2.43.0


