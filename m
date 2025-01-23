Return-Path: <linux-fsdevel+bounces-39894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C2A19C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1EA16B27E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FDC1C28E;
	Thu, 23 Jan 2025 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZMtX/ET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F01E4A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595694; cv=none; b=urPTnSOGJdVrFIRdVdqgQeXZO2ODVSJ0VkJrXsKwl73CYyIhBC9hl6nivU6Ii3vFrHLuLFUvugn/8ZG1agHs1VBBAQdWQ7T/ARjCb1Xh//bQfc2sSfK3vbIo5/mohKd/z3dsqujbql71MV3n53dfzfFZz3m8xVl4sZjCaL1Mvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595694; c=relaxed/simple;
	bh=mvQwxrUibyVsExtkARfXA0/1+GN/KVCy4nAumcLVxY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXCPavJ48ustpGYe6kFNb6NqCA4chk+WyfRQC1PX43q827OxljzME1UETRE2qDKnUzPxzRZSzHpJRNZrCvPqQtEa6PXNIJu0hvIQ+P1X5HpgM6OTwwTdmr+CnQfnlKlEHi2mPBQxhpt9vKv9fOhBJMoX+uOheqBv0Tnhx9G50Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZMtX/ET; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5773c5901aso2564038276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595691; x=1738200491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHYMznGelv2FVMsnzqkI+3tl4jMW1kXv/aI/zPv0Htk=;
        b=YZMtX/ETeN20hlFw4FtiYIZLdVKB+1ZTcDWcFYci9+hsr6P7Khm9CkZ6D3zqEDyoOl
         iBMpTj8VJDZfhHYebzTTtnP1VYbDv/zqGXCTNRAYEDbQMkQYD4/eePbjBvXAZsQ8fW1o
         NUs+4OFe137jwGhQJ8zcVCIeu+PGQbwJYTkpcqihwW5+C1HW3wXbkKIpoJx3VK+JVg/i
         tT7ryOvNSp+Qi+yNI9uwUITwkW0lYkLBcVuzs+IyyKD+2KryKsikOsdy2ZHheHyrojNL
         84U1FhWYf07ek0C9/5/2XKD2/VYggu/a5dJCmmfu+QpVGu0C71e5vmRnAzOq/p/b0DX1
         5dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595691; x=1738200491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHYMznGelv2FVMsnzqkI+3tl4jMW1kXv/aI/zPv0Htk=;
        b=ce7eOq26wOkrw17JfHAIODSbnqtIKHadJqERvBT2ygo14I1PXFJWsLCLpNNCnIeBEJ
         bzMV0pDJB8uKyHZ3xwDc5RfPWYTIkwRs0Ko3BSGzwlHkJC623mhGqrYJC7Y9Kst0rXTu
         dr6fuUiwY673bosanNPVJf8Z9TvAe5HGAAq3+p05ys/KrZ42W0NKdhzMwK+0ZNoMkLu/
         5DOxlM88NJsiNKj45A+OYzJzg5oCPsFruIKpFvY5ejCFe+U1LCoClyDOvKhWE8BEmOmD
         sBCziVpcQz+d08ioCJCG4sePEk70BxPST1am8w1GHpO+uAXXkgHmF/yRfgd7kLj9+Ab6
         /2zg==
X-Forwarded-Encrypted: i=1; AJvYcCX20jC/V1bFfKogRKrLMhX+1arJ6Mp1lGI/9wtqDN5D1IpzS9Jg0OOqyBc5lP/0Yd6IwBzvuc5Jpq+QO/J1@vger.kernel.org
X-Gm-Message-State: AOJu0YyjB9EHYH54GYwkXXB9Ej03eRjFzwbdc+VmwEhFDbGwu/BZXyfW
	tnNH8Bip86vte6Rp/wVmbdbHJyP6f7Jjq3f9X5HDF7npNauRQOPU
X-Gm-Gg: ASbGncs1QJlHZkt9QwDr1rZe3sfrLSUF4nNnDlc9qKx+0w9d50+/zMFFbobyIK45sNT
	uL+GNHSmtoqHi6cI4oe5SLUE7i/5ofga/TOpGf+FjBI9BzQ5HsIrsl0ZRcyVyyZO8GUcBsQpJ//
	d4RS+y3IYTfrgWQTWT5iMKZW+hbmR8+a3JtRF9tyaJDMLJ+KJKUmdPTIKbtTm43HjbqM8DLfz9u
	2IFQ0I16NCYytiaCcSKVUgYrUlSgx7iD4Vm1jw1x0ZH6IVovtnjdQuDJ21rILtTp8l/rD9qDPaU
	dg==
X-Google-Smtp-Source: AGHT+IGW3HLY+Ovq7bmzp+fU299Io+3F8+0tArQ2FHeWQCveOY7EWc7AhZnOpoGrsng/Es1h2kAljA==
X-Received: by 2002:a05:6902:18c6:b0:e58:8eb:d703 with SMTP id 3f1490d57ef6-e58258b3e4bmr1150070276.22.1737595691461;
        Wed, 22 Jan 2025 17:28:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2e5fe9sm2275265276.13.2025.01.22.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:11 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 05/10] fuse: support large folios for folio reads
Date: Wed, 22 Jan 2025 17:24:43 -0800
Message-ID: <20250123012448.2479372-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index aeed80bbf01c..89ca6ac49187 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -875,7 +875,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.43.5


