Return-Path: <linux-fsdevel+bounces-20973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558838FBA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F941C2259C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669114388D;
	Tue,  4 Jun 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxyfcMbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72B7E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521465; cv=none; b=EKAXTT0XGfHu/vqAVLvLVeKcVyZgPNBQ0JVQNegq6iPVbEW5W4nY1Xzly+cyngLb85tEiEQgGurGQnwmcOsDC03Jwx35qbLl3HyKifmjG9ZSVmnEVKJ3Zj2Sjf9iqaRR63Z+SSqIxdbyMkgeY8qHWAgElg+sto4BqDNZwOEPrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521465; c=relaxed/simple;
	bh=6KpvonU28xAaESTXS/DQ7D1ZoHutYvZAzRUJbQQT7DE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ea0BlvlzMI5+jAaBkiRkPNEdsl0HywV7ucyU0OkOzYB5iHfXOkHkDCb0GwHqNTudP27VDCVm5Q2EGfeBGMi9lZVRUl/TcYs3nvjWeWoIY/01f/ms70eTABBTWukRribEwlm9H18utXZJP2aj8yXpTw3nFAFWueTN6fJ2j+I/fcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxyfcMbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717521463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AV25XjL9BzFccI0I9XCoNrwxuId5sqRgx8tkB1IYPDc=;
	b=MxyfcMbkgdJ/vanMhsfNZKU+lJHaExd4hSV2/KyMXNgbPhAVZGxoouRYzdY6tU7AaLiAGX
	oicQeWRBJ9HMAZMTTZ8PapYABMnr99FPcKsp4Jpiz8mjYRd0NKird2lcpB58ow8hLyzxcs
	lVf06yIpwqfiMvxAh9ZQglnHUtnCG0g=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Tlc1uTwWMGaCRQpC_G3Zvw-1; Tue, 04 Jun 2024 13:17:41 -0400
X-MC-Unique: Tlc1uTwWMGaCRQpC_G3Zvw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ea27057813so549214239f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 10:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717521461; x=1718126261;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV25XjL9BzFccI0I9XCoNrwxuId5sqRgx8tkB1IYPDc=;
        b=mVsGLDgaum/I+2uyO1KTQpTorLHqAz+8eTX0WVbNI/GoLDtcFh6uwlH9WHtgMfjN6S
         nwp+gzXfAFZOy5lJlVzJCuD3VKDA7dP+NLr8f3KZptKwOkr65ZLb2ZfV1UVkocdHGv36
         E+xtUt5dNOS898wN1qpMBnPXAfIzzp5/8BVxCyL/mzlU6vCTrcrRYh7El9w3htsKaiMv
         HtunpHHBtBGJQg1xlscyppGgL62reVfioyzPeQMf0ob55IwZoAVCFufvTa3GnkFujYoA
         sztNwmJQFdCtm2fp7zXvoszBPMIbBEbSDmUJ+33LjXiQBz3l4KHhWVC7WVOWll+sT0bd
         8SQw==
X-Gm-Message-State: AOJu0YxriELa4NO/u9gpNyJ9N/S7zrx7ATYu36STBpgWY7PcOnyxQUGA
	DHP9DVfd5UYQd3Dsen7Y2mucaldDtQiLFb72CDbH+k6HNn5FE6uhw2JSSSktEF98oVGhTaTmYtA
	S0ZIDgYw+3YqmPtw22ISX+qIL01mYNmEgUheoqb1GsgMaKfaOqVavOHyEY0Axz/XP0xWlJ8siKj
	AbtAXEX7g2Uxjq8mdzsgskAVJK94J9zhvaQuAbWYKu2EMtbg==
X-Received: by 2002:a05:6602:3f86:b0:7e1:b4b2:d708 with SMTP id ca18e2360f4ac-7eaffe9a58amr1716364539f.4.1717521460518;
        Tue, 04 Jun 2024 10:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHLL2KONXVJlNFYlrUALg4lwzfVacjPw5xw0VoepXa3sYFrh2b5JdYgFn4mZiFJxrcqHRq3A==
X-Received: by 2002:a05:6602:3f86:b0:7e1:b4b2:d708 with SMTP id ca18e2360f4ac-7eaffe9a58amr1716361439f.4.1717521460022;
        Tue, 04 Jun 2024 10:17:40 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7eafe5ba64fsm261253139f.30.2024.06.04.10.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:17:39 -0700 (PDT)
