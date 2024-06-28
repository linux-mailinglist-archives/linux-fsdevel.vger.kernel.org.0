Return-Path: <linux-fsdevel+bounces-22707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC0591B366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B98AB20BEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554D3224;
	Fri, 28 Jun 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSGKCtwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E66AAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534717; cv=none; b=thx4ELfCVaGYq+XjfN0jUdFN6NigzkpUNnHp1EhPWAzP6nsgiGRlA/1u/RfzYwIhsIaKPRN0+5S1l56m5S4rfX67TgFPl76wfN8hQaNgpfNymBBxPgOkTyB2rpHdAAmCQ8CR0K4Y+xujjBPUNBZOysr9Q6SBPzU4TvjTLV/B6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534717; c=relaxed/simple;
	bh=HBxVszKikaJWx1gETB5mDKxXYp8rY5DqnfBXy54fyCk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JkPSlvW1Gxxj+p2DVIp+h1Bi7mPaCFTgGV18fXYtE88UZZwi7Xlln+VT9Iz0Yj6UkcUfipFAqjmeO4W53RLi73OLBxypfJ5K+uCbwpa30hWXLX0o5lmzVRf/3Txskx3SPbBE+thVUNm416Q6goF12B1/qMqlTQki/IPu2vaeVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSGKCtwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiPuGUz7hisfeWM28u5JCiXWCiZ4+FNesuTv/XbbajI=;
	b=iSGKCtwMJAV7dc0a/1v6VGdhru66W+0RBlBtqgNDKk+XdLVVQZA43AI9K1P7VU9fkKBJrd
	MBIAUNFGf3Jj1nCW3XGNLfmRXQB/5yetISsvfEeeI/pWdIPeTXa4w5clDaJIgTqDQfYGu+
	GlBwYplJj04nvXUcoDCVzxVbHmI3gB0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-auPlAmFfN42VoFXMAqciXQ-1; Thu, 27 Jun 2024 20:31:53 -0400
X-MC-Unique: auPlAmFfN42VoFXMAqciXQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61fca8c40so3321739f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534712; x=1720139512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiPuGUz7hisfeWM28u5JCiXWCiZ4+FNesuTv/XbbajI=;
        b=wEioNEuDfFOzGYdBVe8iCGrI69xXL3kc4z0KhrxBa7UC15qqb4IuRx6v4KtHVRfNU1
         v2Hy/RdKZaXTc8FGFJxobo8jv3TYb/dIf5HP5vZFoR494j7pvewgpMiAj+sgyQYgykuX
         KJPwB85OYCS2wOFPCw4reQnK7ZliVApWpXadztN+48kNWYoVX3DCl5JPCmG2KSJj1Q1w
         9mpiUzMAu3Lvd+tg5k4IhEYBSWqZbnP6HkEwUG/9oAfMWZZf5TiRyDJlC/N61t8UQqbn
         E0CDsx9WPi1pApLu+HJYTmY0wKQMTIPOpKBL4+Hs8tt7xZNJS0QMc+laTUp41/M9p1nU
         osOA==
X-Gm-Message-State: AOJu0YwGoRRwiDLKChUX97MuOqgvJNBjG2m+rcWD1chRm60wu9rRt5hx
	2/33IF2oaGN6dftYQ7YasJUOjbqv3rtmMAoQr++H3krmsNVZqIKZFG31fNjgBQd4yJVJfZnDAyR
	MZdRZjrV1vEoeTDGRGKN7243OxccER33evRMuapmvBHRhkD2+y1a1u5cHfEmiNyNs8IGOoeQf2Y
	jsR44YNb3hgpwFhK4n6Xkn4lD8xINXWHv6ItZjw/veWS+43g==
X-Received: by 2002:a05:6602:1696:b0:7f6:200a:ba8c with SMTP id ca18e2360f4ac-7f6200abb9dmr1372339f.1.1719534712436;
        Thu, 27 Jun 2024 17:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC2XOb/lNC60hMurxkgKTx4JZiZLcoMlaWGCoAMiFiM5OAIWa8XH0AMUHgZnGSJPesh964Tg==
X-Received: by 2002:a05:6602:1696:b0:7f6:200a:ba8c with SMTP id ca18e2360f4ac-7f6200abb9dmr1370539f.1.1719534712072;
        Thu, 27 Jun 2024 17:31:52 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e05e31sm223150173.73.2024.06.27.17.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:31:51 -0700 (PDT)
Message-ID: <dda575de-11a7-4139-8a25-07957d311ed3@redhat.com>
Date: Thu, 27 Jun 2024 19:31:51 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 05/14] exfat: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/exfat/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3d5ea2cfad66..a3c7173ef693 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -225,8 +225,8 @@ static const struct constant_table exfat_param_enums[] = {
 };
 
 static const struct fs_parameter_spec exfat_parameters[] = {
-	fsparam_u32("uid",			Opt_uid),
-	fsparam_u32("gid",			Opt_gid),
+	fsparam_uid("uid",			Opt_uid),
+	fsparam_gid("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
 	fsparam_u32oct("dmask",			Opt_dmask),
 	fsparam_u32oct("fmask",			Opt_fmask),
@@ -262,10 +262,10 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case Opt_uid:
-		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
+		opts->fs_uid = result.uid;
 		break;
 	case Opt_gid:
-		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
+		opts->fs_gid = result.gid;
 		break;
 	case Opt_umask:
 		opts->fs_fmask = result.uint_32;
-- 
2.45.2



