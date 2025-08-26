Return-Path: <linux-fsdevel+bounces-59264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A1B36E91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9218461070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1C34DCC9;
	Tue, 26 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VX3rg/1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA236933B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222899; cv=none; b=dXpqB6TLl2LfZ762AfD6hUSvaVuBvVPnt5wzNyzSQo5fjcWaIny5Daw5CFTl3viOPjty2DRPFZLvTg4drwA5P4rgh7wMLWfePX4iGpRihov7N8mJwWp0mEH3IzeyZJuOzLS5j1o8iOLaqE0cHVbzwwN+dX/IC9Nno8wsGLH+bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222899; c=relaxed/simple;
	bh=Ek+K7HnIxIEopRMdqMnNty91y2VWEE+x+hrrKpFJIDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ/GDyPrhznQG+b72bgw5N9dbW4H80e3KE8UjLH8xL+ataEUAxx8Xgpjbb23dyFNb0dh4UYoU7VX9VX77pcVINPxi7Ot0g8yOJikSm3aPL18xjX40rORRMdnTbFROeVR+uwVwGVxys06ANOtDp5iWihzneZR96ttS4y8sWp0CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VX3rg/1n; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e9526271af9so3041790276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222894; x=1756827694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=VX3rg/1nwaBPBki8rHZ8UMExRSuThguHtxx0flJqoSvOXhaKgDjDtKIA9EExV3qk5T
         Lqz10q8Di5PI1oODeVYRbgF9u76OCf+emIJobOksU8NQXOzWMc+5V4S5R+zwW24dLhrr
         o3mbJQQhDm/K2PBw/cD36W1RjN4n7mW+rT/mHqT/KCDwiXwhmLiHqBvUZ2+V7kv5Nnj/
         LU7Uft/YyWnrh5UMWE6VaGIZ1Y89oBRVuzQ8LFofIdzNVuSH1+CeQVbKI6gfxtBxnXY9
         9POUaUX+9zt9GdgGY1QctZaiKg/jBZ7hGSx/DUmlX9hLHYgsZeIPLwZouW/pYPC8fZCt
         RC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222894; x=1756827694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=Vive2Ivmopj8PdHlV4oekNda+pp9XW1+meZRk8OUjm2X2z57tCF64Dc3fq+0EZZ6CU
         TBuasxIIybTjswZQFCsYIx9X63d96U9iHUPM6zUy3mgaHvMxhlZAouh80t2qkUFD4Ppy
         dNz32wHacCg3MJ0HoW+YFZuXIn9SjWS46PYOEAvOHBULPPEbOIirbVA4SFWz2GTVfZXR
         WeSEw8lU5Tz6NZacrTkIlm5bBhe9XhJo0DPVwxSEi4UEJnw6AruIovUSB/aBmixbv4Ab
         LSc7oEInu9CrcxlITfH/9u16B6w1mKch6Kmi5EirqcL91MnsOw6Pm90xTaG6MXvD4DGq
         NwDg==
X-Gm-Message-State: AOJu0YzVZ5OwoSsO/eZXmV06W9SMZxmwXoBvxmVknirG2Ud1pYXULYNT
	RybTvsiUf++uXRZMVrZbr1ggc6RmBbR41+3WuZifvbVKike4Uf/nZCvNIpvT7mX4C57yYnL5Dbz
	12frM
X-Gm-Gg: ASbGncvrB2KgP4YHv9kr3itYutC/2D7VVo9l6mauso7E5altpA2CLA+i7YnH7nNiTDj
	BfBdtuDBh8KAVFrFLNl3xQTkJNyBWthkf2GEsKldlVtbi6eGLwSBfLGrUhVxE3C82QBq5F4oeuj
	OiXYMp1q5YnL6Ief7gv56+zO1xumEu2/CM/rgPVVVt6NIDxZNWnYAbKDQ+8xzZ0pgKvD+LEMns7
	jdGcPiNTSEK9U5flmgDBPrDceUVdUael3MoKXDHBROMw2Ehzf7AIjqGsnSL4uYgZc6tNoPVLL65
	grqfHr+Guv/IfcOmwTuMFvhVEqwkfgiwf4idD2WJO7ak1GBL0pOBko2SUWqnx6h6pMq07JqEuXR
	fejxVZbzq1dcAS4plnxesdx41TybQb2ub5lJXayRx/s6b09N6nHuOIzHkKlg=
X-Google-Smtp-Source: AGHT+IGsMpG/UCDruSz3Wvi7CzZlKIL5xzEKlg+zB+8+jIE4udBR1skQ5tPNMiXAg2ctT0vtiUJNQg==
X-Received: by 2002:a05:6902:c11:b0:e95:25c2:e800 with SMTP id 3f1490d57ef6-e9525c2f090mr16314789276.44.1756222893943;
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm850314276.20.2025.08.26.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 31/54] block: use igrab in sync_bdevs
Date: Tue, 26 Aug 2025 11:39:31 -0400
Message-ID: <83700637bec18af1ca85a2d232a11c0fa85dca34.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking I_WILL_FREE or I_FREEING simply grab a reference to
the inode, as it will only succeed if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..94ffc0b5a68c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,13 +1265,15 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
-		    mapping->nrpages == 0) {
+		if (inode->i_state & I_NEW || mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
+
 		spin_unlock(&blockdev_superblock->s_inode_list_lock);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
-- 
2.49.0


