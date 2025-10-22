Return-Path: <linux-fsdevel+bounces-65210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D875CBFE25F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A843A7D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7E2FB622;
	Wed, 22 Oct 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgiTv4H1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396352FAC18
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164592; cv=none; b=qmqLkT/X4McJ0/QBt6ybYf7pXx+m7Qh50wK9eFIx8bIPzJ4AQvKw3b1oXYXAZb+zxFY8WMv+9ZGE5q/iqyaQlSBBIsStY0FhZ0D9l+ka1NZso+iFCtlHgJlrOqyxqIiTP5HPHVfTr7rUJi9FJPWHeWXGhfnhKmPqgcsybJ5zY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164592; c=relaxed/simple;
	bh=5mGTHKsXQv408pm5SoqLD5GoewsNp5Bjs5WKt6tWBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/NbdjRa05P9sCcDwgYN4TEIyHSLGs0uWJ23ypFsVI0AuS4FKG7tseGzEC8IG9pE9hHw/ybD2i4ElXaDamJ15Uv5WG1+CKGUtKgHTSoDTOP7/6lWv9haKC+FNooEJCCTOoDHc03wuU2YJqNTURIRmAfCuKpYLgyFCkJ5pJ991Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgiTv4H1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eceb38eb1so75144505ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164589; x=1761769389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMrDgkreuMkwxyjlwV8UKQbwsl/RgFlAftkbtcC6Jgk=;
        b=hgiTv4H1D6AjTUnuGSqK6jb4jzg2ToW4SNNG81472A2HgVKWOTsEfN976GSjE7ZNxV
         tbUZMD7QQNNzaIIeOjhrqMJFsAvrWVbJsuI4ySd8B9NEtosETYV6oITKAfZsA6IFOr7g
         /DfoSd85phMw7PlxpURFPpcj++hRQqzLO9iPleCbr2i0k/JdIYSDur4TW5Tk8SxdA5Z3
         DKo8apxwSp+2W74YgQa8tH9xixwVpMBx+NGb8LM0eJIHZE5To2CAXqzKDIDvNEB9SI8C
         sf6RNjfgyJKd2zAyXvCojIcYmvy0K0EzsLXMUKKOXF2WhSf4p/hvT6oFWd0bcjGwD+J5
         tkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164589; x=1761769389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMrDgkreuMkwxyjlwV8UKQbwsl/RgFlAftkbtcC6Jgk=;
        b=sFHExiW8RsvUknqWyO4mPngSPyAv9kUuF3or20v2JJ44GswbGjDhgMQSZqdyTWqCNH
         Hp0QC+qR3243frSrLBcAZzJGhsEkMChXMV+QMi83X+w0azAyZsTyxl1hFNhjHD3//q9J
         44M37nOH2/fLTGZPNr60BWKoMinhXiUvclKU6lh5BhMU4kztn+8klZaCZM64l3k5SZDv
         IC/ueZNV3qX9kpSxWz6yyET9k7roXIRgJ4CJuknzqSwUo9q/LVDLYb7ZCQjuKnck7AnZ
         Ih8YW+AWlmIpmI8rEdW8gyB3VkFd8O7OI2vYyt+PDfbjya7oN6uX1Iw9aY+hJmApHMnQ
         ++1w==
X-Gm-Message-State: AOJu0YyqmFyP9aYNJ0JcWVX6aIK/CYVUXPeenUYqkVl9+FOXTH10xJsu
	HigwU+wJOqgzhmu9LUxNTgs7wmVYVSfoYGTY+np+HJAm0DUA55jjTNuahTslMw==
X-Gm-Gg: ASbGncsIsMboyPu5Dgg0nZWeKHjepznqXYvbYC84a7MzBdAMA+Ru8O2LqjJVbUUPFay
	7J11XIaE1qckVfabd+HdEaSEC8oE05DTYhjneUHdT4Zkd8aEQdE1Pf6TXmcFOz20t0RTDAyQ0pK
	NvBb4LonTMrkSje7v7JbkDlRGUDapVq0PHFkAO2FospdbSRMFcPU+B0Rcdt5qS/TCtQ8d79WVmn
	o8+3xUO1ciKGXGFN3yv6k+klRw6Q5NHleT063eZTP5ELvq6H3SDMl7OIHAol1BVEFL0emyn1uAz
	V3EBhEZxP5HZpZZEDHqa1mNZRnyZSpvG9/qs/4QwfJldgqjCOhWpIsc0t0AHSwIjlXLX/KggRhT
	xS2ZavgMNTkd9KxyJ8gHOJ2ZOvJZrClq2YDXF4qa8vctriu0Kn5DnoYMMWEVmuksNyiwZ59K/VG
	iEh7QjZCKE/F9f6631UlRkudfIR8U=
X-Google-Smtp-Source: AGHT+IFqN567FI5QsK8lZuMHHcMGHghKlmdWXCLA05arSr2M91d3jOjl5DkbcgOAUFVUVgzE3GNY8A==
X-Received: by 2002:a17:902:f64a:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-290ca403110mr272080675ad.21.1761164589389;
        Wed, 22 Oct 2025 13:23:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a34esm3444453a91.15.2025.10.22.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:23:09 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com
Subject: [PATCH v1 1/2] io-uring: add io_uring_cmd_get_buffer_info()
Date: Wed, 22 Oct 2025 13:20:20 -0700
Message-ID: <20251022202021.3649586-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022202021.3649586-1-joannelkoong@gmail.com>
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_uring_cmd_get_buffer_info() to fetch buffer information that will
be necessary for constructing an iov iter for it.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h |  2 ++
 io_uring/rsrc.c              | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..a92e810f37f9 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -177,4 +177,6 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf,
+				 unsigned int *len);
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..8554cdad8abc 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1569,3 +1569,24 @@ int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 	req->flags |= REQ_F_IMPORT_BUFFER;
 	return 0;
 }
+
+int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf,
+				 unsigned int *len)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_rsrc_data *data = &ctx->buf_table;
+	struct io_mapped_ubuf *imu;
+	unsigned int buf_index;
+
+	if (!data->nr)
+		return -EINVAL;
+
+	buf_index = cmd->sqe->buf_index;
+	imu = data->nodes[buf_index]->buf;
+
+	*ubuf = imu->ubuf;
+	*len = imu->len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_get_buffer_info);
-- 
2.47.3


