Return-Path: <linux-fsdevel+bounces-36195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A09DF4D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 06:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960B3162E6F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2743172;
	Sun,  1 Dec 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER2VBy/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C84C66;
	Sun,  1 Dec 2024 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733030069; cv=none; b=c88IxUnMM+0vzseI33bHedc72d/XzOSYGAbK5wK9xlp/I6894JE7dwbPtjY5wbRhHdSlbsOIBa8NwpoP4k1FG78mzc+JVmrIWZYL4cqmIUM6IC7vsAg8Nimvr4GF7/Eex1MfznpXPlPhVYTS8qpYnSqGgQH/shd23RGpvMPTjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733030069; c=relaxed/simple;
	bh=rNzd7yjBZUaCxxBQ9iJVBkcS76uPcj3OZqA/qwmgDlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHhhkLmbLYnXzu594dkLy3Hzn9TcIQ94jSnVTtrRPAfHHrD/jH8D5iz/iQK31ZLOEJo7Q/02nLPZNe4rCFsUgz1LmktoXM9fWraeof9WKjv6eYwUa272C+RcBN/pV8EWz/YRV1p24PSL1WvnBxkmKhFtMCsSe84Th65AJ85f/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER2VBy/E; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724d23df764so2726549b3a.1;
        Sat, 30 Nov 2024 21:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733030066; x=1733634866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0s427cTV7ZgH4dcpPNy+NEqv19G1w/i2+L9gNXF6G44=;
        b=ER2VBy/E2+fwCYgJgfqX1Ns8Xq+FSjgw1EGDyjm7kkwmrKJ7bVFgy0U46H0R8eE10g
         F94NY8VGxPGq2yRGHrnOwk6UpfQ/O1OiGuLVOxr0htFt33ToHDLrncC0vFatHUN36br1
         9VEScf+P6jb4DRO5JJPnrvxKy6uEBd2hgzz8ZvnC2AcQYJ9aAbWiSVTLwDSDbeKocXLW
         wW9fXKi/02yKR47gNpc4XPVnDUqOtnpGUPIG7nXLFxs1XisY7a95LYuGas1jWYuOzR5I
         sfQ9i9M4nRd5aRFjr8xl9gPrRYlSkcKbb63W/6yIJs8lhmzFDG/2cpvtNVLHHqjenSVy
         2VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733030066; x=1733634866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s427cTV7ZgH4dcpPNy+NEqv19G1w/i2+L9gNXF6G44=;
        b=ievmfG/qhLHo6Zp5dIij4vBgiGOsE3Gr0w5d5dVSx2yYNoU4gl5l4tyB+MzNpSh6Lp
         d9XE45XlDFNwIT/PxZ9uHglNbBXxRCbq6GyPm5c3E1G4ZsRBMUvDZEfzgekFR5koWzr4
         xWRl5fL3kbZ+egjTLP0vhsWyU2lNiXlQ9HnnDsVdkbeTzXRX7E+PtSqOrEI1UWo+Hsz+
         6qEHpwBAXOlX16UojJSXAl6sFSnfdsbDozMSVo4vlWIfMGzPPYb5wUWbXdg5uhX7ER9b
         xj2LceQfIdCFVzl/BiLDrjOofPi9xN3SQ0dXQ85fHFQ7AULJs4t40BjqHweDbvP8hnTF
         BVlw==
X-Forwarded-Encrypted: i=1; AJvYcCVnYFbkv4asAiZYk1A08X+m1WRsUMaHXfzAT0r4M7taV8gUh+iQPXqgjTtQMAa1yMA2hnwIAxLXJXa5M9VO@vger.kernel.org, AJvYcCXm65SszLgYZMp1jGItnrLfCjFIJzhKT5cgJ57Et+86MANYLU5OlPJP0VjYblSUOOXNZNGcc2T+nyWFybOc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyljdie9lfH0ZIB29vV2spSjDSQUGXUlyKKRlCO+xA6G++Kx8t
	V+9zdk1GZOH8a81lQWbL2+QMhcHNTseL2ubh4+Csht/lmBxV1p+6
X-Gm-Gg: ASbGnctLE+u+9jo0gg7E2uDMpZs3Gt0cv0Qx/O32XvaehKZWCo8OAdbrZ1eWCTH32Lv
	o7yvOEeUy2O9kcssuO0m6ML4uwaNud1U7VIyWoYRLeR306UzVhf8Mr98WRGDvgw/k7puQFJux5H
	AJpVoA24v1r9yfCYiRZIw0lGxYXC06tx4osEtLSVAaXOg0xwBoy+TaEPpC2APEHhaKz+oUpCiY+
	NUg8lyQTyqnC6XCgl/jhMqU6Pv7mOdsVtlgLEb7K4peXOt7sQj3YWmnN2rmILfoyA==
X-Google-Smtp-Source: AGHT+IF22MYhPE8y05UYJU+M1MvOKq17DNzKujQDoNfEOSkd6GOJ1l2WAaNV0GQX+LwAdaFpwLFf5A==
X-Received: by 2002:a05:6a00:230b:b0:724:5d26:d904 with SMTP id d2e1a72fcca58-7253014341cmr23056647b3a.18.1733030065841;
        Sat, 30 Nov 2024 21:14:25 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a600:8588:f159:8ed9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c30e4cfsm4744318a12.36.2024.11.30.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 21:14:25 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: brauner@kernel.org,
	sandeen@redhat.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	quic_jjohnson@quicinc.com
Cc: Leo Stone <leocstone@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Subject: [PATCH v2] hfs: Sanity check the root record
Date: Sat, 30 Nov 2024 21:14:19 -0800
Message-ID: <20241201051420.77858-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the syzbot reproducer, the hfs_cat_rec for the root dir has type
HFS_CDR_FIL after being read with hfs_bnode_read() in hfs_super_fill().
This indicates it should be used as an hfs_cat_file, which is 102 bytes.
Only the first 70 bytes of that struct are initialized, however,
because the entrylength passed into hfs_bnode_read() is still the length of
a directory record. This causes uninitialized values to be used later on,
when the hfs_cat_rec union is treated as the larger hfs_cat_file struct.

Add a check to make sure the retrieved record has the correct type
for the root directory (HFS_CDR_DIR), and make sure we load the correct
number of bytes for a directory record.

Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Tested-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Made the check on fd.entrylength more strict. Tested with real HFS
    images.
v1: https://lore.kernel.org/all/20241123194949.9243-1-leocstone@gmail.com
---
 fs/hfs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 3bee9b5dba5e..fe09c2093a93 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -349,11 +349,13 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto bail_no_root;
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
-		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
+		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
+		if (rec.type != HFS_CDR_DIR)
+			res = -EIO;
 	}
 	if (res)
 		goto bail_hfs_find;
-- 
2.43.0


