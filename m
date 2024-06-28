Return-Path: <linux-fsdevel+bounces-22715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82F91B435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683C42817C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDCCA40;
	Fri, 28 Jun 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUMcffQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CB4C7B
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535250; cv=none; b=r/dcr87TackAwwMFmBJqTYs061pAUVwWM0R9nQJMIfCYApsO3lcqtzjto90mcjsCGsibPuW6WJXzSVHlChpjFU3gxHpXgc//lzDv5csHG8ee15jhJjvGHS67p+2CCekIqr1053H1T0OPb444Q2ND9jjpNmo2ZJFcIOJvJjIir40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535250; c=relaxed/simple;
	bh=Xv8gun3l3UQeFDGlNKxjbcBxzvE7uW/YCpmcLt2vJf4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oJ2hBsG/RAu4VV+MFNtLHU3+qD7FECt7KI2XlDcFVxLmAOUdeYnTUaeC/7bK4cwA9rF6/zKW5T1H09fDUeiqwCgfaikraIkgY8TWWA2L5Hxu9XhtLHplxJejjaz5AHkfWZxNNX4eTOvEmCPw5IrTxnaFpe+03aXrMSway96TlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUMcffQX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Unk1vGLR1Be3cNBuySBujecQ1IeVxttlaXhutd1cek=;
	b=HUMcffQXU3qnMIBE2p6m9B7qWBcpsZ9YtiobHoS0wrnxAEXJM60YSsx8WNDwAYXVp+krvm
	dUXMtzCn+uBzaFPE+WVbUzxbLFbEPWwpreTgFyH/tDFAx5YM0MtPtTClMeep4Vi9hQZwVn
	bwuhX1wHkrIXag5RRMqpR2L13BME6u0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Nbq9UqU2Pjyy-yqfgJS23g-1; Thu, 27 Jun 2024 20:40:46 -0400
X-MC-Unique: Nbq9UqU2Pjyy-yqfgJS23g-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3ee909so1350325ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535245; x=1720140045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Unk1vGLR1Be3cNBuySBujecQ1IeVxttlaXhutd1cek=;
        b=obpqs3LK5qsLEck/VmpqkfDtmi+QkzqOfioPvysgTcXFouNZW7+OXzYws2fa0rctWs
         Bsg3XC8cZiABSdIC07dOVG2c0iUOeOt5iLbyChgSv8BrYk43/LQqKzUjHT59SDpOyKvL
         /ELPRyY4w1+e0ZgjK9gwKYnGUj4SYBTBISZFtykxQIXCS2xtzkOPhpyzn+sqefyJWFN2
         BY5f1rE96/ajAF+/K/P2X2fkeVPBSy0nBFA+f5+ZmcvJWIZkYGcUCOj0Sdo0W2fQGr0o
         dsUGhT8t/GrceMb+8GWglEF5yQizNXGXzst10aAlYQ+YuFVWvUKusW6GRreECGcJetXi
         pn4g==
X-Gm-Message-State: AOJu0YySqoOIBbPEt0HyBY5IDr/xiyrZeOgXc+uiqZJM0K8ZPhZC3Q6x
	ECUwyivEMy/BHIt4bq6F7iX51DOBeLkcyHyIhlOuPJYNK61xbALNS1n+tsZSFG3vrQGpNrpjCtx
	OBZnpChS6peQiv4U9S4BbdwjETR51EMuRHhfGEwA9MJfKbfjGeJSJcjUkrzerTBMrM/1aBouKk+
	QpfIA6Pqsb2IXpSvxYLkvQfvVEILEtcWf9JQ++OfFJd1Qt8A==
X-Received: by 2002:a92:c56a:0:b0:375:b381:9acb with SMTP id e9e14a558f8ab-3763b34fe73mr188912145ab.30.1719535245219;
        Thu, 27 Jun 2024 17:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh9UG4ASP/yXk4fz3eeE0HY6mTqWEdaPkoaUz2MCu4nPDeuH3H/jqqW6WuJ5Q6wUHkbfa/OQ==
X-Received: by 2002:a92:c56a:0:b0:375:b381:9acb with SMTP id e9e14a558f8ab-3763b34fe73mr188911955ab.30.1719535244811;
        Thu, 27 Jun 2024 17:40:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f41329sm1773545ab.50.2024.06.27.17.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:40:44 -0700 (PDT)
Message-ID: <6c9b0b16-e61b-4dfc-852d-e2eb5bb11b82@redhat.com>
Date: Thu, 27 Jun 2024 19:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 13/14] tracefs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/tracefs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7c29f4afc23d..1028ab6d9a74 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -296,9 +296,9 @@ enum {
 };
 
 static const struct fs_parameter_spec tracefs_param_specs[] = {
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
-	fsparam_u32	("uid",		Opt_uid),
+	fsparam_uid	("uid",		Opt_uid),
 	{}
 };
 
@@ -306,8 +306,6 @@ static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param
 {
 	struct tracefs_fs_info *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, tracefs_param_specs, param, &result);
@@ -316,16 +314,10 @@ static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param
 
 	switch (opt) {
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalf(fc, "Unknown uid");
-		opts->uid = uid;
+		opts->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalf(fc, "Unknown gid");
-		opts->gid = gid;
+		opts->gid = result.gid;
 		break;
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
-- 
2.45.2



