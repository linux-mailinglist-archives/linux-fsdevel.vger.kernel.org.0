Return-Path: <linux-fsdevel+bounces-31774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B6799AC7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7A51F26EA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3621CDA0A;
	Fri, 11 Oct 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AudOCPgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37619F49F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674072; cv=none; b=ospZS+gMsSePuc7dnWKTpcRkT7NWEBkmuM+Yb6qTH53IWe5VFzLQAi1gHR0+gC1Pjo8kirlaLlo6Nxi/W03ch8boajULgfQTCEHhdiLOgS9Vw7tiq5/FHUuhMWkRk+PaKx3Wpf9lTPGn3tG3c7gZ/gDQ0WNGb7KghNhP6G8IetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674072; c=relaxed/simple;
	bh=sT0M4whB/azqkzoFo3lVc/mFbRxhHK9wlM3tA4SQE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAJru0lPNJYD/mou/4LZGxRt55OhK4QQIuQq7H9RpCQ4uQkqTfia9KhznnkeRcJBjZGczgSqz54+OYtxMfex7EcN1GD9G6gm2HbS1RTlgdcubCLPfqaSyFTjCK4jTITCoUke4f7bMjq8aSJcuh939fuZZk47V4yjdzXCXn9jAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AudOCPgV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2915f00c12so1558106276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674070; x=1729278870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6jJbBxQuM5gPGTlpVDtO28bvFS1W1MYo8GZrczErKs=;
        b=AudOCPgVbJAwT+1V4ZMeBVV6p3nR5Natz0jSjGZ3ImIs5DjA0SeR8fi763vfpieJOP
         t0euBP0pncw/eXN4Bx/Yt/Ih4ytIU1ws5w5WWjGCoHzUpOyWgk3m27+q5+JyCuXOU/iC
         OLNVdoZa7OxVQbYbWlELOFMdlUnyxz3yH3b3wsd3+Jt71igOQjkffnqWwUsHzBmAiHun
         j60NDH5eEDsohUp6tcjuG6rFjAqns/PuUzw6JsTYaMg+oRxZwSOeKc5JoEibdfAhhw8T
         ais9e79WIGcQyqfZfoqABa4nRqAM2mk/XRxWEIEsDsRoHrUDSkGO/j19ni9TKFEx3TfX
         Oekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674070; x=1729278870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6jJbBxQuM5gPGTlpVDtO28bvFS1W1MYo8GZrczErKs=;
        b=V+w3s95H2whmnOmrPqV8aRij2+k6TeZRlIPNHgb/w5BAXqX5q17L/9MbyfVBlDNKEG
         1WWVKCdTywLBXTE9DHGFAjlZfzKEzuQUrPn04uU3yhYp8rMVuJzGFcfDUgeOHJvmX6FI
         NrlYP3aAWfOX2m5XrC2SLZxdwydKY1Yg78s74wcBGApXgIERR7uvN5Idw4SbVABXS0Cw
         WxFC5csSdXWk684Upf/FX9Gy7DnYv4ObwKgFKW/9C7clhlH68sLkgRTq7IpQotmB+0Er
         dq6d8u4HY0gUcsMM0xkVoDCr3J3kTbwXIRujJBU59PbRz/yt/essgpyCPu/8hRsmOoK1
         uvBA==
X-Forwarded-Encrypted: i=1; AJvYcCWSdkRpNdrNUGl+mw0Qyn7F7dErAhdTqMcSJa5pcPuGfGp4BjDX8a7kGebQm8rRLigdzXaZf6kv1PnDy9nx@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwJWBLjdPS3mrYTThxv8zUR7v4deTfrsrbohNR4ULEs5xtpOd
	4RnMl4cqtj7lsU7S6qVv2v1jUqgJGXzbtPXe5SfcfexoKnYy+K6E
X-Google-Smtp-Source: AGHT+IFNnsNCjOpaELsrTGp6rOINivAhI0i97pytULZyNzKdp1W9XuE7k2FnDbddXhukqIFASFcQPg==
X-Received: by 2002:a05:690c:388:b0:6db:4536:8591 with SMTP id 00721157ae682-6e347c615a3mr30624447b3.28.1728674070000;
        Fri, 11 Oct 2024 12:14:30 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b619a8sm6997007b3.21.2024.10.11.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:14:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v8 1/3] fs_parser: add fsparam_u16 helper
Date: Fri, 11 Oct 2024 12:13:18 -0700
Message-ID: <20241011191320.91592-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011191320.91592-1-joannelkoong@gmail.com>
References: <20241011191320.91592-1-joannelkoong@gmail.com>
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


