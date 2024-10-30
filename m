Return-Path: <linux-fsdevel+bounces-33304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646069B6FAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B2A2852B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8485216423;
	Wed, 30 Oct 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbuKPUCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1021BD9DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326115; cv=none; b=E8dw7ASqqaOZM/Br3JGtnNk3/hW3w6NsEJM5LyAs2xcTx08uzrDthDqDrhZ6J42dcERrcqE5qloWTL/R8Ux0c8gQheqjhk5wOcpOoVtYoh9pvv5m/6JH+zt5o3YgzpxUcEKu4l0YwpCY2l9QHS/y9damDI9a1O+x2b02Qpmq83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326115; c=relaxed/simple;
	bh=XTqdpnqCQUq/lyFP7zkZinayJQkDWOixs7lnvYm0jvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7EIE4bD26fHKuhgNXiBzQqNT+cwovbCq25X/K/DmRtbfzGKjnDd51BV9QDShoRHiqyeFdB+ZcojxfIhhRkal6m3uLR42ZqOSXJ7SZWiKzA9hyHzRshZMbw40Q4T90WwrAFI+OMtJ9WF80RVgKLIkrAfmwg8ZMD+zvkepk9n40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbuKPUCi; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so289858276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730326112; x=1730930912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aw6yEAfKVb/rJW5k4q7A4sTnqwnlBXS09YR6aNAi5U8=;
        b=FbuKPUCi8Eh086NbBacgPdqgmnwLmq9mBjy5b2/tCOfIC9SuUKjuQByrzAHOtsrCbG
         BNN9hPJo7OtEUeRydGC+QzlUSRVDryGKEfTfH15W+6V1kviXyv/yKH1HdfAEfpegCQbP
         JrcN7aEOya562JP/LJ4CCC+6vTaLaAV9O4DbSld248W5Au5SX/HW1wZJ+s2l1e7xLg3D
         cnsMAJ7fm3wqx1FZYbEsn1sMEt4tNzIr75RsIwa+5127rSltUBf6AZUSIGZbW9O6wY1K
         D6Z9swZyS1hPQRDnzzcnKIhRefszhGJx0rm9cjy9V1TzWkH8GNGWHy2/F2EpzHQM/wR2
         LEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326112; x=1730930912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aw6yEAfKVb/rJW5k4q7A4sTnqwnlBXS09YR6aNAi5U8=;
        b=QOWNT8kT5VdSuzuA96dYRYRQXxyLqBuxiivOSEyzLR0awB4xgSx47cyhnnTRThRIBd
         YcnlQCCxftYnwzthbjeE/VNOxdmACZyzMmO/YmmC6UoHMuKfBLuIRD+e90qgZG0YNFAJ
         91KiO+jfCzOFBEf6oV+LSTTrvNpYYgWO3Nc28Io3rWmLJa4hpmRq8WUQS+KMiE9yisfi
         utJc9hHHrW+xUgWisXc4QY73cr3022xLkQvxyKMbZDMhw95hfWztkXX6P3ogQlNKMNBt
         Y6oz3+uq8P7qaNk6nCe8rMISPLA07S8fGcTlb/Jpx5z1/yoVCPSLou3SdGR/seKhIjqN
         2tQw==
X-Forwarded-Encrypted: i=1; AJvYcCVwp/oeuhlsjUW2eXOWcJDFKpfoU/wV5KqvwwxCh7zqidYS1C702AW95Kru/JcYX/0Bfiy+uGjNOVfJZwzM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9T/iI8dNpTLseU7Dmd+aFTKaHf7YaxDlfgRnxeWJXzuSbPtT
	mPYQ7UQ+/O1R1+U53KxKnSxyVzBPfpkHIceezv8ZwEIh7Vq9obQ7sYqLEA==
X-Google-Smtp-Source: AGHT+IFa/N/xa3Exi/jCvTm8b4sfp0zO278nWHgfclQtwI7G7JJB2bQFymI9OHFp1sLENhmTpGbadg==
X-Received: by 2002:a05:6902:1203:b0:e28:fbbf:7406 with SMTP id 3f1490d57ef6-e30e5a3dff1mr1325102276.15.1730326112066;
        Wed, 30 Oct 2024 15:08:32 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a63368sm34056276.4.2024.10.30.15.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:08:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	viro@zeniv.linux.org.uk,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v9 1/3] fs_parser: add fsparam_u16 helper
Date: Wed, 30 Oct 2024 15:08:04 -0700
Message-ID: <20241030220804.652651-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fsparam helper for unsigned 16 bit values.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
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
index 6cf713a7e6c6..84acd7acef50 100644
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
+		u16             uint_16;	/* For spec_u16{,_octal,_hex}/spec_enum */
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


