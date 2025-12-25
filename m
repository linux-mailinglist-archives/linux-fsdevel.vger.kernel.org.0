Return-Path: <linux-fsdevel+bounces-72089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FBCDD6CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A80B300E444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D82F39C2;
	Thu, 25 Dec 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPbbcRHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C092D77EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647722; cv=none; b=i4oqNENkBZhg55XmL1cYLsPLyS5OcdS7dZ58CAJxHi3er3P7dy+F5I1dUArRI/6ZFHU3Bn8yYVQQxGalqm9VZY/Vca6sbz9Lp5mmQ7Qum/qgGZ14hiSwBYUJHtYADtW75E8Ogyt8VDMrJYZoE27ltAmeigcvolozYtCb718Og+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647722; c=relaxed/simple;
	bh=nDbknJ7IUdumOxpo9hBQLkqYxDx2G2kdEPg/Zd1nCmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6y6dcgo6lYh+8fh5JWsmb4bUBh+REW8DKm3tY05Hqk+DPzR24qDtLICWGbRL+099qY3GaMEOE+5HIYP3w9DDRh4/iz7AfY7nYhxpBmdj7PZcZEOA+rP23/lzA0jb2nTPtnXVDmfx7Cech88vvRPI3R7ncl5rS/IurBxeFumRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPbbcRHm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo7360315b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 23:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766647719; x=1767252519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6BFcbd9iyFXSrOLN1khZAr09vJHb19aUamed8L/NRg=;
        b=BPbbcRHmr2XAdJPMbciFDgXmgU2jEEOqvaF0Uodl2q4pcJDvclntXFPZBMU4D3Xmj9
         6EiI/uap6ZpVRRZCcMoDJixOIp/Q74rr4fZAXLUm7ON3pfULkisWRbsdReDXWge4UeBG
         3L9v7CvBQFDnG5tCjk+MXQDu+N2CGaJ3kTe7I81zz7N0bGn1sozoFkMn1XvWv/f9IS++
         dlFmBlqBrJNh9bHjIGT9ah8fgeQqbRnq/HXFszpC/oWICopN6Ix4hJ6MXRygPu9P+Gz+
         r35zBYl+8grrB7AkgdvIhsmieZHHX1eUtTXIbhLg+a1vCn5z5oUlp9n5qjQZpp5cMjTy
         PzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766647719; x=1767252519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6BFcbd9iyFXSrOLN1khZAr09vJHb19aUamed8L/NRg=;
        b=IdzPU2sNKE1IZcmOMpeWjE/iLtyTwi7u9upu14KMU4krhsNMLEWLicjQsKeGbDpsMH
         wdVwmpg9Ud/p9641knkK7Wy+S+PzSZQ9BoBIIZbnUOBi+550JsJ5yExsEl8oL+pPffef
         +bwtmKPHP1IIFEIJsC5QDCQ3fe+QTeHiHbIsasGFnZ2C8VI0auBys4uuWklUWx8HwIBe
         /I7oA7GcGAEc6fhIlR9Nd/SV1VwmzzAi6j0bItqWhMqNx2phvLgmbTrb8d5Iqs2nqsKi
         KD9OKBXn12lKUpR/XPLT7VTDE77oKLC2Ho6VsHlKXBPeXVNAKljjNsCtTKSpV1dyu2H2
         eX/g==
X-Forwarded-Encrypted: i=1; AJvYcCVCMqq3v6Jgb7srhoYySAkOIYef9I/Ho8BsY3SaGLcf+FURErEELERKIJysPWjD/+Fym5fU3kTnllQruRV3@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpgKQTA6RJYM//3N00mdZT/89BZynNFOW+F+XiO2aA377x/35
	C0g9cKant6KAwNX8IOUxzPFBnviQy9Oupxi1Oza+CaS6qruktt0Pi4CE
X-Gm-Gg: AY/fxX6f3Uq1qKzCBnjP6t9CeKnTsyA2yO9xrOJXxC6X/UeqGksWTecF9bJm58/ODJj
	EKZtmG3ISQbsD7y0HmEq7+tCxhj9wIF0BCztjFY7dDsr+lvpJ6QWFWAAVRoiu8mPAGDsLrgU6Kz
	HCtxsq7LCddI7HWMPjywrCGdipE1zCSjwAWvtLTmALKlXB0fzEJCpAny2XtAJDqXTb01a2jHf4s
	m7wfFFDhSRe+hELFjE+eUrGgUDg8zkWFN3H0fqFcnRLdFMcgh1q5pD/bhlYXXoUq97Q4oo5iZS4
	NvJzrZqfpmCsReu1prxzmt4UsxSDXsQeTxE0q3QgrIv6Mi1k7/V3OdfjobrMdaztKDi2uSGrZCC
	kIiVCmMB1PvbfXBOsCOtO9p64pYqMd3pv9alIgsCMt4uVvdEVYEJ0zSQ3x8/+HGyIe3sXaYo4J+
	+dmy0jtuqCrPwGwhoPEsTk2Amn7t4jZJbAes6ILdE=
X-Google-Smtp-Source: AGHT+IF2kBqM1Pc1oeCfW9iKt8MagjLl70ZYlJlrxss71glv1f95LGdDpd860qL8p+WKwgQCmnLTnQ==
X-Received: by 2002:a05:6a20:9189:b0:366:14ac:8c6c with SMTP id adf61e73a8af0-376ab2e8f52mr18576741637.66.1766647719168;
        Wed, 24 Dec 2025 23:28:39 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm15961406a12.4.2025.12.24.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 23:28:38 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Date: Thu, 25 Dec 2025 12:58:29 +0530
Message-Id: <20251225072829.44646-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 __io_openat_prep() allocates a struct filename using getname(). However,
for the condition of the file being installed in the fixed file table as
well as having O_CLOEXEC flag set, the function returns early. At that
point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
the memory for the newly allocated struct filename is not cleaned up,
causing a memory leak.

Fix this by setting the REQ_F_NEED_CLEANUP for the request just after the
successful getname() call, so that when the request is torn down, the
filename will be cleaned up, along with other resources needing cleanup.

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 io_uring/openclose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..15dde9bd6ff6 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -73,13 +73,13 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		open->filename = NULL;
 		return ret;
 	}
+	req->flags |= REQ_F_NEED_CLEANUP;
 
 	open->file_slot = READ_ONCE(sqe->file_index);
 	if (open->file_slot && (open->how.flags & O_CLOEXEC))
 		return -EINVAL;
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
-	req->flags |= REQ_F_NEED_CLEANUP;
 	if (io_openat_force_async(open))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;

base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.34.1


