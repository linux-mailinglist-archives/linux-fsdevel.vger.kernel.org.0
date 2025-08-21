Return-Path: <linux-fsdevel+bounces-58662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696EB3069C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED85624339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A566373FB6;
	Thu, 21 Aug 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3FnSnXr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9B373F8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807656; cv=none; b=PeW3Is64ottK96OuTBtqN39J72TFcRtbZvtZDMclgmKEDK79zVbGEuhKBKibs0R18wnM9X+cugpf2siBZcE4sXTaHFsDQGRLRFlDlEiI5kcFe0ddsYRGNeEUorb/5WJLxURGeeuT31TdnQLFg7l3m1xZtzCjPjIBATHyYw5yckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807656; c=relaxed/simple;
	bh=0lJmklD4oxs+QmY0EdOdZ2TKHxQWMnxFR9kZzYDsLSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0WbFDMo+7L2o+HwZoHKaJqvgDAvH1zwzDFF+myVnMY9doZF255liY1v6o0K4LZdQwZbDgDDwQd/3Uz7Y0JJ9Ms2m3RCHfYcveBlcfRp5TluToHWA6Mf0D2ib4A/qMVqzgr8UzkZp1d9oaKtXAGanAGcAcZFW4O8Bfm95tXPIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3FnSnXr2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab69so12152967b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807653; x=1756412453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=3FnSnXr2Gj5yC8LL+E8khTsGRxQamoR5vf1dQWNL4hxgzLoq/lAjbNhEDY+7v1VghA
         hpnXAwgQ/zOa/dK8jd5kYbjpGbKaojRnnoOaDQFsicvONuE77VBScYZiX0x1wkYQcwP+
         /9AhsJDlL6L+2+b/E/BHisu5fzYxOPuQpQvAsOpCmc2rwO9ClErZtv1MD0chfwZMcut6
         NVZ3y0AMCblXREB/tHmAAPERlFqUrw1Qbw2hMx33CoksEQutGTjBXAP8QfUKwT5Ze8N4
         72noxgyDc/0S0dGpqOqnechN/3lyTkk2ODALTSRMOuG7JUENrIlz2pXVS+6UP2Q/SHcn
         YuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807653; x=1756412453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=shcYUWM4kG5/ntZrwnu6rWbKcgCbQDa//889aB33F5ty3jZD8KlTWi2BPpYhAYhPVU
         OKvQ/qF5E3OyLxBmMF4VZ/gmvcs1Avt+A6pwOPBehfm//ezsA2jKNC0sRENQQ68cZuHS
         3b3spIW/9uY5Q39heQIrlKE6qYgfK82mtlEyB7o4xePXOymI8nbNog/wcX6vjYZAp5TZ
         jJLPr9WXghb54dKv6LArlmtx5CJKcWoJbrnlCSVVQ0TBc9QFJB0hB+Bb1UQkhM1yqFMO
         ww1Ug/r2Eik5qXbPVBUHxkCxMvwIxNaR1Lq0sENEiRqiQ3fTLzjqrW85Rb3Pp0WbFX2B
         Ftgg==
X-Gm-Message-State: AOJu0Yy2a7QXGL1YHPeqQb3ycMl3EzlXjb00zqCTxUdsZov7gHyc1GfO
	eM6FZSfTrtYE3oq+CYnSCJHxtpK5IaChOWiigEAAj/RSMIQHNS7L15egEKxOX9gS8XRBAeSPBVb
	6+jn4IXhk+w==
X-Gm-Gg: ASbGncvfmh6Bv9D+ObGLl10TvWSsbi7DS89ULawazpBqAt4Kdlkc1gi+AE8ax8nvKKn
	oKxQ9S4RAeAaxBV7mDFcFdvrtbAOm7NY9bxOox/MU4KeD3n7nTik7WhbJ/CLdVGc4ukZhSHBL8s
	eu64w3I96JNKLvmh7goNUlihfjrJ3uMTNncNpU86e7w5EEoNwozFB9e4whs4bv6g74QvuZa1uPn
	18tzdoqGDVJSrsrZS1ucQ+LwZGDVCRVJMxZHn81h3xcQpBqXbXrLl7HxVxtUgxqmthgdeUwj4zl
	NsZkoA0VKuydvHcSjv31ZhNzwdM4pg36plqF5ITMK1ULdhzNKtPWLKtEefgPWMUs+u2I4vJ6uPU
	ifyJgg2hpJadSm2z5MFU9zGxMmw+ms2TqVBTHJlV6aXEhq1HZJ7JoX2041gs=
X-Google-Smtp-Source: AGHT+IHkbsShVmVIQwfdIh0hUjUE61OmSFNVWODMerAHLv7/HcdmGwNwtKO6+Co21rSFectU4cHp5g==
X-Received: by 2002:a05:690c:45c3:b0:71c:44eb:fae6 with SMTP id 00721157ae682-71fdc3cdb12mr6675767b3.27.1755807652956;
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52b903320sm54724d50.0.2025.08.21.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 25/50] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Thu, 21 Aug 2025 16:18:36 -0400
Message-ID: <e42de7e9cd9b5fb17d159dda3de200b1800d671b.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6b772b9883ec..c61400f39876 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -613,8 +613,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (refcount_read(&inode->i_count) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0


