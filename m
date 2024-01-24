Return-Path: <linux-fsdevel+bounces-8825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B538383B475
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A628254C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9BE135A42;
	Wed, 24 Jan 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0/zUNWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491213398B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133988; cv=none; b=nnTPsHWBzJKmR+kVIuz7jJ4aMz7IKx/709hO8IyqOn0GksigeaI9ZcewbHzAHxTKeQnlv9z94h83aL7TlKyq98T66wN1f85nn/2nd6+pOQQI0HuE9jCy49ULIBjfUCZVO5e0dQ6bt7kbG5Ve6P8wWKifvLTUXLvpV+thd+S1urI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133988; c=relaxed/simple;
	bh=gunPgS3TJQWZsp2MxCZKzizIUB7sMDtjwQmEImgzamo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lF2d47ensRJiLfsit6ckaEzHeChWtwAHLCX2tEzegTBXqzvAFMq9dQSz1RSWdoJA0btpuRm5gKZKWiBzPqL0W24WAkv1XbmsV3v5Y/0Tn6KJUZ4xhnupavGbRG80HYhDALVjEOxHHFUOSBepZ9QRBbcW7iDYbmV8sBvSaJV3RQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0/zUNWH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71cb97937so38528985ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706133986; x=1706738786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQhmzfTAsJcV9PaL7uovsChg4Yg2U/Z+yBT5DYmcULc=;
        b=h0/zUNWHpHeiOreGZPuONa6Z84M/pJCO4vYE8O2tqXbEXtnwwi1Gl/QXb5GYYd8Yrm
         4GVRbP5WDq2007KaxngcFm+xeaEMpnYMzvaoMakiAMiuXRCePkASY5LNn6LGf3Dd1NBV
         dxKDMUJZtWBX7s/I0xUzYxx/tUKu+YMAWwQ3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133986; x=1706738786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQhmzfTAsJcV9PaL7uovsChg4Yg2U/Z+yBT5DYmcULc=;
        b=aT2klXlHIK7wGZyjYOAaywuDJBeTsR5sE0UgMeEKNhPo41iQuX4q7N+uzQ1resMeqN
         cw+xwwCey/tnmDjsenQVHQKcuEQA/P3BwUtBX3mqi8UatKWoDQjHEuNK70p/qxvPvIzk
         dt5KeRx/7gUt3dYP6aLpoG/F39k5ZBGBE5YqO5xXCFh3opMsLlzWSfgAftOfWny1bjZf
         cfr0VQZ1z99zvqLyYx6iV/S/1J/QrHRHhwMVvqGf8QgoE3sgyiqxWO+vnLMxMgYDgpek
         uwAv6zSjrsuwP90pe2MnWx5tZIaXahO1QtdQjgyK2yzPvX+FMpeLMUcfm0ldg6GcRrrm
         fQ+Q==
X-Gm-Message-State: AOJu0YxvmMMuuDr9mB49ap6EJIVuNh76JZclJpHUgbxi16eSDgxxpR7s
	XLy9EzsK5xdMYHzx/5i1X6zRbBNsVOTQCG/b3U15dCTNgLFCr5RVHQIgeuLpHA==
X-Google-Smtp-Source: AGHT+IGHYywWf+5nzxcSvzbfWT3qv6YRgnr2OB0CfhQi5LwevM4tDZ29AOUbaz9SAS7N7WG6MpupWQ==
X-Received: by 2002:a17:902:ea10:b0:1d6:f263:5698 with SMTP id s16-20020a170902ea1000b001d6f2635698mr61299plg.28.1706133986148;
        Wed, 24 Jan 2024 14:06:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001d71ae81cbbsm9398467plw.190.2024.01.24.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:06:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Remove __FMODE_EXEC from uselib()
Date: Wed, 24 Jan 2024 14:06:23 -0800
Message-Id: <20240124220619.work.227-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gunPgS3TJQWZsp2MxCZKzizIUB7sMDtjwQmEImgzamo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlsYnf7Lk5Uf58mAb9lvaALksPqiA1c0eFcYWS1
 pm8ae1S6IWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbGJ3wAKCRCJcvTf3G3A
 Jh3PD/wJCOZiXf2turY8NXwNDR9hOetJn5TUurzjSx1454xqWSrni13jg9kUhLD8/Q3CJ0k7QtE
 lkVXUafB7zj45P53AR/4/7mbdMEUdN3IkYXJuDHj9CugQLCxGx/XEdyKVm2nTancZQxdKocFuvL
 BKD5whC/h3YmJ/elQq+LVUoaUoQujwHs/gWUm81mrJdrjnscFhP1aFDgg4/QL/yVX8/C1lnEd8W
 KULt3HRcq5HRP4zoBAW3+nOTrzatET2nm9FF43sWginO9aFnXzOSqnbb36xQkBqdlg2OdIELrUs
 HEmanv/2AURU4BEjz2DIMfC5O3P2u2hfeDxtTvcGKCK0WhFkJcXQ4+2PoOsUXkdbVtzQJrZJlrv
 zXFmWXLVdwYPZlYWePXATpqmiR5csemrnL87mZtP7lPcz0uShL4ThhOh8ZEEWj28vUfttd/k6ff
 0ztAdSJFTWpRKG0ziU/UP3olgu9Rn6VSr7OcEj0kbeA2RAq/lgM1YECuIk/UL7aG2A3UFXjlpBX
 1jfOmvDoaEfzKrpXM15eNkiWQ8OiMXxxkmqZqFPE2bntN8h41Nk1IlTisaVVdOusbm2usWcYVYZ
 /QCUMcvHCjm3Jxzo3pqMx39ax/dNE2k7R28V13HwSO1gG4FF44qH95KgUZHNt19WB6tb56+Q0al
 eHBAz9g maHQEgNQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Path-based LSMs will bypass uselib() "open" checks since commit
4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs"),
so don't set __FMODE_EXEC during uselib(). The LSM "open" and eventual
"mmap" hooks will be restored. (uselib() never set current->in_execve.)

Other things that checked __FMODE_EXEC:

- fs/fcntl.c is just doing a bitfield sanity check.

- nfs_open_permission_mask() is only checking for the
  "unreadable exec" case, which is not an issue for uselib(),
  which sets MAY_READ, unlike execve().

- fsnotify would no longer see uselib() as FS_OPEN_EXEC_PERM, but
  rather as FS_OPEN_PERM, but this is likely a bug fix, as uselib() isn't
  an exec: it's more like mmap(), which fsnotify doesn't intercept.

Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/lkml/CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com/
Fixes: 4759ff71f23e ("exec: Check __FMODE_EXEC instead of in_execve for LSMs")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index d179abb78a1c..af4fbb61cd53 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	struct filename *tmp = getname(library);
 	int error = PTR_ERR(tmp);
 	static const struct open_flags uselib_flags = {
-		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
+		.open_flag = O_LARGEFILE | O_RDONLY,
 		.acc_mode = MAY_READ | MAY_EXEC,
 		.intent = LOOKUP_OPEN,
 		.lookup_flags = LOOKUP_FOLLOW,
-- 
2.34.1


