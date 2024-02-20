Return-Path: <linux-fsdevel+bounces-12183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D585CA26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 22:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA821C20BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40220151CEA;
	Tue, 20 Feb 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOEYFCcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1314A4C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465408; cv=none; b=gYulx9fd9xcvISrJiTohGrk9CEeqjiKa98tLjFyz6Kq9FcNuOOIoaZVLlWztMWB9o+uqXqNRC7AWLKmgl25kpgR7qJDeAg/rVKqWi4l8W8ifeYFhAIwF7BW7im9LGbcEVE0Szgm4hrqwKAEINcFl+kcF0+ioLAqhkG6pdvXpySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465408; c=relaxed/simple;
	bh=40b6PUhYU84dL4uyVdWron9ibcIh+/wsz4NHREQuozY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DW+xuK8UM1Mr+ZQSPwJlQzJexSQQzK0YPUpe7MzHInJhIps6zYoKNpA80ecyJsrlRPyEYNI7pA3fSpRKZyOOXhz3TkZ0eBmwD0zAUJWoJ8CTXidP3tdD17Vr3VBw0jrIQEwQmV/JC7ZI2x8gYhEUGv5Xrakon3jaJolZA1ZRR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOEYFCcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708465405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixymZfO8ZAeVdrmnk2mKGVa7zupI51VEqO/jUJJUIZM=;
	b=WOEYFCcLNm0rGiRON5wtazGo2kwo+KyVmOB2NcT3t60bQTpA7nBWJjWesVXa3XveBDOSbn
	6qm/Z3kGLnvG14WF8kqe9QO98zEO+qtPQ2DS48EHpiQjtK6ud9epRHwsZPDLrZ7xnYD2pE
	OGjKwAxcFpgDT0GWk600X0t01OvQq3I=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-PYCptMtiMzaB_jIIotqXRg-1; Tue, 20 Feb 2024 16:43:24 -0500
X-MC-Unique: PYCptMtiMzaB_jIIotqXRg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so420122739f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 13:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465402; x=1709070202;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixymZfO8ZAeVdrmnk2mKGVa7zupI51VEqO/jUJJUIZM=;
        b=tj0TGfIzt60NC0sxPaMr9E033ZA6zoh9G1wBatQJWpH0+sWXzt1BkzvaDFbBfXzWQY
         fsh6Fq1tpTsbNHvScva0jr0D97Zxj9SrOF7XMMQmZNWglytV9SXU1498hm9wDmAJQZul
         1D2NO2/VxsPr/i7VLjJ+iWVrZeotfrpT3x52Wqj595YpGRN4EDkGtkQp94oJ6t5ejCjp
         I4y1D0ZMSbZ0lfOu+4b+tTd9e8nUp8RItcY9cgtHF9ga+F9j19CmzkisnpP2cn0vskJ1
         HoEAJTA1zfAg5bO+IwIK7jm2O9IGr1bOdSN5Cxl8W55gRImOzDoCsiG6X7Vup2rDEASS
         Yxng==
X-Gm-Message-State: AOJu0Yx5EuR9dnGWcH9W5GM7JMJCI/JXDB4uqLO8CT/YdRI/KJ5qPvcD
	8mORz4vU8rPpU2BGoyqG5OD+j0DNiCIemsVyl3OCXUhfmKQBj7pH0y74vo9fBql8K6gmocwtc6h
	W0wMv0sO5LABgq6c2j1EZmLiUSNc/J2ysHRmWoEhciaFrIMtk7sZ4e7kyqYy4bxAFFxg0A0SYOL
	pAOvjhKowP9PUfxcdgIR8qPI/IIO3f1mzsfAkSzyw6XFnZ2A==
X-Received: by 2002:a05:6e02:14f:b0:365:1fa4:1b41 with SMTP id j15-20020a056e02014f00b003651fa41b41mr8937356ilr.15.1708465402699;
        Tue, 20 Feb 2024 13:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYSIcoQF13CxEcd76W3BuhHx0igmPMYYHerv7OtxP0H6SDbkjip/EeMxW2MWTg7cA7qoyyCQ==
X-Received: by 2002:a05:6e02:14f:b0:365:1fa4:1b41 with SMTP id j15-20020a056e02014f00b003651fa41b41mr8937344ilr.15.1708465402344;
        Tue, 20 Feb 2024 13:43:22 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ck9-20020a0566383f0900b0047436275c32sm715164jab.1.2024.02.20.13.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:43:22 -0800 (PST)
Message-ID: <b5d53492-b99a-4b3c-82c0-581df9a9e384@redhat.com>
Date: Tue, 20 Feb 2024 15:43:21 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] udf: convert novrs to an option flag
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
 Bill O'Donnell <billodo@redhat.com>
References: <ecf5bc91-69fc-45ce-a70c-c0cd84c42766@redhat.com>
In-Reply-To: <ecf5bc91-69fc-45ce-a70c-c0cd84c42766@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There's no reason to treat novers specially, convert it
to a flag in uopt->flags like other flag options.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/udf/super.c  | 6 ++----
 fs/udf/udf_sb.h | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..5b036c8b08a8 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -209,7 +209,6 @@ static const struct super_operations udf_sb_ops = {
 };
 
 struct udf_options {
-	unsigned char novrs;
 	unsigned int blocksize;
 	unsigned int session;
 	unsigned int lastblock;
@@ -461,7 +460,6 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 	int option;
 	unsigned int uv;
 
-	uopt->novrs = 0;
 	uopt->session = 0xFFFFFFFF;
 	uopt->lastblock = 0;
 	uopt->anchor = 0;
@@ -479,7 +477,7 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_novrs:
-			uopt->novrs = 1;
+			uopt->flags |= (1 << UDF_FLAG_NOVRS);
 			break;
 		case Opt_bs:
 			if (match_int(&args[0], &option))
@@ -1946,7 +1944,7 @@ static int udf_load_vrs(struct super_block *sb, struct udf_options *uopt,
 		return -EINVAL;
 	}
 	sbi->s_last_block = uopt->lastblock;
-	if (!uopt->novrs) {
+	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_NOVRS)) {
 		/* Check that it is NSR02 compliant */
 		nsr = udf_check_vsd(sb);
 		if (!nsr) {
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index f9a60bc1abcf..08ec8756b948 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -23,6 +23,7 @@
 #define UDF_FLAG_STRICT			5
 #define UDF_FLAG_UNDELETE		6
 #define UDF_FLAG_UNHIDE			7
+#define UDF_FLAG_NOVRS			8
 #define UDF_FLAG_UID_FORGET     11    /* save -1 for uid to disk */
 #define UDF_FLAG_GID_FORGET     12
 #define UDF_FLAG_UID_SET	13
-- 
2.43.0



