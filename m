Return-Path: <linux-fsdevel+bounces-44879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C4A6DF8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDBF188A6C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34AF263C6B;
	Mon, 24 Mar 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAffRKsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333425E81C;
	Mon, 24 Mar 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833444; cv=none; b=VUXDv846c147f0xnyG8vFhnrROciqLuVpvVf8+vM5Nm+Ktoic38Ell30BEAEWY5gmYC+nvBzllDXW3I6147XQjPzhxtQIfya3cHFMl1qJW6kHJKYq1BNU0bywdi5ubkDHQT5ByHBQOERREMsNPEnX5tLR4uJVITgT49MJQ8cMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833444; c=relaxed/simple;
	bh=gG2U0rwHUfXmhboLhgXja8zI1PVcLv4TVPPi4iGB9bo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J4ktAXgSbaL6J2sqT+4gyk8UFgC+oDnlJmXeitRmMMtDcycrI2MROZOC79rJStEhMl60poknWI9QDCWV5B9Hpn2IrFXWRnFxb3Z4PDq6vS3UjN9T0zYl3RD/1ksJq1KA9QHrIOjH1EvXuQ/H/Eivf1zicew99CE22IzpV0+jOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAffRKsv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso9936935a91.1;
        Mon, 24 Mar 2025 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833442; x=1743438242; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kysj7IBo2X0ysdrAKwKae8EbeSBOtCN5Ht/coLd5RSE=;
        b=TAffRKsvaMXRHuvahCAN04z4pFfmiKoB8PLXzt3FPTVfb+exGb1a2d0wm1LLWwa2RR
         2OWQaZMgeCNphBvbCz4cvGZQ59jfUIq80WPNf5EWhbF+i9mZhvc60m26c4eQsb38YvN1
         3NETt5lqN/EYw7pt6F8agVSaAQFTlAmUG4xTEDCSmMytImA25kH0M2nykURgvlj2IVJw
         NQRbtnW/uNFynqDggGyCL4f+hQWB8sQmHre3WpIYO/itaI6iw8HO7SNls1t13/gHY0Eb
         d7TusmAmmTE8MflS1/hsR++nfYvaFtCFsWM7ZBP69iL2MigGPQlKM8BBHKSSkO4uaw2l
         Ho2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833442; x=1743438242;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kysj7IBo2X0ysdrAKwKae8EbeSBOtCN5Ht/coLd5RSE=;
        b=jLhfngXpBRqvk23/jgM0Bmz2cpXaAKnplcw6g3hEo+9ifxOXkKEBNgR885gfZlsHTG
         DlC50ePECsJQOX5oq33ujsR4lWdA5srI66eyLKb7fKwxMIP0Fxk6fU566djkGjSVcyP4
         Bkf86s9XD2vYGwz25kX/hVjQA3bDPKI2898JK4YfwzyvVlgLLYgIael2Sv0PNLX2E46X
         ff+7Y01096Nvn6veOmRBIPWuQJcUcx17x6RquSGINVcphJtQwOMYVP2QoXmYYQ/YjXOa
         qqhtSxnZyuv780+UbdA54CxvwoKgVqtbE7ob8Dqku3YlOCexgZ4aBCrKsq33rvoMdzis
         ycLw==
X-Forwarded-Encrypted: i=1; AJvYcCW8aayqmSOdLV4ZkAq845deV5+hPgfcr2ybKd/BlfPkmClA63IMVbq3pbtqjdrOn099Cuw8lXwbFmcbVHNJ@vger.kernel.org, AJvYcCWlYgPOXJYqfcH+HJ0ep7WT58UQACcPgdLs+5iIsHFodWt+huCaAugJrlJc99+CSxHr20qrjImeG3c3DHv/@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBHPDMP4xvGJfTRhjWSJ2i8ACfYWYm6bLin64V66JozrO9DeS
	IPaCPyEbx7QE7e5KaMJ9f/bsrVpRrvlnxARwQg9NJahRnoLVHHHi
X-Gm-Gg: ASbGncv1lzO6BBSuq3AhORCoseBOd7Hnr5avPbw3IBfazkHFjG//SFEj6ewdzK/9s2D
	iDipliqsaSTLY2Waiyz8tE/5yCfZ3BfDCPUQpDeYFdIjvMfCk79igeQDuCdgs0ZE6N5EH9ZhFvf
	uR31vq1Up8ioR8trEy1VWMDMeccxgONCjFocN6K/8Ttdf3mbfCPKDPTwItxlBfQVTjt7Od0y5Tl
	MaFvCwCMDxc3vPfNVCO3EGoX5R220WtaAAa9zsSYWCCVUXwuUavuqw7hX2392PzYiGwltQ4Eiza
	rlNh6+GJdEw6VdeGG0eIpVXfH/sII4PQT6Yrq+pS8LhLI7CDgCRx6X/O0SbnYjMNSThysw==
X-Google-Smtp-Source: AGHT+IEvNnBjw5De5SVjsZeYu7qUy5PqIxNAPMhbDeTvl0ikfBm1tdeg8dNDggku/btrG3cVZ+aOrQ==
X-Received: by 2002:a17:90b:38d0:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-301d42b3a2dmr26594206a91.5.1742833442081;
        Mon, 24 Mar 2025 09:24:02 -0700 (PDT)
Received: from ubuntu.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301b9e19ceesm12518210a91.0.2025.03.24.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:24:01 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Cc: tglx@linutronix.de,
	jlayton@kernel.org,
	viro@zeniv.linux.org.uk,
	felix.moessbauer@siemens.com,
	adrian.ratiu@collabora.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com,
	syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH] proc: Fix the issue of proc_mem_open returning NULL
Date: Mon, 24 Mar 2025 09:23:53 -0700
Message-Id: <20250324162353.72271-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The following functions call proc_mem_open but do not handle the case
where it returns NULL:

  __mem_open in fs/proc/base.c
  proc_maps_open in fs/proc/task_mmu.c
  smaps_rollup_open in fs/proc/task_mmu.c
  pagemap_open in fs/proc/task_mmu.c
  maps_open in fs/proc/task_nommu.c

The following reported bugs may be related to this issue:

  https://lore.kernel.org/all/000000000000f52642060d4e3750@google.com
  https://lore.kernel.org/all/0000000000001bc4a00612d9a7f4@google.com

Fix:

Modify proc_mem_open to return an error code in case of errors, instead
of returning NULL.

Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..b5e7317cf0dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -840,7 +840,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 	put_task_struct(task);
 
 	if (IS_ERR(mm))
-		return mm == ERR_PTR(-ESRCH) ? NULL : mm;
+		return mm;
 
 	/* ensure this mm_struct can't be freed */
 	mmgrab(mm);
-- 
2.17.1


