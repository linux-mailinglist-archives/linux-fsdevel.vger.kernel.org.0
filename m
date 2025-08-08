Return-Path: <linux-fsdevel+bounces-57129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060FB1EEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B25A2DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A6288513;
	Fri,  8 Aug 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/7LxGgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7712882B9
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681429; cv=none; b=o1hwsmr5cyAlD9PClZyUMU+sj5RmqWP1aZy6sLwSwa1sZGPJUoHN/MCWO1ZMqZPjzZtMWWtrcuw1BZLULjcA0ek4K3Iub4aQJ0NppoH9wK75XVdck9g5dNE8loDjOz4xu831V0zFulCjYXFFij/aPmlJXgm7637ybcU7CmH5yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681429; c=relaxed/simple;
	bh=rkmNz1sSnysOaIdcGInEjZTg0J3rQpVEu6HfuiKCXOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=CVgoiiBIYASP2G91erDP7nGLZUCqA9nO/sHNIRIIqBSP98Z4eqMCM6up24P5qzRFDIbW27i88ohuKbIE+QoB/FlwPyj0SsEwJ6XSRPdlRM+l8mPobqsBP7Mm/l54QVMQbY9UxPqkBLT29MgY3oKH4mCLT85Z0vXuXPQ1aRUeVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/7LxGgq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpVGkkrUe+YakAilFwzjKDkOETJ448oermX++9pfg/4=;
	b=I/7LxGgqEEMGk1uIuiqfWcoynl39W2upcb4YPv03wZqumNBpwVsBbUyQ+9ztHBQXBBbOHD
	ybfPadj+4gM81wDVArBYq02SpzxLvPx1GXJdzAfuXBinwUZoCFtUHjoCfHYlemZJ9qDzXL
	YH6GiEL2FE2OwHE9qGZR/ZJNzh7GscU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-V-sfNPUzNbi3BVYGakwMmg-1; Fri, 08 Aug 2025 15:30:25 -0400
X-MC-Unique: V-sfNPUzNbi3BVYGakwMmg-1
X-Mimecast-MFC-AGG-ID: V-sfNPUzNbi3BVYGakwMmg_1754681424
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d7da3647so18893115e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681424; x=1755286224;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpVGkkrUe+YakAilFwzjKDkOETJ448oermX++9pfg/4=;
        b=ox0FlUUNJR9W7wMsNIt8rS8bcp1F9WXr+FKPhlDBJWSMTyNVsqMquxDVxO4WeVDUE6
         ip0mondPOptwd4pJPxNaWhLGgkFFELPQ4mvWWC1bJB6w3T50KGStcjwVlkzV1mM0K9VZ
         Uhw+9HMO3l/ntOu480b2+vJm6N+p/rLqOi690kWFVBpQySIY2pz5WI5sbz7a6bCqIMNX
         AxaUqcjt+d7dEHCrauGTbSyg9btZZ8jdHxiOo0uD3bcvGIhROMsmiSd3ZDNVjtlFthJx
         RWB2IDAXTuEElRz11h+xFeIwjdqwbB9I0vcNTqCrXQWB6DjM/Ff7SgKJFC7XmzjzW+FC
         oVjw==
X-Forwarded-Encrypted: i=1; AJvYcCUCmDDuSK1o0OcwgxtsaiiDdCFw7HPBeBw2e6sbbMwRpaXLhDrolQklk3LFY81pTOQSiUkoeIdyPTJsKLma@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDFEOa4vtpXiu3OajYg/S0ojDjtG5EnxPYNpsqgmmdL5EoSYJ
	Umz7f5NiYl76+9vNr0J44R8RGeVXxOoZxfX3UvCPMqYsCn2Tm+YOIg5sPHnDynbpuKm4uj2buOc
	IO23Zzy8L85M4e5XrNRotZilGGAsfukHyvkVB1RhUd7xxiCZoHUFStl/gHlCbS0PegQ==
X-Gm-Gg: ASbGnctVWR28lJqzRpOpxivw09i7MihV34A4jssAsTfk9osle/leZwm9m/r2mvOpgQc
	xcY4+MyuZTVJQaha/4mu53YsvqNYaaNfzxx7jMWB629XSFC9Kj2a/iU8kNTq2fvBacVUXqOlzo3
	Smq1lnhjPaYGhEyngDipzExZo602WbYVaoEU31Yl6wL4TdxanGZsbndQcveyEYGClqQlO+JkU83
	m57Rjct7Ux+ZS5qUl3W7XxGyl8GkC+0BV+FmYO72PsiKbYh1z+p7WIjmjYFF4r20M2nOtXGSy9V
	Xo8p3YHezkDjjxw8iNfhAZv0qpT9qq9uWSgg/1zUNytYZw==
