Return-Path: <linux-fsdevel+bounces-34839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198EA9C926C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DEBB2D021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774A1ABEA0;
	Thu, 14 Nov 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPpTDb5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6761AB51F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611634; cv=none; b=RmePWbOvXfBVXJuCH5HzyKPweZBFa2O+gY/oGJ1B4HPgLbXQ/pf0QeLnK629T3KpnCqPbo4uuITGoKbs4EjZm9VRq0q+TIfgIZzv0ku93EdZLCQx/jhid/on0zERdg2BZI6NxYdwn/aGgho90hlh6cFyLRIByG79pu0OK/83hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611634; c=relaxed/simple;
	bh=XTqdpnqCQUq/lyFP7zkZinayJQkDWOixs7lnvYm0jvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHIU2hNED297iKehMF4/SsHXqDblnp5JrzjxZlppCltjFOIizwkTK3XqyhAFL7taG8qSe27iiPdyoaW/n5KZdmvH/vPveaqTs5TdhTThpxma++viAkDEa4xcQHVbaGpP7lBfc6rrNkecnP4tsaKJQwOcgKsSm3Fuqz3l6OnPzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPpTDb5I; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38193093a7so748791276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611631; x=1732216431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw6yEAfKVb/rJW5k4q7A4sTnqwnlBXS09YR6aNAi5U8=;
        b=iPpTDb5Ii5hTh8ZtA/Z2zvYDxU3eouIyIRExqWbBzZ5C2ykJAYqoWaUtjx16iSDMM5
         24UVvosZbXV05uwk2TdU1LlteBYhz/GKN5bafj5nmMzvAJ/tfvFpcqm3DE17co5Ri+Py
         /7eV3x3VPmD9FAqbziR20kHQbNWL2ujaAfiRruBw0yOlCD3JUhqbKEBeQ+Y1/wfCiqUe
         nRatkvUq6ESqL9XMqPysWQmdrYYsp/cBGm4wDvlmal7+FvjFJU8bBGZyP4lO3LYirZR+
         ipEgmjHzgJ9IJOVhwVIuxqH1zFHmE4AyhZWZjmZfiyWZ0V4RBk6vMu+c8pIOSewg/0ab
         VL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611631; x=1732216431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw6yEAfKVb/rJW5k4q7A4sTnqwnlBXS09YR6aNAi5U8=;
        b=UCiMcHKHOcSX4GUGvjGzj/skPCxX0Oe2MjBjCfat6W/0ntUFoxudbH0nVsBEmOvQ1E
         AOhew9X2uxUydQZ6C5ZltmJAkQZ5eAOtoKI+eo7TxroTTHYkfPy2+NDEBAwRE48z+3MB
         fBr0wD74rX7WoUMufFZcw6SFAAa+Nj2d9beVm7LNS4qy9R4dfSOjJ1Tm+1t3rM0CzQ/Y
         zUQ1gq1NTKmiEWRrqp0iXziV1DpTmVqrMCKxSF8Y+0Zk52HFobzmSI/jpWYBpi4+UdoO
         q5O+Kp8VufgApFSFfcUHG6vEj2u+2AeCXzeLjmw3A3lIyaynuoP0ZYA3nRnh2WnNnE5h
         eK2A==
X-Forwarded-Encrypted: i=1; AJvYcCUgZIA9NFyy97oQf7kdCrZf5crSWFftoEHSM8lO8YUlmPTYyjYYa1/DfrIO8NhDFRPVclpNSwf27e80ayEI@vger.kernel.org
X-Gm-Message-State: AOJu0YyiH7Kwl0oixoE5aEj6DLxdMF1dFtayZM66+Yi8G+MqJX0rRH5d
	Upo6zMix3sXLM5KZLTNgBJ6EYsBtMlxFj2i+1SLV40fubDwE8WLq
X-Google-Smtp-Source: AGHT+IHfK6FdLsWwcF5qvTOk0MIcLBo07MSwwVmcfGvB9zQWa9k4bBl1UzOYK5Ajb8+/N9k12UkLRg==
X-Received: by 2002:a05:6902:3402:b0:e2b:9ae5:5bf7 with SMTP id 3f1490d57ef6-e38140e52demr3261026276.19.1731611631499;
        Thu, 14 Nov 2024 11:13:51 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e381545ae2esm467773276.38.2024.11.14.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:13:51 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH RESEND v9 1/3] fs_parser: add fsparam_u16 helper
Date: Thu, 14 Nov 2024 11:13:30 -0800
Message-ID: <20241114191332.669127-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114191332.669127-1-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
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


