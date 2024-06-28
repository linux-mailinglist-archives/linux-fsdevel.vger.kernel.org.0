Return-Path: <linux-fsdevel+bounces-22714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBB91B432
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248EE1F215F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAC25634;
	Fri, 28 Jun 2024 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPbNaPkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E21D545
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535174; cv=none; b=ZEAQFkBak6ZvoUfzqGPPHujNRVsz8+N658nSsIMo2rPDiSV5E3KPL6FYprIOogNh5UIAZ3AL64dEwBpANSFwzMXWmr/GaVbI8qTBOoqMpdQaO0fSsIIFiwqpSoUnMd8SmkryHrwDheIevQHP7yAt538yikg+1CymiC00MzdoWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535174; c=relaxed/simple;
	bh=k/GYj49tNHRu9Cr1Jzcr4L9WQKK7GhbiY7wTq6I033E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RMShOVBuh+6YZsiV0H4Nzr7+wUb72JgY94Sbel18QSGgW0HUyLOX3X9enOaR/FTZ4SbJqihx/ml/OOGatFtpFtwh+hNViaUEYExVQEyTJMZDECXmTIA91Z9aXpDolSmFBSveWEkv2tZ8G6ibRYnPho3AlpfV5HX03a2LRf/TWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPbNaPkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6lVI4UdpUrrU7t2THONNRQMSPsMiPCxjmcMgqZQjHI=;
	b=IPbNaPkzSYlROLwtDFz/eoL7Yz1suA76jiJ8/uu7Ilt53rh8KYJbAySNwJzx7zY39zxzOH
	JqCYAFEQzzQ2Wu0mV3D6s6BTUFvwznufKlzMcNtqP0s2W4rewQxxOlnfNY1HfarUhbFdyi
	zXP8IKlFnRiWxCQi5hFMj71lq+EiTgQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-mkKqGq53NJC_ZHOlBjX_cQ-1; Thu, 27 Jun 2024 20:39:29 -0400
X-MC-Unique: mkKqGq53NJC_ZHOlBjX_cQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737b3ee909so1339345ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535168; x=1720139968;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6lVI4UdpUrrU7t2THONNRQMSPsMiPCxjmcMgqZQjHI=;
        b=N8rDm3wCCrNIYg6mP5iTCDMzuAB/SSvc+40DukSM3EeHmuYrkQp4T32jz1I6mC5iaH
         Nuf36MekujZeM+HvfnuS6aP7wgnDTYBTSpWIsP0vdnqUaagI7FVJR4l9s2n6410n3uj3
         AccCKNxKBxJB6NPg5SuSTQ4H96lVnM1iWvw6RALRwxkfISU9tZNa/LZOgc/i4ej5+c7N
         Q82s70Be8YlM0Klj8UYGlx/M8jpjggXYUDRl3E3lcDfu2CwTwuWOjLDcWshoxYNSPrCK
         tv3CfZq6ZBqGceGeb5BNpkB760FT2sHl48a3JdA5Id8K1XwkaD+x3padczEUur/sgvfs
         b9eg==
X-Gm-Message-State: AOJu0YwP8Pvh7Xi81/8KvqnD1C0X//38h7g1qcxbQOXr3pQRqiN576cF
	47xCFWHhqAGus8XlgzMs4Vrq9YztXMRFztucg1mbQqC3DrBGB//V9Lqe0tFtjB+9+vsIANfkJY3
	Uqs/QI0vseG+tCQjro8YQzXJFDq7qGLkl+w3BzG0mPev9gfgM6sXwSptQPM7XhxCPt/GQz3Sry4
	b6zpqnmZi7GX3bybfLDQtsgXLvKcioU7DCmnZHl0RhXgB7eg==
X-Received: by 2002:a05:6e02:1b08:b0:375:be9e:34da with SMTP id e9e14a558f8ab-3763b0b4a4cmr217561785ab.2.1719535167785;
        Thu, 27 Jun 2024 17:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUkR/svSoWco43afklhPBsywxkUN6yiEPhjVFS6DjWiJxJqu6iv90RyIE35M2Q0SO3H2GPzA==
X-Received: by 2002:a05:6e02:1b08:b0:375:be9e:34da with SMTP id e9e14a558f8ab-3763b0b4a4cmr217561645ab.2.1719535167496;
        Thu, 27 Jun 2024 17:39:27 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad29827d6sm1751535ab.32.2024.06.27.17.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:39:27 -0700 (PDT)
Message-ID: <2543358a-b97e-45ce-8cdc-3de1dd9a782f@redhat.com>
Date: Thu, 27 Jun 2024 19:39:26 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 12/14] smb: client: Convert to new uid/gid option parsing
 helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-cifs@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/smb/client/fs_context.c | 39 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 3bbac925d076..bc926ab2555b 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -128,12 +128,14 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_flag("compress", Opt_compress),
 	fsparam_flag("witness", Opt_witness),
 
+	/* Mount options which take uid or gid */
+	fsparam_uid("backupuid", Opt_backupuid),
+	fsparam_gid("backupgid", Opt_backupgid),
+	fsparam_uid("uid", Opt_uid),
+	fsparam_uid("cruid", Opt_cruid),
+	fsparam_gid("gid", Opt_gid),
+
 	/* Mount options which take numeric value */
-	fsparam_u32("backupuid", Opt_backupuid),
-	fsparam_u32("backupgid", Opt_backupgid),
-	fsparam_u32("uid", Opt_uid),
-	fsparam_u32("cruid", Opt_cruid),
-	fsparam_u32("gid", Opt_gid),
 	fsparam_u32("file_mode", Opt_file_mode),
 	fsparam_u32("dirmode", Opt_dirmode),
 	fsparam_u32("dir_mode", Opt_dirmode),
@@ -951,8 +953,6 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	int i, opt;
 	bool is_smb3 = !strcmp(fc->fs_type->name, "smb3");
 	bool skip_parsing = false;
-	kuid_t uid;
-	kgid_t gid;
 
 	cifs_dbg(FYI, "CIFS: parsing cifs mount option '%s'\n", param->key);
 
@@ -1083,38 +1083,23 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			goto cifs_parse_mount_err;
-		ctx->linux_uid = uid;
+		ctx->linux_uid = result.uid;
 		ctx->uid_specified = true;
 		break;
 	case Opt_cruid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			goto cifs_parse_mount_err;
-		ctx->cred_uid = uid;
+		ctx->cred_uid = result.uid;
 		ctx->cruid_specified = true;
 		break;
 	case Opt_backupuid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			goto cifs_parse_mount_err;
-		ctx->backupuid = uid;
+		ctx->backupuid = result.uid;
 		ctx->backupuid_specified = true;
 		break;
 	case Opt_backupgid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			goto cifs_parse_mount_err;
-		ctx->backupgid = gid;
+		ctx->backupgid = result.gid;
 		ctx->backupgid_specified = true;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			goto cifs_parse_mount_err;
-		ctx->linux_gid = gid;
+		ctx->linux_gid = result.gid;
 		ctx->gid_specified = true;
 		break;
 	case Opt_port:
-- 
2.45.2



