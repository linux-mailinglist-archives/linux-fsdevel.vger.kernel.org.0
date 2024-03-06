Return-Path: <linux-fsdevel+bounces-13755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C309C8736C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006581C227F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D09130E5A;
	Wed,  6 Mar 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMmn96V7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDA61272B9;
	Wed,  6 Mar 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728861; cv=none; b=JHgWbBlWo5ESu20l13a2F7LogjiA2GoCFfKUQXd6mW+llFiHDXd97LBGCXaq+ZVDqwlVF4wq6XHhmuTI2luoUkY2QSp7T86xBq6M71ntpprcZuVloJh1BiCKhtX0YwoQ17tKqw/yMYjLY+suchbQVFBz89CKw/hw7LDHyF9nevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728861; c=relaxed/simple;
	bh=UtXFUhqermy9LTNrI/IvJ4ub3irTv6w86+6UyvBqI9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FHqr37Ifo619rgyc3GoWiicHEotxdQb2S1eF8utlClS5FiPcj/BgFVFJ8Kr4Z8F77AnUGUemdMcFYpkoCEoJAYr9nkx1M4K2+96rSe3nPOvS56I/ficxrBl5iOmsmoyakCk33YqbzFSP2jjdyOiFNgXzfweehdshWinHSebY5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMmn96V7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412f0655d81so9651565e9.2;
        Wed, 06 Mar 2024 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709728856; x=1710333656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb4JijoDvx9NYWTRsmYG7XFGmbbVsOk1cVh5cF3zIr8=;
        b=IMmn96V7S7rEkLoUjg0K9Zp9I2vdCvKuqsz6fGO4X5/XkDWxrIlcTiBPQBZoOfZ1Z6
         TavlD9yFiDlJK7fg6lzhVn98J+G+J46W1TGA9R/R1mj7eXmbiWAJf/ydetbDkCoLrymm
         sgvrdQ3BerwV6ZNGGBu/2BfBaAj/dECNznbMLUHYGl+JnqR2bnffYCgI7OCsJ6hNzYEa
         Um0NBPShrjhGOqZsorqUSK14FXLxoeacT8tPlrg5Kom9j5CNc4wUPZj121l0q1jps29l
         hiyILtrTQM4frcWVQlFJHY5iWXws6NlDm7ScSMLoE7Oi23StOD31VC8ur9aRMwmt17MP
         Evrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728856; x=1710333656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb4JijoDvx9NYWTRsmYG7XFGmbbVsOk1cVh5cF3zIr8=;
        b=EFGZM+OPTL1DnxLT2ViLjY5XXtB2Mr8srs06dSSDNWPoPyQJ76otMEH/Dm/hMJF3+r
         ShgL4FjQn+EiM7hGrMb24DaQIKcB0+tc32orO8SxK/7sGGRyJUxRqmm2F4bowqTtz6Wc
         31cEnOccVTCqvo8gBzRoT9odAuDM0ltOtf1Zhy9fcJWhwISJ02U0wxLtIiGNN3WGXQJI
         ZfZXi3ooRbEcHszFoFBbzWcDUxZ4RJFcZqNcZbB/G4x7pAzE0992MEp8sz+aXAmyJe7L
         uZ+gp418seaNeRU2tGROydB9cLC27oFgnCKgLuOSsd/uQZ4uEaEjman4+AKqujLSje6I
         6rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJzAOfwfeurAFuyq1UkZTG2tDNbuAdS9fn6t1j83uD29y2Cq63VhubVjx87vCLrf/VIOlK1d/6rzqiyBTuikCleQ6aULZ8qOp1ZjK7Q7iaMk7xHBOPCLpW108JdP1EC3G3ybEJD6bmkxtr8g==
X-Gm-Message-State: AOJu0YyI+g2QFhI19dlWhaCdN6hzWvSKRdBwLunr2lJjNlaLFsN0taCn
	eHD3deXTnoHep+CsQF8P77dqfiubI3TezFyYp3jZWpLTb5IhTra1
X-Google-Smtp-Source: AGHT+IF1DaezPiqzFxxA1H+f5F4oN502JTyV/jTD1scFcDyo8uoWYmdH3zmw/9EBnVpZ5lKsUQzOAw==
X-Received: by 2002:a05:600c:4448:b0:412:f6dc:1d3 with SMTP id v8-20020a05600c444800b00412f6dc01d3mr1046437wmn.11.1709728855924;
        Wed, 06 Mar 2024 04:40:55 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b0041294d015fbsm20904242wms.40.2024.03.06.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:40:55 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Wedson Almeida Filho <walmeida@microsoft.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] hfsplus: remove dev_err message "xattr exists yet"
Date: Wed,  6 Mar 2024 12:40:54 +0000
Message-Id: <20240306124054.1785697-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

While exercising hfsplus with stress-ng with xattr tests the kernel
log was spammed with many "xattr exists yet" messages. The error
EOPNOTSUPP is returned, so the need to emit these error messages is
not necessary; removing them reduces kernel error spamming.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hfsplus/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..57101524fff4 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -288,7 +288,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (!strcmp_xattr_finder_info(name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
 			err = -EOPNOTSUPP;
 			goto end_setxattr;
 		}
@@ -335,7 +334,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (hfsplus_attr_exists(inode, name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
 			err = -EOPNOTSUPP;
 			goto end_setxattr;
 		}
-- 
2.39.2


