Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA610DCAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK3Fb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:31:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46183 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfK3FbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so15630039pfc.13;
        Fri, 29 Nov 2019 21:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vw3rC7pffNNcciKNW8GALTh1NKcZNgUJHxJWIV46+IQ=;
        b=QTBT8UKK9yUITRVyFfiYMom5BZg89YGsEzgcN6Ysm4CvfNOo1aUz9n83Bt2HWsz5LM
         nRyX1eeWgFXLJKlPkpmyyju0gEUuWJ0X0v6fgyh/HuWx9WJOWxyIJ5+j0upSMpupRdQh
         pMM0oanTxpjUBVKYEI9vcqAAOEnRGt7G/7VR4kBBVYQ1/4L7AktgC0zSLB+1OO9WWpEg
         GU6bKa7qCf9HcrUuEubih9LUwQfFCfpnyqbywLQs12WvQV0BEtdptgpXs8RHA6VfHTcH
         VriOGXHIOpd1+HAZL86mfD73n3063vP0YD8EIHCljzpubRjfwiN/VnKRAivE2x4v01Nw
         sIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vw3rC7pffNNcciKNW8GALTh1NKcZNgUJHxJWIV46+IQ=;
        b=ZN9lj5kqcdD2HNmjC3ce6wrHBbiI33BjY2UgjkfO+fZG5i6k0629UARWt/u7slXDcL
         nJh8LH50M+4KAQ9LLSeA9rlPjbLiZnHB9zJ9uknKKu1Em64oAPuFO7YFlInwlpau0nzO
         PV7PTOlZkXMnADaCoBPeJfMuAJu9EssvPhdJknVxfxrhqCsE69aXYolwjSXKwp7I6hnT
         mh44ScMhj19iF+THLeFklIceQik0sXZt/OM5vZ09Y8dV7tF5r3WROTB0tP0T2vQy7kcn
         2kVKGi8C2BANYecz8ZKaPIWtkW8GDbnT8bqYe99ffsHyAf6GwB5sCmz4YGXimWJExZ8J
         v8ZA==
X-Gm-Message-State: APjAAAXoxGoq4fzd72/XamhG1xKC7jbBKeLmen0lKMkiPfknJhfjOPFY
        ac+r2Aag5PCQO3yLeTJidRE=
X-Google-Smtp-Source: APXvYqyKLE9MPEOfva5JmfnqKbKoz5o2n2ZiCUAM4Gm+j89Z0YMto0rYLtIj75X10hjrQIYJyzB12Q==
X-Received: by 2002:a65:58ce:: with SMTP id e14mr263048pgu.153.1575091880926;
        Fri, 29 Nov 2019 21:31:20 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:20 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de, richard@nod.at,
        linux-mtd@lists.infradead.org
Subject: [PATCH 5/7] fs: ubifs: Eliminate timespec64_trunc() usage
Date:   Fri, 29 Nov 2019 21:30:28 -0800
Message-Id: <20191130053030.7868-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
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

