Return-Path: <linux-fsdevel+bounces-70487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC93C9D386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F868349FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956532F7AAD;
	Tue,  2 Dec 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrqAHtd2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuklMzos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468232EB5A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714899; cv=none; b=pskKJZvsJDpqgKsfTfv78ZSiiTEf4JFXGI4Ya+eefCT3jn6ovl312ubFs206b6d2vocKvXR6rLrViBqjWn6q6+9MAAeKS09CvK4dUWp91m4yraEqCmmcrhdFfKmV5fOojycBy0Weiq/TcQo7opqwAa4Vo2VXCZtPV3Of+NiNB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714899; c=relaxed/simple;
	bh=knGCB2QWCi7I+b7T8oml1J2JVo/fTrJd+ijEv1ZyS1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sup6MfZx/Qa0OMYsqxgUvUVvMe+Nhx9rbuoMrqyu0nBQQxHsExKhUlRGjtutURwxmgkle4i8pXPoxjxHUPAT88JX9FZFlUu1WpQ5i1Pecgh9ZMDlpOXMfmGrMNGMc8BzTPROW93apsuwgNIhEBsEMQjqCOF/IxFeOK3PG2ix89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrqAHtd2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuklMzos; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764714895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I75stScld0jImIWnHzAwTuoOvKajHCPvGtn9toaW0BQ=;
	b=CrqAHtd2aqCQ7bjFPTr/Kz8Mx5kTw89CfSUPU8duirv+hJJyenAglk2XNHKoY1fbKEwtUV
	pQrO48rfuxBi6BFKYfotGaxPyH80REs64iLCN7obUGX9w6snGa6DX52db//uO2lkIiw8hE
	MfT3AbDcgj5+r7mTGpUxUbMJhpPl6XI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-TfIVQ_q1O7CPkNrMAac1-w-1; Tue, 02 Dec 2025 17:34:53 -0500
X-MC-Unique: TfIVQ_q1O7CPkNrMAac1-w-1
X-Mimecast-MFC-AGG-ID: TfIVQ_q1O7CPkNrMAac1-w_1764714893
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7c70268301aso2920341a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764714893; x=1765319693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I75stScld0jImIWnHzAwTuoOvKajHCPvGtn9toaW0BQ=;
        b=RuklMzosmMWpFYND4EKJ/yEg3C+xck00vLSxCoHH+klZ83U28t78dX0FwUPcaUL9Wn
         L+G4Hi6UObOEEVJuzPDocPETw5Fqfle7MT/gP+lpYEGtuxEWrpFb+vy9DwAILjOFidFg
         aTvF6KdOIFp0oIiA9IGYq4HxeqG0+nM+O92mM++5b3ssykV5CvovTnAn6kQOqjeKuepn
         7HyHccU6Jy7kQQ4+NokNzAwYvC0FkCuHvstzU75TiuzSiaSNkZ5nsAVZHrfBmEy+THKx
         BH6KZbxnZ216G7vJq0z2APME5hCER4a6/N41LorYtM5C8I02n1oKyXR32bAyOoSom2+n
         FfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714893; x=1765319693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I75stScld0jImIWnHzAwTuoOvKajHCPvGtn9toaW0BQ=;
        b=gqwFTnYP+gRPAcrvRlClmeLJHA3tf3GmdtzOrTmZRVnhe8G73qbL3jS11L53uv6xdp
         fqnhWriLQGbHRJEAk+xn90FJbhNpOVXIMHXTA2kez3AO8yGR/SmaXRnLp9Q6P6C8kRcU
         pb2KZB2PY33hwvk/XTApvcUZZ30Icu4JhZe/ykP6VDwR81TKdz5crv0I4zYMKTR4PkUU
         HFZeHgfPmmrZGZVkIcNiHSvNmYIncOeMrWMou4N2kZuG5oD+eoLwFtKRLE/A/wk6E6xW
         mDvPMyfk9SyqXBt4cUAUZcyRkDcrmGrwqzwzQkEWq4YTCS9VXwCKI4BG6oxe5q7EyORU
         eQwg==
X-Gm-Message-State: AOJu0Yxx1Yef3Hdv/WqyDeTTFhiF5cTqOYIuCrQ3YAUvb5J9TiyUDYsB
	qXU0ycrczzo1kIFzNq/kJFQAaE3pAapWrZn3ph8mjQgSGHlFFM6wPuckhvpsGpMNOnZ6ISigsxL
	qGZp2j5DwEhhuMwXScFC684NCI0BvtwebM5rufLpLknSkGzQGzAT11/NNFgsbjVWzgeo=