X-Received: by 2002:a05:6000:240b:b0:3b6:1a8c:569f with SMTP id ffacd0b85a97d-3b900b49861mr3916106f8f.1.1754681424070;
        Fri, 08 Aug 2025 12:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJrVlyIhj5KYTf9nlfZi/yobMCyyW6+KZtHs0zepTVKqSEVXLpboIqqa5l9qlNh4xq6cN0pA==
X-Received: by 2002:a05:6000:240b:b0:3b6:1a8c:569f with SMTP id ffacd0b85a97d-3b900b49861mr3916076f8f.1.1754681423522;
        Fri, 08 Aug 2025 12:30:23 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm8925162f8f.69.2025.08.08.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:30:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:30:19 +0200
Subject: [PATCH 4/4] xfs_db: use file_setattr to copy attributes on special
 files with rdump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-4-48567c29e45c@kernel.org>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=rkmNz1sSnysOaIdcGInEjZTg0J3rQpVEu6HfuiKCXOg=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYFeC97cmja525mk/VHWDwyzlcw9PcHS5RW6IgKR
 K3rSDih/LmjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARGQfMzIcUHUTum4oN785
 9wHPAjXpq42vTqbtKuH+wijx9EPhmdZURoabZwKK7BtDG7l2dVWbBsiaHpywP7RmQc3yrgcn4vR
 vZTECACz2RNQ=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

rdump just skipped file attributes on special files as copying wasn't
possible. Let's use new file_getattr/file_setattr syscalls to copy
attributes even for special files.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 db/rdump.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/db/rdump.c b/db/rdump.c
index 9ff833553ccb..5b9458e6bc94 100644
--- a/db/rdump.c
+++ b/db/rdump.c
@@ -17,6 +17,7 @@
 #include "field.h"
 #include "inode.h"
 #include "listxattr.h"
+#include "libfrog/file_attr.h"
 #include <sys/xattr.h>
 #include <linux/xattr.h>
 
@@ -152,10 +153,17 @@ rdump_fileattrs_path(
 	const struct destdir	*destdir,
 	const struct pathbuf	*pbuf)
 {
+	struct file_attr	fa = {
+		.fa_extsize	= ip->i_extsize,
+		.fa_projid	= ip->i_projid,
+		.fa_cowextsize	= ip->i_cowextsize,
+		.fa_xflags	= xfs_ip2xflags(ip),
+	};
 	int			ret;
+	int			at_flags = AT_SYMLINK_NOFOLLOW;
 
 	ret = fchmodat(destdir->fd, pbuf->path, VFS_I(ip)->i_mode & ~S_IFMT,
-			AT_SYMLINK_NOFOLLOW);
+			at_flags);
 	if (ret) {
 		/* fchmodat on a symlink is not supported */
 		if (errno == EPERM || errno == EOPNOTSUPP)
@@ -169,7 +177,7 @@ rdump_fileattrs_path(
 	}
 
 	ret = fchownat(destdir->fd, pbuf->path, i_uid_read(VFS_I(ip)),
-			i_gid_read(VFS_I(ip)), AT_SYMLINK_NOFOLLOW);
+			i_gid_read(VFS_I(ip)), at_flags);
 	if (ret) {
 		if (errno == EPERM)
 			lost_mask |= LOST_OWNER;
@@ -181,7 +189,17 @@ rdump_fileattrs_path(
 			return 1;
 	}
 
-	/* Cannot copy fsxattrs until setfsxattrat gets merged */
+	ret = file_setattr(destdir->fd, pbuf->path, NULL, &fa, at_flags);
+	if (ret) {
+		if (errno == EOPNOTSUPP || errno == EPERM || errno == ENOTTY)
+			lost_mask |= LOST_FSXATTR;
+		else
+			dbprintf(_("%s%s%s: file_setattr %s\n"), destdir->path,
+					destdir->sep, pbuf->path,
+					strerror(errno));
+		if (strict_errors)
+			return 1;
+	}
 
 	return 0;
 }

-- 
2.49.0


