Return-Path: <linux-fsdevel+bounces-53386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45641AEE462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A22E3AD231
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743C0298249;
	Mon, 30 Jun 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHNEn+uX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FF292B4F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300442; cv=none; b=CQWS/XYvrvnpgP3B0CkQ267d4NwHLaw9ZDEgfnk3RRHVCHyL1CtOogfVRZuGPFlTzF0cz27HUC9A6q+W2gBt3a4ng18tdmMlE1Fyz9DHg0m4x2OvJpZaRSWYar2cbGJMlYKzjYj39M931z05Nx3UkJFLca4CZ9Pq51SQ5pn6l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300442; c=relaxed/simple;
	bh=foooJvFPpaD5U1NIc0z1whyvvGUcJuzLkZ/bh7+WhsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9qAdAl0M4OT5dtIWfetGWpNdmoDIpqzmPLECijrksRzzwQAhjAgmo1s9GzEcINnXiaARN8sv3lQ32wytl8J64Snmrr16Vga6Cie/MEBsrPzCSyhXpjYXxGc9tlrrpB/N1sYIDz69N8WsE3NyYMdgff3qubgsFdnH1ObsxM6tDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHNEn+uX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DdCDc+5wwhrTWZmiggiHt07OVS9wseyBUBrB0c0lZSY=;
	b=YHNEn+uXzVBzU/XwxZMw0/d3gYAWzStdYNp7808Xf182VgyNHjsLFfd0rfJZP9kymnNeZx
	v3VjZ/Sd8k4prAq5sRilREDE9fb5j1kUNP2UL6CJBXV56Urf6brBzk0Zwz9RHYRwGE+50q
	ylcqF6xEfztZE7DpDX7etb+b1wPWsHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-ATrYOLBoN6-ief6U1YozYA-1; Mon, 30 Jun 2025 12:20:37 -0400
X-MC-Unique: ATrYOLBoN6-ief6U1YozYA-1
X-Mimecast-MFC-AGG-ID: ATrYOLBoN6-ief6U1YozYA_1751300437
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535ee06160so17608785e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300436; x=1751905236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdCDc+5wwhrTWZmiggiHt07OVS9wseyBUBrB0c0lZSY=;
        b=ZTv+D6j6JV8ehe54sHkdswYQW0XSFnFNqby1Ro3KVe7sZ5j2ZEe0hfxnZnklOBubLH
         rDGhaqr9iNlQ4gGeROMiOD3e5X3b7gWv2dWDbnfrokQLBY/C5/hNkSLVe0NjJKgT9T58
         8RJI9MEtEw1tEXliuzmfCYYfSl4hzsyUACD9q7OdT4mhyuMFDRNCpFDPHeK+Q4c9rzVW
         xlyhoV1IOWdPDFaGARjgYPYckcLqOBQ1b0hUVJKUKykjWvnKuvmHhU01KwlPAVoItd/x
         1GjFsVynp4fpjSf8dLP212rEJ79Xn4rF8eU3F8EOSOnDeX2TNH8skro1nJbd9g7R1Hk1
         JeTg==
X-Forwarded-Encrypted: i=1; AJvYcCWmEW9yZgs/VUdfFBwSBHdoVNRwYGyudiT8eByHYvIYSPMCp2u60o9OpvR7YiD+k4KpbXVsbPBLxiflUXQz@vger.kernel.org
X-Gm-Message-State: AOJu0YyQon3jIxFkMtB+03Y6fV4c81CoGuP0wQ0j5ny5eg4NxCwIV6uc
	Sx4bTXbAM/Of5pBOp+WN7tlAXWli9mlWRmvmkC3rMx2EnezXzknJjjXUR2+ITTHUaU+A9y2CWuF
	PxZsRptjxoFip3ugC5LoofW7s2AnSnTxMO9l+wE0ZAylLEcwlx8wMOV9ttK3pyOH9Mg==
X-Gm-Gg: ASbGncvQa/gFKmOsmBX3r5LtKADbtrB9DKB23ONgWODMR4/KH7Vtne4RRGQVt9yQZRI
	RS1UnMI+cuoE3omJiqsYg6rFJLenpH6HRH34uXtK6S5Y+6gtVZDT9otKfLRiKRDesFucDuVUBUz
	nJrOdkESItr72ya7a6J2XR3LZlpcTZmf2Md81+rR0I5jfv9GWCELmqd6pQLj0uWoYRvPZLIWvvA
	xJ5Qgir3kLAl7tYjO2MjVE9Iyya2L7IOJpk40QkfCufsU3Jy9yIWX7equBFk5eIFJ5RcQ//ql5o
	rIddtfpG3bM7DwLvJKz6I1o4RUbD
X-Received: by 2002:a05:600c:83c6:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-453a7264638mr5226465e9.31.1751300436487;
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBcIwNOVZbbeCVmBSm0GSwp6bviZIHyE1JnfXVzq6+huhRLCuA9yHQd2Lb4OcWzcyg0+4Wrw==
X-Received: by 2002:a05:600c:83c6:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-453a7264638mr5226125e9.31.1751300436014;
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:15 +0200
Subject: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=IIV2cRquSoQDpyjj3fxxhkDYmgsYRlcj84QBPmOyXno=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2epvKL1KqqgkNvm3IsfeBdK/GQ7Vj5kGz+g/JP
 HzuvPaEY2JHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiTw8zvCHM/bZTbHepcd0
 TPsaqyd8c9JX2aGyiV17oUCzhl/651W7GRlu3/i+kvuc0IKOb351FTMWH2dpPJxivOQ0xzIFl6o
 LPLncAL7sRno=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Amir Goldstein <amir73il@gmail.com>

We intend to add support for more xflags to selective filesystems and
We cannot rely on copy_struct_from_user() to detect this extension.

In preparation of extending the API, do not allow setting xflags unknown
by this kernel version.

Also do not pass the read-only flags and read-only field fsx_nextents to
filesystem.

These changes should not affect existing chattr programs that use the
ioctl to get fsxattr before setting the new values.

Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
Cc: Pali Rohár <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c           |  8 +++++++-
 include/linux/fileattr.h | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 4e85fa00c092..62f08872d4ad 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
+	__u32 mask = FS_XFLAGS_MASK;
 
 	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
+	xfa.fsx_xflags = fa->fsx_xflags & mask;
 	xfa.fsx_extsize = fa->fsx_extsize;
 	xfa.fsx_nextents = fa->fsx_nextents;
 	xfa.fsx_projid = fa->fsx_projid;
@@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
+	__u32 mask = FS_XFLAGS_MASK;
 
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
+	if (xfa.fsx_xflags & ~mask)
+		return -EINVAL;
+
 	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
 	fa->fsx_extsize = xfa.fsx_extsize;
 	fa->fsx_nextents = xfa.fsx_nextents;
 	fa->fsx_projid = xfa.fsx_projid;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 6030d0bf7ad3..e2a2f4ae242d 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -14,6 +14,26 @@
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
 	 FS_XFLAG_PROJINHERIT)
 
+/* Read-only inode flags */
+#define FS_XFLAG_RDONLY_MASK \
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+
+/* Flags to indicate valid value of fsx_ fields */
+#define FS_XFLAG_VALUES_MASK \
+	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
+
+/* Flags for directories */
+#define FS_XFLAG_DIRONLY_MASK \
+	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
+
+/* Misc settable flags */
+#define FS_XFLAG_MISC_MASK \
+	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
+
+#define FS_XFLAGS_MASK \
+	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
+	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
+
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
  * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which

-- 
2.47.2


