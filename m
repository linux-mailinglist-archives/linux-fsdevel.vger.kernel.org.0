Return-Path: <linux-fsdevel+bounces-56361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE4B16783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1ED1AA41EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054A21FF36;
	Wed, 30 Jul 2025 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbAwyf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73821B9E0;
	Wed, 30 Jul 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906745; cv=none; b=AAWo0GyDxG7xgMIIzGadRJve8HOEjcCdSGvArkm2LtJuRppOXMBz93H4G8edDLpageMvHKkKrCb5p+9IWQRrhl9/BVbqqqHKBjzHS05cLWfibREIWqxDYAGQFMQwGM78MrS+YbEdxk8JQTQSTRK3/E/z/zmjPFFzS6X5lRemWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906745; c=relaxed/simple;
	bh=aB7CBF9ndAPvB+Xnx16s4jRkTWA4duLFe047G2Mi1b8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDtcn7KcBAsplqoOGruXh2GYahyfwN3fdQJ6Eu3N2wKv5cKPjGduB6aEoqPiqInOX8BbWN/ftBRUNYla91vXJuFdro1kh1NLnF2/IINd3lLOiPQxxwTUVhfSBq2qfssZ8O6/ZxFZ4ucy7x9y6DI4DH7ZLudYtF+JZW3iMhRAtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWbAwyf+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76a3374b143so296551b3a.0;
        Wed, 30 Jul 2025 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753906743; x=1754511543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlO42ltRQH4KQlJYhZ6wjecii6JSbxSUwJocNSNqQQo=;
        b=XWbAwyf+4JWRLDQjSUrPb0doTc3l6/uZAG8549XFmME477ZnAdz4Sh0HsI5CZsgjNv
         g0JOgg1hbI+LNxCUMJL9aruzU39XtEtCYZp3vaZ9q9cCcVswcvGSsx4uyXqxP/Xs5vJH
         Z+f6OnSmcN1gpxebsHPWEMKT82ksVTLObrOWzNXi5ZqlzWBUGE4YnZ3I5kcmM8lWjqF4
         WubBDXwIRn2/bL0Y/9LJA/tiJssSJ6OKQ8mWqIStC3tAr4mnwSLf1aVudcfJwIO98EaA
         vpChdG6mEhQ9z2i1XYcOyhw6Rs2yDHIRVEU4u0rMtFzl6aLPFN/0DtWIWcVyDkbPejkU
         ZJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753906743; x=1754511543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlO42ltRQH4KQlJYhZ6wjecii6JSbxSUwJocNSNqQQo=;
        b=k1CE+nPYI+sofKbcmBirwaxIRPJEnBO1wzX4nqeFJxRXBgq7A5Ce7EJjf8OuTd1C9Y
         yKo+ZJqJ8JwCE8wgY2U/juygkpeR3y3dU+zVYHmZmWRWnOsrA7jic7OysACKfrtc64Rc
         fc7hgCJ35knO822fgwIeGU6AIsFM0SgUn+o8OBCwI5405YCAFei8JEoe/Hy//wGWFzzB
         ssc8/3jyNvvUQO8KsS89sVtafw3z2TO5Z1TFlGOC+TKiaVUm90vAdWzSizfbqcXNmzMV
         Im/xDuh7+BXOdT3dNkCT4uLQ0DdF+lSxaKPpR/qBgaz2q/uOgt2287qvBOoPJjpuYqJm
         Kq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVb2Js87uVUR2i0KYmMpzWrLiXzPaKeoWP3Tq4E6CkvnSUcBfzS1sZE0aVB0sXKN+oNyL3V08Z1tnCAEBF4@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7dHMI/b3+cS9sO6YZbV4bbNczNkYNeFzaMA5+rd2jCxzd0eo
	6tTI+lId0paU9/HTiJ/vZpz/2CtLlYEPc1uxEkydzE2GaO8SSq3hrsiZ
X-Gm-Gg: ASbGncsnKZIFo2QY39vTppbfv9B3J0u+kq2hLTyezHJGhIfehQUmOzDtHPNMoZf7m70
	RPTbwEHGCU7rMdHYS7SR3DDyB0Sss8td6UQrHQq+xjG9XIpbqeY16kZkRCvbeszzNJzfSHzyskB
	mNLdyJTdxIuD5WfkEkfw8kKvPGUSCjYkb7ytUulF0odBNerUkeJL6xcbAJZoUb7QLHWaqwR/dvm
	yb4cNeM/jH4Y3em3DCA/ZC5vt36jqQRmJI5BRcgMaiNFN/MTPYPZbW/qJWMo3dYtMc4MkAF0iQT
	+7RWLNV5ZkiWAs62kmF2WArc/rUUI/oTEhkvhIvB2MjBdFF0MI2AbGM2rNbjw/uNrm0QlBRZ7QI
	lRzyj/zc8H8BKSa+M37Kc5VJrZJ9yg++dkEwdHiGQ
X-Google-Smtp-Source: AGHT+IHBG5gx5IHA8gfp0MfSUg4wj7EQYZ7A9K2oxxf6n/sZ+QJuN2mQffF7BmQWYJnYW6g8lKCcfQ==
X-Received: by 2002:a17:902:e848:b0:240:3915:99d6 with SMTP id d9443c01a7336-24096b236bamr65250465ad.33.1753906743191;
        Wed, 30 Jul 2025 13:19:03 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009b8661fsm85484925ad.126.2025.07.30.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:19:02 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: skhan@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] fs: document 'name' parameter for name_contains_dotdot()
Date: Wed, 30 Jul 2025 20:18:53 +0000
Message-Id: <20250730201853.8436-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for name_contains_dotdot() was missing the @name
parameter description, leading to a warning during make htmldocs.

Add the missing documentation to resolve this warning.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2ec4807d4ea8..d7d311b99438 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3279,7 +3279,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
- *
+ * @name: File path string to check
  * Search for ".." surrounded by either '/' or start/end of string.
  */
 static inline bool name_contains_dotdot(const char *name)
-- 
2.34.1


