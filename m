Return-Path: <linux-fsdevel+bounces-22703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024BC91B35D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D451C21F58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB344A24;
	Fri, 28 Jun 2024 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqkCs1vE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECE17F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534391; cv=none; b=paCn8rIeMeFS41qZ7R8etoo6HJZ8dKu1ybE7legYq/dOMfyg1Hhh+d2xg6fLk+CGTJjkCZBTFXD0HCyMb5o95kwVcXAw6BIRRuFX3AI7pDy/5KjZoPQ1oSGzgkZUjJ3kZVLK2xRmPGf0Wsd3Ha/BdvX/KN+lJv5Xh/LzoqV/oFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534391; c=relaxed/simple;
	bh=hh11G/iodh5iWE0DKtFfqmVHr22By8Ulh9rirP+ZYcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WANPDu+d1NH8Xm73KKzHuphHGmNYQ/h3v1utjbO/5pOiMGIvYSv8ainwP185LuZNTftZqvx+Fo4FVqlKpOWblERvBQ0Ol1yJO8mWH7325Y865I5uJnl9yFoFO+Z+bVsVAKsVflpD5/TmfCn6juCPOQZkbwQxTAxrKrFFo0Ddc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqkCs1vE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719534388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F920R5yaBE3PsuRdteKVNVN6MSLZBpfM90SMj8g8nmA=;
	b=MqkCs1vELpBXue/wzqbDkxiCkET4JDzLp+A0PCGAJ/eWIUog8Uv9BByus4U8hcydGZewNn
	J0U+dE/SeBwB8YUnQs2UAOgOPHDTDc3/imI6cm92A0jYtpmCJb/l+nRiXDPeq84G65oA/c
	Tcush1T+oKaqiX7WYCwwttQgqlqBzRY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-DM-LmOfbPWWzDTtNU9l69w-1; Thu, 27 Jun 2024 20:26:27 -0400
X-MC-Unique: DM-LmOfbPWWzDTtNU9l69w-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so2903139f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534386; x=1720139186;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F920R5yaBE3PsuRdteKVNVN6MSLZBpfM90SMj8g8nmA=;
        b=uQPUBP8uV9aTOg7aEiBaz9Xdaqpc42C5xwnDf62rTGPZ8cxavJ16AOf50wLrAoA9Om
         pqMA81MViaqAz7Wwj+lB1jUkxjXulqpQCcOKTVW38RajCvt0Tdf4bpVdeYJX3MAZwX5D
         ZjbasnM/Vc02ZCl0j71z1wn2e0CA4zkyUeXiZc5oJQ1LkULUpba9VLJ70SL3pAadz5kW
         AU8V9OxN1RkJymsT/no9iApkoL23tjElcl/Dfn/I9Armg8C0WPL36JDMlZO4iRYeTUqX
         XaYXfN80B6Wtq0QOzU0NLaebpGc5Fw/a6OFQq5bnYM1Nel5N1E/ZM6xGOUX8po5yjYAh
         KA9Q==
X-Gm-Message-State: AOJu0YziXVSR3aW19AkyNWSt47+BE2o3sX1TDpKf4ZRfMx4OkqpiXL1S
	Uf2VUYG1EGC40B6JbUvLJzNCa3h20r3E7SqyHSezS5fKcnPiatI7blUL977VhXJyZZWY68afigJ
	nUTD9a7qeq+y7CaiCoQs+qmaDqzRq7K2zbalAaf1YMngFzeDNXomcEz4hAR/BM+mBwpe4/PNamj
	zP3E0uIcGjNo9o5LRHX8d0nTirjGLEWs6G2fQ25orJeD7Wxh9U
X-Received: by 2002:a6b:730e:0:b0:7f3:d863:3cf8 with SMTP id ca18e2360f4ac-7f3d8634018mr415332339f.4.1719534385904;
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQ+evTqW23iP2xMhQPr9hw69BKkkeaSh3vRZVLP5nIJpjBkoHrAggDlvkHwnRujUOQkyNmA==
X-Received: by 2002:a6b:730e:0:b0:7f3:d863:3cf8 with SMTP id ca18e2360f4ac-7f3d8634018mr415329439f.4.1719534385516;
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd541dsm219330173.55.2024.06.27.17.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:26:25 -0700 (PDT)
Message-ID: <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
Date: Thu, 27 Jun 2024 19:26:24 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/14] fs_parse: add uid & gid option option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 linux-mm@kvack.org, Jan Kara <jack@suse.cz>, ntfs3@lists.linux.dev,
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Hans Caniullan <hcaniull@redhat.com>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Language: en-US
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Multiple filesystems take uid and gid as options, and the code to
create the ID from an integer and validate it is standard boilerplate
that can be moved into common helper functions, so do that for
consistency and less cut&paste.

This also helps avoid the buggy pattern noted by Seth Jenkins at
https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
because uid/gid parsing will fail before any assignment in most
filesystems.

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---
 Documentation/filesystems/mount_api.rst |  9 +++++--
 fs/fs_parser.c                          | 34 +++++++++++++++++++++++++
 include/linux/fs_parser.h               |  6 ++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 9aaf6ef75eb5..317934c9e8fc 100644
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
index a4d6ca0b8971..24727ec34e5a 100644
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
+		return inval_plog(log, "Invalid uid '%s'", param->string);
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
+		return inval_plog(log, "Invalid gid '%s'", param->string);
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
index d3350979115f..6cf713a7e6c6 100644
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
2.45.2


