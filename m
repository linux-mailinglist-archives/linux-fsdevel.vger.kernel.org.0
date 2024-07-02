Return-Path: <linux-fsdevel+bounces-22984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEF924BD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1187CB215F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3755C08;
	Tue,  2 Jul 2024 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9Dx+ILB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755171DA30D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960364; cv=none; b=bAkQfoZtQFhyy8JJz7n/ZferY+fF7j0jyoxyeWTA6KCwWHlqDyNtpS+U2aKYumnrbDg3SHe03i6T2+AP5WvcgiUHE+QkK/z5S29lZJdXEBIDbGP4B4eK4Xl+W5VKluEyTq/6n/skrkuOsYk1Vg0DXBaNU+UxMW8dF1Q+rBiSSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960364; c=relaxed/simple;
	bh=8wglXVnsBVQ4uaXIaXUPCDoirlWh+hcbqLfgU59gQpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NN6ZfFEuwvPOZIr6BkMOdBiWtAtCY2iCK6R09iMU3lky+X1zkE+cSnIDj/ZJYyyZl3hXdTZwoKkN0d82RZm30SHLq8onKeNu3yet8s68no/7+A5MLQsdB1+lZyxleytMekJMPaK4JGIpsLQDP6Yv6J3pCuiAoRTZCaxK0YGyrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9Dx+ILB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719960361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWUeUaokR/SB0OVoD4hdeHfCZgt9QY3pVE0yqvD3yNA=;
	b=L9Dx+ILBRUvr5dMx2cntpT+/8/9vYeXXH7bkT9i8AEqyydqqz9Y5bYaKh/25SIIEkuNnHR
	dmjP/b58LB4A6bHLYZtb4IO/EBawym4WHscexgm6iIuQ9z33DHGJmvTxGWe7cWEHqowVpg
	m42uZuUQXXpueZMCbwH5A1ax20AlvuU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-MzOIGQEtP5q6HSEcK-bE7Q-1; Tue, 02 Jul 2024 18:46:00 -0400
X-MC-Unique: MzOIGQEtP5q6HSEcK-bE7Q-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3c8b1fee1so494092939f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960359; x=1720565159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWUeUaokR/SB0OVoD4hdeHfCZgt9QY3pVE0yqvD3yNA=;
        b=w4KMjPQUhnKTPWlbQuT95VZRQKcwz/nEgh9pq1PiSt/aPREhm6Dmm3nx/3OnZNHfC7
         xfJMdlKCs2l8ktFup56crKMDyQdKK98d5AI+kB8teaArBLF87wJ9xYIizlVFbdrAnD4P
         jjo6+DcJiLf5Ct7gmPfROHnv2AaKH1dMFeqlrf4bRRNIbo144bu9+Z2OkyZ6mPqqS/iJ
         KsQ74cCQA27wshNbobuKB4e1077DynCv4DEYRflJlLoy1qccWqHuUkQZkZph/ISUyMsu
         KPtnntLGLtLujc3ts5y4YYNEHHy4uXXW+KQlpuxWEFA2jfN0Z3fc8UZa1p71VE7dCcJf
         b4yQ==
X-Gm-Message-State: AOJu0YySMWk3Ihv0/ASlHTs80za8ElhcLyf3UDaYSyYD1osEY7YR+Gj9
	gYGAa1rgFveg3px9o3beWdRsNMNFlxKqQgE+gnCOrys0g97auZC2rP9y0wNKz9c6Oji9RdRpKa5
	mY6UtvrByH2UlkQkpPyCqk3+DJvnp8+8XXSs4eTDXvTPKLn/jiZL7qvZ/opV08b8xTdN5pQtU3S
	CZTCcoisc9dZ28POdpJLd9NThJVJZcmKdW49owjc3N3WR7Hg==
X-Received: by 2002:a6b:4f09:0:b0:7f3:c811:3369 with SMTP id ca18e2360f4ac-7f62ee3d7bbmr1044352039f.2.1719960359171;
        Tue, 02 Jul 2024 15:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIBAKGWJfAMkhoZLCZKVSWV+SOVWEdoWN8yCgPWZ/9PS2CHAok8SSRcvF967pLB5ul+febXw==
X-Received: by 2002:a6b:4f09:0:b0:7f3:c811:3369 with SMTP id ca18e2360f4ac-7f62ee3d7bbmr1044350239f.2.1719960358758;
        Tue, 02 Jul 2024 15:45:58 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f90ed8sm3017811173.99.2024.07.02.15.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:45:58 -0700 (PDT)
Message-ID: <1a67d2a8-0aae-42a2-9c0f-21cd4cd87d13@redhat.com>
Date: Tue, 2 Jul 2024 17:45:57 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2 3/3] fat: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Content-Language: en-US
In-Reply-To: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/fat/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index b83b39f2f69b..8fbf5edb7aa2 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1091,8 +1091,8 @@ static const struct constant_table fat_param_conv[] = {
 /* Core options. See below for vfat and msdos extras */
 const struct fs_parameter_spec fat_param_spec[] = {
 	fsparam_enum	("check",	Opt_check, fat_param_check),
-	fsparam_u32	("uid",		Opt_uid),
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("umask",	Opt_umask),
 	fsparam_u32oct	("dmask",	Opt_dmask),
 	fsparam_u32oct	("fmask",	Opt_fmask),
@@ -1161,8 +1161,6 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
 	struct fat_mount_options *opts = fc->fs_private;
 	struct fs_parse_result result;
 	int opt;
-	kuid_t uid;
-	kgid_t gid;
 
 	/* remount options have traditionally been ignored */
 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
@@ -1209,16 +1207,10 @@ int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
 		opts->sys_immutable = 1;
 		break;
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return -EINVAL;
-		opts->fs_uid = uid;
+		opts->fs_uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return -EINVAL;
-		opts->fs_gid = gid;
+		opts->fs_gid = result.gid;
 		break;
 	case Opt_umask:
 		opts->fs_fmask = opts->fs_dmask = result.uint_32;
-- 
2.45.2



