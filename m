Return-Path: <linux-fsdevel+bounces-22711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C420491B42E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81547281A8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878F208A0;
	Fri, 28 Jun 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQ1OdOsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC301BF50
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535012; cv=none; b=Zq6/xVbS0T5XHe091jZL39lOhaLgWIjfRBb8a2R6ZU4Qvmf7UxX3bh1BnrB9RywBwaOInNbj1n+SOtaETI2Rgsv3Md7QUprc/lHZPFInszLB1jsx9UdC/BZA2bY9q+hKrYnd+byuBE0TX6T3c2W4wmmPWGI+i5H5Hf4qA2oez9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535012; c=relaxed/simple;
	bh=sQQl/VZkA4HWR9CyQ6uX05OLO58/QyhZXouv4KpZh38=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KnErbXCzhSkTMhsn1MPpOjl+PLt5JGGChP7c2oJ1IfCvuwAKjC2T9YvQTn19cPvgj6x09+KgTI7ao/wwTmr9/lLH++QCg/1R8btcT9l95apJS5wpjpmEk9/8KxGvoAARATAXkzsn7MhalSbdTM1hzSJjLMyLHwd/FmAh/NlOi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQ1OdOsS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8HMgmWto9s6viH/+SjxOue/JAoKhgQHCg5Kd6Ay2i0=;
	b=fQ1OdOsScDGr4gDWv5qfdFwD3mm/HuUazVhx7WtMXbeMK+aIBV8iD+QlN0R8jwDaBYxkKz
	9oBqGBlgK5d7jeAj0Wbq/4AlzLGLWvAqsmwaEtURC/BhiUBFVD2qOO1zbOk2Gzb3gU0h9t
	aPcylqPLjXLXu6mXH16SNQV8Kn0uStQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-cJFWtg6lPSC-rWue3Z8REg-1; Thu, 27 Jun 2024 20:36:16 -0400
X-MC-Unique: cJFWtg6lPSC-rWue3Z8REg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61da2de1eso5072439f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534975; x=1720139775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8HMgmWto9s6viH/+SjxOue/JAoKhgQHCg5Kd6Ay2i0=;
        b=apXdFt8m+Cwy7gJ45uo9voIji5aYrTNHg48KgVGPeQFYxjoS+p1C4kdSBPiSTGXQnC
         /SQq1CMEPEdPy0tSPDQZ7NsrM1eiP2oEyPZs5hb14USdDeR5IKcyVPfq6MsKZ7jOLuV2
         SvzRBrPpFvORQNd99ThSVPW2yLGTt/qYwESFaTuLsyvw7OdA7KCLP4ZCaXWuQTBEkBpL
         yUXTNWyU6QFeh4xv0E6zlUtbLhcmwqmZfazpTTCFMHl13mxNN6oMO4w+99Y5jTCyE04N
         OCIrN2vlC9sHpu2u/Pnb7qU8BZAtwICPGpDkxKGtczi1SZhp/+QNSIVer4P6F9pd1H/t
         vEQA==
X-Gm-Message-State: AOJu0YwLQ25nE18/LFlJ0oeTnHxA7Vg4cWmEaAZ7qpCfrHEtAOb/Lrmi
	SJCalbJSpFpbGwJi2Pq8jZCdemxAtuwgAS0iHDhS7+inDY5kWJLmlsFwlpUJD8Q5ZxqlfC6DtOo
	wSGeMhydO2dqEUeQOfo896fm8YS3fyT5d5PLcPzkLUF1XZrKBj78oJ+Wf5Wa/Kl4ABiHL96Lx7j
	DKpzQGS9dR5L0ClfsG9r8jBu1U62UOXjNQmrz+5OUVTTbJQA==
X-Received: by 2002:a6b:6513:0:b0:7f6:1d7e:a9c9 with SMTP id ca18e2360f4ac-7f61d7eac73mr98537539f.6.1719534975467;
        Thu, 27 Jun 2024 17:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVmrxmGHTN77xyBvsNCRip9PfxH3HGoiT5m4TtdeHqRU1DrdFs66Ypzp6P4cDe7Un7vKV9sA==
X-Received: by 2002:a6b:6513:0:b0:7f6:1d7e:a9c9 with SMTP id ca18e2360f4ac-7f61d7eac73mr98536339f.6.1719534975027;
        Thu, 27 Jun 2024 17:36:15 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9d928sm18531739f.15.2024.06.27.17.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:36:14 -0700 (PDT)
Message-ID: <3e57caa1-33e0-4456-8e07-60922439e479@redhat.com>
Date: Thu, 27 Jun 2024 19:36:14 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 09/14] isofs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Alejandra Bujniewicz <abujniew@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/isofs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 93b1077a380a..ed548efdd9bb 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -326,8 +326,8 @@ static const struct fs_parameter_spec isofs_param_spec[] = {
 	fsparam_u32	("session",		Opt_session),
 	fsparam_u32	("sbsector",		Opt_sb),
 	fsparam_enum	("check",		Opt_check, isofs_param_check),
-	fsparam_u32	("uid",			Opt_uid),
-	fsparam_u32	("gid",			Opt_gid),
+	fsparam_uid	("uid",			Opt_uid),
+	fsparam_gid	("gid",			Opt_gid),
 	/* Note: mode/dmode historically accepted %u not strictly %o */
 	fsparam_u32	("mode",		Opt_mode),
 	fsparam_u32	("dmode",		Opt_dmode),
@@ -344,8 +344,6 @@ static int isofs_parse_param(struct fs_context *fc,
 	struct isofs_options *popt = fc->fs_private;
 	struct fs_parse_result result;
 	int opt;
-	kuid_t uid;
-	kgid_t gid;
 	unsigned int n;
 
 	/* There are no remountable options */
@@ -409,17 +407,11 @@ static int isofs_parse_param(struct fs_context *fc,
 	case Opt_ignore:
 		break;
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return -EINVAL;
-		popt->uid = uid;
+		popt->uid = result.uid;
 		popt->uid_set = 1;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return -EINVAL;
-		popt->gid = gid;
+		popt->gid = result.gid;
 		popt->gid_set = 1;
 		break;
 	case Opt_mode:
-- 
2.45.2



