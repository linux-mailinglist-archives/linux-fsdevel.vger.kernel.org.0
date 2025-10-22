Return-Path: <linux-fsdevel+bounces-65109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116EBFCA50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B626E7C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7E336EC9;
	Wed, 22 Oct 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb1wa7yX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3E21FF30
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143482; cv=none; b=LyeZBPhuVt71H90rEL9U42N6lI1IkeT2R44tlZBINbiLTy+jPsySlELBKMYpuDb013Wm+av0M1PEGHDvhpaMTvvljzc0tvp3CBsPS3IRT1DAdII31GTyUuFTIQncundOD/sbd5xQ34dClkTzRT9cCYofGv6Pd77Yw0y+sdc5yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143482; c=relaxed/simple;
	bh=/+f7zm4UZMwLgha92op7H8NhlwZHgmSQD6lJFi5OKDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvbcHjXK73zHa1FI4u/MxGPqe5RmR9m2TMtkv2jFOabUR65peO9fMNauhGdvy5ebQfIiLKQ3HjJF6cIKYFovNGDB/bLU5o/2CBMOaQLnER46DVna081XM2OKoE2pcAmAc1oG/DYQxJKf6YIKslb8edXBLND6V2k72bCbwuqU4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb1wa7yX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so136253266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143479; x=1761748279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9whuGnuPXQMiozYzw9EFrS5Wt/oxDlovKn0Z9cvxXbs=;
        b=Lb1wa7yXYqQy3HEqTo+MZgqtNLQ2pzmPaMP3a+fGoQUi31p3eJa3dNPAoAuklT4G6z
         DRr7e1sSLYp9tF7Ql6lVQWaZaeuLzed7CfQ41IQkZnA5dcM9Xn7bDes5fD6gZh9PPheY
         kp2Rs98YMkloUHpsnYVlMzL0v789Y7Y93WLCQpHvFjZ7JHpMWzUb/9SCpPIWiqXVBiH4
         SIkimkOdsma1ivUvnrKb/QBHHQBlwFMchIEHHAO9mBQbAvv77AWXEP+SAQPP+KDGHkNR
         QF+CdLVGusvG6jfhMGVfauXVuWErojfKKLjWtBvuhI7iD63G3zA1LlA7RCQ4v9SEFVAh
         W1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143479; x=1761748279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9whuGnuPXQMiozYzw9EFrS5Wt/oxDlovKn0Z9cvxXbs=;
        b=T/Pi2Lx/vbodSrVinHLmnbZyEOPcgtTnLy6IOtpFdUnSEzN4Py670dTgb8bEFEWLla
         hNJFwxp/a0fHHCYB8W///9QBqiqZooMRdQIomPW9OWPUPQenAll5PazWLjuRxxS6MNKb
         nHQAOWapyDt0FyW/LuHlo3pj8NWt7AWBC00WovLhi6Y4DRtAr0e61V4GSjKBNWslHN+X
         Ug9tcONQU7JueC11sGqOg4+PyHEm7Tqv8ST+aNycPYK60NszOo3DvUrzLXy728s9QBVk
         okFqrZGuBfAsE3Kl1k/eXwtoMDDczh2XvhriwLLixR0M6kdO04jLurSXcUr8llLJ7CET
         6frw==
X-Forwarded-Encrypted: i=1; AJvYcCXvOS0AoXDrsyl/M5ytffBAMa/Ff3EM0BeQdpg7zCLuKcNqgz2ftHRkN6s4OeCMqrCt+MAgdftYhKn3WBey@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSZRvQNvX6neJfepOdNtN9Sg3deeAo4kvqznd0RCEEsf2I9qJ
	76B4PTGGNeyQL6c7IcMCpY1Z5knQWQY3lrMrr1d1V5qAHHjmx6uK3wy1vW1YKQ==
X-Gm-Gg: ASbGncvpq6w6AnJOEig8+X3vhdW2eFZfS8gIIohJeQrW5tUULzcjmwonWsfIXfG4qiN
	T6LnCVUYZVzQJG5n9eKZhxkU3MgndEty0oULMyvOVKhMw9Cu3jh9JWOLpS1rBFer8zkdYFUFhiY
	zoQ5rniGMi+MJ6y8eVjix40yqEbg9KMUQ1VW9r/hJuEbTwRYXc43Y/Riqb6iBSQ2iyTVuwadKzM
	Kb2yj7ZPwPzysrZXrWPu4/ksMVDc8dvt4d83INmE0UDytY1Pe86My4FHDl4UKB7xA53qUr7H6gX
	MqpTmM5oW6d40i9ftjKXa6H5C9zdmtQ5hwwDYBBvma7UqsXyq3RauzyPX8KApF50P5pIxldrFP2
	kiUAns6EYdBIPh+vSaC886Uob/YNyskt55EPwYS80Sm/65ltDlCi73NHGmYLn4u6nyhFYHKCkf3
	YCF8mDPFtN/uttl4mQxiur3hZOCIaLkf7VwESuRYlJqE9nAEBdYAQ=
X-Google-Smtp-Source: AGHT+IE+pwnW9zL8ErkB/M6kEddbTgmQKrjc+IfZQ7Hw9IKmnFcTlv7KGon/bCAe+74TqmfI2oab/Q==
X-Received: by 2002:a17:907:845:b0:b2a:47c9:8ff5 with SMTP id a640c23a62f3a-b6d2c71f62amr514412866b.10.1761143479159;
        Wed, 22 Oct 2025 07:31:19 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1335188066b.74.2025.10.22.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:31:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: push list presence check into inode_io_list_del()
Date: Wed, 22 Oct 2025 16:31:11 +0200
Message-ID: <20251022143112.3303937-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with sb routines.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c | 3 +++
 fs/inode.c        | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f784d8b09b04..5dccbe5fb09d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
 
+	if (list_empty(&inode->i_io_list))
+		return;
+
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
diff --git a/fs/inode.c b/fs/inode.c
index 3153d725859c..274350095537 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -789,9 +789,7 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
-		inode_io_list_del(inode);
-
+	inode_io_list_del(inode);
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-- 
2.34.1


