Return-Path: <linux-fsdevel+bounces-22979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23C924B92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050701F215D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0021DA309;
	Tue,  2 Jul 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+CVvUgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42C1DA302
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959010; cv=none; b=BJNKZl4cCX5bkj9/PFSqp5nv1+cOVBQhq0xfL3+WsNNwhyljQLddq8jRZqWD5BP4Q9JRU/MNYv7WrNhgmV09DRf9zGoIVkgBBUqra9T632fXTuWhb9HA88xYmToNLB7+YFNkm0Ja2zG621Mldhyms1fjo765TuhTwFelsQGM1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959010; c=relaxed/simple;
	bh=Mbx58N76lUGvPh9AcCGpgBhYOcPzWf2TUr+J5FHUBG8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntmcUfryCq0qZnqSasmb7EhCxQXo4yIwwnb5rQh4CdN+URNSTP9MFpaCqLFRzv3BNbHSX9bLURS4cU6YpU1qldBsRWtAJKKcmMqm7z1Jxm33r9hbHnPBbafUDqcdTH8tskFuCmfDbTrzq2oY38uQVdn4sVsicbsWGsPA7DVpM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+CVvUgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719959008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMMbZ/913FEfCX0QedugUqvPu4SJWVMwEkgwhAwO34k=;
	b=A+CVvUgFqyOk6DQwoU9qyvsFBgYgm6yhpU2X7VWUPLqaTD5Y9ewiD9T0UQch89ZeuvnBZy
	v6ThKNAC+TrIyZ4mtXub0N7KcAVRLP8yvw7R85nJDsjHYPnIamgYmmT+BV3UpVEiqOnEez
	/HcfxQRxNIDOhwiInkrA/ixqPp+FTiI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Yp_leRU8Pd-gupyECliQyg-1; Tue, 02 Jul 2024 18:23:27 -0400
X-MC-Unique: Yp_leRU8Pd-gupyECliQyg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3810df375d0so327225ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959006; x=1720563806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMMbZ/913FEfCX0QedugUqvPu4SJWVMwEkgwhAwO34k=;
        b=uXW/Lnz56A56JJzbZE/NTXcIJ/mwJwHwQDtOveWJurV/8jneD/otRnq3clMsmSTO5t
         4S83xuEF/g/xeyo0p3HCzjeXFpbfo9/PzGfBg7X/xfP6ZyBWSUQIrev8TgB7K5k+vZFB
         Nkh7uryftw6RYxzg3s1LstJvzuu3C6dOSCmZynVP0LdIStZ17vUs5JEefu3l8GaFuDW3
         XPsECQkc+xWZwnQ0gaU4MYMRH9dykHTvffUBBiWYMS5g0J7XvA/Uv142Yq30kLoxvcc8
         MBT/pj1nHVEiu6IgV8I+utD0j10gn8s2doFQ+QY2ta+uQDWde76bWNZUBNCXe5xTjSLG
         rXMg==
X-Gm-Message-State: AOJu0YyAx+O5DFFUnsAmIdXZ+3x2lEjXRb58nHQjfHziULCPQsqcadGb
	8J1ZiCxh77l4FlXGT2ouvrYu2MduhTzyXVBem4W6sKwC3JEM/nnpr3xmo9vSpG7qG4uVTIHNX7l
	dvv1K4OVEYitxtT8LoMrB1LlGxippLE+mjjEPHNjQ0qnIUTCIFZKVysy5TJwxdW+K+UPl89miga
	reEcMt40R0yjUA0ZDCnbXWh8CHZRqJKZCA8zMbkf7bnodU3g==
X-Received: by 2002:a05:6e02:144e:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-37b29465921mr74128545ab.4.1719959006061;
        Tue, 02 Jul 2024 15:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGI6kbwONNLJRyeKi48NJGl3IAzMb0xdlSqDezHsDCkjtN7wFR98Wd+qJ8bdPEq1hjHH9mlw==
X-Received: by 2002:a05:6e02:144e:b0:376:3ece:dc5 with SMTP id e9e14a558f8ab-37b29465921mr74128415ab.4.1719959005615;
        Tue, 02 Jul 2024 15:23:25 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1ce6sm3051101173.177.2024.07.02.15.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:23:25 -0700 (PDT)
Message-ID: <4e1a4efa-4ca5-4358-acee-40efd07c3c44@redhat.com>
Date: Tue, 2 Jul 2024 17:23:24 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] fuse: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
References: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Content-Language: en-US
In-Reply-To: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/fuse/inode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 32fe6fa72f46..d8ab4e93916f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -740,8 +740,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_string	("source",		OPT_SOURCE),
 	fsparam_u32	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
-	fsparam_u32	("user_id",		OPT_USER_ID),
-	fsparam_u32	("group_id",		OPT_GROUP_ID),
+	fsparam_uid	("user_id",		OPT_USER_ID),
+	fsparam_gid	("group_id",		OPT_GROUP_ID),
 	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
 	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
 	fsparam_u32	("max_read",		OPT_MAX_READ),
@@ -801,9 +801,7 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		kuid =  make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(kuid))
-			return invalfc(fsc, "Invalid user_id");
+		kuid = result.uid;
 		/*
 		 * The requested uid must be representable in the
 		 * filesystem's idmapping.
@@ -815,9 +813,7 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_GROUP_ID:
-		kgid = make_kgid(fsc->user_ns, result.uint_32);;
-		if (!gid_valid(kgid))
-			return invalfc(fsc, "Invalid group_id");
+		kgid = result.gid;
 		/*
 		 * The requested gid must be representable in the
 		 * filesystem's idmapping.
-- 
2.45.2



