Return-Path: <linux-fsdevel+bounces-32036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD0099FA1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 23:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6024D2846A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FC201029;
	Tue, 15 Oct 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkhLr5d6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57C2003DD;
	Tue, 15 Oct 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027988; cv=none; b=REhCToGfK0Nmf/qHt3gQZ35Qyq5jacKaUrxrJY57ZvnnZr1vvWctqczzxKK1X2Tn7PT6oWS/usfg4MkmT8faTlcwtmRajfFynqkYi8k1QqMUhsbGKrWk5ae2jGsHZ8qyLTd+rA22GPRZFe1Qy6ZtGENRbgIbzUqHRrFDcjDpMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027988; c=relaxed/simple;
	bh=NezhgycQLAQIQcDYDKSY4BGfzzueVAmkJQhNThtdlI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1N9O4HJNGkYCqs5P7NskzYkyg0nlrMZcs5xBB1Z01FALEf2LbBc2+rXUwiwjxWfh6BdFqqjjk0kd4hPyIm5Pzln8nJ6boF5e/v6Vl03txbzqoWRr2LbpmMzvZwGk9DJ37l9L5jZ/HyB3OhMPx+pO/WiG6uhPm1TXLW/xK2JGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkhLr5d6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so22833755ad.1;
        Tue, 15 Oct 2024 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729027986; x=1729632786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVAm6BNE00O0scacTdQbYjMo5XjngWN20FrkxdPAapA=;
        b=jkhLr5d6Yn6QdRuxz4Avz9RxO3djh6Whjzo2QfeKvQVCgoqM41H3zwJ3kBVJWBhxVX
         ZQP3izBblUpw6wsJ/3LaNANv+8gfyEjjeAz80u+zjPs6BUtOj5Q0QXYJRxhhQ1IDDSS8
         okyAMJ+eFoaWNPZCyBrR6zxd+UeAneLSILRoi/uZapLfO0IDoSmfavRScKupaij1Awyu
         XZ3yEOPFYKjMfSAoYASrI9V5MyO6O5kJjI1GeEKN12ac+qvCK/fsZaMeNh1hlKwusdsA
         paZX9db/6+b4U8Jc3FYqcLE2Ty51ozniUT27RXpXH0kvJpjilLLfgAWyhYpGNWYONngg
         UXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729027986; x=1729632786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVAm6BNE00O0scacTdQbYjMo5XjngWN20FrkxdPAapA=;
        b=sNKuDNx4cuQjtn5RD0J5VpTpmNvxL8CZyzrgeXhkpbhxQfbjy5RVm7+e8ih9Sc5CRP
         P43CGHg2a2q3fZ77Wn+cpgBOSWdvhgonW2I3rFgYnIsNsoI44xHHkNmyYxMfpT9u3Ju0
         K4WTrIXPBNKwx1+ub4cYn9auFTIRx1CuSw97ROFr9yqbIkVl3gvlNRHn14VPtycND6sL
         sqGM3ZEq03U9SVwLHocFe4pANcUgYGFPDg9pqWrn7lw6awYVIQiVXs5km9czjuKj25qR
         yPvkPD+e9XtNW6HqYkkp23E0TVAU+YoZVB+3jtma5DrNcmhnFbgEK0l+S/U9YYRwX+PK
         143g==
X-Forwarded-Encrypted: i=1; AJvYcCV3E6jO6skntLHNuGlAU4rDgFN23vqMf69TIRIF7hY9vHvS4Le7qDhdqTFEJmhAJnixelbMVIx8HepjPv4l@vger.kernel.org, AJvYcCXX5ejJgAkkmUvE+1hXdoY1ywC3Hrpr5coE0NIntkb6hRbUVRyJ44yEujoSoDDV6FP/QDr3X6pbUl4spMYY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuqu+WMILzDzJdgC4d4hwI48v8G8IMF36w8yNshBNrJzfHxd8m
	VD3Ar6YujOCZ9F48sRq3yWfb8/no7My57PHBd9bW4vRiWM9skMud1+ZFWg==
X-Google-Smtp-Source: AGHT+IE2k8JjtGFY8J21CW8gY4rJ5C8TPoXMzrZQWce/UKEpuNUCsECgkTSwDiCAZKj8SJZ4ejN+sQ==
X-Received: by 2002:a17:903:2344:b0:20b:6e74:b712 with SMTP id d9443c01a7336-20ca16cadd7mr212783355ad.45.1729027985903;
        Tue, 15 Oct 2024 14:33:05 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805cc09sm16768935ad.275.2024.10.15.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:33:05 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix kernel bug due to missing clearing of buffer delay flag
Date: Wed, 16 Oct 2024 06:32:07 +0900
Message-ID: <20241015213300.7114-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
References: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported that after nilfs2 reads a corrupted file system image
and degrades to read-only, the BUG_ON check for the buffer delay flag
in submit_bh_wbc() may fail, causing a kernel bug.

This is because the buffer delay flag is not cleared when clearing the
buffer state flags to discard a page/folio or a buffer head. So, fix
this.

This became necessary when the use of nilfs2's own page clear routine
was expanded.  This state inconsistency does not occur if the buffer
is written normally by log writing.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=985ada84bf055a575c07
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Cc: stable@vger.kernel.org
---
Andrew, please apply this as a bug fix.

This fixes a kernel bug recently reported by Syzbot.

Thanks,
Ryusuke Konishi

 fs/nilfs2/page.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 9c0b7cddeaae..5436eb0424bd 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -77,7 +77,8 @@ void nilfs_forget_buffer(struct buffer_head *bh)
 	const unsigned long clear_bits =
 		(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 		 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+		 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+		 BIT(BH_Delay));
 
 	lock_buffer(bh);
 	set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -406,7 +407,8 @@ void nilfs_clear_folio_dirty(struct folio *folio)
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
-			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
+			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
+			 BIT(BH_Delay));
 
 		bh = head;
 		do {
-- 
2.43.0


