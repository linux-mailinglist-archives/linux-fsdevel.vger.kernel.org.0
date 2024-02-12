Return-Path: <linux-fsdevel+bounces-11146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C56851A60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EF8285DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40A3E49E;
	Mon, 12 Feb 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frMUGRTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EF3E46D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757201; cv=none; b=MMIbPsqWRUC/kwbNeaQ+bHK60mYQtisbPdEE4bjILijAOYHSYrBna0s1u8Fawj8KJZUrCSKuot6OwoOxqYKLhSll9u2S6hIsQh1H3en181UTnwBjwjpglpNdnWVO7zVFyDV/MNBGXjDDZlhLnnP1k4h8i4N/VkCvZikSfoN1SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757201; c=relaxed/simple;
	bh=cvhOJNMgYbCTZs0crMMOB5Pl60dq3zxJ6bSAHeiofko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdTMHeqO2ZkmsXw/cduFOxCwrlotO5vD5r1RFhAWjUE5o2HjRxMtJo+Q9M0n3IBT97G+UOzkOHrHo+gh9Nuf8SDShlbah6+HAWoSrzMb5reNsELAqMSXoG2yuTXtgASfA+mvYROh913xZ3TQtcj+eJrUFrMcprzlTmJAdR9Zyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frMUGRTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eZDjHaP7Kupt8d6Iu2ty2GFMw3W0f+xpOseohnHwTk=;
	b=frMUGRTfKyeKDbS4I0tG0iEi27f8GlYS/Jn779TwFuDjdrzrH5BGlwEicG39b/4AYgG/UN
	iPp05JsSmPdMwUAAF3bT7T9WoPLMYmdsarrqdlhNvKsnJQkbhqU5qDrR/tkWjoKnnAXM0/
	ehoCqXFwIbv/EuIGWvaTEYAhhbvNELA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-S-ubIfxjPc6MV7HFlYot8Q-1; Mon, 12 Feb 2024 11:59:56 -0500
X-MC-Unique: S-ubIfxjPc6MV7HFlYot8Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5600db7aa23so1995698a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757195; x=1708361995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eZDjHaP7Kupt8d6Iu2ty2GFMw3W0f+xpOseohnHwTk=;
        b=drqs7LX5U7BgFTAVeqE3NkCcb5mnCl3krK3BySRrxD8Lp3k1MX57R3cMNhArH7Nb1e
         itkkXjHprAZAUFEpp/72Z0NP0M6SrqQrNsXDgNt9oFvt0IWJKGWDeK3TggYcdsSz/hcG
         /N+x9hpMCV1twQAvKr/ikRyyk8qdenEveSLQuelqxf/FzSLwSzHvfTz3B/K8UKljiOPS
         4kjaYzh3zHAbmv8UUI5CHaT7sxKOuG3yywEPJz+zh+OMgdk1cvFzL6+iaayiq1Dgexvh
         nN9ZFxCvvqTAnq2XCkPW+Q5YN4/767ksOEhn+nD8PflWTgtDW7byc9CDm8HW/urU6/wx
         o7VA==
X-Gm-Message-State: AOJu0YyEI3MxaSptrwY9xljW71F9QgKQRjT2bEsxtwr9MEaRkQ1XcgHG
	36OmK7I4BGpa4AAmZ+2xdGcP/kxCCMtWXcgpSXK8nmSUIyun9WfmLHBqpQQh5t+/5maliQKh7Sl
	9qO9Kam/EmbyAgtr5z/op6/dYvwFHMEub7fxzxFQB4SWbhWQYe4tqpFuoUh54TvEgaRqdYw==
X-Received: by 2002:a05:6402:544:b0:55f:c3c1:34e with SMTP id i4-20020a056402054400b0055fc3c1034emr1476951edx.15.1707757195351;
        Mon, 12 Feb 2024 08:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyQP1vpD0d7s1DLfQrdN0VArL3Z7/S/UGhBKfUY5OPPaBlXP9kgpE6F85URgM94E6HCoBQBw==
X-Received: by 2002:a05:6402:544:b0:55f:c3c1:34e with SMTP id i4-20020a056402054400b0055fc3c1034emr1476936edx.15.1707757195175;
        Mon, 12 Feb 2024 08:59:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMULeE9s3nH+f2UMQCVjIYAATNr91A4Ha5f9VSJraW6oqpiPL3tmAHAY6PdEz054BS664a2YaRiaMUr/8qUiCssI9wfT114LLRO4KVxI9+V0jszODBczr1+t3NlI/Rz45VtOoo6Ui5gEPxUDyPQKU3N9O2/8/ta9Zk1gx9LBEHd/xz9LtHu9mXtCI9WUv9KptxyN5Fs3L6rp+W5VAUwLQh/y9gvRq8YnP/
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:54 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 05/25] fs: add FS_XFLAG_VERITY for verity files
Date: Mon, 12 Feb 2024 17:58:02 +0100
Message-Id: <20240212165821.1901300-6-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extended attribute FS_XFLAG_VERITY for inodes with fs-verity
enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 Documentation/filesystems/fsverity.rst | 12 ++++++++++++
 fs/ioctl.c                             | 11 +++++++++++
 include/uapi/linux/fs.h                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..19e59e87999e 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -326,6 +326,18 @@ the file has fs-verity enabled.  This can perform better than
 FS_IOC_GETFLAGS and FS_IOC_MEASURE_VERITY because it doesn't require
 opening the file, and opening verity files can be expensive.
 
+FS_IOC_FSGETXATTR
+-----------------
+
+Since Linux v6.9, FS_XFLAG_VERITY (0x00020000) file attribute is set for verity
+files. The attribute can be observed via lsattr.
+
+    [root@vm:~]# lsattr /mnt/test/foo
+    --------------------V- /mnt/test/foo
+
+Note that this attribute cannot be set with FS_IOC_FSSETXATTR as enabling verity
+requires input parameters. See FS_IOC_ENABLE_VERITY.
+
 .. _accessing_verity_files:
 
 Accessing verity files
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..38c00e47c069 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -481,6 +481,8 @@ void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
 		fa->flags |= FS_DAX_FL;
 	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
 		fa->flags |= FS_PROJINHERIT_FL;
+	if (fa->fsx_xflags & FS_XFLAG_VERITY)
+		fa->flags |= FS_VERITY_FL;
 }
 EXPORT_SYMBOL(fileattr_fill_xflags);
 
@@ -511,6 +513,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_DAX;
 	if (fa->flags & FS_PROJINHERIT_FL)
 		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+	if (fa->flags & FS_VERITY_FL)
+		fa->fsx_xflags |= FS_XFLAG_VERITY;
 }
 EXPORT_SYMBOL(fileattr_fill_flags);
 
@@ -641,6 +645,13 @@ static int fileattr_set_prepare(struct inode *inode,
 	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
 		return -EINVAL;
 
+	/*
+	 * Verity cannot be set through FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS.
+	 * See FS_IOC_ENABLE_VERITY
+	 */
+	if (fa->fsx_xflags & FS_XFLAG_VERITY)
+		return -EINVAL;
+
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
 		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 48ad69f7722e..6e63ea832d4f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.42.0


