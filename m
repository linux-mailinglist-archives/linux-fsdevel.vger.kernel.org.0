Return-Path: <linux-fsdevel+bounces-59394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A940DB3864B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC692044A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43B31282B;
	Wed, 27 Aug 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te3Yn9b4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06827AC3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307767; cv=none; b=e+a2wf92mEKHcfBNHFprzPq59bg3AYMd1bPduVtuNQNyXXOPkOlmOKxCVuNv+Dark6RGXGhB/wrBhEOd4FMk6msoSplt93lKdoA0YbmPhOM95yXTN6WB+lCU2YxMts2bpCCKabBJmW9LGig1wVcY4lqZf2DyUnSBHknxHox/Lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307767; c=relaxed/simple;
	bh=izSJWa7mz724b1JHGLezzPPHQAOYuss7tQ3I2vbEPI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Uxb0CEEfYA+0HCuw0uNr98ldsHNuNY6AYAKIf2j/J7egDL+T5xr/L5tqGmKCSkF5elPxIrQ9jPdytHjMyI7z1abWfW6YsKt9UvaBybQG9f54zzh+udPYQ7Tsf/ukMozyqC2hW1AMALSAyT1BBJ9KULIGxEIsgfi/NFtVCydMoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te3Yn9b4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilPsX5xqHT53yqhTHdeXCad6dD85Xi19tJRkkZN2ujQ=;
	b=Te3Yn9b4+Ey/jJfeKaSAgJuwvjX5mFIAe/zv0N2Bqzfc02+PWt+pAZ0Zr4h57/yQ02GhpH
	JbLIkpTcTDo67QwVbPKbuhAUgoXjzyVjSr217HrohlyY7n2fGH8KtqbLqmYfXBGbKUgfTp
	e1DPtS3x/8x3K63//7uRWpbHIt1o+gk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-MVk2QrToON2AEEFtRDIBaA-1; Wed, 27 Aug 2025 11:16:02 -0400
X-MC-Unique: MVk2QrToON2AEEFtRDIBaA-1
X-Mimecast-MFC-AGG-ID: MVk2QrToON2AEEFtRDIBaA_1756307761
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so36651395e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307761; x=1756912561;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilPsX5xqHT53yqhTHdeXCad6dD85Xi19tJRkkZN2ujQ=;
        b=AwsVJHQdXP37KfAAtcK2Va8WwwezEap/CGNz1VzHkP+tvZaTrtSPRmhRXjEILKMAxF
         5TWnyCllPWshbMM3BmnddDkJ0vaGHRgqLLkmNsXEiIRqD1rKOx6jYTN2+dxvCm61gjf2
         RSKcD6S5bgE1g1SIpMmXFCDkraCHqn6Ux8HwQUAJtBd1ZEAnuu3fYQ9LdZRaVwlFlpg1
         Cg1307SjBb0ap2Y2l7G9MditzruL51HYPwZl5FZzns75ZkncxmQIAo/pNTQhvaX/FtVo
         +Yi8OgkFgDomDrwTzAPml5/JC2UYmCMh4IrYubO9YXZINNxAC7RJTrpk3C89CR6yfxmd
         yxsg==
X-Forwarded-Encrypted: i=1; AJvYcCVbWJIlyiMZqZU8wpPkdSwlFEcxka8pQxfVd4woJJhX0FDCjG6XDHHJbCp9x3EBPENhUhlXbGKFJ/Cho8Np@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+g5WNiTi12DCFMXmz19S5f+SXaJJ9Rtp9kFSeXd45c1M2AaK
	RVdjPlCluwp4hYH1Bg8C7TZvvMFw+qPuKqLFf+G65O5uR+zkSpmpOKRqi7R74zqHtHhFQgIYLJy
	Cp+t/GIx4LZlAHQyilIjU1YhM/zSSUsI+qTjHGpVr4yRHQXrR5akNs1SZwSNBfmcvQmnUZbUYvg
	==
X-Gm-Gg: ASbGnctqj4AE40ZI9kOpyaqbqyWUqwRyBN8E7L/KaOP4aCz7TCXghLTIYQKxLqP+qg9
	zWnBWflI5pPDgGsnoQJ8raZdDYqfkH6ECc/htUpoU/1w3p6NGEiiU5XL0tJWdKOzp2AheB+b9m2
	mSID+3KaTO5aqfyK68C+lGEmmaI+xvDcba3A4NM30w1/rCDLtA6yKhU8lWdwqpbQ22K3uUge0xa
	oZqGjHNKcGS6KmHwfUkpeWS6cYrKU9WyTjcXvhfU3VRvdLAbTJLKmdZHg2/r8qost581bXscLwR
	B56nmz6cZux+vbxvIA==
X-Received: by 2002:a05:600c:8b55:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45b54b21175mr167644055e9.9.1756307761122;
        Wed, 27 Aug 2025 08:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjEsUcMJyO+PVXTjXz23g996Y3GnnPBnHITgsL3/hdP62yPOXCCipt8Xc5Y0OEQxuWSFy33g==
X-Received: by 2002:a05:600c:8b55:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45b54b21175mr167643805e9.9.1756307760700;
        Wed, 27 Aug 2025 08:16:00 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0e27b2sm33896285e9.10.2025.08.27.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:00 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:15:56 +0200
Subject: [PATCH v2 4/4] xfs_db: use file_setattr to copy attributes on
 special files with rdump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-4-82a2d2d5865b@kernel.org>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=izSJWa7mz724b1JHGLezzPPHQAOYuss7tQ3I2vbEPI4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYr6sx2X2/9R/D67Q6xFYxlLXWhp/qbZFq/RwTff
 npny8VlBZs6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATGTPKoZ/ag2LZ8awTl3L
 0TMp2qHn0vufM3mZVTblO/sEbdHvd55awvDPlF/kdm7+m1dPhLcJu0x6k3X2U4jQtEvmWgdU7vC
 cbvjLDADKp0kQ
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

rdump just skipped file attributes on special files as copying wasn't
possible. Let's use new file_getattr/file_setattr syscalls to copy
attributes even for special files.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 db/rdump.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/db/rdump.c b/db/rdump.c
index 9ff833553ccb..82520e37d713 100644
--- a/db/rdump.c
+++ b/db/rdump.c
@@ -17,6 +17,7 @@
 #include "field.h"
 #include "inode.h"
 #include "listxattr.h"
+#include "libfrog/file_attr.h"
 #include <sys/xattr.h>
 #include <linux/xattr.h>
 
@@ -152,6 +153,12 @@ rdump_fileattrs_path(
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
 
 	ret = fchmodat(destdir->fd, pbuf->path, VFS_I(ip)->i_mode & ~S_IFMT,
@@ -181,7 +188,18 @@ rdump_fileattrs_path(
 			return 1;
 	}
 
-	/* Cannot copy fsxattrs until setfsxattrat gets merged */
+	ret = xfrog_file_setattr(destdir->fd, pbuf->path, NULL, &fa,
+			AT_SYMLINK_NOFOLLOW);
+	if (ret) {
+		if (errno == EOPNOTSUPP || errno == EPERM || errno == ENOTTY)
+			lost_mask |= LOST_FSXATTR;
+		else
+			dbprintf(_("%s%s%s: xfrog_file_setattr %s\n"),
+					destdir->path, destdir->sep, pbuf->path,
+					strerror(errno));
+		if (strict_errors)
+			return 1;
+	}
 
 	return 0;
 }

-- 
2.49.0


