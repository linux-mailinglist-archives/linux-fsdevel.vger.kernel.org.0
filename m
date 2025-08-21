Return-Path: <linux-fsdevel+bounces-58670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E59B306C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580FC1D2476B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0239095D;
	Thu, 21 Aug 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ia90qBLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54638F1DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807669; cv=none; b=fvW/FJWjLFANH7IV2xVYIFU6JHDIZX9jZLOOAqJoEETm9lCrdrzSREvrd5BcdeV+gMNPM79gy2zwCStAt4QqDfj7ax4euGbEbILMVHdRiZ1pag1GEfHAu1ZXPgxDe+NljatpFIaU3VKvtSWnwlNFcBahJvhYjd7itcF79kSnuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807669; c=relaxed/simple;
	bh=9pmJgOu567RA5Ek8MFIOT/ON1k/r/cyEM9dNKAJxRKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEM1ldFsauoQcIi43l+oz7cwzbN8sCKHzkJt0u21Rd0UjYqhXZR1AQ9RJmGS78O57EIm8EoZ0Axd1WlDJPaVZ6XGzRSOT18kpAJDNKbjTjH6fIUOtYSlJtqN+/vwrHjT5G4vLUK+AXv2+7T+PSkN9Lpj04hCf4zOYBo4K6x6DgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ia90qBLf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e950257b9b9so1428121276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807666; x=1756412466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTp3cGLbO59j3lKKBRw8ISQooTk63pePlY3kcn/TIF4=;
        b=ia90qBLfu1VH0QSFY8tATZlNB2UdQpu+I9379MS+KMkVo58JC66crqh+KatrZURjdR
         SZEASlhf9yQo9qPQpw8BWmkFNLUX6Jo2Vl6nNJ5YLSVRzASYmLtOoh320NDdVptTVisK
         ipNlM8uY5Uigt3/g/OHDxVStb0Be/8GfGQ47/hQwo35qIVuVF5RiPQNCuvBjcJwgsptt
         aKkHLiJHKJzjARPrdT7W6/9WFJU2ymDgBGUUO6Xqdq4a4zt4VcWnITPEshQu/VHx2KLM
         I32P/yrysOMQF/FNwdUr2t7AALO2NJt0nn7jZGj5cJ8pnT6zBEUWxuuAUr4UoHoHihdI
         HiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807666; x=1756412466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTp3cGLbO59j3lKKBRw8ISQooTk63pePlY3kcn/TIF4=;
        b=asM0Xe38sTOzV6n0FoIeIqPEB/rNTy2FuExj97lRJsb6Was/M12yGa1W3dbrQ8YTi5
         KrozAOIHwrUxROG1V3X7WDWo9+6gougomCrlJtj1bYRGxGVVW6YI3HmXmr3WAqdLdOQw
         naH/RbJZJFrSg/naW8Rg9PXn0f+YLayUxHwADJbuXMmJeR21ISlF6xymnLX6bsD+tyGa
         Iks2dT0HyXmLA/P4KMSm46uw+Bc/rgUnHzxUEFk7306XQ8yIgYUwTOqKhZoJ4A6m3lr5
         d4hVILLu1f5XAJr7xasE40TQupEp3TvxUwsWbIpBXMTMLuP8j5OH7NykKmBag8Bu7Rq7
         /+iA==
X-Gm-Message-State: AOJu0Yyroy76gEOjDszUf8oxCygseii2Ll9bOiR99tki4JaqnwUKdLbX
	mEhXmPX4YW8D9qmtWcCwHwEmGiyGsVM3dkAG1yweciXTq1uFtzfP/WdpE7q1TFDEoXaojSWZFjQ
	QJZ7OY4Hbbg==
X-Gm-Gg: ASbGncsVGzgjyHPAGQRqzynfwhWRlAnOb/aHv3lmzx2RNZcTup8H920XuAC02vQaYym
	QZgbV9SlTkTrwLzhlKtWHbzDHINoqG7qW1kfXK76fwMlN6MgTjFoMQhffngySDg741aWPa8qfzS
	3Oic4vuKG77F1w5BM+1Qrim/zdDhybNab99z7eeFEq5kTkqbcVx5SfatOLVWqQSgIeWgflyEMEZ
	cDQx5yXmPYUHlnee0Gwu8kCq9uoinpeuR584JWx2q0+o4Fes2cOBMvq4uJCSB/O3cjRlbFMgAkZ
	rfWq+bfTgVeYKOO+IaOOYFCEJQFJyOyd3dN7DKKCgGr5dWWQUDpFHpcuFvZUVgRLszgYkXmfORy
	7PQ6dUH5afaX7doNSfXtDJjHP0ezmAQHr0tyghT4lj/KddwOPQBVcEXHlFfQ=
X-Google-Smtp-Source: AGHT+IG3QjFoZbQu6hg8VFuaebRzzPXkxgod3PhB2rVk9DI3MJfu/348HPHSDjgQnN+TBDXaLYfVew==
X-Received: by 2002:a05:6902:2082:b0:e93:2e8c:36b5 with SMTP id 3f1490d57ef6-e951c401816mr828431276.42.1755807666169;
        Thu, 21 Aug 2025 13:21:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e85ab0e9sm2809223276.37.2025.08.21.13.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 33/50] fs: stop checking I_FREEING in d_find_alias_rcu
Date: Thu, 21 Aug 2025 16:18:44 -0400
Message-ID: <782ee9ead6eddc1f96a0ab91b97dea577d20779f.1755806649.git.josef@toxicpanda.com>
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

Instead of checking for I_FREEING, check the refcount of the inode to
see if it is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..fa72a7922517 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1072,8 +1072,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
-	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	// used without having an i_count reference, which means no aliases left
+	if (likely(refcount_read(&inode->i_count) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
-- 
2.49.0


