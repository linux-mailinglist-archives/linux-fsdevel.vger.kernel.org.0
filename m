Return-Path: <linux-fsdevel+bounces-44389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C869A6814B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2A3B17BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDA1B0F20;
	Wed, 19 Mar 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TEXnBMMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4215A85E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343348; cv=none; b=PREwCmIEpKSx4iJTh8pvT1ymzMxIv9cZbJyNxBxyO0eQ48z4JY7yFRUjMDlnVO2dC8kH7yiAE/Jnta+yImvWSDyHl/GEvYnooadIr0/wzNpFxecCc6IQQi9bRziwNqOhFwccz85PtiUxTLI3nmZUs7+baW5KRin6jItlpbXphBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343348; c=relaxed/simple;
	bh=Fj2ZLr2NuM8eVI7Uv7KChJMeytj/MaTnY6KtSJCMWGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I30R9hNcstxtvt/Wjs90A+7fXzCGqBC+SXWOJ/W/6Z9ftCTOQUBJZG0JA4y2zIaeCiceb9Q/LaqiTm51jNdFpsyBTn5lpFdN/GVxPd2/l8MOMMVvD9nNznqE6pwmLgvXtLSEiXwplya26VHLPYg1tz7XeG/Mf/KIsOuBdXlPnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TEXnBMMg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso118237735ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343345; x=1742948145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZik9d5yBmYj5s2FfgR/QYgFrjABkp7Ts2fZAz7VStI=;
        b=TEXnBMMg1yHzHRSdTyjQ4M5eMSAi4cm6TcUSzBE4v7T1aqMx+wOwTc6oUD0kcfSZNL
         VOJK8MM3qhNyS6dcx/4/9GrwYPJewhpfQwpVTCu/Ze7UO/jFMU8c9KVklQf7I6DLAnX1
         spB1gN/5SZKx0xAUSD3s1COypqv7dwxz8dYBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343345; x=1742948145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZik9d5yBmYj5s2FfgR/QYgFrjABkp7Ts2fZAz7VStI=;
        b=luqjqLxgaHwA0W8Q8j9w9ZQ48kzDRQX/GmjECZbt0SzFDa+6rGw6RrOMqbIqCfUJhe
         sTJyCgvNgHHgAs9nVxJCH+wW8MJpcwsa4380/h1TGyDJw7iRBGa+9QD7yCM/wR05dzKC
         rfn8alELC7UDL3k47l3quMfGvW6t38xu+Pgnz1vLF6Lzf/YlaeZgvFHNP8YYcw3hpRHI
         VMoN+k8HI5/S03PA5ktSavMX67cL3+Oxihsy7RylXeofLLSqBqg1LXrwScbYmQiP3Bz7
         S9MHpfgFqxh8sROvtPBjPuq8qLvYbJQ7AerYPSFchjX4Evu1VyUcXTb5cG7lclDOY1yW
         PZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVo44yebteF5QmuzV87pVh6VzCPI90mkjuxAha6CczBweyegcz8Jp/UZTem0fU+ReVg/fy73s0Hn4Ui0uHt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5/LkUJSG+SqtAAfSZ+YsfIxWbB/JSnXwTsUAInHtNghe0iw/
	VYX9hNaPtP4J17aQzh1+wE2gfk/oxHo80BGiEPQSejQdskoPeqRkvHDqXV60CaA=
X-Gm-Gg: ASbGnct7w2GPxP9bSI/eXRn3eJ5hTov5zoHxR/omsAv6JERd3zcnIoR1BdlSTJQoUP0
	nUwiGwAKrkEZmAZ6sbOgqY2XgXGREZsxwrtVLTp9hPOd1Tn7+ynP06v86yfzGowCc9IFb4q7i44
	rVMzIbjbDzS2T2m2SJYWm7yUjQ1+6s+GDdzQ3ECtPGKRBYSfBfEbrNFyhNShIXvG7s8kl30n2xH
	R4Bp2X3NVLbTGrJhwHvXd1fQJgEMjeA6rbNw/8ZTTp4IF7PuvNlE8Qi2PP+WqHDWK+BN+LthuPw
	cbFSynCcyyLL3KzExkjqD4MeMtOMhO//ebI0FMOGNj3+uGaRi5Wd
X-Google-Smtp-Source: AGHT+IHOPH7tlvaKSgwzc5NrClMTJfkFBSLl86NoVpY2lwDOnHY3Yjh4FQI06/JOfl0Mx53H9CjTVw==
X-Received: by 2002:a17:902:d4c9:b0:223:3bf6:7e64 with SMTP id d9443c01a7336-22649a33d25mr10033275ad.24.1742343344716;
        Tue, 18 Mar 2025 17:15:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:44 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 05/10] fs: Add splice_write_sd to file operations
Date: Wed, 19 Mar 2025 00:15:16 +0000
Message-ID: <20250319001521.53249-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce splice_write_sd to file operations and export a new helper for
sockets splice_to_socket_sd to pass through the splice_desc context
allowing the allocated ubuf to be attached.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 22 ++++++++++++++++++----
 include/linux/fs.h     |  2 ++
 include/linux/splice.h |  2 ++
 net/socket.c           |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6dc60f47f84e..d08fa2a6d930 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -935,6 +935,16 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 {
 	return splice_socket_generic(pipe, out, ppos, len, flags, NULL);
 }
+
+ssize_t splice_to_socket_sd(struct pipe_inode_info *pipe,
+			    struct file *out, struct splice_desc *sd)
+{
+	ssize_t ret;
+
+	ret = splice_socket_generic(pipe, out, sd->opos, sd->total_len,
+				    sd->flags, sd->ubuf_info);
+	return ret;
+}
 #endif
 
 static int warn_unsupported(struct file *file, const char *op)
@@ -959,10 +969,14 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
 				 struct splice_desc *sd)
 {
-	if (unlikely(!out->f_op->splice_write))
-		return warn_unsupported(out, "write");
-	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
-				       sd->flags);
+	if (likely(!(sd->flags & SPLICE_F_ZC))) {
+		if (unlikely(!out->f_op->splice_write))
+			return warn_unsupported(out, "write");
+		return out->f_op->splice_write(pipe, out, sd->opos,
+					       sd->total_len, sd->flags);
+	} else {
+		return out->f_op->splice_write_sd(pipe, out, sd);
+	}
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..843e8b8a1d4d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2065,6 +2065,7 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
+struct splice_desc;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -2093,6 +2094,7 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*flock) (struct file *, int, struct file_lock *);
 	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
+	ssize_t (*splice_write_sd)(struct pipe_inode_info *, struct file *, struct splice_desc *);
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
 	void (*splice_eof)(struct file *file);
 	int (*setlease)(struct file *, int, struct file_lease **, void **);
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a88588cf2754..356b8cae4818 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -100,6 +100,8 @@ static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
 
 ssize_t do_tee(struct file *in, struct file *out, size_t len,
 	       unsigned int flags);
+ssize_t splice_to_socket_sd(struct pipe_inode_info *pipe, struct file *out,
+			    struct splice_desc *sd);
 ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 			 loff_t *ppos, size_t len, unsigned int flags);
 
diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f..4baf26a36477 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -165,6 +165,7 @@ static const struct file_operations socket_file_ops = {
 	.release =	sock_close,
 	.fasync =	sock_fasync,
 	.splice_write = splice_to_socket,
+	.splice_write_sd = splice_to_socket_sd,
 	.splice_read =	sock_splice_read,
 	.splice_eof =	sock_splice_eof,
 	.show_fdinfo =	sock_show_fdinfo,
-- 
2.43.0