Message-ID: <8b06d4d4-3f99-4c16-9489-c6cc549a3daf@redhat.com>
Date: Tue, 4 Jun 2024 12:17:39 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, Bill O'Donnell <billodo@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH RFC] fs_parse: add uid & gid option parsing helpers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Multiple filesystems take uid and gid as options, and the code to
create the ID from an integer and validate it is standard boilerplate
that can be moved into common parsing helper functions, so do that for
consistency and less cut&paste.

This also helps avoid the buggy pattern noted by Seth Jenkins at
https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
because uid/gid parsing will fail before any assignment in most
filesystems.

With this in place, filesystem parsing is simplified, as in
the patch at
https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/commit/?h=mount-api-uid-helper&id=480d0d3c6699abfbb174b1bf2ab2bbeeec4fe911

Note that FS_USERNS_MOUNT filesystems still need to do additional
checking with k[ug]id_has_mapping(), I think.

Thoughts? Is this useful / worthwhile? If so I can send a proper
2-patch series ccing the dozen or so filesystems the 2nd patch will
touch. :)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 Documentation/filesystems/mount_api.rst |  9 +++++++--
 fs/fs_parser.c                          | 34 +++++++++++++++++++++++++++++++++
 include/linux/fs_parser.h               |  6 +++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 9aaf6ef75eb53b..317934c9e8fcac 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -645,6 +645,8 @@ The members are as follows:
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
 	fs_param_is_fd		File descriptor		result->int_32
+	fs_param_is_uid		User ID (u32)           result->uid
+	fs_param_is_gid		Group ID (u32)          result->gid
 	=======================	=======================	=====================
 
      Note that if the value is of fs_param_is_bool type, fs_parse() will try
@@ -678,6 +680,8 @@ The members are as follows:
 	fsparam_bdev()		fs_param_is_blockdev
 	fsparam_path()		fs_param_is_path
 	fsparam_fd()		fs_param_is_fd
+	fsparam_uid()		fs_param_is_uid
+	fsparam_gid()		fs_param_is_gid
 	=======================	===============================================
 
      all of which take two arguments, name string and option number - for
@@ -784,8 +788,9 @@ process the parameters it is given.
      option number (which it returns).
 
      If successful, and if the parameter type indicates the result is a
-     boolean, integer or enum type, the value is converted by this function and
-     the result stored in result->{boolean,int_32,uint_32,uint_64}.
+     boolean, integer, enum, uid, or gid type, the value is converted by this
+     function and the result stored in
+     result->{boolean,int_32,uint_32,uint_64,uid,gid}.
 
      If a match isn't initially made, the key is prefixed with "no" and no
      value is present then an attempt will be made to look up the key with the
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index a4d6ca0b8971e6..9c4e4984aae8a4 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
 }
 EXPORT_SYMBOL(fs_param_is_fd);
 
+int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kuid_t uid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	uid = make_kuid(current_user_ns(), result->uint_32);
+	if (!uid_valid(uid))
+		return inval_plog(log, "Bad uid '%s'", param->string);
+
+	result->uid = uid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_uid);
+
+int fs_param_is_gid(struct p_log *log, const struct fs_parameter_spec *p,
+		    struct fs_parameter *param, struct fs_parse_result *result)
+{
+	kgid_t gid;
+
+	if (fs_param_is_u32(log, p, param, result) != 0)
+		return fs_param_bad_value(log, param);
+
+	gid = make_kgid(current_user_ns(), result->uint_32);
+	if (!gid_valid(gid))
+		return inval_plog(log, "Bad gid '%s'", param->string);
+
+	result->gid = gid;
+	return 0;
+}
+EXPORT_SYMBOL(fs_param_is_gid);
+
 int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
 		  struct fs_parameter *param, struct fs_parse_result *result)
 {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index d3350979115f0a..6cf713a7e6c6fc 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -28,7 +28,7 @@ typedef int fs_param_type(struct p_log *,
  */
 fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
 	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
-	fs_param_is_path, fs_param_is_fd;
+	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
 
 /*
  * Specification of the type of value a parameter wants.
@@ -57,6 +57,8 @@ struct fs_parse_result {
 		int		int_32;		/* For spec_s32/spec_enum */
 		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
 		u64		uint_64;	/* For spec_u64 */
+		kuid_t		uid;
+		kgid_t		gid;
 	};
 };
 
@@ -131,6 +133,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+#define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
+#define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
 
 /* String parameter that allows empty argument */
 #define fsparam_string_empty(NAME, OPT) \
-- 
cgit 1.2.3-korg


