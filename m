Return-Path: <linux-fsdevel+bounces-60687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE93B50106
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EE03B2158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA61352071;
	Tue,  9 Sep 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVony3LR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF52BB17
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431495; cv=none; b=NxkLcU5Rajb+kn0n7Ydd0hEfXP1RI1tGX4r83PjDkN1uA8JmsTnm3Dck0icrHHt3tNJ5WwrZWHmH2dgpRW6QJkXHHx//oU9HqOeLpeETgO83qQl5Z+x9/xdi3Utc0LtWn1Sjs2nfGwtfonrDIJOezgdwTwoNgSgzgPOg50RL1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431495; c=relaxed/simple;
	bh=z+tyXqRc3qX4wqplgzQnqDbFqxJloPMK3+hI46X8YgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lf1WPlPW3rn9DrgVNSgptcnwHPXn1K/Ygv1Yap2Ezh25sUACRWriOkDxYNnzPhKQu27dphvTGMdZyrXX3WE8pOwZvxSxGUL3zFH4edTJxfgekx6GZT8jP98A76No2esQ+lLVLzUXsjiY2kRyjDVmxlKT4gUjWz6yU8ZFYvgi79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVony3LR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svATf4jV9PaaZloPDRsoRh+GR/XlAbjioABy+qAlzGc=;
	b=fVony3LRaumUVE19GOL7nZdCWd3CGrk8oofIe4BB9b74Tu5jq2Evt5D4bNIt14v5ghIvO4
	MZ0Kf8esAqSo1DYMOC8WSOmiPocY38E2cMFl75uSOpcwcaYNaLWZeCkFLLht3jspPuhRYe
	O3SkrF64bqU/ZheYigoUOyEtQX4VUrQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-vi2YReEBMEq6UibtYr_8LQ-1; Tue, 09 Sep 2025 11:24:48 -0400
X-MC-Unique: vi2YReEBMEq6UibtYr_8LQ-1
X-Mimecast-MFC-AGG-ID: vi2YReEBMEq6UibtYr_8LQ_1757431488
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45ddbdb92dfso22445495e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431488; x=1758036288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svATf4jV9PaaZloPDRsoRh+GR/XlAbjioABy+qAlzGc=;
        b=bFFwmcZ5G9p1S09sD8XjCq2gCdlMSw7Qp+xgbJrhKyg2QxOjMwmPqGK6MgxGpVHEZA
         hvweIVlUaltMHCXwJl+rawwt/rL395q+eP/bnHzP3n/KXPqMCTNGyHI/CwM0ZBYpbHXo
         DY1yBCS8tjRWjpj1JCmKMyV4mWeEwZw/UfT93ijVVur9ZjaqGlSfJCkbH1GufjFyPW4+
         j1KpZSuDwohiQXLPy75/qQ21tkrkXAg6hCyiHYxAwoqyjFDBHLKCCcsixJd0tPnZuZYZ
         y2EeSDhr2EY+yGKy4xF5V8YYae1gpLSVQ1MOU2KB+nLuMtsqlTNYHE2bJgk1QeeAvV5z
         c8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFiFDGXAV3yC6RBaLs5LSywywlhfKgx664tdS123s6xBNTm1E3U5e1Wxx5/LwxJZdXa/k/Zg6n6WTOuMdM@vger.kernel.org
X-Gm-Message-State: AOJu0YymNA+N1COTAV+Eq0IhuUlYQG9dPci75iN5DKBRk/JCqelcbEe5
	OfaMiBtjhwHI5N3DKOV2geb+qkeeTYOgwpA/yPEex12YQloiL2uKHke1wTDz/qqhZKlbWUwTmPS
	mWHj1o4GsVizmDIhGhVc6Xv5yoxEVDiIEm0d5UGLHEH+VXeoTdtkeMdoYMw8IAsRELg==
X-Gm-Gg: ASbGncsThQub+MKz/F3iJFF3vPJf6UJDLTWeRDo6vGbOebRNpNmTgjE7KOofMoEG+FU
	I7bUG4tBAfll6b2D7sjmu4QoNKaT7iPZHHnUO0gwFUxSNOM3lB5Vr/wnI3daadccI857jhc1L0W
	F2Pg3dCMrMIsbXgzYydLA59UhFDI6QXyiUK6evRzqJzIWFj1b6IadYkzUzwSuXQPeF+PdmG3tRG
	I3ELNHU6PR0KzRYb7gGExKbaWzKhA4GlajzQqV5WBJbK2eNEwHutPWpsWGS85vnoJg/8JQyrLeX
	adHD74o404o/ZAFPLSuXB9jKTfMnWvEiNiVB6eE=
X-Received: by 2002:a05:600c:4711:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45dddecd454mr99452925e9.21.1757431487609;
        Tue, 09 Sep 2025 08:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvf6FWC/ciiTn+/Mgina5JZXqPtWrvEBZEV9wK96oJZ5HTW8jnE2JD2EpF5Zh+/kwyDtOPCw==
X-Received: by 2002:a05:600c:4711:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45dddecd454mr99452565e9.21.1757431487139;
        Tue, 09 Sep 2025 08:24:47 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df17d9774sm11432015e9.9.2025.09.09.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:24:46 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 09 Sep 2025 17:24:39 +0200
Subject: [PATCH v3 v3 4/4] xfs_db: use file_setattr to copy attributes on
 special files with rdump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-xattrat-syscall-v3-4-4407a714817e@kernel.org>
References: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
In-Reply-To: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=z+tyXqRc3qX4wqplgzQnqDbFqxJloPMK3+hI46X8YgM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMg647VJeFfRS5PNbm+txYXFHulYL9+/rS26boicl8
 yNTWfUrU1BHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiWwSZGSYWi17/eyGpMrW
 1kPhywLCDlXWsKg3iU+0O8tzeWqcW38uw09GoSpeHZegCFvB6I7ADSsnzBIUXDeFpUr8hHn2Zz6
 hJfwAlglCEQ==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

rdump just skipped file attributes on special files as copying wasn't
possible. Let's use new file_getattr/file_setattr syscalls to copy
attributes even for special files.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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
2.50.1


