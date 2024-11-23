Return-Path: <linux-fsdevel+bounces-35645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52DE9D6AAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C4A16198B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FE1422D4;
	Sat, 23 Nov 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxS6rn8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867892AE90;
	Sat, 23 Nov 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385499; cv=none; b=oAuPTyEl0hMvB/f29k6d4wqxt9X77VBMOJZZzUwlJab/7XjQF5kcAQtNJDq4oEOCKpDK62w8qEvbWgIQ4q+NyFRf/4sFxtflHRp5jvoHGiIQhybvhoJT7Zu2wQc30uyFcniJyedeC1KMwddFam12CZ3xHh6mbsrdV03zzAdZEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385499; c=relaxed/simple;
	bh=4OWydb0uad+cSg6XEwN8/7A1yX2vzbSXD+Cg2vpFN7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLMNze4D655FfIPPlgesv7TECZsuCndQaFs91AAvtbvBGQgh+Cu4qNuv4uNVKiJbPBqGW1HYQzR7Cm9y2PADBk6FIjBu5jPtSp8nRaYVxa9jV21G/eUq/Yrkzsm/9uZJ5d1RABqd+1V4pgp6oyRTEr/zzKGPXmJFThyhENdyAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxS6rn8K; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2126408cf52so26888745ad.1;
        Sat, 23 Nov 2024 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385498; x=1732990298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRKUntj3FsK+vGHd9SV+LXgOh6pOpY3AJO079Y2j5WQ=;
        b=FxS6rn8KH1KB466XUAMWQaXix9z7Q93LOzvWdl6cw/oOIATqrJviNV5SdNDyqbYzY7
         Ts6o25nv71JUFtr++A6Os8W+KBuPwtUP3TECcAgIXNgtajL9v4dklbK1T0JEgX8qxLFE
         9LJNKqPKaAIM/8X3pGDYxz5bCCrkKug+cSKK0I5j0CRs9WA9rjvCmh23j972wdTgCf+d
         MQoo1fwhl8dhKFHVE+xoaetbRBrzugyKxaWcAJkRrgrZ1bvcZGDZFdBn7aQqNq40+Ihy
         NFQuJ06vnperJm7vNETc6xG8GRO9SgQX/LqGAu5Oi0kiHNc2UAkllNo+jaiCRhixNakR
         A06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385498; x=1732990298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRKUntj3FsK+vGHd9SV+LXgOh6pOpY3AJO079Y2j5WQ=;
        b=AufvZ9IwmY2g3cVWELmsmZsfgIbrqw3VD2j4zU4i/VEja3HkpYmCj4EzmmHM7r8VVp
         zKh2yvSAdOCgplUWEUpZyXW3OW/LyHt+50kVuESLuM45SOBfc8NX8y/PkSZk6/zDc5XZ
         xH4B9fZC1ETxpMx2AzBdRCOuiGh/uze8t8OossLFTwB6S+qXIq2VNGg3LS6wTMGynm5L
         2pBH24jhD6jlmYou5LAcnlfOO5ae4X0CZAeBYvkz+yuoEr/V/AWLYC0RD4itvaxtN3PK
         qt8M7hQKBKrr2GMl6908D45RRGHSOwN+HVpC0/Q6QcTV5Bb7pQFKjQZlk7hTfbev5qP8
         mFhA==
X-Forwarded-Encrypted: i=1; AJvYcCVdyPMaAkTg7SNSXEdKjIttGvYmMDlC3MIw/A/8mg8wbwUyfT0CHqCPhQROO98jSqtAFR5AHtRhlILqqZ7L@vger.kernel.org, AJvYcCXbmPuKdyfc/s6Bl6h/nss0Qt1Z+tOtRGLGhgJmM6HpqpZsjA7j2xGmROnK397QccejVrkDZXZf9dad+LIp@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvf7SV3rKzP5syhJkUJZIbAvOh5EDOAcBguE/iIOgtzkLTSqV
	baF176GI3JaJo+mEp/lGDNiKUyhjI9CsTIC5V8g1hRI4g9hnPsHu
X-Gm-Gg: ASbGncuDzpcVbDHjd8R9mQvx6Y5wxjsLAJbcn/VhpfZekpCBPjy+6M+6HCVknJ/gUCO
	nWm8cy4kwQnBlkKuPLd9Kd+b1+XW1CFZ5FIOcjcm16NzrjpC85y8aZ3jJrZ9HT6FFgBIvys4qWc
	w5tjh3gyinuPkbD6GtqBcRrXE4SYU2w/ggCz0IeQ2lIlQDs/GXOZj5MkOAG2sHoGbyHCy1NXHbm
	BXUJdrfEBFVmEKubjBFfVDmx+ko8Qn/3LK1BsGgMqbl5XEakCfmFG/hTyqFgd4u1g==
X-Google-Smtp-Source: AGHT+IH7JsT2i9QyVrPXyB5XpQoB19pl05nm3HgNi3l9Ub1OwD1IcHz4rt2GMP3yfLk7QKZTpx7TiA==
X-Received: by 2002:a17:902:fc50:b0:212:9b1:e580 with SMTP id d9443c01a7336-2129f7d6f95mr91193985ad.56.1732385497753;
        Sat, 23 Nov 2024 10:11:37 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2c5fcsm34512885ad.280.2024.11.23.10.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:11:37 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 1/6] fs: fix proc_handler for sysctl_nr_open
Date: Sun, 24 Nov 2024 02:11:28 +0800
Message-ID: <20241123181128.183232-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proc_douintvec_minmax() instead of proc_dointvec_minmax() to handle
sysctl_nr_open, because its data type is unsigned int, not int.

Fixes: 9b80a184eaad ("fs/file: more unsigned file descriptors")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 976736be47cb..502b81f614d9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -128,7 +128,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &sysctl_nr_open,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= &sysctl_nr_open_min,
 		.extra2		= &sysctl_nr_open_max,
 	},
-- 
2.41.1


