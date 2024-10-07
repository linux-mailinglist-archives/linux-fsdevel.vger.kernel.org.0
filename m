Return-Path: <linux-fsdevel+bounces-31249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB388993670
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FEFB22B97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211781DE2CB;
	Mon,  7 Oct 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMJ1L/MD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CB1DE2B7
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326638; cv=none; b=bkuxVLoIo9IHdyIUpmXmSUV4kHo5kygT5urjXpuvTXfXJmpTTi2WE4vy+YKZMFCfl8CBMfCFybEEfOroWWyXNM0kFZY6raU+dCGHnAGJgERuP8rrfkZN76Q6j0Y8eIKMoM+yrY50qfY9Pf4RMrx5gIGHGzJZaW59oR6tECuYImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326638; c=relaxed/simple;
	bh=sT0M4whB/azqkzoFo3lVc/mFbRxhHK9wlM3tA4SQE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g27bB6ZNjVXvqVv/Bjb4QWuzoi7ydyhxpGPcOLhoearAQKtCfUbzTqZqk48ZrUvc8yvBuckqtew3Td3E7r08tOiZX3qVUrtm/4zgYOLcziDmQ5D5fvQW4/JFa5t4fCorhY6VzUp9m0wu5EtcepLcRaS4n2UmNIHFRNHpbEXd6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMJ1L/MD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e427b07dso15060217b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326636; x=1728931436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6jJbBxQuM5gPGTlpVDtO28bvFS1W1MYo8GZrczErKs=;
        b=OMJ1L/MD5kTtYuKPVfIst8nHwmryn74NLqnP7d0+seAN7F2gJyOadaElNWX/CBiT0g
         BelUE0oIPi0VuPGzliMS6tR0f0BnrPlk5J7/gps9wHxSx4lC/Vgpa6JxSUd8cD/25prT
         nEnrQlQLUrgHYgr1/oPB9OTkijllgwoavUMB4tkPK4ToaGS0Al3ghTQKTO4Dy7hJauvw
         pP2LVbrBXY6jrjCth1ThNFb1DkRxEFCkh2QfKo6qqj6mGMV1DXiD7hQMU00vWshWFEBp
         pbvx/aslG7Elx93lVl/cqbfV1y8uIRSP2HWzaPg9YSbNE09qmbGIaDIMoG1yHhmbhUeT
         +wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326636; x=1728931436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6jJbBxQuM5gPGTlpVDtO28bvFS1W1MYo8GZrczErKs=;
        b=VnbogR40plIcAs9EXleVrIOJUsGoqvPFIFnGD7STc/sDQPeod3mIMQAQcEWe7Z+0VY
         Yb5RlF4P5q0A+d8FvSfJoaaF2YyzqYl52rDJskUNUAUGTfUqGnJAFSZB+o7JQgaKcCjh
         b4L2ctuTl650l7TdVv1tXDsjItV3VrCRB8kg/hu9kn1NjyQ4/w2GMbglTmo1bO7qo5/L
         lrQKr8FSCpYqIdq9HB3Hhbr8oOQeR97/pEmSlcJRkmvRBuEBO8eFevbaB9BrS+IL3D81
         8przxaHFxDoySquk71MvI8iB8w2yHQgcBnsvgtvlk6fvZlUO8kHSn5b0Bn8/0xupDFW5
         PN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHbc2fLUTI9fBltMx4OqITW3avG+kowQqV4S4x3zMbTv4sNmgwedTDfAqEd3V0LdDJjP6qF0DTNcYy0h1b@vger.kernel.org
X-Gm-Message-State: AOJu0YySycaCnTrmKYIBeNeq2f/YwKWQTuiYva3g/NnuPt4sQRsqfQv8
	Ca2MX6yS0xlcCmdve2NrrsSthiwyw7LaMEKFV5/aI/00r5VZCSiB
X-Google-Smtp-Source: AGHT+IGsahaEuPh5rzkeGFiwGBMj/2XyvADfiHBQFRsPE02/wng9V/l8J4dkyvEUialmcTHesQ6Mgg==
X-Received: by 2002:a05:690c:6893:b0:6e2:12e5:35b4 with SMTP id 00721157ae682-6e2c6e8c181mr117571687b3.0.1728326635943;
        Mon, 07 Oct 2024 11:43:55 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e40c5sm11296307b3.123.2024.10.07.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:43:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v7 1/3] fs_parser: add fsparam_u16 helper
Date: Mon,  7 Oct 2024 11:42:56 -0700
Message-ID: <20241007184258.2837492-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007184258.2837492-1-joannelkoong@gmail.com>
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fsparam helper for unsigned 16 bit values.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs_parser.c            | 14 ++++++++++++++
 include/linux/fs_parser.h |  9 ++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 24727ec34e5a..0e06f9618c89 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -210,6 +210,20 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_bool);
 
+int fs_param_is_u16(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	int base = (unsigned long)p->data;
+	if (param->type != fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtou16(param->string, base, &result->uint_16) < 0)
+		return fs_param_bad_value(log, param);
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_u16);
+
 int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 6cf713a7e6c6..1c940756300c 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -26,9 +26,10 @@ typedef int fs_param_type(struct p_log *,
 /*
  * The type of parameter expected.
  */
-fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
-	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
+fs_param_type fs_param_is_bool, fs_param_is_u16, fs_param_is_u32, fs_param_is_s32,
+	fs_param_is_u64, fs_param_is_enum, fs_param_is_string, fs_param_is_blob,
+	fs_param_is_blockdev, fs_param_is_path, fs_param_is_fd, fs_param_is_uid,
+	fs_param_is_gid;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -55,6 +56,7 @@ struct fs_parse_result {
 	union {
 		bool		boolean;	/* For spec_bool */
 		int		int_32;		/* For spec_s32/spec_enum */
+		u16             uint_16;	/* For spec_u16 */
 		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
 		u64		uint_64;	/* For spec_u64 */
 		kuid_t		uid;
@@ -119,6 +121,7 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_flag_no(NAME, OPT) \
 			__fsparam(NULL, NAME, OPT, fs_param_neg_with_no, NULL)
 #define fsparam_bool(NAME, OPT)	__fsparam(fs_param_is_bool, NAME, OPT, 0, NULL)
+#define fsparam_u16(NAME, OPT)	__fsparam(fs_param_is_u16, NAME, OPT, 0, NULL)
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
-- 
2.43.5


