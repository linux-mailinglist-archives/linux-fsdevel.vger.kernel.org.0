Return-Path: <linux-fsdevel+bounces-13525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B4870A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765061C20EBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E19B78B70;
	Mon,  4 Mar 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqyS2U1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9C78B7F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579540; cv=none; b=pf0zHscEOUqh3pjnILAYcdObIJjYP6+ysncBZ1R24bJJvJCU+oshaI5cvmfVWkkA5mWvPNYEQOJj3Ycb5jPXmWth7evi240UQ85UEDteQBBkQvrI2xzJRa0OiYSoDVFjTXUlEwka+PrawTz6N4YasQqzJBWppbUTVdOr5X9/oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579540; c=relaxed/simple;
	bh=RsSA5HXP4XdTMyeDSklbX2t9chAOtXyvct70Wpdi/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXvlyn7VbfSfT8KxPSGtd3PUGosTvy30eyP+Ga7vPLpED0xQkxZkZUks7U7Brh+ztBA/Esc7eCtyHAKyg9CN9lEzkOZ6u25LrG8LWslLX6fe5q7Kl+KscDshM0J1MTSh0w64ABJ20ZdzDDTObCDzRdbAs5MqSeKQQ64RYAaDc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqyS2U1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLiAPlULZquK5Brfr95QLdeh/hZ5v9ntg4e4aq6YwHM=;
	b=PqyS2U1ctAcMNQQvTzjVq27gMkEyZ/XglVRuI+Sv8USYkpS3fWbrA5pt5EVsllfPahl1rd
	SV+iqqY8CzeAGl+w/DsJSoLcfYKM9PcepC1Q/x9oSxHR9VeboEYPj74eUMUxZfMj13gMmN
	XMKqVIyUMDZxb5p7mmrJke0UmGA0aaA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Aw2B886BM0-bXjFfUZBCgQ-1; Mon, 04 Mar 2024 14:12:16 -0500
X-MC-Unique: Aw2B886BM0-bXjFfUZBCgQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a440b057909so293873766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579535; x=1710184335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLiAPlULZquK5Brfr95QLdeh/hZ5v9ntg4e4aq6YwHM=;
        b=ERlK8HIlVXD0pQcdyLG556lydL0VWHhm7unHhzFL0xkfNrGnhgcPNWTFKk6RToebHd
         GGAhiKTl7WqjvnKgOVTXoEIgSNyginw1Nlci6xOAEpzus0nS5/xR2kEEjDBze3x3xKzc
         GC+/NC8qTp4Ugx0cUtIwak1BbsEv0WjI/zQjhYLzumvpbdsdi23aW3or7FFBeoal/Tw+
         SX9wu77rfYdVVKVdoOkSoxR1HQYlkCV8H1ixjJMxlgy/r0iOSML/Xc6ZHv4iCuTdWeuC
         gXtMcA68IJHMCnP+xcLGyKxBLF1rQY0UbszwVq+0HfLAYGwPfCceHjP0RN3jtcWaznBE
         oRRg==
X-Forwarded-Encrypted: i=1; AJvYcCX3T7kzJttqmXy4wFrtni/NGlA/GrGbQMrmlpLs0u+EK8TiyVlkVZ+whFEBq1MbY+uo8aCSlZY0GwpTU0IqB1t3l/CbAyB36fz0MM8C8w==
X-Gm-Message-State: AOJu0YxKIo5lSXnyQ9Z5rF7sAI56VexxPwhGJr1Jzyy/neRWRSRORAL3
	hJPy8lFrTYMt1IyKAxIz8EnepD9Sf07xzj63db6cSzu9IOJTemKHR8fh1r1Yi8DipJATSKJeu4a
	hNz6HfdH6ams31s9Tzw65RIsQuC8tDGvOgM/PixCZ0k7OhfSkHBupyA9pRs//tQ==
X-Received: by 2002:a17:906:13d5:b0:a45:95f5:f314 with SMTP id g21-20020a17090613d500b00a4595f5f314mr344240ejc.42.1709579535550;
        Mon, 04 Mar 2024 11:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx8vfrZMAjuMwszwGXOM9gKTiOkhdQUg8Hw3nl4YJ4PBoUGUn4W527I5Al2Nj2TIVW4ljXsA==
X-Received: by 2002:a17:906:13d5:b0:a45:95f5:f314 with SMTP id g21-20020a17090613d500b00a4595f5f314mr344237ejc.42.1709579535279;
        Mon, 04 Mar 2024 11:12:15 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:14 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 05/24] fs: add FS_XFLAG_VERITY for verity files
Date: Mon,  4 Mar 2024 20:10:28 +0100
Message-ID: <20240304191046.157464-7-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
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
 Documentation/filesystems/fsverity.rst |  8 ++++++++
 fs/ioctl.c                             | 11 +++++++++++
 include/uapi/linux/fs.h                |  1 +
 3 files changed, 20 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..887cdaf162a9 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -326,6 +326,14 @@ the file has fs-verity enabled.  This can perform better than
 FS_IOC_GETFLAGS and FS_IOC_MEASURE_VERITY because it doesn't require
 opening the file, and opening verity files can be expensive.
 
+FS_IOC_FSGETXATTR
+-----------------
+
+Since Linux v6.9, the FS_IOC_FSGETXATTR ioctl sets FS_XFLAG_VERITY (0x00020000)
+in the returned flags when the file has verity enabled. Note that this attribute
+cannot be set with FS_IOC_FSSETXATTR as enabling verity requires input
+parameters. See FS_IOC_ENABLE_VERITY.
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
index 48ad69f7722e..b1d0e1169bc3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.42.0