X-Gm-Gg: ASbGncvqUGFfDO9H1rtj1B9bwQqDgoprWwYucp8ZAU7vqkR1fN3SYtIhGICVPhbq3SX
	Ta8XwYrl1+pvtAmg7RfwYIti0s/hWHOS32yin0yK6024RpIxcgeR3ytsQSuIdjQmYGgP8EhCesR
	FHpwWA+zxc6WNZkf3IxA70XEBrF49sOZJtg8b0HZrQWQ0963/XVwgHkgNwU9ulFbAhz1xDxcEWS
	ctnUQK+WOKSTVLKphtBWWfDTSiqs69Yrt0u71KQ7LDIaowW4ub7dCc+Pkc97TtK3zk+B1cTSOnL
	t3ZAw2r3HWzLCba7lk3UJDuEcLVXoOiAe0VRZYWMyGjUVXFQTSFGhjq7DwXbpz0qBFcLiAYnX6f
	jXlm/+MQ+5sVEau0+etX33UuNwDuqymmX0vGGmkoUiw6XRkPuAdI=
X-Received: by 2002:a05:6830:310b:b0:78e:a394:ca24 with SMTP id 46e09a7af769-7c94db16322mr243461a34.8.1764714892759;
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBk5xgbqxkiF0SI2w8qIvhL+LUE6hwtLWp1H8RJuryPPzCLFIrSmuLFBL1JZq1IvKtaEk8Vw==
X-Received: by 2002:a05:6830:310b:b0:78e:a394:ca24 with SMTP id 46e09a7af769-7c94db16322mr243453a34.8.1764714892458;
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5d7ba2sm7520115a34.5.2025.12.02.14.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:34:52 -0800 (PST)
Message-ID: <48cdeec9-5bb9-4c7a-a203-39bb8e0ef443@redhat.com>
Date: Tue, 2 Dec 2025 16:34:51 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V3 6/4] 9p: fix new mount API cache option handling
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After commit 4eb3117888a92, 9p needs to be able to accept numerical
cache= mount options as well as the string "shortcuts" because the option
is printed numerically in /proc/mounts rather than by string. This was
missed in the mount API conversion, which used an enum for the shortcuts
and therefore could not handle a numeric equivalent as an argument
to the cache option.

Fix this by removing the enum and reverting to the slightly more
open-coded option handling for Opt_cache, with the reinstated
get_cache_mode() helper.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

If you wanted to fold this into my original mount api conversion patch
so there's no regression point, that would be fine with me as well,
of course. Sorry for the error.

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index d684cb406ed6..dea2c5347933 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -72,15 +72,6 @@ static const struct constant_table p9_versions[] = {
 	{}
 };
 
-static const struct constant_table p9_cache_mode[] = {
-	{ "loose",	CACHE_SC_LOOSE },
-	{ "fscache",	CACHE_SC_FSCACHE },
-	{ "mmap",	CACHE_SC_MMAP },
-	{ "readahead",	CACHE_SC_READAHEAD },
-	{ "none",	CACHE_SC_NONE },
-	{}
-};
-
 /*
  * This structure contains all parameters used for the core code,
  * the client, and all the transports.
@@ -97,7 +88,7 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	fsparam_flag	("noxattr",	Opt_noxattr),
 	fsparam_flag	("directio",	Opt_directio),
 	fsparam_flag	("ignoreqv",	Opt_ignoreqv),
-	fsparam_enum	("cache",	Opt_cache, p9_cache_mode),
+	fsparam_string	("cache",	Opt_cache),
 	fsparam_string	("cachetag",	Opt_cachetag),
 	fsparam_string	("access",	Opt_access),
 	fsparam_flag	("posixacl",	Opt_posixacl),
@@ -124,6 +115,33 @@ const struct fs_parameter_spec v9fs_param_spec[] = {
 	{}
 };
 
+/* Interpret mount options for cache mode */
+static int get_cache_mode(char *s)
+{
+	int version = -EINVAL;
+
+	if (!strcmp(s, "loose")) {
+		version = CACHE_SC_LOOSE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: loose\n");
+	} else if (!strcmp(s, "fscache")) {
+		version = CACHE_SC_FSCACHE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: fscache\n");
+	} else if (!strcmp(s, "mmap")) {
+		version = CACHE_SC_MMAP;
+		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
+	} else if (!strcmp(s, "readahead")) {
+		version = CACHE_SC_READAHEAD;
+		p9_debug(P9_DEBUG_9P, "Cache mode: readahead\n");
+	} else if (!strcmp(s, "none")) {
+		version = CACHE_SC_NONE;
+		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
+	} else if (kstrtoint(s, 0, &version) != 0) {
+		version = -EINVAL;
+		pr_info("Unknown Cache mode or invalid value %s\n", s);
+	}
+	return version;
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -269,8 +287,10 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 #endif
 		break;
 	case Opt_cache:
-		session_opts->cache = result.uint_32;
-		p9_debug(P9_DEBUG_9P, "Cache mode: %s\n", param->string);
+		r = get_cache_mode(param->string);
+		if (r < 0)
+			return r;
+		session_opts->cache = r;
 		break;
 	case Opt_access:
 		s = param->string;



