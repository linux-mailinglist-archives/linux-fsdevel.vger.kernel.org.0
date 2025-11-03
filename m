Return-Path: <linux-fsdevel+bounces-66842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D53C2D3E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9616934B35C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8156431C597;
	Mon,  3 Nov 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by4Nn7Pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879131A57E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188516; cv=none; b=biKvsMSe4/Kbewut7bssFRK4VSP8ZUb1RRkEpHoC4rN4p7MbKfLL+fe6esd0qqLwm2f7182VPa8/LbtxVyfTiU2lQAwkEZbI8Qahux+Y44EmhjOVQKZEB/urCYhYzxhOplCuf6vEJDKR2GlsqGKCEib8h9Cfj5D/RIFfiggBS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188516; c=relaxed/simple;
	bh=803fn53SStK4wXIjz1Zh8Pjere+o4fW/LFg6pbNfZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oiw9ed1hQfze6JSACf5/5XsiAOSxoDp5ycIcJZbuj5z2mW98Xiecd6ppryPIGP65XsK2l97xTbIDUT8bDO7zKXj/0X7hQ6PZvdAaXklkS1yGi9a4BV+p3n5nZrb6EQ8ioj9FKxnP4rbxAtUFDgt4pXZ1h9Y3yeiFCX7e6HB1ZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by4Nn7Pw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340c680fe8cso1856022a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188513; x=1762793313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzqCA84hItOJG3LR9jcLPhJDx5yJuZqijNb5+VhOfn8=;
        b=by4Nn7Pw0YzDVlnvK/hIO+LBJjbY8kQynOeCj0qKqfql7QmpuCy/3h+iYUqrHJ0XzN
         syCNrTU9En8G3vfNm+FuJ6zxgPzfc/OBYAeMcm6a3RkUFZn5s4P+CuYV1eKe8gnAuk9F
         +n2gzirLVSWvsJ3spkW9hh4MmElD/TDweMRjCAmX8zuM1G/sbdxIFs7GKgtMus75u23w
         1FaewPOusm8S9eFbhoKjspeZan3Xm/heZk8uQ01tmf5j4C46o1gU6ofeljEE5LXi16mT
         zPBfGT2aZ2wTdnnR7gjjoWR6o69TynZLxNV/0Bt8r299HDRuLR0jYCAAJxV/yK6xcsTn
         kHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188513; x=1762793313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzqCA84hItOJG3LR9jcLPhJDx5yJuZqijNb5+VhOfn8=;
        b=FZkh3Y1CPuLMmO1vg0yr+j7uRy8TzepSVToarxUuUGYeFgWJEa3bpILbyCaBBhtsty
         gE9z1xslduuwo/zBYgWzi3awVMpGOUD/op3NdcrEEO+n3IgzmvYzH3DSXWNadIlNvFWz
         v8+mET2bRolmYe/L1bh7mHtOKfEYV93pB2g/jq3/EoyyuVTBajCGbbWetG8BrzYVS6rS
         2NjNS/ka75DfFiI1spSRNaqjakxqK2ctSwcWxjQFZNMkSvl/v8cnq3Z5OSkTd5qRiaUr
         ARMn8v6VPNuWJ8d/ZvXPtJbDlPvESNFJZAcgc4IsbmOKPeLNa328wktuzDscuxuYQeV2
         cipg==
X-Forwarded-Encrypted: i=1; AJvYcCW3pujHazQ0JqrPpLMEccOrhgIjvyIc7iv+6Lj4KxS/jc1ZJIscx5YDulSIgHf52jUG4AkYDQbjP/R6ftwo@vger.kernel.org
X-Gm-Message-State: AOJu0YxhN2NxU9PGTQXmb9TvsKeAbGbra0WAcnd97XxUwALY5B3XTAx8
	WI+sdgWLGB2oDGKii2VZPsEXxT5Yn06ZEpse7E+vD7sYMZjg30ATgzg/
X-Gm-Gg: ASbGnctqnwG+6MH8fKRGSLd0MpMOHNm8LsZrCPFlO3d/oI+M/PgYaYLebUSWwcK4wGp
	sSrdq7J/cjXpMX31fmRe9BY0WanLYHRNvJiPjwWIiRYRgRfgn2DWTRdwIvU24pGGwwIpUW+/D4b
	DK+QG1+DPmGJAYzs2I1ziCE5IOEE0Bssw12SPXXJhcbHbNTWNliIunIs1CIdKLUJ31EEDNtk58W
	g4e3xQXvBLCEXVuJUoo0VhbR8vtVJpebCgdD9rUKmDgQHwUFlyJyaMb4jvXQk2FpZcYmS0QmZNs
	TcvLc8yTd0c7Zm8V6jEGihLfqYHehaK963rMEvcRqACcYJpM2LVuQo11CqFfjUBpneQGPpia7gq
	0njiKLJ97EFxCVWj3yVrdDq0FkMKC3RqEY0wuxcOpcM4jE8GHArQPtC/fKxdduewPlPIr2IhrnF
	CkAFENUIlHyox2TeN0vRmR
X-Google-Smtp-Source: AGHT+IEKGMkG8LSM8k5x2jtLV6ot/I3WeKc2wYyKsbkf6hGph6RyW15e3Nzs5v2jxgF/0uRopdPS1g==
X-Received: by 2002:a17:90b:1c0a:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-34082eded6bmr17634572a91.0.1762188513382;
        Mon, 03 Nov 2025 08:48:33 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:33 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v5 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 00:47:23 +0800
Message-ID: <20251103164722.151563-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When sb_min_blocksize() returns 0 and the return value is not checked,
it may lead to a situation where sb->s_blocksize is 0 when
accessing the filesystem super block. After commit a64e5a596067bd
("bdev: add back PAGE_SIZE block size validation for
sb_set_blocksize()"), this becomes more likely to happen when the
block device’s logical_block_size is larger than PAGE_SIZE and the
filesystem is unformatted. Add the __must_check attribute to ensure
callers always check the return value.

Cc: <stable@vger.kernel.org> # v6.15
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 block/bdev.c       | 2 +-
 include/linux/fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..26d4ca0f859a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+extern int __must_check sb_min_blocksize(struct super_block *, int);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


