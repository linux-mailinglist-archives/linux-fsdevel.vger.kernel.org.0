Return-Path: <linux-fsdevel+bounces-22816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB691CE47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F21F21B7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B039E81AD2;
	Sat, 29 Jun 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFO/mdqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483033D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682297; cv=none; b=QyctAVW8JNpSq1xAVpTOa0wss4ZyAtp3xh0bng5oDpqDxqbcqU6p2YRAvc5fmtCT8+M+o9S/srz5WrIR/OgoaxZjSrYyOf+guN/67w8hzD9dwAaTniu1Z0gbzdUDps0G7s3qD7QQT5QoAnLgdduj//VB7z6oY9kt01/DqxlmzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682297; c=relaxed/simple;
	bh=+e78sDqa/Pq+/sL8dzjkxFQ7iR2Wyhlet+Hy+W/YAcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kRlAmQF9Rq/Dedwk4ImvAgy9gN5t0/KFURWx8tlkIL13P6XrwPIdLxGugqTZwSXA+yrmcvetEOHHxYDG+APbmd0ukhCi0sr/zTPg3IxT553MYVSWdTps2Bgztqfyrlwf8ZcP4kf577df4V1+1iq+Ibz3cp3eMu2gVrShwWmgqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFO/mdqS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719682294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWX/+HRaILkZj+eezATx5d0KRhJjERpWMZN0o02JzDg=;
	b=JFO/mdqS5ChYoVM9WlW+l47M6KUjFilqsm2+H2ODeujyqqZ88nUtgphTZF8aeA3NXUzV1s
	MkJss1Qf+j7rvfU6nta4LCy0dxIqXVL1H6E7vc+K1He7NCCr3Hu2N91013Ugug5t40gtQ4
	FIl79DlJ9tTOIat/piEO/W9Wainzp2Q=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-IomZwZGnPGyJVPGcSttUSQ-1; Sat, 29 Jun 2024 13:31:30 -0400
X-MC-Unique: IomZwZGnPGyJVPGcSttUSQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375beb12e67so18053045ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 10:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682289; x=1720287089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWX/+HRaILkZj+eezATx5d0KRhJjERpWMZN0o02JzDg=;
        b=qbRv8INfRc5cEunm0RaOlZbuhj1O+nh5ddkFnPZoLFUgXftUTHwF9oY4aDhOwW70iA
         q8PuUAJ+wbEBHxI+s0pxZaMhczvZDqA+hAst9XdCx3dJYTXuvC1rGWVhbPwMszGOz/8A
         EneJn4A4nITItmFc63n6qA7mf8kzwTeM7qQXCvUqYdF3AkHWf+wktQzlcirn6nH57ZGF
         WfJtCaw8vJsp7HpTfOnKb2JBh1frl2BjjBWw5GPbz2vk+tSt/t2Ca8LQJ2FT+I2y6hn6
         AX+s1ID+63T9MgAimmKg9eMYNYOJV2PpO6QPL3UEN81PAIJ7B0+FCPGW5ZtQu1tNzbhi
         48JQ==
X-Gm-Message-State: AOJu0YyPm3U2/BdZu/bJxfCZMCe130/I0+V87OShXoFC+86+DLPXo1xl
	5Bb64o2aIoc7nlL8l82BQUEiTrZPdHdsVBNQ7bDVwCjl5OEHd45eME/K9Mel6LQ8H98M4z9czkQ
	zLDPZ+D378mVU44hzXfMm4bb2lraz+e5jcirWrv8zWPR4P6HxLBc6WFI23ME+uln+xFZGGEW5XI
	8AozEvFHZxCF3a4L9YhVMMMCWtPiUC3zmIV9ufL2hSERAZ7w==
X-Received: by 2002:a05:6e02:2142:b0:377:17ba:bb3e with SMTP id e9e14a558f8ab-37cd377b7e3mr12772895ab.30.1719682289604;
        Sat, 29 Jun 2024 10:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFegjXCncdsW14Ok0mBnE58ULCiiyjyb0ntTkPs5fC9xRpo00rAPD4xKxquqZ0Fdyn3rxCgVA==
X-Received: by 2002:a05:6e02:2142:b0:377:17ba:bb3e with SMTP id e9e14a558f8ab-37cd377b7e3mr12772355ab.30.1719682288195;
        Sat, 29 Jun 2024 10:31:28 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1f6bsm1155227173.178.2024.06.29.10.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 10:31:27 -0700 (PDT)
Message-ID: <8817d4ae-7fe7-4f28-baa1-db9cf3bcef1a@redhat.com>
Date: Sat, 29 Jun 2024 12:31:27 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] fat: move debug into fat_mount_options
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Language: en-US
In-Reply-To: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move the debug variable into fat_mount_options for consistency and
to facilitate conversion to the new mount API.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/fat/fat.h   | 3 ++-
 fs/fat/inode.c | 9 ++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 66cf4778cf3b..37ced7bb06d5 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -51,7 +51,8 @@ struct fat_mount_options {
 		 tz_set:1,	   /* Filesystem timestamps' offset set */
 		 rodir:1,	   /* allow ATTR_RO for directory */
 		 discard:1,	   /* Issue discard requests on deletions */
-		 dos1xfloppy:1;	   /* Assume default BPB for DOS 1.x floppies */
+		 dos1xfloppy:1,	   /* Assume default BPB for DOS 1.x floppies */
+		 debug:1;	   /* Not currently used */
 };
 
 #define FAT_HASH_BITS	8
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d9e6fbb6f246..2a6537ba0d49 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1132,7 +1132,7 @@ static const match_table_t vfat_tokens = {
 };
 
 static int parse_options(struct super_block *sb, char *options, int is_vfat,
-			 int silent, int *debug, struct fat_mount_options *opts)
+			 int silent, struct fat_mount_options *opts)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -1162,7 +1162,7 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 	opts->tz_set = 0;
 	opts->nfs = 0;
 	opts->errors = FAT_ERRORS_RO;
-	*debug = 0;
+	opts->debug = 0;
 
 	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
 
@@ -1210,7 +1210,7 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 			opts->showexec = 1;
 			break;
 		case Opt_debug:
-			*debug = 1;
+			opts->debug = 1;
 			break;
 		case Opt_immutable:
 			opts->sys_immutable = 1;
@@ -1614,7 +1614,6 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	struct msdos_sb_info *sbi;
 	u16 logical_sector_size;
 	u32 total_sectors, total_clusters, fat_clusters, rootdir_sectors;
-	int debug;
 	long error;
 	char buf[50];
 	struct timespec64 ts;
@@ -1643,7 +1642,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	error = parse_options(sb, data, isvfat, silent, &debug, &sbi->options);
+	error = parse_options(sb, data, isvfat, silent, &sbi->options);
 	if (error)
 		goto out_fail;
 
-- 
2.45.2


