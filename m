Return-Path: <linux-fsdevel+bounces-45038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D01A70847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5953A8F87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9526139D;
	Tue, 25 Mar 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKdqZZFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFA19E971;
	Tue, 25 Mar 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924031; cv=none; b=Fvw3/70BVdvQIxZY9+fCPFWLliLZisk88EBDP/z6ZILZZ3tqWGLT/yCIG4I71xj6AwMddsQQyL90/N/KjEkzWkIdl6ETOaA2A5IdyEhskq8wloVikAQwgiwyvg0Meh7w2cx4XBqskFuI71dhbKVrUxvz0ZdZCvlQiBtZ2jElins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924031; c=relaxed/simple;
	bh=n56wZD3unKZRmTLCGR1Z8EkvtdF67dNLHsB3HHb7BlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+FAdW6dOhbDMM4pe5oASXYT2FcrgfmokhkG4AjOjx5WlnGtGSXrLCGgqkorzXkYmfbGllehLsLW7uxgcYtovyQfF0rWDZLchgQdURUoOpTOZyDaAWth2uHf3SMAw4IMI5FkCc6SrhpPtQj4JR+PYaWRhUyUB/WcbpiAAgo8npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKdqZZFC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22580c9ee0aso122031365ad.2;
        Tue, 25 Mar 2025 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742924029; x=1743528829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbCxACC2BfEEkXadwikRQtJ2Dlwty6pyPKDjr9xljYQ=;
        b=FKdqZZFCKlMjxsZlWWQmzJNxS7b2j2ItfDW2xIx13I5/LBj2mANSLBFAO+ccWvHaqH
         ApCUTD0cwQXqxcWsa1QEH27W/0x5mEkvR2dfDtWWgSPO1Cuic/+XexT/ozZ0J6WwOWD5
         JfG21Kb8lySBWzLgs6MyT98dbhaZkmhA4+nXF25/vQnYcZGHXkcvZNdExXVBNC43zfaz
         E42xwVbsHTaAgcUikTxKwGycPEqKmiZpgR2g+jtDGfg2T2v6FfW0nZq9vB4DNqhzh/7k
         UiRoeqo0ZzC159KFXSEB2OVAg5KBnynwzwgcyA7Dj2Eim56jqV0Kevovkfl1CYOpFU7C
         ry0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924029; x=1743528829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbCxACC2BfEEkXadwikRQtJ2Dlwty6pyPKDjr9xljYQ=;
        b=aZMIXjvjJqbwCYxO4rz62fxqIMyyZYxgUdI15ye4EZz8xy7Wyrvx2kW/q7qy7rU0nI
         JWkhll+UZeZHeuhpsv9EHOTsp+KzbQgFeVx7DPIg8hkw7Nyf6NkReVaUgIIh6kFSr6JO
         yNrdykzrCRIaumYoR8KwdohUqt2i+TUGlDKCzb5lxC+ybqMh6Hk/kXhp34spVWIrKt3l
         u3xbWAI7D89UVS4YA8inGFR8jFDiGzwFmk+BWob2YXqrcIT1dHwlFtKoV9kszdFB9Mf7
         HwGUjkj/Fz/bzgJjAbApzz5QVq7xQaT6wRDDhllX4BVxq4NciEsdF5/eTuTADIfYQVpP
         eSmg==
X-Forwarded-Encrypted: i=1; AJvYcCU1d9X3phkPPxSqSu2k9Dd4UnvIjN4JQqKzPqRyOEuiZvRozk0005f3WVvFuFTSVnZwztsh68CZrqNd7g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUwDvO0XhvyPkO5Y71PIjvnhojbrvy93vi38j1QKI3WzO55/P
	RCTUzQ3+JQmA0kmyID8yGzzgMkQXLNzJXgloedNUAfHuzUWKLAi5fz1U+4s2xUs=
X-Gm-Gg: ASbGncunHfk0nOfV4xDenM/ipVAteO6it/bba4ifK0aNxvuU+gOV9sG/mUPU5L/xbKD
	LTSkkaKPgoeYjyK7H6qY6y/xCpFzI586gOQYKNtSIk14t4vfYbh36LkbaeAPHSZ7Ptf4hNjO0ul
	vi21EgV4Hg4HhTA8ualOl8WyoTogAQXKBqDUjpLvr0FiEemxfduYRDdrz6/iJojP49G1JCYICZS
	yT5EzM/zMkG9wlcoowv8i5a20haa1lB7gtDeVo6EzZ6ht8zeHMYbnPMK893HYoGU21QOtxGaEbZ
	KzuZU3qJ0arZiplKJTJ50jZAuYV+u4XtrlK3TBkt9OfkVkaqo7Gxyieve1mDztXFaAVP0cG9vPi
	09P4=
X-Google-Smtp-Source: AGHT+IFSyebz9/38Exw0xxL24gjDqBElaKgEmfLyzFRrzrVMg4oPusN/Ove23CRtuCRoW2t1q8laGA==
X-Received: by 2002:a17:903:18f:b0:227:e74a:a066 with SMTP id d9443c01a7336-227e74aa5b4mr32125235ad.28.1742924028980;
        Tue, 25 Mar 2025 10:33:48 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:119f:3ad6:66e:eb88:9ca5:b5e6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227e452ec4asm16723955ad.194.2025.03.25.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:33:48 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>,
	syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Subject: [PATCH] fs: Fix jfs_fsync() Sleeping in Invalid Context
Date: Tue, 25 Mar 2025 23:03:36 +0530
Message-Id: <20250325173336.8225-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug detected by Syzbot:
BUG: sleeping function called from invalid context in jfs_fsync

generic_write_sync() is called within dio_complete(), which can be
triggered by dio_bio_end_aio(), a bio completion handler running in
SoftIRQ context. Since fsync() can sleep, executing it in SoftIRQ
causes an invalid context bug.

Fix this by deferring generic_write_sync() when dio_complete() is
triggered from dio_bio_end_aio(). Modify the completion path to
ensure fsync() is not executed in an atomic context, maintaining
proper synchronization and preventing unexpected failures.

Reported-by: syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=219127d0a3bce650e1b6
Tested-by: syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Fixes: 5955102c9984 ("wrappers for ->i_mutex access")
Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250322142134.35325-1-purvayeshi550@gmail.com/
V2 - Fix invalid jfs_fsync() invocation by deferring generic_write_sync()
in dio_complete().

 fs/direct-io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae1..2ae832e7c57b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -356,13 +356,9 @@ static void dio_bio_end_aio(struct bio *bio)
 			defer_completion = dio->defer_completion ||
 					   (dio_op == REQ_OP_WRITE &&
 					    dio->inode->i_mapping->nrpages);
-		if (defer_completion) {
-			INIT_WORK(&dio->complete_work, dio_aio_complete_work);
-			queue_work(dio->inode->i_sb->s_dio_done_wq,
-				   &dio->complete_work);
-		} else {
-			dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
-		}
+
+		INIT_WORK(&dio->complete_work, dio_aio_complete_work);
+		queue_work(dio->inode->i_sb->s_dio_done_wq, &dio->complete_work);
 	}
 }
 
-- 
2.34.1


