Return-Path: <linux-fsdevel+bounces-35649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009D9D6AB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F3FB21F60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63554146013;
	Sat, 23 Nov 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWDVR0rV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5D156F3A;
	Sat, 23 Nov 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385596; cv=none; b=XrhU1UH5rfGzSdtbUTDQuVyO9SKQ6Nho19CCTFf4A8nmCRD84K3DyEfpO9G90pM6lX/NPZn9/S4LWCepbFLW+DDIGzLRhLAg87LbP2C3W+4qvlSJF5K5koCIez0Qp/Ada6BVtnExDXW2D/XhX6b+XTu8a8YCptNtvnwa7Sjvpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385596; c=relaxed/simple;
	bh=Npxa+HJYQa0mjfNuQEiqTLLB9c3WY8PZwAVhQU8fIaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfhKpAgBSoXLp3gdtJ6rOIIZtGZM14g65Vs9++YDvUBwl/JPlowE8euT01bWZAptC0B9jFGUox2x0b5WSeB/NGkYVv0sgfW3NUq6gvx4opYmEONde3Aog8p+5YEJHf0ywHxHklSmM3sXtpvIObhLQyh7u4D0Ia8Su7+UTaYCDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWDVR0rV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea4d429e43so2572241a91.3;
        Sat, 23 Nov 2024 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385595; x=1732990395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHYJzxn/9mDcQtzwabJ2ppWw/ZPZ6ejLQTI/1mfqL54=;
        b=iWDVR0rVTvqI5cwDIERWcD2qx+2D+u0MKaFFuis8ShxbVYnfRZK2LhuyDggVWfdfNu
         hzk/tIiwXI5x1VrMRrK5lj2CBAB8U/RxWGn1RpWOswIdo3e4jp6tcN1gn9wYdzAdBVcl
         roKhsCU1wjqNIO5M4IZwLxLbN6NzES3lgCSlf4AxKzbaR64/OgY4/W9eu2ODDz8zEGvp
         np55D46pz2HO3U4wC4giyGajXw1/J+SdZwG8HeYE3vABiuyTGqhhrDEyAay8u0JlSXXT
         al8ZuEUGOrsYl3ZbbYIePRWl5vfk+WKuOUjgJf3A3+H588s7A1Mml1JEW1VTW6EGqP8o
         panA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385595; x=1732990395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHYJzxn/9mDcQtzwabJ2ppWw/ZPZ6ejLQTI/1mfqL54=;
        b=mJgp/9S7QS7+st9iqN/zObA0HGmWt7PRPB3Uh0MqQgz8uDaW6pwnA4MK2Hkp7eUUlY
         QJhO0F7wFf7cd2WuRQCH2AGckMT22VnR3ZHzUya7IKfkSzyIpq9UxkOAs2kMw8/bOs08
         ce/0xqAX5AFIrhxwpkuKa7rNaLyAV4exgZ0oXrjh7yYZSo8o9aVnwQge+iIx7NSMIac/
         uiGDnXFpmiUJksxsqpwQvzMMdJQusTi3D0zl/Fi7G3oQ9JRPJZPGZ09hh1okliuOcCW4
         eNV9Mo28wP3mk+kqMoPmG3px8hp2M0CPblkbixNc/6AzPos7pw/G8a83djNue51He7ZL
         g69w==
X-Forwarded-Encrypted: i=1; AJvYcCV2VzCnTRWJau4ntrD0lORLjbQwcJN8SLedvhjZnmYVpWSqYpdTZGt0shdzdQ5f0paQ81njoV8tQgWBRM02@vger.kernel.org, AJvYcCXFMDPibKIsy93bevfsIz0ICCaXUF95ajaoruAjCRqp8saQhpBb5sG2gq3SOToIkElKWAMQPNLa5Hy7M464@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRkq0mRR8bYqZwpUUccKTfjOZyrw65Ku/JQzI/E8bxEMYBxxL
	gENX4AC39JJ3mHoifcpLOcDlOuID77cxsOdvhBBo8xtPBI936RZW
X-Gm-Gg: ASbGncvyna9icn6ewk7YCaXo1DzIqa5cMul49y0KkuShptdMSmI1TwFSQGadNNXjC4e
	jbqkr0Duo6fPubDaDsJzjOQAj/93SHKX6fQLLZeze5nRL0x8uzYmBuaETKtANOSlumlVKTGEruh
	9NxrGOTvXkRhliBO2A8yYtz+wuUQbHAH9m+O0xz9y1m0llbXINaxJCrpP+ZOKWUL+sZq0EW1enU
	kgT3CvmRzkyKcUZtrdXCfU71lnW/1wZWFoxQBQY8IURlxlqyc2U4N9LuUcVJXXdKQ==
X-Google-Smtp-Source: AGHT+IFvWLR++Afy5oXhKNrCYBN0L6MI4zrKjPePWbQ71RPvoIuQKWS++OBaafYZ/LTctWs2dNcatA==
X-Received: by 2002:a17:90b:38ca:b0:2ea:97b6:c44d with SMTP id 98e67ed59e1d1-2eb0e2369f2mr9572206a91.15.1732385594656;
        Sat, 23 Nov 2024 10:13:14 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eaafadde27sm6692793a91.0.2024.11.23.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:13:14 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 5/6] sysctl: ensure sysctl_nr_open is not greater than files_stat.max_files
Date: Sun, 24 Nov 2024 02:13:08 +0800
Message-ID: <20241123181308.184294-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce proc_douintvec_nropen_minmax(), ensure the value of
sysctl_nr_open is not greater than files_stat.max_files.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c        |  2 +-
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 01faa9c2869e..43838354ce6d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -128,7 +128,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &sysctl_nr_open,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
+		.proc_handler	= proc_douintvec_nropen_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
 	},
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 4ecf945de956..ed7400841f82 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -72,6 +72,8 @@ int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+int proc_douintvec_nropen_minmax(const struct ctl_table *, int, void *,
+		size_t *, loff_t *);
 int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
 int proc_dointvec_jiffies(const struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ee2bfc7fcbe..d8ce18368ab3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -944,6 +944,27 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write,
 				 do_proc_douintvec_minmax_conv, &param);
 }
 
+/*
+ * Used for 'sysctl -w fs.nr_open', ensuring its value will not be greater
+ * than files_stat.max_files.
+ */
+int proc_douintvec_nropen_minmax(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int file_max;
+	struct do_proc_douintvec_minmax_conv_param param = {
+		.min = (unsigned int *) table->extra1,
+		.max = (unsigned int *) table->extra2,
+	};
+
+	file_max = min_t(unsigned int, files_stat.max_files,
+			*(unsigned int *)table->extra2);
+	if (write)
+		param.max = &file_max;
+	return do_proc_douintvec(table, write, buffer, lenp, ppos,
+				 do_proc_douintvec_minmax_conv, &param);
+}
+
 /**
  * proc_dou8vec_minmax - read a vector of unsigned chars with min/max values
  * @table: the sysctl table
-- 
2.41.1


