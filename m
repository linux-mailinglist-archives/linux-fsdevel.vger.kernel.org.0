Return-Path: <linux-fsdevel+bounces-22981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD12924BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642551F231F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCBC12FF8F;
	Tue,  2 Jul 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbM934/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C682E1DA30E
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960088; cv=none; b=MjcLySow5ydIXXgOf2duLyA6hI4w3SxT0OLynhsRcwuSfb5SWZER7ny01WdTN1R4ezG0xRjIzehAAolS9PzyhkuPjR1s6j6jfZOkO6lUCafFRDfmnuPzcIWTr1gNipI8GOvcCtBu8/nQIsI4M+r7xFVn4ycvgV47SFQYF5Ns+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960088; c=relaxed/simple;
	bh=GHwJQ8IpmPogJGqZwGoI/BWMINlnUS/bTqQUwlZyQu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YkhO3N1tR+FoYZWCPIsbn0ND1KcPv1AMyudxe/ym2kpd4QaNR/+1A9EBu2EdAuczwtCJ8Xn2yicmHrPL4biuIRARkzT2g9NMP6DujxuLPq6QavcvKwyTjY91ZgnehNiWDSZkJFSxSymXqvf1wc8X6WYlJ7XHQgOfOM6DkFs0fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbM934/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719960085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qem8wwNoBAT+5Wn6ogp8dszte/TbekgSRcAM6t9d7Mg=;
	b=WbM934/RcPTjfkwkyzjog3bn6JUq4BdnW98tETQOKMaOUJ88PxyQLhrBNvbGQNXMwk0IIo
	/3Eeux71LeI4fdpH3YxjPq+j6L+B6wluFyvyWODYbiblMbzdUGXXe+ujOIxv+wSORecC4D
	Uyo5z0l3nK80DBsy+h9Ve6UNuEHEA0s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-QDOkzaAoM92bSCiaHP-OUA-1; Tue, 02 Jul 2024 18:41:24 -0400
X-MC-Unique: QDOkzaAoM92bSCiaHP-OUA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so473141339f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960083; x=1720564883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qem8wwNoBAT+5Wn6ogp8dszte/TbekgSRcAM6t9d7Mg=;
        b=GT2Am58NyouCRDsxktFjHzHZo8EWlCCKLq6XVpqXUhCokvyoEI6r3dD0GorTe9Vt98
         yWO5/CVsmmmKS1lchP1L38xe7mSuwZiVR5uY1rpQd0Kaa4zkH9wDUWKYylf97Xjw755N
         Nmst/764KjmYyzefxbx+auBBCfQBaPFyjReBfILQMyKHUb1SaSrVn//6xvJCUWjIHFuc
         ILu+VNHFV14F/P/goVZzbg0Jqv1/9L9p4tPvWPhUCUsam/MD+eDs6y+a4Om/1pjTp1B/
         X3isCUGAkOm1JIiB6WBRxyrkLmzRKmiiex3tqPO7lb9fLhIEC1pzaswRTE5BW1/gazpc
         dB8A==
X-Gm-Message-State: AOJu0YyeEl8kupbEA7NviOCSdxAunEREiocn3ng/0Rza8e7xdf8lNYM2
	gUZyB2CHAt6QCePao1ANRNSGSyS5BNpQ9t65Drz2ppSkKIpaOfS6Z6RZkIhRcO/9IUByjjf8avz
	WGQXujD3v/rSpIWicuWzwJ5Mp9bStMmat3tM7P4wa4mjc6yXcn8lbcC5EA/xxgRt44cxJLOUAzn
	YifsE0H1FoeNaSytis2yyOcNQ91mXhdqRX1mtzlIOCpo2JVA==
X-Received: by 2002:a05:6602:5c2:b0:7f6:20d1:ab08 with SMTP id ca18e2360f4ac-7f62ee64d93mr993840639f.15.1719960083421;
        Tue, 02 Jul 2024 15:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYegadKZuSfm//3yH8o3WuhQx8veshostHozgQLIrRhYxZi+3ROHfNZDxXATVNOGQYmr4gVA==
X-Received: by 2002:a05:6602:5c2:b0:7f6:20d1:ab08 with SMTP id ca18e2360f4ac-7f62ee64d93mr993839839f.15.1719960083053;
        Tue, 02 Jul 2024 15:41:23 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f910fdsm3036261173.91.2024.07.02.15.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:41:22 -0700 (PDT)
Message-ID: <f6155247-32ee-4cfe-b808-9102b17f7cd1@redhat.com>
Date: Tue, 2 Jul 2024 17:41:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2 1/3] fat: move debug into fat_mount_options
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Content-Language: en-US
In-Reply-To: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move the debug variable into fat_mount_options for consistency and
to facilitate conversion to new mount API.

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



