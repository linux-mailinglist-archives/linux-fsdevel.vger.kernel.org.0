Return-Path: <linux-fsdevel+bounces-63970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1230BD3471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAE524EC3BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9142228CB0;
	Mon, 13 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io1hlNIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A75227B95
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363249; cv=none; b=owZOn1Z1yToo/KQrUc0FHOTscwjmngTv/gWNx17DiR6GuDniozaicAvffFK25L1uqm+hfTi0rgKLf10MkCup0YsNGD77s6dGdY5uC3xYnm/tFXNwC4tcaA2ZmWNp+V//lzC+PBSO4qjKRTS9co6YZRFDsOI0RvGK384oL97Zuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363249; c=relaxed/simple;
	bh=Swp4+xHTqvgYr+z64DMuU57MVlL3j0v8jDSlSv8/1Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amHPzRm1S+EyFIqB2v7+deHGLiC4sBKLXE4BuxYaMTh36+TyWyhjqP0UFzhxFnzGKVtNc6yqK7xtF1diNlWGoupMWAfegDU7iJ4fupQCXj1lsnfOtBOENkz0DpQkGBc0PQxJ3mNCmbkBGv8J4ksQWVbVc5nx9AVZleDXPx9fd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io1hlNIi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so3321782a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760363247; x=1760968047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=io1hlNIiVqXlc1wjOO1Rak6dG0PCmd87m6yKf7aSc0mEZV0nxR+OmHBUv4xbgPmchU
         UT+ohTXQGkOWgu7RQUvjFsuw3jx95XXtFJj20VylppMWy9L9VAsDDkBiNpYVMusvyQ3o
         5wjdI0ZxwK366brx/sQD+9O8TEEWQm7k3m7aFlh6Nc3UJ0aqRWHBeoXzgROm4kJ/VXaI
         3pp5GEfkHcyzG+rdmiiYdmYN4N9F+SvKTQaUK/x/f4/7Fajd7S3IkP6Zi9AcdDIoz+tV
         1+5p1fKcdPVgXYtm6+w3qn6va/Hm+qiv9MFZnQXvkRaD0TGc+zOt81ZvR423VgKgR1Xu
         jzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760363247; x=1760968047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=HQHT+2OJ6Brnn8ZQxYBttmHBvuMFj7u6O3d9g3z8cx89QR1jeVSFTUgMwNBI/MhqST
         aC9KR29f3BTKeSiUP9MvDcrWxKkbf16Mv1ZD03VOT4RnTKt/do6vkE3FMn0KXcgnNxuH
         cneDdP0x9ZD5A99zIEcAPHZyhY4RNkNzZC1hNPsqTGISR63HctWqvLGAw0ws0n4wM8Y8
         qn8JcgkV4COfOoYqNX9kXDvRISp/4uXlcf05tZ7etQALuRNy6FbwDu+4BIvu6DrfjoU+
         j49rALUaTDAyweqkXfNvrJC6sSATUdbcxQkiFSK3axhqDb8c4twxllgKrI8kYhzeI/Io
         69Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVHzOwM3Vtib61ryzl7No4VVreDhso7rdlZlm2i6zkD1mTx7oWvyxI2HHFk5xWlMWjV6998+cWtpNCaRsEg@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcDcRFu615TBStkwogc3hlozDbFUVOc4kmzz9qWjfTmU6jtNV
	Fs+BudXz0hHs6uqIsqSLdSjhaZZlvrREZ3NJUIBCydl0qtlFbp5+hLY1
X-Gm-Gg: ASbGnctp7rAyfjHzmFhrt09pzSsC08fYdMpiVgivAGGl3PgW5cKT/klIoL2vYIAj9mO
	b5LilXxMdivEbYdTBz5eF5trNa6Y9mqgQSj+GDY1urYWv3O7MVv4NxrIHIAYO7RB60fMCHHUodR
	7qqbkAsBFIeKKLCie5pIxuhIwO6jEGLbGXDmYS3xim+0ExxU0VrdzQ/V13RYgmUeXiOxIs93dko
	tZxv8lIPQHxQpWu9n2Fi5RF2aPAEtjLXZUeaRjJKCIdKSEK2gCC8a0ezohx8B4tqtN5TmG2nHAZ
	+7UTyy07hDil3RQaxF35Ufm8lZIrot7omk4ByAiWwhrfBz2YpfCTbbT16iuOd02G7OVcRq1B1HT
	tYPB2wFwnafLY+aV74X387RuqE6YW4hMvczWpbIwuflAsCEiScjBWQGxgj33Dyx8EQ/qJ
X-Google-Smtp-Source: AGHT+IFD9xM53HQ+bQQDPEQgAUdL3IwH91zz8prxo1co6ZEPN18n39S7OZmUBWp8Eqf4/zWeSLysJQ==
X-Received: by 2002:a17:90b:1d06:b0:32e:2c90:99a with SMTP id 98e67ed59e1d1-33b513b4b51mr31706554a91.35.1760363246720;
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d61aasm12295067a91.17.2025.10.13.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon, 13 Oct 2025 22:47:08 +0900
Message-Id: <20251013134708.1270704-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the len argument value passed to exfat_ioctl_set_volume_label()
from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.

And because of the NLS_NAME_OVERLEN macro, another error occurs when
creating a file with a period at the end using utf8 and other iocharsets,
so the NLS_NAME_OVERLEN macro should be removed and the len argument value
should be passed as FSLABEL_MAX - 1.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/file.c | 2 +-
 fs/exfat/nls.c  | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..7ce0fb6f2564 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -521,7 +521,7 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 
 	memset(&uniname, 0, sizeof(uniname));
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX - 1,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..57db08a5271c 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
-		lossy |= NLS_NAME_OVERLEN;
-
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
 	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
--

