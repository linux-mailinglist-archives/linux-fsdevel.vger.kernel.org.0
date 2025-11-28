Return-Path: <linux-fsdevel+bounces-70108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C514C90CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78933A904A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF252D3220;
	Fri, 28 Nov 2025 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhE7ghey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E270552
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301932; cv=none; b=D44d7qeBNjAwyLF1VXpKPZmHMTafA3gQMeTX3v6RN+yQVJn2Kx6nzcqpTPwAsQ4zCwpatFwnlzkvZAggTN/9H8qpoeJGIZPRYtGISp2w3Tz8U6or8NzkFVLzlW+fm3X/146CItcnHtv45NqnJTck05P+sDcdQ35HrqdBBWn2+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301932; c=relaxed/simple;
	bh=HCOdt9Qo99hBgbc0ASsfVOj8uWEFmoT9+DK8BnZ2g1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDSAQ59YfTwDCviUL6BCMLqh78ZMmTmo3zj0MnDzWA4j3Ey1QzpPKhCuQb62EiHDjvEp9SnT3snCpPhCgNm8ctrF8QF3j1+vjbaV053clyRMVgf+6lrlZuVYsHGNDwOYmjs/z9/76AVbqo+t6KJdPkPoUqUWUvmtuEoCF7sPJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhE7ghey; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1646339b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 19:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301929; x=1764906729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CltxbTuE1mCSM75e6GOL0VL8ptzQXyj6/2m6IZdHiE=;
        b=jhE7ghey85A4AZ8xSO4EJ3zzL4Y/7QnXmp63NlWVA5s5M0u31rJLBfHKusqBnrJ0u0
         fYKYgBIhbr2jz9IwbthdfR4NGoFDLw/s/tHnR2WMyS3YQ92HrV3cRMgKhHxW1f+WAvDg
         HX+s03PXVeCr3jKVehq5aFYzh4bQObcrY8Uez0TX6J1zzMAR4+pA6Ch7qySklaWqW9kd
         XcK/k+zLVCs6W6dmrc+CBp+WMDlw9wzWzUrDJ3vdf/l+kNFLO+EwnytstlQp1TlPW7oS
         TgEfkqB3j8Quhg/AiGpf0GfGbeW5foP/7ResqO6eir9YZroqJFfdhJEpkp8Otzs7iwSX
         o+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301929; x=1764906729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CltxbTuE1mCSM75e6GOL0VL8ptzQXyj6/2m6IZdHiE=;
        b=EQARI5sM5J9/sQcxgAfp615KIzN6uDfzlmrdCRJtPEU1rxIi7DKVpqElGsbYaif6m4
         eOrCblLUwYzvF6qdRjCzLOEDkhqIFHcU6DTIs0gY9AajGmzitjb91gZiZELyC4xy0hTA
         9q4bDsB2I49GDRvgwpUjxLJ/2nqKvPkz6rvJis4EuAN2QJboICb6/vtmr2Oz4OPeIOZz
         1mBndut2k9lXP79Rsjk8yZXNttcK/CBS7pLUxPK/squUkIJHSik5CLsIi3stG6S0vrUE
         VFewq7fQLozNZHuxBmxyVO9IanAeCbfJYC/0Nq45Ph+WUHCvTuH0jbFZ3B7taN9PPSSA
         LXHw==
X-Gm-Message-State: AOJu0Yxa5X00yJQz6tF/SD73UND6D0o21944VmA34QAHfnyiZquTfdCV
	KP2JoJo5H81Ty+ohl9iTyXH7YnLC+jiYLhwsIYlDEmRyvrZw+4xC/3gI
X-Gm-Gg: ASbGncv1Xudqmm4muJtEOOZjTWLXJLZpwlTvLIu/dEBal11jKcTatEu+azRnSmmPO/I
	lwCwpVWvtKDTbup/WpCMNwAHYcU9tUOA/Fz5qXW1uXqTxai5vHnaGYECU1ZGo360LeKUl/438kS
	WcU+cDy/nx1ShLbrZ5lWzGCSL+xelyMb9SiNY/13lEB7Un6ShOu8ogp2wl+81B2SLeUySmzR+ds
	36uiNwVKU62Abib53PK+NVUYbCINapkBUFV8ZbxW231guSEJhDUXPCUyU7rADtoBzJYuyf1lhQV
	7nY/PdRip3gvheigFwaWCMj6Q3km9mPsJGVk89/GGYbzV9oZ1AfywA2kBSwBGsWwkwXEjM0Bgq6
	oKP7BHNQ2Pl8R/2v3H4l7riA5LVazs6GQi3UV07BsaG9mbbDrtt0PJG6LzcwexKuBLIlUHLrOL2
	MbixFPbFb6SuMeofsWmOa7qb3QPBdEVpCAbZU=
X-Google-Smtp-Source: AGHT+IGOZUJSqSaUAsFfUtC3iidI2uyYilieUl+dVyyfoh7INnYHEIe9kYoy7b8hsG9r/zdplWPNIQ==
X-Received: by 2002:a05:6a00:12e1:b0:7ba:2efc:7b3f with SMTP id d2e1a72fcca58-7c58beb6412mr24314905b3a.5.1764301929136;
        Thu, 27 Nov 2025 19:52:09 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:fa57:54bd:ea3b:1d14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fd01c3csm3290008b3a.69.2025.11.27.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:52:08 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+94048264da5715c251f9@syzkaller.appspotmail.com
Subject: [PATCH] fs/namespace: fix mntput of ERR_PTR in fsmount error path
Date: Fri, 28 Nov 2025 09:21:48 +0530
Message-ID: <20251128035149.392402-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vfs_create_mount() fails and returns an error pointer, the
__free(path_put) cleanup attribute causes path_put() to be called
on the error pointer, which then calls mntput() on an invalid
pointer value (e.g., -ENOENT = 0xfffffffffffffff4).

This results in a general protection fault in mntput() when KASAN
tries to check the shadow memory for the near-null address computed
from the error pointer offset.

Fix this by clearing newmount.mnt to NULL after extracting the error
code, preventing the path_put cleanup from operating on the error
pointer.

Reported-by: syzbot+94048264da5715c251f9@syzkaller.appspotmail.com
Tested-by: syzbot+94048264da5715c251f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=94048264da5715c251f9
Fixes: 67c68da01266 ("namespace: convert fsmount() to FD_PREPARE()")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/namespace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e5240df614de..236482fd503f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4343,8 +4343,11 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		warn_mandlock();
 
 	newmount.mnt = vfs_create_mount(fc);
-	if (IS_ERR(newmount.mnt))
-		return PTR_ERR(newmount.mnt);
+	if (IS_ERR(newmount.mnt)) {
+		ret = PTR_ERR(newmount.mnt);
+		newmount.mnt = NULL;
+		return ret;
+	}
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
-- 
2.43.0


