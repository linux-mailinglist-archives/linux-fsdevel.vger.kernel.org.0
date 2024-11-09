Return-Path: <linux-fsdevel+bounces-34118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D09C28B2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517E31C210C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB681E;
	Sat,  9 Nov 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iws2+8w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8E8836
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111232; cv=none; b=O5kmSAeC0ijLdDO/Yvq8ri8xLyNDJmhza5yf90Kui4EvW3IDAD+QtHqm96Wjeq0Rgd/qDCLbw82/rFrKzJq3/bhuLwJXvySP86rQzOGvV76D/MGkYH+/Eq/utoQuNeiNXIg1q5ruoiTacqv5ps3M1cB1Uze9Ken5L9d5V5FN20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111232; c=relaxed/simple;
	bh=EfvJz6dAtZPmu+joMXDpM3F6Jmc3RbJ0pN7c68vk1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8t+VP+VrRzg8ZNeAh7Ey8O9j7HfOeX3d915VphobAH2fMBs4EXRtBOpWOHXQGsEZX7GyxPALQSe2hYf6iGYgNgPryZl6+fxRrODLgN9rG8+durwdDLlZfc1LC13x3IVgMNVV7lpO34ki4GPRjJFumATd5p4q6YyLJfTfppWlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iws2+8w5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea7c26e195so30809657b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111230; x=1731716030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuvUotWx8eISAi8drzhpx6GLm3Zs1eFnPNa5j8GNQb8=;
        b=Iws2+8w5nC8XczhvUVdK+O+n1SvTh6u76KT3Vjhz6MrP5vTrvGc6v2Bygxk/Fp/7Mx
         ojlx6qTxY2jwaVH0YL11ZRBubYQogyjx+m0E9KwTQ1HgEx0SQcflh3mbmJxz6ISI1r6U
         /V/7IKO0Sj/Z3+Wr719NrU+sMsqHmR5TCjW5bsHIeOJxAque4lAAUy2P3CiKk+gzS6Ci
         gjgYDa98ToJxH+fQC9QuNya6hRRELUwt+SjB0bwpSyCtrvWQZulza+aRj3a8UBKuN5hC
         lM8TDORHUPZuzVuOTk4o2hhh+aSSCn3vowVD6Z/VN91Q7Vg9MZU+6WMskvWMisE1hLs/
         tocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111230; x=1731716030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuvUotWx8eISAi8drzhpx6GLm3Zs1eFnPNa5j8GNQb8=;
        b=AZhUR+XwsPDdHhuzX5UHRKa6BqEyWvkiYqNcAd3Pc6UJlvzsrGHpc4eMQ/65X5U0qc
         Kn/8y1zdcnJrwkQYAT3gcNxtcvLhWtEihauqfWvSvfHaWeteTNfmB/f7tGL98CEpLQJH
         gT2UvT+y1L/3unXaG3YcpdMT2NFyatM2TlWDlbsNbr2mT3yjRud99oY2cfW0U/5klz3e
         DOAnRdQAhBmwLdrNfU0ye1vQ1+f01dsvlIiLRbtIdZcaltizWyuoZeBl5oj3LjXwTm5h
         3atUc1FIOSIVylPDLN18l6r+DqWAOhf8QiWctlf6TLCH8O52wMvHHyP6P0tmLqiGDJpt
         PMbA==
X-Forwarded-Encrypted: i=1; AJvYcCV76s8KfxbAt6hiknk7P8mS7pffTylAjuVY8Uc76OyYO41A4OE7PeJykiAsaITWBiVfEqEHmlj9Vnn5A0VL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfoq3RSYZQDbqa620RP5HuOxKR9i05Irz+utjVBaDRf1PvSrYd
	tKNtrSEZjSq0ca3hFHu5eLuVVcN/sed+UzFT3YukVDo1qVw8KBTR
X-Google-Smtp-Source: AGHT+IFlcpc0RTuF8gHufS9jIfzQrmIZwZmuEVr4kHl8oFTWESceAkpLUHK9N9e74WhMUWmbtXeA4g==
X-Received: by 2002:a0d:c304:0:b0:6ea:ef9d:fcba with SMTP id 00721157ae682-6eaef9dfe5cmr9885037b3.6.1731111230352;
        Fri, 08 Nov 2024 16:13:50 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ef3ebsm9417777b3.34.2024.11.08.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:50 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 08/12] fuse: support large folios for queued writes
Date: Fri,  8 Nov 2024 16:12:54 -0800
Message-ID: <20241109001258.2216604-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 399bc8898cc4..44a65bdfe8fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1793,11 +1793,14 @@ __releases(fi->lock)
 __acquires(fi->lock)
 {
 	struct fuse_inode *fi = get_fuse_inode(wpa->inode);
+	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct fuse_write_in *inarg = &wpa->ia.write.in;
-	struct fuse_args *args = &wpa->ia.ap.args;
-	/* Currently, all folios in FUSE are one page */
-	__u64 data_size = wpa->ia.ap.num_folios * PAGE_SIZE;
-	int err;
+	struct fuse_args *args = &ap->args;
+	__u64 data_size = 0;
+	int err, i;
+
+	for (i = 0; i < ap->num_folios; i++)
+		data_size += ap->descs[i].length;
 
 	fi->writectr++;
 	if (inarg->offset + data_size <= size) {
-- 
2.43.5


