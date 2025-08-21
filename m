Return-Path: <linux-fsdevel+bounces-58656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83759B30671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9742B1CE7568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88838CFB8;
	Thu, 21 Aug 2025 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XbtCyXsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44B38CF88
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807646; cv=none; b=XovxLhgPjBCb6Jp+B4eSD/VGWKjbqKj5FDt34D6aX4io0ldp/2nlbZOQeq01N/lVWKWyUDQz+Z+DWiknoMdFG0/4HaP4d0/BiHdp6wXLf1bpeix/zCDm9r8EaCa6T1Zdyy8lNJhSIC1L23qsFOJk6yvN/IHOYBo4wCwrNaWQnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807646; c=relaxed/simple;
	bh=MCFryGt8OvI9I73T/3uykYAdJBu4EwKq4BQ7zZxDWuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbaKcXfxCCCK2E28zg+tXA2u0rNY6HF/LzjqcIucNs1oCodmEeC52UxniXMbQeCEDkodslkhB4Sxr50EaHhooeRAOIBSMdW64ocia5KOiVx1oSlSx7KUPQJmPzAXpriXcZEZBd1N8jh5R9Ap3Slda22gyBsAMe1mB3TpTjiX2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XbtCyXsE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d60504bf8so12598007b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807644; x=1756412444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSiPe2GSvHZEVcD4vFKlapaYeiYpuc+3T8lPvcFai6c=;
        b=XbtCyXsEmrWBsd6yDF9IiegwUNgVXBlCVrPUJumMYWKm7MJYHgiOSQhrDwWG76DwYN
         ZMX8+pAhrNnDAN2d9AzJUoQTUVkEq925Neajk4k8/tRVDbFiEeeHFZCYnLmN+u+oh8JP
         CqtSTnWdN8a4ABBbWzDbXBKx9UZOf3C7Jf1Xogt4mPwpIunt4vOSlUa5H2mb2gjxA1B1
         0sN38P91d53XHZkvAjCjcuLmQyM+36kwS9UR3r8AMu8/7EmQ6YZc+nhV73a1IVoN7dh1
         RjaMsoUO8PKkIsPaBJI7EvFq6PUq93VWXeWkZMkt4m0sQEsP5aJBb0OGWzckH+1smCDM
         HFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807644; x=1756412444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSiPe2GSvHZEVcD4vFKlapaYeiYpuc+3T8lPvcFai6c=;
        b=aFXSBQDy1i0rByFMe7I5Dj8h/ZTLgf+p2wXcLEv4CJkdt6vkQeiDpxntjQQJqXZ1ia
         QUBHHd10VSeSBsfJ54m2piydLwIfp4arxoDWvj9+JExMmw11S82tO9s1NHc8kD1wSWsR
         a4uhPsC4qIhWiwjEZh20GWTyyGgZSkZrDVi3QbQMmcmlNa/aEUByCkVe9OE+yLEuCKFw
         MJRsZ6UZiEfSVShKDTBBtM4zXAgeye+ZRSbgjSCwpoEbLkNEMxJ92ugxu+VI8u1E6ktN
         peM5cT3fxSYWkvV5QyeUWtJkS8pp5rffDxyTILmfmC3RcH0s5YLs6TdrLAdm6IX2OouL
         MtVg==
X-Gm-Message-State: AOJu0Ywozy/ZvQENQH942uPjTHLo98XN1hTn1EC5/8FJNokh3MPovKes
	wsjqIr9pOlBiWmsSwAlJ6BmnaQtNPbSqdxGuj4a1itXY8FgtISl6a8R28l1JpbqgMyAoYdYCLWA
	9A+YDUaCNmQ==
X-Gm-Gg: ASbGncsOcniXUCzLodXVrOg4kUbTml4aRePzhXKfMucwt6LviO27kiWgoT0x2h9d1lb
	nuRapmYJjG/UJzvFfBM+iGKPneu+9GbOMM1LofO3mTpqP2F3i5Tu8z03yurZ4hIz5doDuz0jB9D
	Of96A8SwrkdCa171hl8kUqDzR0zumT3GZwkPZoRXtiLlu5rpypk3SKcfRul9g/U4feYFHtKIYQH
	9LTYiBlXKDZEYj66do6YAYx/fckbI2ItimPwky+P8n+z0HEUad8w95ktogf2TO3G3CMuioipa0N
	44Gackk8mlKNq6DA/XKunUwPQKhdzq84KvVDHGsOdJm1MRj8mdzfV/qrGO+dj5SwLPEV71IL7fl
	pmt4mXUtLyZPSP9mlditzITkMqFMz5qYx5ldlEVgdcqOLiOZzA2okWU/tOXabjLPGBsZCUQ==
X-Google-Smtp-Source: AGHT+IGDgf7aCeL2nL93909EYOEt+b6G5wwfK4meP/GDmXRwGfXQkKjEhZnhShlvmG9gTGb/wy4z9A==
X-Received: by 2002:a05:690c:6c0d:b0:71f:c6c5:c55c with SMTP id 00721157ae682-71fdc3d1834mr6237357b3.26.1755807643782;
        Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e05c0bbsm46459507b3.43.2025.08.21.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 19/50] fs: make evict_inodes add to the dispose list under the i_lock
Date: Thu, 21 Aug 2025 16:18:30 -0400
Message-ID: <9aacbf6b90ed4a980a49cb4d4eaa3d2fefa1a7d8.1755806649.git.josef@toxicpanda.com>
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

In the future when we only serialize the freeing of the inode on the
reference count we could potentially be relying on ->i_lru to be
consistent, which means we need it to be consistent under the ->i_lock.
Move the list_add in evict_inodes() to under the ->i_lock to prevent
potential races where we think the inode isn't on a list but is going to
be added to the private dispose list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index b4145ddbaf8e..07c8edb4b58a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -991,8 +991,8 @@ void evict_inodes(struct super_block *sb)
 
 		__iget(inode);
 		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+		spin_unlock(&inode->i_lock);
 
 		/*
 		 * We can have a ton of inodes to evict at unmount time given
-- 
2.49.0


