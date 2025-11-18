Return-Path: <linux-fsdevel+bounces-68820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BEC67104
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321B9364291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24267328B43;
	Tue, 18 Nov 2025 02:48:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E41E0DD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434105; cv=none; b=JiXS+iM3OphcrHWCAFOIkiLU1ziTWXvHF8qqtMNfHxyd/Jw4WEMLiE0+dNATk7gLg1k1JtaGlzmJKjFvGMwWJ9oJaN6R1RkG0rqQAapSF+snH+a+lsppAKfIZWupXF7VdwrUDSDBe+2o/5khKynkh6VrRArAK8QU+AiqzTi91jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434105; c=relaxed/simple;
	bh=RNzuOfhnaaoIPT/hhpurTDMUrMFWpoGZ1URc7azveIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hw6tXD1SKYnii1reTqcnCk2w2TrBEuZYr7Em2mma+hhPlWDc9gr24i083RiBYAiNLmYPgWHsx0sbGll6oyL13uo/Pbiw4ntLz1caUKy6HzCbh7QQlC1bV+FKXZKg7sg5mbOAkGnq6fHuTKVOkOeNW4lfyZD9N5ThUE07gtA8oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso5621663b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434103; x=1764038903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFRzafrM6Eva6+M5WExAq5JV9s+bKfFRLI1WdLs+7Kg=;
        b=t9c/1PnW8bzXq0d96lB3tMKbxsg+iHCRlTrjYyj6HUoFUbDUq/M17RRlyzMnOzR0a6
         jpiuS25BLMqGlHa4NB2P8P/vuVGW1EIDwOmNJQOsfEOzuW/duoaPvLZ/G8EGkm61hjm8
         0rUjB8xumlEJ9d0pL6oEfaIv9x0POE+8ykjjfHrl1cQEjPyeD5UH5CM5wBnwwvVG97qW
         iTXdpGYxZCPt2qdh5kash/iKNCCS1QtTrWft+2KQdeskC3CKE8xe4vzI4xZEDZ4kvFJs
         gumk2oBxRmd61SDG60ZA44CAe+4GnGJKDBtcX98fucxiBCoAJXucE+TSUZJTdmi61AnE
         x1Gg==
X-Gm-Message-State: AOJu0YxLdA1MkZ3MwJLV1A1q7rw/sGPmwBv/MBo1+JRZXh/NFn/0z9Nq
	U2N/l9SHFnCFiTvanV5EDUWfSfp1pIEP5UHFKrTMy0a8Uo1SpEEiScdz
X-Gm-Gg: ASbGncv5Hx+m/eWq4X8Gu39mDT8bwgMIbUE9KVYVTpJm6Y3ynZeYuvwUBgdzXpEujk8
	tjW69EqsP7hR+4lVYfT4RRiRekpF9JUSCFK9kJ/d5p3z2icKlJE5MYovkC5l9rFQMSOygapfB+5
	xTGPTRKOCbsYOftsIrf/Zmh/weK348/qdR+zmL5CQOxY4g5wsmiPaYMu+oKw3xdbLikwpngEXnS
	Pv/bRCAHRKbDfVbqeVLwmcMn5kD8/M9n+VshT3OI/RMOX3K1QqjWHo+mWVxZQFIEVL8BAQ8l2YJ
	x5FudwoKZd2qpsuB1Zeq/XZWSSbSKODc0DT+kmeBC00OWu1OofBwRouVZVcguqxDfj/fq9XtiHr
	BRfgyU9VNZKWwXoopgDYAORYK1pbq/JSbQoJXl6Wm9Zkuzi3nPEtE/Wu8kc9LaXEjN3J0/fyZBS
	y7XsWfIHt7/JTD5SbcbXyv9OvQAQ==
X-Google-Smtp-Source: AGHT+IGlJv7sR+AI1gk41lPOdUK0NOGCgkmiOfUU6drXPL+od9OGfeLZVrAtIy2n17APvDcanj6FAA==
X-Received: by 2002:a05:6a20:6a21:b0:342:a261:e2bc with SMTP id adf61e73a8af0-35b9f7802fdmr19744524637.10.1763434103453;
        Mon, 17 Nov 2025 18:48:23 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36e8a58cfsm13485846a12.10.2025.11.17.18.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:48:22 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Jiaming Zhang <r772577952@gmail.com>
Subject: [PATCH] exfat: fix divide-by-zero in exfat_allocate_bitmap
Date: Tue, 18 Nov 2025 11:48:04 +0900
Message-Id: <20251118024804.7143-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable max_ra_count can be 0 in exfat_allocate_bitmap(),
which causes a divide-by-zero error in the subsequent modulo operation
(i % max_ra_count), leading to a system crash.
When max_ra_count is 0, it means that readahead is not used. This patch
load the bitmap without readahead.

Reported-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index b387bf7df65e..5429041c7eaf 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -106,7 +106,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		(PAGE_SHIFT - sb->s_blocksize_bits);
 	for (i = 0; i < sbi->map_sectors; i++) {
 		/* Trigger the next readahead in advance. */
-		if (0 == (i % max_ra_count)) {
+		if (max_ra_count && 0 == (i % max_ra_count)) {
 			blk_start_plug(&plug);
 			for (j = i; j < min(max_ra_count, sbi->map_sectors - i) + i; j++)
 				sb_breadahead(sb, sector + j);
-- 
2.25.1


