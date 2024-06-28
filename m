Return-Path: <linux-fsdevel+bounces-22704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483BE91B361
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A5F28424F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6074428;
	Fri, 28 Jun 2024 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R46wQbfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C041860
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534461; cv=none; b=JrFHuRHlepNuXD4cIhsiNWhLLANuDd5rpAHojV64niShBvU3K5DMGgFdawc+pH6w1qglbhlL0S3QUpFRPsZ8O/IQDcAxhNfO+QOucFwB3m3BbElwspH4Kk9TCQ+vVqJQYGdjT+q52B3wvYBD7fhHdVReao3aTL6sOFF+czwceyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534461; c=relaxed/simple;
	bh=6cKqtCpH8bqxXYQecoEwGzK0ITdWxgDV+Gl1s1fVe9Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZJD4SshVLye0ALxXRsLmcYYpWs7TjAkWrnOUyvRmhxNEPOa7lR9E2F8DNGSbAOvulE+x8b0MOtPrg87izRh1+f/0/LgCcnxxJ4HSIzOrcDeQ7zJ2Fu12Np4pjENIi8sBpRBlnmMWRZHSUMDhVss5+fCQox46wURwOa5SLV6JbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R46wQbfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAKbKmRLSwctjf83mRn6yEmbgLL+aa60ltLEMmxDMiQ=;
	b=R46wQbfx2D7NWpMZxwXaxcGjYixxlhEswZo4lejJ3/53deIWQlo5bvPvWDTnVOPJav9541
	WesKOFHoSoPrROvZmH+dg6er/lmFde4b0m8yBzwCG3cJhr+noJdg6Rdm7D23sBQWulCJop
	BREpy3mmHWAu/MzTxpyQTzqjE2dacL8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-4W4jugC1N1C0RpqoJOntVw-1; Thu, 27 Jun 2024 20:27:37 -0400
X-MC-Unique: 4W4jugC1N1C0RpqoJOntVw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3cb65d1bbso7370539f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534456; x=1720139256;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAKbKmRLSwctjf83mRn6yEmbgLL+aa60ltLEMmxDMiQ=;
        b=qKZq3ReVhszDFKxB35geJ/tGPlR4g1P+zdMi5Vqq2kcsidSzu4benPqbI4LRxRGg8y
         U0PraTFVcaluWzIcAeGi7CHzzeif5bTXnZCR1q6Ag6nDynuzkeNzu8UAUbRpmWQEAWDu
         mfi4BZLChfusMuD5tFEqmqzZ4n0lPIYYg8aVOmS+Yvxu6OwZVdG1Ft2EUrzLayoyqi1z
         oMEYe79aS6P9VCEqQyvGDJVFKMWZcFhUXW4/87nT9TTLXdMhpLajqIFAeanxWEpit1/C
         7HqywkkHZs0ormjNwjEpdUoOKnLjyOMWINRN3grC0mZ5zBbtkfeS0xoaUuetRT+Zr+7y
         8/vg==
X-Gm-Message-State: AOJu0YxQmivYzaP9GXLCuXWFVb2oyqNlJdi6NWklOcr6x+y/z2Ix3fU+
	+UQNpiGZ3KXt68rKdp0Vr+TlN0LDVqmYcXuAR2gNoElJuqJaxswfl3J7WX/0fgZwiqUsW4pJfcw
	AX5J3HWm9GYbJw+1DIYB7l9Y7wehImzQqMvidYHDBASMA5/TDsolZH8GUNauNKR+Xnwe9f2wAp8
	4o3ypIAffbmxDEAHoBRY6hC4ZWzWQxqt1YGp/ZZkWAaNjlww==
X-Received: by 2002:a6b:5018:0:b0:7eb:71bb:6f6b with SMTP id ca18e2360f4ac-7f61f4c37b1mr7866539f.3.1719534456588;
        Thu, 27 Jun 2024 17:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx110DNHxTSreLctRcWiK2JHDrIX02c4cFkG8VQlm/XKUsIS+lOqf2FRUbQYTrkIFM5D53jg==
X-Received: by 2002:a6b:5018:0:b0:7eb:71bb:6f6b with SMTP id ca18e2360f4ac-7f61f4c37b1mr7865439f.3.1719534456175;
        Thu, 27 Jun 2024 17:27:36 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1774sm214540173.160.2024.06.27.17.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:27:35 -0700 (PDT)
Message-ID: <faccdd51-07d6-413f-aa55-41bb0e7660df@redhat.com>
Date: Thu, 27 Jun 2024 19:27:35 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/14] autofs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---
 fs/autofs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 1f5db6863663..cf792d4de4f1 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -126,7 +126,7 @@ enum {
 const struct fs_parameter_spec autofs_param_specs[] = {
 	fsparam_flag	("direct",		Opt_direct),
 	fsparam_fd	("fd",			Opt_fd),
-	fsparam_u32	("gid",			Opt_gid),
+	fsparam_gid	("gid",			Opt_gid),
 	fsparam_flag	("ignore",		Opt_ignore),
 	fsparam_flag	("indirect",		Opt_indirect),
 	fsparam_u32	("maxproto",		Opt_maxproto),
@@ -134,7 +134,7 @@ const struct fs_parameter_spec autofs_param_specs[] = {
 	fsparam_flag	("offset",		Opt_offset),
 	fsparam_u32	("pgrp",		Opt_pgrp),
 	fsparam_flag	("strictexpire",	Opt_strictexpire),
-	fsparam_u32	("uid",			Opt_uid),
+	fsparam_uid	("uid",			Opt_uid),
 	{}
 };
 
@@ -193,8 +193,6 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct autofs_fs_context *ctx = fc->fs_private;
 	struct autofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, autofs_param_specs, param, &result);
@@ -205,16 +203,10 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_fd:
 		return autofs_parse_fd(fc, sbi, param, &result);
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalfc(fc, "Invalid uid");
-		ctx->uid = uid;
+		ctx->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalfc(fc, "Invalid gid");
-		ctx->gid = gid;
+		ctx->gid = result.gid;
 		break;
 	case Opt_pgrp:
 		ctx->pgrp = result.uint_32;
-- 
2.45.2


