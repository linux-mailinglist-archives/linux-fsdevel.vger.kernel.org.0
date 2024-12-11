Return-Path: <linux-fsdevel+bounces-37090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CDD9ED6F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20767280DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633B209F4B;
	Wed, 11 Dec 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCFqnATY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD72594B3;
	Wed, 11 Dec 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947421; cv=none; b=NfYa9v3o12nDwkIph2ZWqLXyWLOXYyq8lV4zGewa3hdvaxpcrGmOXT7YW6HC5CrISxiNnT4FXdhRkbIvcV4emQbk1E5xUQXDU0H80iyIZkobsArAPp5RpQ9SUMuR9Ao6YET+8/ncdCmYfeiZu/owkouSO0nETVHbkU2arlKUcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947421; c=relaxed/simple;
	bh=c+2c10RP4eGxCZIDeYuweNxkKIm5rRVnujDbzoBRRQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lctoM4N7lcm6ZYW7jl5o4qzwzVcDffFXvi7oSwjSzpMKkuyx9hwxdGNH5gAUadxodukULkm51tnGi9NFG8bGQ/OmorILGKC8hMf7X8AkII6JQvImRFMEYPIEDjIoUP9X3IYBv6F2fASw/UOjXJWF0HeuDO3SLncEFJ9KILuKcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCFqnATY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso5162569a91.0;
        Wed, 11 Dec 2024 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733947419; x=1734552219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpNgAxO5KyvvV+aPXyUgI2o0mazz3K0LzFSUucmqIA=;
        b=YCFqnATYSunrFPR/xMGodMXv0YD20QQJzz0i18a6NchhuOlfzVxnorFb6WppvXl3GR
         22/9j8azIvanopYeQveeX2JdPPEAz3hl5Qn2OyCOBSoKzhr1sv//KgDzzLT7feyfPt31
         oX+OYRXjWlUZBIx1+MCN8OeuYmfuT4p654PGYCOZcnYqVY6Np0oUDHeSGLLvTwjVzT7L
         jLMkWnTqabn5Cd8/FI/YSq8xl5xUAHNDdwoUBKzZ23sSWeczGfpFcL54OsHu3Hdeh490
         O6Fspf7J+PKl+1Fe0T3XHUrjGCpavXhefsi9hBaNaL1CNzf4TQAHd1WrwpqUkblEavyh
         29CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947419; x=1734552219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjpNgAxO5KyvvV+aPXyUgI2o0mazz3K0LzFSUucmqIA=;
        b=hY8HXfA7D/7GDfZF4oMOOANWz/VOjwdJEMZE7CcIihbLDwAzM0H2FM7Q16Mj24Pj+B
         f5R7RLyb0Wm/abfVbz7VlvPYslifcywyGPWUGfOcodxPeRyyMP3/31uiIuy5KRswq9MF
         mH7CWKpnEBhg5MBkt/lTFELWZZwqPOmkUQfVDlCvBZc5Mpv29Nx6DBaM8CYUkYlzj+lb
         zlJjc9619XXsAhcsbA8lpTnQrUXMsK0E6hRuc8cz9E8BEQ549X1unDhCPkovqTP5lIQA
         5/ZvbeRK1hNAdyEWbfSjrl0u4DXu/hsoaFOgd1UnEZNoqdM/i3Kf+BDQ7x0X27TtxZis
         JoFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlAvoBTFcVbVz13RahuG6BwISuYr2TnzcBn1PrNU3mTLu78p2Jy8XL6ZwIoQloqKV3TFbcfPvNBn3Bc1dv@vger.kernel.org, AJvYcCWALotstSXHoGkEkj6hO0u+Bvs5pZdoQIgGfbmASbRX+r5E2r8sbDP96GiEysZ3dOIIg+iZrMGCmCedJrc6@vger.kernel.org
X-Gm-Message-State: AOJu0Yymt/RyOYSBzNa1KjAVtGicd68DO5kuCN6rZX75VYqo16+gDYK8
	ZmDIY3ZOI2AX8rsvMeVSeQHpk55bWublur+o+ZeycEwShc6904cT
X-Gm-Gg: ASbGncsghyzoOcsnzexkpxJaP8y/lFEd0fOHdWcIG7sU8A3F787jaDXCBiiQoo9xHOr
	l5kJlAWgb71ZZz2T3G4ktuUlQ73bl8iJx0A20HZ9ius6lqpq3i1+4TKug0DEkZPv7F/Id4N4px8
	O+7x7+cSrry126ZF2psHHlt8ZXnQxs3uCcrm9V5Y2i0tMv94xaq7+Gx375mTc3u1wZb+B4uW8Je
	JDaq3A6qvMMYUZfA8tWNVzmWSCjN4Wgh9gxhzBPhk0s9LOuU1TUyYt0ZtjW9+D6KSntsw==
X-Google-Smtp-Source: AGHT+IFkpFW//odQIKH7vFlXlfPhvueJRWLMq59qElOmOHMBZNOyfMpmd6lTVOFk+xCH3IcDg/u63A==
X-Received: by 2002:a17:90b:1c87:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f127f7e587mr6242980a91.6.1733947418716;
        Wed, 11 Dec 2024 12:03:38 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a69f:44ab:93c9:b027])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4757691dsm6158725a12.18.2024.12.11.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:03:38 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org,
	ericvh@gmail.com,
	ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org,
	v9fs-developer@lists.sourceforge.net,
	v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk,
	Leo Stone <leocstone@gmail.com>
Subject: Re: WARNING in __alloc_frozen_pages_noprof
Date: Wed, 11 Dec 2024 12:02:40 -0800
Message-ID: <20241211200240.103853-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675963eb.050a0220.17f54a.0038.GAE@google.com>
References: <675963eb.050a0220.17f54a.0038.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot creates a pipe and writes some data to it. It then creates a v9fs
mount using the pipe as transport. The data in the pipe specifies an ACL
of size 9 TB (9895604649984 bytes) for the root inode, causing kmalloc
to fail.

KMALLOC_MAX_SIZE is probably too loose of an upper bound for the size of
an ACL, but I didn't see an existing limit for V9FS like in e.g. NFS:

include/linux/nfsacl.h:
>/* Maximum number of ACL entries over NFS */
>#define NFS_ACL_MAX_ENTRIES     1024
>
>#define NFSACL_MAXWORDS         (2*(2+3*NFS_ACL_MAX_ENTRIES))
>#define NFSACL_MAXPAGES         ((2*(8+12*NFS_ACL_MAX_ENTRIES) + PAGE_SIZE-1) \
>                                 >> PAGE_SHIFT)
>        
>#define NFS_ACL_MAX_ENTRIES_INLINE      (5)
>#define NFS_ACL_INLINE_BUFSIZE  ((2*(2+3*NFS_ACL_MAX_ENTRIES_INLINE)) << 2)

#syz test

---
 fs/9p/acl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index eed551d8555f..1b9681d58f8d 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -28,6 +28,8 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 		return ERR_PTR(size);
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
+	if (size > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-ERANGE);
 
 	value = kzalloc(size, GFP_NOFS);
 	if (!value)
-- 
2.43.0


