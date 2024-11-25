Return-Path: <linux-fsdevel+bounces-35856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5D9D8E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDA280ECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6951CDFAC;
	Mon, 25 Nov 2024 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG9CXEgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0E1CDA2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572370; cv=none; b=gbvLD0wTA0/BTr2zglckxY52KMad2ev2mbLNt6wRn17ezmn2+0f0GW9tJcJndR9+G1l0j+vw11U6VSQkEyh5p3ZtHsvkVGK6/Ww7CQI8UKxtegdl204FHRwFY5se1LT3l7fHVORqS3lF93lkyZiL+/NAVmDT3k1WxJYR9bWI25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572370; c=relaxed/simple;
	bh=8ytq8AOm7aoQB4MLaaPubElK8U/fCzNiMimPIgt84v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtECkx05GGg19WcS+YNN7yLL+AjaO9/sLj42P677YMnfguFXdyWq0uDxos4ApRgZv7jTxzqrXNICiu8JVbHP21R22smCgw0VkDQnTSGQT6BYub7DUAlXbAqFxxiK/eRoJwrRZb4DjD/GyLg7zRjgursJ9iRWQpaDqfspzbXFfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG9CXEgM; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e388e1fd582so4972928276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572367; x=1733177167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75koXwbdSoG3gCLmkutCS3FJrNxaCzCuH3eaPPnbUw8=;
        b=PG9CXEgMhnDtWhOwK3exl8L+Gu7mthLRDraKZetgtZlxT1Q4UqYrQXqyWHIMphQmS1
         J5PjZuBpxRXzHbdkuKEjfnO0orxB6u/RX4iAV9jYgT5fgUYvMHgKbyGAKKgtsbIAY4A+
         bDytmCe1QKkDBmOI59oYRLSGLXHQorYsMibnTBV0vjNzIL3D+70zU3SkiN+V+n3bSwNH
         XwDxtLSsZIqw7SYVVJ9EEVlfKU07rwft9pjrxl9Kdx3Df9+GYbunO+U+pTLre4dxBsLY
         CN8XSYOTpKRTJmJfY3LNnTOrDtDM/Zd2Qu+lQmfJEliw+QtpabJXfAtT2C/deUEK1SWG
         u25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572367; x=1733177167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75koXwbdSoG3gCLmkutCS3FJrNxaCzCuH3eaPPnbUw8=;
        b=M2x//4ZzineXJ/JslIPkgU85DYH7p8JcNKztrmVTjNsZHURiHYHq+ghE30MT6sKI9Y
         XCNrqx01YJb1hPHKfiOuJCcn8OFu1Hsiz/meORHEPvqvyTlnNy7Ij0XpTyLMWJCwHrba
         +wsyVY5PiztInFljNM/mzRLG1YsigoJruuSY77lPGQB+7yArTCofeDi/6MmSoP+7oqfZ
         Ur4qvmBdYCNwS9pJ92zfceqAd6DwIvFB9++zvsC0m+bSfh4d0MWYUYYax8baxWZdM8rO
         UVmyewoNmI45+fBGOjyvnPUOfUmDsd4EnKmpji1lbWrQ/YWTj/tXhHIXEJCXSqzf1qyV
         RlRg==
X-Forwarded-Encrypted: i=1; AJvYcCXaUsFmyLd8rJWAaezptdq6r7mkexNMXIMO9E3sQVKBgw5lWuHSKKriwQg2wgq81Oxto3XM5YnMp0b6Exed@vger.kernel.org
X-Gm-Message-State: AOJu0Yxec0WoImU3LJ5CXlW9bDRbD37gAE+GdP850EPkx94SRV5cqjl5
	pNWK+BpwFok4Qo35dVDFpsB/lzshrXzU4GwXjmzgjKxwXCeou98i
X-Gm-Gg: ASbGncspzpMZevwT+h+7NyPV/IE6b5BN3M48kRUvZkzQQkcAfEXo2SqQu0kISVZTJVu
	csIxt1QEygXT7HlJRDVWEeee/0H9lDzkauWl7+RHQLCtQazK7+cIIsylWGafZFMLNozVwRO5HFa
	C3Qj1l5voOzfKuJRBs6VcKpW2HznubyE/YRqusn4AaTMWauMBZzxcZwH7etVIjGW+TiA2zKytS3
	MSmyVnKxuiw68pBddMmqR8Iph7mX7nwW5x+DgpLi6mjPT+NpYh0eWspYqvhgvMRR9kwE36R+BP+
	40yKZajz
X-Google-Smtp-Source: AGHT+IFqZUiniyw3XUwSQmwh/7z8hBU9vw5M3kTr2NvNzt9UOfH1Vvu0a6vqj9PZ956uCILRFpTgNQ==
X-Received: by 2002:a05:6902:1b81:b0:e30:c78e:33c8 with SMTP id 3f1490d57ef6-e38f8c07a00mr12658751276.45.1732572366800;
        Mon, 25 Nov 2024 14:06:06 -0800 (PST)
Received: from localhost (fwdproxy-nha-014.fbsv.net. [2a03:2880:25ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f604d36bsm2625306276.22.2024.11.25.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:06 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 08/12] fuse: support large folios for queued writes
Date: Mon, 25 Nov 2024 14:05:33 -0800
Message-ID: <20241125220537.3663725-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for queued writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b12b3cb96450..1cf11ba556f9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1791,11 +1791,14 @@ __releases(fi->lock)
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


