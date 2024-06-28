Return-Path: <linux-fsdevel+bounces-22712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529291B42F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22841283D02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FBC225D7;
	Fri, 28 Jun 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV7+w2up"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221F224DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535072; cv=none; b=hCnuP0M+MgUM1QPaI52eInjQfp/EqwYCDwAF9rgXFlFS6PY/tzT1wlF7JbFHbzibwethBqA1dOpC3J7eFWDVE9LClr7WFNRWRmY+SRE7WASC+pV7VRnGA9lhmGpzfRUcOYkWcVECoNH9GEapSMi5dIpf5R+0QFEvRI11RABUxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535072; c=relaxed/simple;
	bh=T9giCEeQe9O8JFgY1dAQ7TEqaknAFm0RMHXlWCjwxCM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hjDJK2yJ1uN+rCEDlJ1IkJA+S+9DrYiNXyAdwXt1bocuw7xTQNrfeZW6LaniwbViio/wCDk91UUTbkj95F5cbCtj2ceKMUXc5Ge5mvqEH9sSNqqkMLpl2zGNelRjJv4zH4HaacCcYUnoazDqMIi1ZpELcewXA6cLl+hjGaAdqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV7+w2up; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQhMiTQyhSFYcIKwGIviJG1vL1dNkSkhvAxcEpR5AZU=;
	b=dV7+w2upqQS5raPYmc/Xh+NVfrZ06RNiSl/XERSOKeOD+p3+7e0orf+gbCyeS3NWHS5lHP
	fSY3OnOehWhViYHC4e9Yk0f1Fz1hqLMRmKfKgxB8AXXpl5nRPX51WvrlfrhCO1jLMuEKBR
	E3esNcf4Ih26RLm1wcsw/Was9CtlgCo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-cpWUIslOPhSgtfwzcVaddQ-1; Thu, 27 Jun 2024 20:37:23 -0400
X-MC-Unique: cpWUIslOPhSgtfwzcVaddQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3c9764edbso3672739f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535042; x=1720139842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQhMiTQyhSFYcIKwGIviJG1vL1dNkSkhvAxcEpR5AZU=;
        b=eZjX1zNhr4F7xGiFP2B+2iImOKNm8rNbJmlgr6q+LUHBZXUg6pMo94uS/tEy8Fzh+P
         7jJ/ukLdP/Z4eL8MSFeTNq0fWTaoLHJ0j3QA+xJ3s5i2XTkYBC4JCFb4CNrUFSwNtGj9
         rYSIOJUKD36dCLGAhs2vXxS0PakEAEyha4OXMleZuY7W3/ogRtHG8VMQ8amdcL1yVyLx
         3/a6QOxDJ0qDQpihNWQhYuEbTa7T5T4Ozu8hYXEUm74MV5mKqbHqDG5rFK0ydtKbj+le
         Je/NIGU2R4969C1z/1KDLvDRNdiR3iq9/GR/JoellX148syAY/aZznTHxpHQBus1dUsK
         8IFQ==
X-Gm-Message-State: AOJu0YwNIBGUvgJ7uxDKElZ8yr6YFdi+me5Jh90nB/I7hDHGZppR7KrO
	+Cz3zzJls3hUXYCkEyVosU4FPFwdl7GXiAvbgSPVsvBlDNqchxd7PPkO2cUselJSdhj5kKkcVTR
	jgYSpiXBX+REEKkunnz8njEzYgqXk6eyfqNxKvxXk7yeLmQU7Z8folsYpQG7cNizY03J6Iv7nGO
	4498Gp1aKCkU3UZokWtZOpva7rpQHUE/9lDBHoOYRUQcNcfA==
X-Received: by 2002:a6b:7010:0:b0:7f6:1b9f:8939 with SMTP id ca18e2360f4ac-7f61b9f8cecmr145464739f.7.1719535042404;
        Thu, 27 Jun 2024 17:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTaAADBARuSKBG3oQZT/2IZEnJcQm2Lvl9Dt7upSPBZW1npZEvY8uH0LWguSFbG15wJ+Z0dw==
X-Received: by 2002:a6b:7010:0:b0:7f6:1b9f:8939 with SMTP id ca18e2360f4ac-7f61b9f8cecmr145463439f.7.1719535042046;
        Thu, 27 Jun 2024 17:37:22 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1774sm218559173.160.2024.06.27.17.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:37:21 -0700 (PDT)
Message-ID: <04bf30db-8542-48dc-9060-7f7dc08eda22@redhat.com>
Date: Thu, 27 Jun 2024 19:37:21 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 10/14] ntfs3: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: ntfs3@lists.linux.dev
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ntfs3/super.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 27fbde2701b6..c5b688c5f984 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -259,8 +259,8 @@ enum Opt {
 
 // clang-format off
 static const struct fs_parameter_spec ntfs_fs_parameters[] = {
-	fsparam_u32("uid",			Opt_uid),
-	fsparam_u32("gid",			Opt_gid),
+	fsparam_uid("uid",			Opt_uid),
+	fsparam_gid("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
 	fsparam_u32oct("dmask",			Opt_dmask),
 	fsparam_u32oct("fmask",			Opt_fmask),
@@ -319,14 +319,10 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 
 	switch (opt) {
 	case Opt_uid:
-		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(opts->fs_uid))
-			return invalf(fc, "ntfs3: Invalid value for uid.");
+		opts->fs_uid = result.uid;
 		break;
 	case Opt_gid:
-		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(opts->fs_gid))
-			return invalf(fc, "ntfs3: Invalid value for gid.");
+		opts->fs_gid = result.gid;
 		break;
 	case Opt_umask:
 		if (result.uint_32 & ~07777)
-- 
2.45.2



