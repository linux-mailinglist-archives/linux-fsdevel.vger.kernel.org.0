Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119E410F6E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLCFUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43179 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfLCFUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so1199645plr.10;
        Mon, 02 Dec 2019 21:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vw3rC7pffNNcciKNW8GALTh1NKcZNgUJHxJWIV46+IQ=;
        b=mbTUHEH3Fa7gVHQuyVM58bhc1ZNPyRBhs55wGdEUiozfLFQt7oHsIlRs6OmMbQqk9X
         NVUC20mjFsBXTcFFjt8zkuIz+yoaBfE5ZnDwp/Suspwc56hlLASXeWPasVlSeMabtor9
         VI0kB3d552VGzroKQ5tMWSRZQPP8VpUB7CmiUzWY9w66dit4MPZitKgI1GqWNII5LjRw
         LHkxHknvZaO8zBaWNUHohYL5NjnAZVnL+ZWebN2e5lBttB7h2+cPmot5OKPdtbdz/1l4
         tV48n55tuHqaHc9r8Q6nAAjoHSCZCC6Fe2xE5eXTqgl4e5ywCKxp/P2Ro/G38CI1MPM8
         iGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vw3rC7pffNNcciKNW8GALTh1NKcZNgUJHxJWIV46+IQ=;
        b=gTZ5T2DgU5GcQOm3fCwF1pGjj489sm9MrRcP0eUwfPJ6ufefAym9vAbrlnHGIlmr7T
         e7QE49QwwlsT+mggNVBoG1Gq9hHSEwzJb12FS/N9UibmVMJFuwiI5cePXn+mse9mCoXp
         WdvKnH4Oe7THySyvcXyo3o6s4qBewnCSHp63i60jucNdKF/JuubmTlSjCiQ8pnKqrjkt
         jUYjTgZTELqoRrNhigTbKbslsb1iKBRZRFAi5+JvgMRqLs/CPO2FNkjSyS8wyJ9/BWu0
         /jCLZt8jDMVKaq/OPaQEsREcpEc7NMLD+Jj9OkTwVm0N/MF2Voexjoel5typZXcNDstv
         Ka7g==
X-Gm-Message-State: APjAAAUuJ4CXg39HMfDwstE/vb8hQ83oVVh2Yy729bH5xJdPzNZ9j3XL
        MNBbFvmSHQaqeCbh9nRqrRE=
X-Google-Smtp-Source: APXvYqyIirVUziL4a56vsdUKU6cH4t16OUJcrgZCUwEaSPK+fI1rSUG4qhtuG/Zzf1XKgURDz3ytrw==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr3197997plo.300.1575350414514;
        Mon, 02 Dec 2019 21:20:14 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:14 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de, richard@nod.at,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 4/6] fs: ubifs: Eliminate timespec64_trunc() usage
Date:   Mon,  2 Dec 2019 21:19:43 -0800
Message-Id: <20191203051945.9440-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DEFAULT_TIME_GRAN is seconds granularity. We can
just drop the nsec while creating the default root node.
Delete the unneeded call to timespec64_trunc().

Also update the ktime_get_* api to match the one used in
current_time(). This allows for the timestamps to be updated
by using the same ktime_get_* api always.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: richard@nod.at
Cc: linux-mtd@lists.infradead.org
---
 fs/ubifs/sb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 2b7c04bf8983..93d550be4c11 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -84,7 +84,6 @@ static int create_default_filesystem(struct ubifs_info *c)
 	int idx_node_size;
 	long long tmp64, main_bytes;
 	__le64 tmp_le64;
-	__le32 tmp_le32;
 	struct timespec64 ts;
 	u8 hash[UBIFS_HASH_ARR_SZ];
 	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
@@ -291,16 +290,14 @@ static int create_default_filesystem(struct ubifs_info *c)
 	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
 	ino->nlink = cpu_to_le32(2);
 
-	ktime_get_real_ts64(&ts);
-	ts = timespec64_trunc(ts, DEFAULT_TIME_GRAN);
+	ktime_get_coarse_real_ts64(&ts);
 	tmp_le64 = cpu_to_le64(ts.tv_sec);
 	ino->atime_sec   = tmp_le64;
 	ino->ctime_sec   = tmp_le64;
 	ino->mtime_sec   = tmp_le64;
-	tmp_le32 = cpu_to_le32(ts.tv_nsec);
-	ino->atime_nsec  = tmp_le32;
-	ino->ctime_nsec  = tmp_le32;
-	ino->mtime_nsec  = tmp_le32;
+	ino->atime_nsec  = 0;
+	ino->ctime_nsec  = 0;
+	ino->mtime_nsec  = 0;
 	ino->mode = cpu_to_le32(S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
 	ino->size = cpu_to_le64(UBIFS_INO_NODE_SZ);
 
-- 
2.17.1

