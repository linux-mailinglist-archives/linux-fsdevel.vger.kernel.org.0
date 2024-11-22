Return-Path: <linux-fsdevel+bounces-35611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D59D65C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344D8B23C96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00518FC7C;
	Fri, 22 Nov 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCge5YV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E415ADA6;
	Fri, 22 Nov 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314112; cv=none; b=s5t9dV9NQpa8Q8ldzUu6G3HJF1RZ8DOt+3xWIStDVx0yjMVwZcmaRMFFcO4Je7SloP3kxJ/k8fcd9fa/CbBl2N30fGD1hlZ1i3A1Pv3NcN/FMNaMvLd7TWO5izA7s1wyRRnCo2H61oQS5QuqgSjTaWuYb6e/g1SAneD6vtE7QiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314112; c=relaxed/simple;
	bh=AmU7BXi+0SmutD6o3l+LZwSGNXDVBCUbymN/Qpg3vUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaZhd0xhXWv2Ag2qrD9RrrgHjXFI9fKp53qSq4vT/uH4kIWOx6Hmgs940Uej8rR9On3K+RKSAPGPAo2s8VDfdM4ET8lQ0ZN1YuvlCBsetQigvpqdrBJnDVpZkCvLWudTy3d6h/vgQXZaZMjdjXAMiUUfPzYgPuOkR//bBf/MjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCge5YV+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720c286bcd6so2437951b3a.3;
        Fri, 22 Nov 2024 14:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732314110; x=1732918910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7D8SmnjpLOc6rG5pxS/zjl1MQOjwvj/EMRIhBLhBUU=;
        b=VCge5YV+W69s0ThDUX9TnJjwIhxlP+xRAQ7p5dYY/DJThic/88G/95CqRb7aTNLhLw
         LMBo2EV8HtQEEv4X+3UkQ+SXIPVL+fk5V9trzfIROXpGh85qDngXWBowGo5jYVYY6kZZ
         vFYr8d0LUt1EVyFuborkz75h6ma5H04pYVJGCsaHjPjJSkTqAAiM3Xsa5EI2soicuS7W
         1UeXOkds+vKqjLI2WI3k8KzpAshJF8Ixe8cwaRDF6FU0JTMkMPF9h5/+Yt85dEqoYLGZ
         Ktanhn8ScGU0inFuMG6Fwhh7cq/sqn+3QsDBm8pR8g8lHRGhkcHPpDQ98J898Vmd+8vA
         Hxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732314110; x=1732918910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7D8SmnjpLOc6rG5pxS/zjl1MQOjwvj/EMRIhBLhBUU=;
        b=Ev7YOivLK10fA6tn1IhB5KHSShcS9FitOfjvPM7ZM7Q7Ds5sM7TSP8lxrWlhE598/R
         e9hvKFPVQDPmD+j/JXPMgZ82YZEKDyZbenVFNy6+oca9u0ZQRMEq365eyvQ5HLa+Stb0
         kBUdQpvj88KrhYTYh04WvoaQUJlgUjXHigBzJTlUy4+i8b2ih2A7imTD8DV3C24woFJg
         +quBFmaEeOqZpG8TkCOQh/UiGwErwPJkk+KiHjBi/SOyYU4zyAE1hDNuJSfv+tpD8Y85
         2PiAFGYLHk1TCe2vYfF6Maa2RW0zzkDUONUS2A2letnDH13VB+StIxEzAI2tSTKqsoLy
         fJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPuRXYOLR+0JX3tHLXaaxn678D5Pey40LvXlg+VfTO3KySeYX3y0aPwuasSKxX6NNNaJIOu2RdXrMBh59i@vger.kernel.org, AJvYcCXv4yetQOzVT/9UjlgS/EbPTxpBF1Z0btSAUvhUCJCx5UzY6+dbE5v64pCeSJPzacsEkS13e6AVPo+JaEJ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7waEGVqtzKN/D2WkViCXKuaU6TuNJQSRyypdtT0N8A4q7OrgB
	bv0ud2XHUrv7nj3RWagTlSsBXIRBVi7e6chtdoZ2h/dhq/hb1afz
X-Gm-Gg: ASbGncv/58aZyfP2DK9+yQ+pjMRcPcowyib56Gwqx6Xvu4y8uS2uz/PQA6C1C+Sl7Ac
	hYx9fI5UVoorK2IQQ1iSiNDMGu9wwmNarfuamL4pFpJIasAZsVG6zjQEDdJVovVZ+OvtwhCtLb+
	aBfOwBqPfNQqWTMYg5Eu+Kb8gpiaE3Fk9/+1KRJVOSn3tWZwsZkmtFfvanZFH5QRrJ2WL1iNWk4
	amJ/JTyMqOdwJs4K3XGuVgaDgigIqnShsVR95WKyrahFdcJnES2Y6CbT5dIikmG
X-Google-Smtp-Source: AGHT+IF3VxqCrOk1icSTavzZJpVF1aJ/XGFSzqV+znQJt6ShnaHICJ4ETD3ildu0AdAZLj+ETO9pmA==
X-Received: by 2002:a17:902:d2c5:b0:212:4751:ad7e with SMTP id d9443c01a7336-2129f7315dfmr51533365ad.8.1732314110100;
        Fri, 22 Nov 2024 14:21:50 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:c052:af63:423a:20f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc13239sm21219725ad.177.2024.11.22.14.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:21:49 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com,
	brauner@kernel.org,
	quic_jjohnson@quicinc.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	sandeen@redhat.com
Cc: Leo Stone <leocstone@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_read_inode
Date: Fri, 22 Nov 2024 14:19:50 -0800
Message-ID: <20241122221953.18329-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67400d16.050a0220.363a1b.0132.GAE@google.com>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the call to hfs_bnode_read on line 356 of fs/hfs/super.c, the
struct hfs_cat_rec, which is supposed to be for the root dir, has
type HFS_CDR_FIL. Only the first 70 bytes of that struct are then
initialized, because the entrylength passed into hfs_bnode_read is
70, corresponding to the size of struct hfs_cat_dir. This causes
uninitialized values to be used later on when the hfs_cat_rec
union is treated as a hfs_cat_file.

Add a check to make sure the retrieved record has the correct type
for the root directory (HFS_CDR_DIR).

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/hfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 3bee9b5dba5e..02d78992eefd 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -354,6 +354,8 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
-- 
2.43.0


