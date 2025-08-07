Return-Path: <linux-fsdevel+bounces-57009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73047B1DCA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F41FA0047E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290251FF1C4;
	Thu,  7 Aug 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOcdZ5Zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEE1F8677
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589073; cv=none; b=Kp+tM/d+dQ3XHyGdZlLM6U+MZ/AajuKfmxTKf3LeaELU6G6IH5K9kLW+p2+48C1SE6akJuQ/RZgVd0V8xMosTpeAPWju0wi4D80kKzUHq5X6CthU7EWXTp3fEGTjKkEO8spg/dpSnURPF8IjXxb7VD6SLk0PnrehIYjd/6GqYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589073; c=relaxed/simple;
	bh=RmVatj+7jo06KaQAn37VgCls2qhfvtin2QixOBSNLZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eh/GacVWQbbVcEWLJ6ZAqpjdMc9p/yFGc80n5P2eAu2mz6mjML33DPuapXQl2ApcURVucjANbUu+YIFgreFUFSOkqpMKbDNHvcd6xdWUpAJP5srp7Wbc+k2VJO9DnQWTHLsW2knjNyXh4kOnDXFwQJ1XqhYJuwbLATjJkP4YMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOcdZ5Zz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so1225245b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Aug 2025 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754589071; x=1755193871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMRqLIhExZVAfYccMazV9kOBGqRXT44AzWAjvx9vBxk=;
        b=OOcdZ5ZzzteksEDUd19GPxYoY4wwja4+HTYpdZ4pQkBOxGBYaTs/yI5C0AqdPVKHM5
         VifYBSIms/XMIruVvHmgUQQ5akMCvoI6RjAjGjlh8z/3+2z6wVyx+tBRCT5VVobxkVgT
         lGwaEUgG6IAud9Q8YuYS/lQZ94EqxgHMwoP6B4ekvuLdsN2Y2mhhR/GjguanG/DXJRP8
         wncInR/RPNWPndzHCSsYBzqlkKvjtAnCgymIAzs/ArDGjQmEhgO/2Z1egio1gCF01OHu
         1lcBO72vtD71UzX3NRVNDkn/y/oBoFPhmxWHN2GBlzbWxFxk4UneVEsREh+rwRhiAZ9H
         ZE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754589071; x=1755193871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMRqLIhExZVAfYccMazV9kOBGqRXT44AzWAjvx9vBxk=;
        b=uWbn5r5M6isDHKsPKe/LTVYrbx8BdUXejbGbYyaqiGaNL09d0rAz8a7RbTeN8AptIT
         58gnEefFQp2UwGwwD6cOtmbAjwwTheoB514aZBQhrBQloRmauGfgYyefIJv354gDws1r
         TNFFaZ1G4/JHJ2RgZEYwtwU8Lsjik/ju6XBXuJoUtIpTveX98CCXm1vkc///1l7m8ePo
         b2SfnKkFejLE3Z7zKhiCDkveJpKQfv8t2yFVz8AVVsEQYvuJD4H/JuEhGhPey1N1BFtv
         kscTo8OecucCnWLvlZ6tAdFCv1DxKwNnX8qAs9c83xTgwi4ZHbN3IpCDETeuUeWPHeta
         0m7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiD13CdSI2aduUavfvyBMm6LAbMD4/QfGXN4DtoBxHNfylKThySFM8j52ZOe/cPN5ph0MUR7IaXcd0+bwy@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRiFuscWjmtIlf7CbTAb8vsBL2jGcndmF/aeXG6UiK9hV/DDi
	hi3v+RhF8eLkWVjJ5RRiBKmUwlAofMKcw3SI+//HDoMkauLtAWTkccY9
X-Gm-Gg: ASbGncuZ11UpidUunrO+DRJz3/gpCAAAiwzabhvNTmKKr8A80teKa7JwIwbDjuqcnpP
	QHL0HCq/WFtyXzJTynBmSB74vP3nbEuhX/MBo6LY8QaHamXjKgb1SpieKdrpiUbLOa+BzIMyVxy
	1FIIFntj7SydbEY7B+I7FUwYYUrOJQTVhxISguDkyF6CcZM4bBntcYa9BhcdjUaMvGRXYWDTOIJ
	Bsu6V6gwZryafIOikO/y9bCaC2xpmTqM8vqe1EZHrl1vOcCKmOIe5W+QBTwogZrTg1xEfStQPdl
	0Dq8hRZT/CcRUY0Swo/UlyjUHXmwLgZZ3sgpLlMQSI5bVrVMP7OOGu7V5nzAepYz8OM7kMOpDLr
	AEuLcki35HwjwRgy4fg3/fPENJ8s=
X-Google-Smtp-Source: AGHT+IFLQ01FEJypsmR7F/fsM8eeu93DZf6AY6LL0Xcyb7lGkpN7LB02NvgtlO5ylYMeLic38l9gNw==
X-Received: by 2002:a17:902:cccc:b0:240:2eae:aecb with SMTP id d9443c01a7336-2429f54e4aemr107194375ad.43.1754589071273;
        Thu, 07 Aug 2025 10:51:11 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef83f3sm189867975ad.28.2025.08.07.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 10:51:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	brauner@kernel.org
Cc: djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] fuse: keep inode->i_blkbits constant
Date: Thu,  7 Aug 2025 10:50:15 -0700
Message-ID: <20250807175015.515192-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fuse now using iomap for writeback handling, inode blkbits changes
are problematic because iomap relies on inode->i_blkbits for its
internal bitmap logic. Currently we change inode->i_blkbits in fuse to
match the attr->blksize value passed in by the server.

This commit keeps inode->i_blkbits constant in fuse. Any attr->blksize
values passed in by the server will not update inode->i_blkbits. The
client-side behavior for stat is unaffected, stat will still reflect the
blocksize passed in by the server.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: ef7e7cbb32 ("fuse: use iomap for writeback")
---
Changelog:
v1: https://lore.kernel.org/linux-fsdevel/20250804210743.1239373-1-joannelkoong@gmail.com/#t
v1 -> v2:
  * Remove warning and keep stat() behavior unchanged (Miklos)
  * Dropped 2nd patch
---
 fs/fuse/inode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..33632c32ba6c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -285,11 +285,6 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		}
 	}
 
-	if (attr->blksize != 0)
-		inode->i_blkbits = ilog2(attr->blksize);
-	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
-
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
 	 * to check permissions.  This prevents failures due to the
-- 
2.47.3


