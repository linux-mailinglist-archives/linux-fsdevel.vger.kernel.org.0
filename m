Return-Path: <linux-fsdevel+bounces-51646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F5AD98DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 02:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300FC17903A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33653C17;
	Sat, 14 Jun 2025 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN7xfnjk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B6195
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859290; cv=none; b=P3yd+xpRiKvPZYnDtGTvnz/PLjRlzY/r+ozmVS7hsyb/KQpe/7Q/YfFQXtWRkuXIk+e5Kp/ZX/GYe0WZPLH9JigFoDohbwQEMbq67Lv/NjSaHZENRKlfCpnPvVBuK18G4h6zHuLYltFQrSSDbA/PUTEv0TI4DrVlnGIpJKAIaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859290; c=relaxed/simple;
	bh=j/nNovl4t2bY6+4XMdJsDcKubyZN1AXBzSLjfppYD9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjgBBvKnpaUaZeRrzwJJwB+rsej583jwh744stIH9rKmao9MAogO5RSz0Uzkh1MUQBq1sEOdXjzWudgo/7fQBNNqNIgQGfTYGd1mwk+55o3GxnlNOiYXN8WQ7DHdUI1VUwXZm5Lipt80OiScMnAba4F/Ng1QUX9y/Q5xWmliRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN7xfnjk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73972a54919so2496158b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749859288; x=1750464088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDEpIHc32W/1lyIsuWjCSJyGi9EFEJvVo3hLOUpZn1M=;
        b=iN7xfnjkm6tmLTurEvrVO36KNXZMb8uQUSwCQKe1dVMngaoEat2zJboPPsg8VHTEGS
         hc1pDuBJjwTI/URFSVyTIiKGu5qzVhTEBkPEKAUkvryTusf2lZYc3ZWTpuZdflHhgSN2
         4EzMdV16NQ8gmowOU4395Rqcu1nbJOjYlQHy0A6AAaXguUcSiguLMyQyGMvWPkJX4tIQ
         yNDX13uUq2+yl0I4USyEd9ZfM4CBA76gugx3Vx7Y2Er2NDRxZdif0Q32LGvRRcPixoBE
         WdEr/5zJnVX+G/UAGbJ3zzNc0RcrMPvIrfsoF1PoRL6iFN0aF/+ymrVITF60Tt9/C5HQ
         bJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859288; x=1750464088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDEpIHc32W/1lyIsuWjCSJyGi9EFEJvVo3hLOUpZn1M=;
        b=ZWUixb5XXj7HGVmzQv++pBUix+wz2r5NKgLSaz1UEwyLnrcVWzzG/4I7C/8iGHSNcl
         ivafMx+dBoXblp439epaL7pJKd8mFIypv01gGgDCTSYyg29AI1gINXDOo+4enWoZjvWu
         fjZeJXgMzyOQflkWD5hcrPjOKY0lkVhhHB43ud0KODKnkStjT/KbzmZagqOPA809bK2z
         nH+bgrOMKabhUrGvJKTfhJk368rBlYso9viUGgCwHb6zzkppU1Mc2eYbo/6hbnfiQ7U1
         oZviMDIjOYlHJ+TjmkU4gK83NbeDhufXHwN/bFUUUtm4Z5gH6ZdSKOJnAjRbH+h23p+D
         0A/g==
X-Gm-Message-State: AOJu0Ywnf8UxKb5MBiUmc5nPkB5P9y7sUjLFZ3TJlzCNKJwBg13Qpkrd
	x3eIjXmQWkVhwqQwpzQ0l1Lv8W81KWy/GqizqTZCIFL7bVbqm79bvRg3
X-Gm-Gg: ASbGncsn0YMRHtThAgCJs4qNadxT9Lrx4O1X3HRugk1p7MxmXg9QTzVDka/R5JaRE6B
	Ggtojjb98nRPGQ08fG43gvvDiy27IllVyrT2ZCBXntnbljDZ65YORuU0rQr2o1NoDvCoN9BoDOC
	HZWbe7rr4L4WLkd7B6m2UCIakqZ8w/Eu1rkxDhojoJmJryAP+f3SRbR+Fq15yDhx1zMjRwk7/5/
	lRmIWONppuxb3D20KjPLtZsWUhgQMBh07UuwdvWFbV+BCuNzX3mNxwn3K4ge3AgoCGrYrmIEwae
	15TwAbw9r6Zx1LeM2P9tNWc2iDt6DCbCS0Xn9emVHcln5oJh/+/wtA==
X-Google-Smtp-Source: AGHT+IGe7ozlj0tAoD0ft+cnABmGDaKQX5LlYL2EuRUp1P/HBWGxdCRpkw2c/X7iae3Az4AqWAx95Q==
X-Received: by 2002:a05:6a00:3e17:b0:742:da7c:3f28 with SMTP id d2e1a72fcca58-7489d0559d7mr1573716b3a.21.1749859287900;
        Fri, 13 Jun 2025 17:01:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083f25sm2253050b3a.83.2025.06.13.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:01:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com
Subject: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
Date: Fri, 13 Jun 2025 17:01:14 -0700
Message-ID: <20250614000114.910380-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a bug in commit 63c69ad3d18a ("fuse: refactor
fuse_fill_write_pages()") where max_pages << PAGE_SHIFT is mistakenly
used as the calculation for the max_pages upper limit but there's the
possibility that copy_folio_from_iter_atomic() may copy over bytes
from the iov_iter that are less than the full length of the folio,
which would lead to exceeding max_pages.

This commit fixes it by adding a 'ap->num_folios < max_folios' check.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()")
Reported-by: Brian Foster <bfoster@redhat.com>
Closes: https://lore.kernel.org/linux-fsdevel/aEq4haEQScwHIWK6@bfoster/
---
 fs/fuse/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3d0b33be3824..a05a589dc701 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 				     struct address_space *mapping,
 				     struct iov_iter *ii, loff_t pos,
-				     unsigned int max_pages)
+				     unsigned int max_folios)
 {
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
@@ -1157,12 +1157,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	int err = 0;
 
 	num = min(iov_iter_count(ii), fc->max_write);
-	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	while (num) {
+	while (num && ap->num_folios < max_folios) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-- 
2.47.1


