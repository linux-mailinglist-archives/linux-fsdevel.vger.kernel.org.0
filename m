Return-Path: <linux-fsdevel+bounces-54515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7DB00453
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4B3BDDE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857E274667;
	Thu, 10 Jul 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naaB2AZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377422741CE;
	Thu, 10 Jul 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155399; cv=none; b=DM/h58HVN20hnpPpNEDuBBbXQ4obIPTSvmxrUHbo+9uYKiwhRd16dearEe2KW9Ot/IbIJ4GIbEIyXTmAkdu+v8TEqFSkPp5hWaR3gXhGPppR1AsZt0jRCRC+vNHTtPgCwEH/qdiB2LcvYaILqmcZwMq4R/fBjSi81DC1L97bBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155399; c=relaxed/simple;
	bh=VKWXr/HK/VLupzoNAgWEupbPqx6BGTMv/i5Pf0LPT14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3Y01xEktUo2nOV+h7heouQ2JorvMk9I966kVPQu0NvM2CTU3hBHRyK5FWZ0+yeWsjpa1wRNbVSstdbBvSM2H1vNSjnvwdmLCfQUGRgsyJvGRZwlq6/arc2b0S/QLS+xlz3XIXtreR1fuPZdpo7E7PDqpOk9+d4YlcSCK7LnTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naaB2AZg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490acf57b9so774226b3a.2;
        Thu, 10 Jul 2025 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155397; x=1752760197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDCGW/oPEMco1SUfrd5EdB4UCbbB+eSqUhpPBIQfTvY=;
        b=naaB2AZgXeUuGpc/D0fx5jXt2k+4Q2gSNW02Jh1qHAEaUUjmNmjBz1HGTy4la85gXY
         9vQmE7CfoNH8RidjHMSackKFa0WWQg7tPrajV0f3vxl4jtYvoBhRCSUDrcqMgVejIcnD
         yRK3U7MYugFUyHjqPr//Ff8GUr9XMH/EiR9T2OYgSIiD+DUh91bIOa0wLS06SXGHfAIX
         YkZVX/RCgQWfjGSxiXLAgmASZNUUBDko1pWsDCooxIdvNffsoecld/zmOPPaG4YkhCe5
         bgPsEgk5tI/OHq92LYdGVw4qPegn2ML4cOvHKpPAvxcjDGvuE6CjHcfZ9O46jjMoIAy1
         DNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155397; x=1752760197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDCGW/oPEMco1SUfrd5EdB4UCbbB+eSqUhpPBIQfTvY=;
        b=E7+72bdvNUTYafREhhLfw6p+Dt9R8gjWYW2/6ZfHfXWDonPql9subg6ltNCIHx33Zx
         I1CONSCbIExjTQ4npV9F1WmoLqdpcrMd1IErm/16N3WY7zLtC75vEZS3Mma4A8nHPv6D
         I0S6MBfd8fUGO7RM7KjoF5DWuETsbiV8dzTIc+KhjO8dz5CM7pqx+3jZfXWsKthNBrmm
         vo/lZXlbTtQ+10AwXy9l2DDUloCTztz5KkTfFtthI2UcQYWO/hBoA1KO2g68XibWaUoW
         cNhXCr2LR8rCRp9MitZ/exwDDeTXVWN0K4EBV3DNy2PH82NDs7BOr9qc+BToccj3v9VQ
         5jng==
X-Forwarded-Encrypted: i=1; AJvYcCUOro1qeu5YcBOalhAcV/EchpbEAiwGAFr9dum7CkyjN1v1Oy1kFlnJn07TZ37MsfW77EdXV0GWRCbuoVk3@vger.kernel.org, AJvYcCXmQFJm2PMwuWWzzXRVU1/YNT+L6yho7q6U0CKai6af2jC8XMcBC6HCgq1feQ3s5Zls2IaA2rcvkU0nZtGe@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLZv7orPIhB3LW0WWdbipQHqz5SJ0rY0AzcsmJYp3H+M7DqSX
	Gplb4dd3rmDeIeQsobot+zIGI/2RSE6NZUQEcKv8Q7V4lkBXgwpCPKwU
X-Gm-Gg: ASbGncu4buqYOHdWyK63N3vrdKOBrMhickr5ZR7MYQK0Ub3CnGA0Qx4mC6O054jPuo2
	H0M7KNI7F+3nptIcwUTW8GrY3qI+BXeBYAEH60PSZMttguv5bPVmOMJa0vH2lb7Hs63m1SFO++n
	KZ3nGwjy1d4gMBKU31Zx5yasUXgMALBTvxOEtfhDuuoniKQFoSGK2Aby/etSzBF42L9UXGH+y6C
	IrlSpTKseoDscp0OaGG5m99VOCNKxu7Pl8M1T5l/rOtxTj7HSEwbvNNe3mCxW6n5BmQlapL7buT
	qfeKF86STGuXpNuQAiEjMQV+anv+gpB+CuqRA76M5ClwRwUOKECw1xSL/QcsgO/EM5lXKSnrgEH
	x8NcihQgXO+bqDS8OcOZstodQWslVWcPH0yswQCZaKeaUNiI=
X-Google-Smtp-Source: AGHT+IErBzTK6uEuVEefWD+I9F9uGlcuJ7jyJOI+VyLVPWZs6Cu4UCDztUc0eSbE3N8wldfMg3L4WA==
X-Received: by 2002:a05:6a00:22d2:b0:748:e5a0:aa77 with SMTP id d2e1a72fcca58-74eb558ed64mr5694376b3a.13.1752155397408;
        Thu, 10 Jul 2025 06:49:57 -0700 (PDT)
Received: from carrot.. (i223-218-151-160.s42.a014.ap.plala.or.jp. [223.218.151.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06537sm2292854b3a.43.2025.07.10.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:49:56 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: reject invalid file types when reading inodes
Date: Thu, 10 Jul 2025 22:49:08 +0900
Message-ID: <20250710134952.29862-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
References: <686d5a9f.050a0220.1ffab7.0015.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent inodes with invalid file types from tripping through the
vfs and causing malfunctions or assertion failures, add a missing
sanity check when reading an inode from a block device.  If the file
type is not valid, treat it as a filesystem error.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Cc: stable@vger.kernel.org
Fixes: 05fe58fdc10d ("nilfs2: inode operations")
---
Hi Andrew, please apply this as a bug fix.

This fixes a missing check in nilfs2 that could allow invalid file
types to be imported from corrupted filesystem images, as reported by
syzbot following a recently added VFS assertion.

Thanks,
Ryusuke Konishi

 fs/nilfs2/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6613b8fcceb0..5cf7328d5360 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -472,11 +472,18 @@ static int __nilfs_read_inode(struct super_block *sb,
 		inode->i_op = &nilfs_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &nilfs_aops;
-	} else {
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &nilfs_special_inode_operations;
 		init_special_inode(
 			inode, inode->i_mode,
 			huge_decode_dev(le64_to_cpu(raw_inode->i_device_code)));
+	} else {
+		nilfs_error(sb,
+			    "invalid file type bits in mode 0%o for inode %lu",
+			    inode->i_mode, ino);
+		err = -EIO;
+		goto failed_unmap;
 	}
 	nilfs_ifile_unmap_inode(raw_inode);
 	brelse(bh);
-- 
2.43.0


