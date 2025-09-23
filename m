Return-Path: <linux-fsdevel+bounces-62475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6EB9438C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 06:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDB92E27F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 04:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A31275AF8;
	Tue, 23 Sep 2025 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIl2bQ0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49927603A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601326; cv=none; b=DYJ3PSVEyB6VBW+m3m1hgwNcqOVr4yMHuJKVwVyDttj+nH3rCkjXf/GrNE98oyb+JJqrqLY2uMqGjd++baP8lT5fbK/ar5nCz9YlDzT3pNjzEebNdNC5lzc9CefevP3D51RUN6mRqPYGZYcW11CngzGgbXqWCR0NOBNoxmq7iE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601326; c=relaxed/simple;
	bh=XLZkhs9B7s43yPMz0XkRiX5V/b3jeChbEWeI9PX6mdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahRGFDAujh622fF/h/ylEdDB9h730x5t05S/gkako1hGJNeql0aghZHgTHW7Wcz7MgybuuosnNUTF0xUVrO6RjcTKs0Iuvd9MGH05GkMQgl/t2tXILsf/cJUl+5KmTnbs8hwrr0ZRHsNUb9Hqf1OdslGr+mNX8tUYxB4yB1+27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIl2bQ0R; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f38a9de0bso1633771b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601324; x=1759206124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ep2im58IjxT7DllA4u/z9ICpD6gnUYG9dPd2F5jf0=;
        b=QIl2bQ0R3qkHGbx7wtcI+aq1Qp5wUz3htJv3pN0OdZlkdmfWLWSSifGLkjZpwemfji
         AluDAtJEUXF05VpONny+dYF5n5ijJSCa9OYdjVZGPuRs1YxvnP+T224tr3DoZSNBcv7n
         OwpECYJwBrrWE9w+wwloDs383yekhoHh5ZWHJ/rCgQsnxdkd+LwcpNHJEoUyCCF3fIOu
         0Z05VlM3tNbi7FR8iZFSM+x7hOJP2+XfRVw7eXjSOPJ6oFkney9lfhPw+AhNAZyYwUAn
         tWsncgSBd3AEoMwmBcbVfg/PVqahoKxYiriV3Ugh5xYsU+p/eiMAUqZuUXclQusGIDwh
         Q74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601324; x=1759206124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ep2im58IjxT7DllA4u/z9ICpD6gnUYG9dPd2F5jf0=;
        b=lVT/PrwFtonsT1o2sJIFPnNm3Y0eSJKevpqTLj++b8MK1Z0/dmSX9fxxRdgDT7dGlT
         XvAibZ73qIOTqKg1zGRyasWSq+JzNSSQaRmaeRa0jiiuDFq5Cq/oTbSLYLA6njzlbE7M
         DqGrWU1lLUXXlscU3CLtsLMYUt6oABAwisGWUGvt0I0AeY+9/j4BmnoS4t8WXv2xzP3t
         gffYNXonlwQvOoHq5qJDwHUpBB9BADLNZrTacRuAdnlbN24ZaUy7JBip8xijDPToa+Ix
         QIFygB6hVr8K4jhXz53A7mTiV4g7xGW7FvE8bkH2Dd7NHmlwZDKWWNyzF5JC6K2Jpq/Y
         HE/A==
X-Forwarded-Encrypted: i=1; AJvYcCVhjk4zxCy/X/sWVYuYA72lJ4JUVll5102BSpugFkx+jmZAw18We6Bp2XorxulFAXnbfR+8Ho4Ao2uqxaOL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SGo/+avChWnjC12t/mi6AV71PePZz+Cr2DEstMXtmeJNQFKi
	4RhYew6DKCLcNuAYV0s924rkqe/wg7Brh5rWdm1EusLa4UQIT3B/gsFo
X-Gm-Gg: ASbGncsxJBthROYVGLS/NaPz1hd3byfxagebdMnP+s/q+28X8NHEX8c7foEgnEo7BtA
	HWXBi853Y9qHRUaqjy/v7PdqfScjY6Y63UmZuBycE1Sz0u8tcf/he4AL2Cht9617wmyDaR34oiR
	ul5s12jRus3htlZd3ZeFODZ0X8TuFWvuLKglqJ7QrBQ9vIB+5H4/zh6H34TY+aXykXqkzd61DfY
	S6E2iZJzajqeOjfbsifPf79NkoxpiQg7gJpqvw1q/L5HO9qWpFpC7D/amweD/oMccDpqeuZT7hP
	STLOMTWqAjnUttmX7w5ew6gmiJ8Ju7hxS09BsfSHFNhAo4zpG6QQNIWItt6R9GGepbNIAESo5DV
	8nnuJ/5FbcStFlHL90ZRGTTtTbB19inkHjQ==
X-Google-Smtp-Source: AGHT+IFYm7cLGFEmVi93jViXMI0vjzoclxblnK03HrQzBTlwHSUg8RgeIuDYR9ocCKvlWOoegY4qwQ==
X-Received: by 2002:a05:6a00:3d13:b0:775:f2cc:c78e with SMTP id d2e1a72fcca58-77f53a83d8emr1675324b3a.21.1758601324334;
        Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Tue, 23 Sep 2025 12:21:55 +0800
Message-ID: <20250923042158.1196568-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250923042158.1196568-1-alexjlzheng@tencent.com>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..ee1b2cd8a4b4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	WARN_ON_ONCE(*pos & (block_size - 1));
+	WARN_ON_ONCE(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


