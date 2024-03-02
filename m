Return-Path: <linux-fsdevel+bounces-13355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8B86EF3B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC671F2336D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F018657;
	Sat,  2 Mar 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPoK+sXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703218059;
	Sat,  2 Mar 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365367; cv=none; b=LduN4ABZ7QPeLyuWnaNM6Fd9V0tDe+qj2ArUMFS+FyySUeNVO4Zt6tJdQ/Prap70nMjcDms5UWcwGYtW4VDIoibINT3nwRg6XuZUwcS6PKqb8XZmH3DBlLsVPCU55PtaAEmro9XCDHoOILU0KdvC+pNup+JrvdElU8AQxNrVZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365367; c=relaxed/simple;
	bh=XccdQgbUgEfTrYjCxrgPLToybofUT8Nn97GdxSvqImc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euFd6ucb+Yg7+BUygYNh+zE0Z3hHAoTcnLbOWgzRjwcezAP3fNeB0QlI0wXDmZECGJVN1pqk2kwjvo6S0dAomOaFDvUFT5HfGMFOuYOfH69Qc5WP0veNUVNdN5g3jopwlBpsQyD6sPhl7zig89zhIAPW9i4vA8DmxsaWsECKL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPoK+sXQ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21fa872dce3so1203047fac.2;
        Fri, 01 Mar 2024 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365364; x=1709970164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmvvXS9J0hotjKmd7nXk3BFkDw31hUfZsHqAnm1NWAk=;
        b=HPoK+sXQwBYyISFknHPxG2QoERx2lq6Z6PW8pXOvNowJfSN7lx1bi8iUCrwsLc6798
         wPtk3zfoVD5J+m/+tCi97AWAzm1fM7meGU11Ibi9tIc8wWa8qiZ2Uy4tyS5WjkDXm3H6
         AX6cck9M89+rpOGqVXC8azvLZXMVLLmLAT8YKHlkOybREroH1bbtSVCemXdQI1t6BvxC
         CtWkmGZVUHhS4jFmcikCKEc2pQaThBm+PlJTcnw0M80svpnH6r+LNA3G/uwbkTqg1+Tq
         cqUuUqrBzollsz9pn4/MUPkxOY2GXbV4FyBYJP/HqMkHR9MrWpJ8yG+vDaicMIFrW2zh
         KTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365364; x=1709970164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmvvXS9J0hotjKmd7nXk3BFkDw31hUfZsHqAnm1NWAk=;
        b=bbbHZlhrRZuFvtCn4+L1klm9C/l7Zsqzm1htGL0ZAkjGOKa2lqXVlZanu3uj/IePki
         Y2o0J14RkCoEgoxMgQQ+JvvjsoQQCIApYC13mfoWHItoKWLuMUcAWkvGkmCcg3HuXgDY
         5Vk3IpNo9xXMuMjJvqLhniNSGI78UobEvUp0XHKjRqVIWnbsDhhL+ezObwRg4EsuZlWp
         FFKyNwNkKyT74iomZTmYYVXLE6iS+oSpPTF9UdMurXuIVNi1UgIyZwOu9ZTNxkrirPhs
         CFNxuP49b+D5/fTRETD3f225rhgl681X9WgdRW3LUbjacOtq0wSUDbNI88T075R8Pv+2
         MMMw==
X-Forwarded-Encrypted: i=1; AJvYcCWJbF9GyZP5xAvVrZfcLakDkOhLu3ggy9z91aZChNng5dLcOhNL4O8uDMEwLXAZ2ASfVqbHt4NxqzcC8HUD0Bb067MMtitKsnMSjb5YKJgvdG5nmzgdNxP3hALQIjPiTsQfXh72wI3Vcg==
X-Gm-Message-State: AOJu0YxX/kTkiwqBu7sB1jzBnsG6HotwOuG4Yc8wT3BIraQ8NuH5JAGB
	s+c0QYXKsD1iMxSRXIzxG04kwwtC7c5Y82dKOUiieWZAfk5QB+GfRMEremw/
X-Google-Smtp-Source: AGHT+IE4CpBbtufy+ckAJgMRWpOhMbygbFmtOeQHTozWUAdYrfg6HSglZMY1fvBiYVpFNVc5rALKcA==
X-Received: by 2002:a05:6870:c142:b0:220:bf55:b12a with SMTP id g2-20020a056870c14200b00220bf55b12amr3871797oad.38.1709365364048;
        Fri, 01 Mar 2024 23:42:44 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:43 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 5/8] ext4: Adds direct-io atomic writes checks
Date: Sat,  2 Mar 2024 13:12:02 +0530
Message-ID: <e332979deb70913c2c476a059b09015904a5b007.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds ext4 specific checks for supporting atomic writes
using fsawu (filesystem atomic write unit). We can enable this support
with either -
1. bigalloc on a 4k pagesize system or
2. bs < ps system with -b <BS>
3. filesystems with LBS (large block size) support (future)

Let's use generic_atomic_write_valid() helper for alignment
restrictions checking.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 54d6ff22585c..8e309a9a0bd6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -400,6 +400,21 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
 	.end_io = ext4_dio_write_end_io,
 };
 
+static bool ext4_dio_atomic_write_checks(struct kiocb *iocb,
+					 struct iov_iter *from)
+{
+	struct super_block *sb = file_inode(iocb->ki_filp)->i_sb;
+	loff_t pos = iocb->ki_pos;
+	unsigned int fsawu_min, fsawu_max;
+
+	if (!ext4_can_atomic_write_fsawu(sb))
+		return false;
+
+	ext4_atomic_write_fsawu(sb, &fsawu_min, &fsawu_max);
+
+	return generic_atomic_write_valid(pos, from, fsawu_min, fsawu_max);
+}
+
 /*
  * The intention here is to start with shared lock acquired then see if any
  * condition requires an exclusive inode lock. If yes, then we restart the
@@ -427,13 +442,19 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	loff_t offset;
 	size_t count;
 	ssize_t ret;
-	bool overwrite, unaligned_io;
+	bool overwrite, unaligned_io, atomic_write;
 
 restart:
 	ret = ext4_generic_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
 
+	atomic_write = iocb->ki_flags & IOCB_ATOMIC;
+	if (atomic_write && !ext4_dio_atomic_write_checks(iocb, from)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	offset = iocb->ki_pos;
 	count = ret;
 
@@ -576,8 +597,15 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	if (ret == -ENOTBLK)
-		ret = 0;
+
+	/* Fallback to buffered-io for non-atomic DIO */
+	if (ret == -ENOTBLK) {
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			ret = -EIO;
+		else
+			ret = 0;
+	}
+
 	if (extend) {
 		/*
 		 * We always perform extending DIO write synchronously so by
-- 
2.43.0


