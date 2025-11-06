Return-Path: <linux-fsdevel+bounces-67360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36476C3D021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6964742323A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F38B354AFD;
	Thu,  6 Nov 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksfDpozy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073D350D4F
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452082; cv=none; b=F7HQdNrgmlaCTw+9sb+/lDmsO7/y+JMa05WSb/qmzc077wJdDIx7NGno5XzQI29ClET8ySsMWZuyyLXgAKmbhAbjvS+v2fg6kgTXpkT1m560WLBGn0aBrvUsM/jKlzbaeB27cxlx36fnb9bVDh15qAY7odHSQcCgRs/63DIKShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452082; c=relaxed/simple;
	bh=5LtjXMmzmSXGmRg7hUCR8hen8AGyJaa9v1b6R+l+ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5e1zuLyLa3SfollUGbWETBr8fmfDNcgmdTgYIc9y6gq4QMBkD+fNd9bTCGKgSuvQWm0A7ZFT73PlwIvkEFAgoUwf7PsVHi1bcSNRtkFB9Uiu62UOsexzusP9AcdrpmEtTUVEkfe65WDdPYtsMPWTJ2xjrp7uHsBusrOAG26YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksfDpozy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so1623873a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452078; x=1763056878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=ksfDpozy9aJfz/EUpiJfskYRq+dCuyo+MdyvKVLgQWYOKA3U/oP4V37TUcatiRcn0Y
         ozrykxYtA1iluwVsgqI2yDU4CiweuryNlQhk987UGvLDaVaqNt6iIHZU0dIL0t+ZYk2n
         9yWOyPgDDF8G20G/lRqwUOKML+RFuCPR2Tusw//LqaCCbupghIZbs9qdA4oBD1LKU31y
         eZDwOxRUp4Z1OQmjTIPQJU8g82bnK5yL28E7ZGT2C88GJFvZFniSzVtFfp8tpZ5ZhRDc
         78x5j6U0Hg/ekgDutVkCy6gs9MfJmepJKmjqPzXmNiywMX6OuadjvA4H8WH+WWThV1Kx
         lfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452078; x=1763056878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=JDc1qVFSR6RukXaZ2Rxy/oKeB81e5JOQW6Oa51U3LxIoTNP9EdKKliVywisGNtw3ut
         kJ8GpAkCMijG3gabNQL7yICAKxr6oMMPLA1ywFgYEMuI1xjR485BpqG58wCEBfjBvgZ4
         DvD+eUsr+NXDr/3YiMraFc0n4thB2MU6abZiW3zvKH/4zPKBoPCVdeFHvvPhVuxWydMy
         hunK3nVdkHGoaXmUJ4b/sNINs/EDffvTswb2ZfXmy2crgmJW9I7uC3IctnMCSqZ8u9nf
         QxIzlXoGHlK9TdX5h84d8d3kj1OQpQA3DBDqzwjLZHlt+vwqH2SpI5aXXmj+k4T2XhN9
         QKfA==
X-Forwarded-Encrypted: i=1; AJvYcCViJ3AK6npGI4i6OyYUubtS8sQNKl/icxfJOK/sff3zsz+bS4AoqRV5oGNRmKeEMbDhCa989la9+XBm7KHL@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmjUee7LdAyXOvn78NYcRtZB214OfP1XQBS0bofb3WBFqinaC
	ug4HmP+baJdPE9QRhrD1PtO9Zz/w9kfU9bkVAZPwk1J9LCPn3JvoCuFH
X-Gm-Gg: ASbGnctF8rNP5SIA29MgJsikMTJWG55gAwRY4yTMPw84FTDCIRJhC/8gJTSxEW1TBqU
	C3e0zkSHovjwbe1ckMEZnk1J5SJrlrSF7Bm4kTi9tWrWswIecT7VgrbzfC80iyf9gXyFx9G+hXx
	t6Fgoh64YTaENB0oS6tQFMvlPRrWcK2nc7XBao2MJqOiC96WVD8gP3mhcUu717zXBrH+BhZac+1
	IT5bLh2g2GKPZIyohNseF62jdyvJ7iNF7UNRhr3t1qjaEvoU2hqbQCbBwUSmfnYVh+AK+9hE0qO
	wfQZ/eOiv9CUuldC14Y+cVfgM512SLVICy7k4agYa5ZdSw1S2cZKdkOSO4SLEY9FV/jQ0rXy/nf
	kXZn93MocMYZprdQPxgNA+Fy0nIvOiVgKnDkTLj9C5P/GO/nBf4qPswTXTjkgptzAXWyeUKPceG
	Nyjbn2f7rWjb8Ky49nZK+78lvFhVS1TJqRtiASVl2KEQ7LO3s2
X-Google-Smtp-Source: AGHT+IEH7VQOvOdhRi3okWflF+KjH86D1HQeDcRUW3puSes+/n0te4BbALgaZq5PqIhcusM+kRCOPA==
X-Received: by 2002:a17:907:3f91:b0:b70:b1e6:3c78 with SMTP id a640c23a62f3a-b72c0d67c80mr3453866b.34.1762452077678;
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/4] btrfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:01 +0100
Message-ID: <20251106180103.923856-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..42df687a0126 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode_enable_fast_may_exec(&inode->vfs_inode);
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode_enable_fast_may_exec(inode);
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * inode_enable_fast_may_exec() is issued when inodes get instantiated, meaning
+ * calls to this place can be elided.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


