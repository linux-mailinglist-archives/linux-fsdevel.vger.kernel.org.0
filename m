Return-Path: <linux-fsdevel+bounces-13357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5E86EF41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD321C2196A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A371C6AB;
	Sat,  2 Mar 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfRWpGeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A720B3E;
	Sat,  2 Mar 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365375; cv=none; b=hV9Lc78n3k9v2Y4emQBsX35WX7Ud1vQTotmGnLJb1IEjGnytAiv0LZJ4Ddu3ZCgVELG895iEhtVlcVIV/c0dvMfxjI3BYm7Fjgyq/DCYFAMLzXsKPlNPixp0LZlDb3TXVrVc9cgKPuWHqU8Bg/2/p6Xbnx/oXb6F3CLoLq4njxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365375; c=relaxed/simple;
	bh=7K2GXZNUZuFdWwcE5Vtj/VA1EW5ZzCGgdr576kCe59M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9TDrapuThtMHgtX2eFVBlmyRFawWdxlc9l+AbcASJRsfuNECkKNEJ1AIHAf9U/5ODygJAyOoWhSStcTds09lBWmDog9qtHpiPepOMRuHp1OBQQqU1yV5OJyoocpydmgaFrpCMA1hxqxiI3ulgx0RAXhvn8iHFjU5HnLBuLZS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfRWpGeP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4b34f2455so1642234a34.2;
        Fri, 01 Mar 2024 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365371; x=1709970171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kzeTSfiJu806WMN/KPCzhuK/hpOJTvJcAEBv+CARb0=;
        b=HfRWpGePrGLULOH+SA/8rs6MD9/PfkwTDQvZ9oh2woxlUGTtPA0PGDzvOUw8S9Bvod
         BpltlcEyKJ2cuoLiVRuqdEJOLuYI+Vv8Vl44fwNfr2bNW66Sjc4lnknDEJjZcYNoHf+Q
         M1T3ZcpVaSiWetHZF0e+wJPcI1cEYE/P9dWzXNO9pDCPnGPicocO7wAzznz7c4rpTNFw
         6yZDCyHWRnf5CZOX0O7miXb22LD36uxIAIJwWwdKYQAxlxccBwUnnSCA4/CJkBB6ZhpN
         qzahsrOP22KbnfhdxNcVIVuzIA4NcvGLuDwG77Xjy1e4uZx7ohzwBsGnO53vXHNHqIrV
         YUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365371; x=1709970171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kzeTSfiJu806WMN/KPCzhuK/hpOJTvJcAEBv+CARb0=;
        b=lirIAJq37hum70VvuZRoxvtwkHjQqmldIfCmu6jcnxYybM+/GhBQfjIc3Gd1afrb8u
         hjXbstInYJl7VRZICp0ALD32EtC28kvw/pmr8sbc2tP7n7aehYeQ+Fr8IrLVjSLqhz0Q
         pcQKRYmliFTEWfWOLa6b+kdaDBl9dBqZeYfAbMA0YnAZmYZY22cizAjqkRKOTGXtg0WM
         m69SlRFrvgbbACw2onAYqCWneR4TJWc8OKce6OrtYBRq+A+GmkRm02PWIZAloxUQOctE
         V6wXxTZUp+EQI5A3yzpdte2VKW4B9vFqdbXIzMJ7Fj5YFUC63bk7JzKoc+Z29t28QCEF
         Vshg==
X-Forwarded-Encrypted: i=1; AJvYcCXkdyDHjQwC0n7MSgoqU0SUTh8djSULSBIJluWFJZZ/ThBQJMMRbpdSaJEtgLDB4UfInfVmYoaUgffPSe9cFFIVQNEot3R1LTWY9LJfqD52Ej2MnUZ8DmNMuc/uez2JnXoYqNrkC5w66g==
X-Gm-Message-State: AOJu0YwseWLUZE/ekw/YMplvcLH9edJkypYbQYbd9CwKIA8OcxJI94Hc
	dap/+zZbQcCfpwEnNs2g4y21GQ9nbZoBwxy4y4iZYG1Zt4MP6EfxzGZ5pz2h
X-Google-Smtp-Source: AGHT+IFva53f1HkSaVQ0Lv9O37kGnDFML6TGMRrRTSvsFAOCt1IzeQpMsbaFTgagj3y3o+g4gfwMMQ==
X-Received: by 2002:a05:6808:ec9:b0:3c0:4b11:dc54 with SMTP id q9-20020a0568080ec900b003c04b11dc54mr4052409oiv.35.1709365371659;
        Fri, 01 Mar 2024 23:42:51 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:51 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 7/8] ext4: Enable FMODE_CAN_ATOMIC_WRITE in open for direct-io
Date: Sat,  2 Mar 2024 13:12:04 +0530
Message-ID: <703c48213ec033af5fd270c5338921db9898774c.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For inodes which has EXT4_INODE_ATOMIC_WRITE flag set, enable
FMODE_CAN_ATOMIC_WRITE mode in ext4 file open method for file opened
with O_DIRECT.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8e309a9a0bd6..800fd79e2738 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -913,6 +913,10 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 			return ret;
 	}
 
+	if (ext4_test_inode_flag(inode, EXT4_INODE_ATOMIC_WRITE) &&
+			(filp->f_flags & O_DIRECT))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC |
 			FMODE_DIO_PARALLEL_WRITE;
 	return dquot_file_open(inode, filp);
-- 
2.43.0


