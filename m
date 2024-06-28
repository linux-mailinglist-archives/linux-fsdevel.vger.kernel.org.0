Return-Path: <linux-fsdevel+bounces-22716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272091B437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3485F1C216FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E34687;
	Fri, 28 Jun 2024 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLaqlKHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2D3224
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535351; cv=none; b=uVF0OpApuTK06JklRORx0xirwNe9WYVbkIe1Ol3znvDTelOK7eviRTaT/CMGNwrBpnp58zd+G3+WdX95JS6Khu7XO1mC1dLQq/oWD/VvyRMB3VjEWYk3C4vMCv5Oa3lUxaTw+Umu8Svsm/0gGYmUm3F0xFDqtipXgBOcH7KK7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535351; c=relaxed/simple;
	bh=9JlM5wD2SXCrnmtQMestnllMmYEow+klcJ59N8yGv6U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Exc5SlT2sSS5UIZcZxaRvm/6x0Yf0riJcOor+F4Tl6H9Y27436g4F/rxHj/IDXJweJ4x+VlH/9MdfqWScKEZvYdZ7VwscmEIuj2pcBoiO1X76eb10R5DieX0lhUgz5xFCBGmnHxtraKmI4orKr8s6VVpGj1bZa3dP0SKf2ovrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLaqlKHL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIA7+ZRXeTWeMHotFYiEOy3m4rzA2+Fpd4H8n272VYw=;
	b=TLaqlKHLEd9SGCF7L8h+HZaoCvrcOr3Ltwh+f7VQH/diT156WlZYyCangW2zHHgzHuSqj/
	IQnP62q+upLab7gjm+v85i63BEPS7I4KQJmH6LwA9lobpbNmpijxESf64wp4QxhdDKTYgt
	0ftkMGEmjLyhfhio7+Q7b/PtizWpe/w=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-t9JP0e7MOaGqBCtRXVSjTA-1; Thu, 27 Jun 2024 20:42:27 -0400
X-MC-Unique: t9JP0e7MOaGqBCtRXVSjTA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso6118439f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535346; x=1720140146;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIA7+ZRXeTWeMHotFYiEOy3m4rzA2+Fpd4H8n272VYw=;
        b=ibV0CbB9OHlIG+r6MN0s0Om9aTuu0Rs1qNpc6kj4evNOhCRnPX695VbNDopswy+m9C
         AOkCDBGG5K+jFW7uP3bI8mSTy0CZA896K+fl87iG/FNcESSOtMoUXBlNhfcTzlVgGPa8
         R8CcIjp3gLsX9cmNpUAACWy9Z6/vnl+aCVrEiAtG+EPZDG7Q6uS7c6AHDx6XC2fTp0Lp
         Mzgo0e0A0mYvKrQM2+cPvdpwNNUGPBRHf0KGVnnpYJCBcXFFk1m0HzPzidZn1iQMSBvM
         qFV5lOPgsKwEBJHVyKQeW95CJF9SeCS/zVGiDbnEadrAKEbzg+N3A/GHJjyGZHWGPhto
         C1AQ==
X-Gm-Message-State: AOJu0YyVE98qs5fULDfY/Td9TVm/lX7IqpOelvDsfXthRSkAGSF0nT3N
	EdzRXlR5XScw2Q4FwV2uKX8LcwXbQgPP99eHAttGRFuxho2CP6ExpJe1dBsMIubb+PQFgXHV2lj
	1qJ4jq3dO0slYO5guK9AXG0eChCIKIGeyeLA1NCEhvLqEO0px1QSbupryidxr7dO7gRIzpqVU4t
	1o52Jjs10gwf1KjhjFKaByiLbR2IeO7hhXhShJNGN0vT+JwA==
X-Received: by 2002:a05:6602:1648:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f3a4dda0d6mr1937854839f.11.1719535346209;
        Thu, 27 Jun 2024 17:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMedkXRgCs6D2PWTWIjckfA96S4jfjSC4LMilhDSbNUt6OxDRh8WhB4XXkMDeTvbgzVSVoVw==
X-Received: by 2002:a05:6602:1648:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f3a4dda0d6mr1937853439f.11.1719535345820;
        Thu, 27 Jun 2024 17:42:25 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce87f69sm19355839f.1.2024.06.27.17.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:42:25 -0700 (PDT)
Message-ID: <58862d35-a026-4866-ab7f-fa09dda8ac1f@redhat.com>
Date: Thu, 27 Jun 2024 19:42:25 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 14/14] vboxsf: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

From: Eric Sandeen <sandeen@redhat.com>

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/vboxsf/super.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index ffb1d565da39..e95b8a48d8a0 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -41,8 +41,8 @@ enum  { opt_nls, opt_uid, opt_gid, opt_ttl, opt_dmode, opt_fmode,
 
 static const struct fs_parameter_spec vboxsf_fs_parameters[] = {
 	fsparam_string	("nls",		opt_nls),
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid	("uid",		opt_uid),
+	fsparam_gid	("gid",		opt_gid),
 	fsparam_u32	("ttl",		opt_ttl),
 	fsparam_u32oct	("dmode",	opt_dmode),
 	fsparam_u32oct	("fmode",	opt_fmode),
@@ -55,8 +55,6 @@ static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct vboxsf_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, vboxsf_fs_parameters, param, &result);
@@ -73,16 +71,10 @@ static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		param->string = NULL;
 		break;
 	case opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return -EINVAL;
-		ctx->o.uid = uid;
+		ctx->o.uid = result.uid;
 		break;
 	case opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return -EINVAL;
-		ctx->o.gid = gid;
+		ctx->o.gid = result.gid;
 		break;
 	case opt_ttl:
 		ctx->o.ttl = msecs_to_jiffies(result.uint_32);
-- 
2.45.2



