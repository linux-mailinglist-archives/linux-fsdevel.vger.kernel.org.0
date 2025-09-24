Return-Path: <linux-fsdevel+bounces-62667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A01AB9BBAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFAB7ADC01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB412271454;
	Wed, 24 Sep 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6JFw2vi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCD502BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742617; cv=none; b=fDBYpy6fjlvZhz/2X/wklMo2OJOxiE2B5sJuR8IhMfbPMD6Ck+FVZQV10yuHG/cq9Pts7lv2Y9wmoujjBwNjZT1NRkm10pc4E6R52apkPkmoKIwso78lwcSgtRTpN2Mf02Yhp6MuMepa/AxYMZDYv9yrmdrYvlmmKk36MiSUaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742617; c=relaxed/simple;
	bh=knlQO4SkaHGe2+vyy7aEF4PExXNE2xTlAmeg0oqi6Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MW3MS6T3dAuFM1M9IF9vJxNYqY2CE0HO2cMlVqXU5DH9OBw2ew/Erw7maoAb3xz0hGCQiFFeJCAMcebJ7VGT4Vi0zownnEe49Fn6Q+AtnFzwrED4sGcGiUreVFsCo5mYn2jKMsoESV99ljNPGMf/e0xMDJ8IUpSKGgJPKrAW9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6JFw2vi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so2697975ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758742615; x=1759347415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGksrBnhrwp6FwXulyPD+bzAipxEJqKqqJx21DNikWM=;
        b=V6JFw2vietB5csB2m9tQMuwjN3uLyW10qDefC1r9Lc8fM5mNxbtLRCWdDe7/CY6jsT
         aeVOwuOE/P2YGaZbQu40JRItxFCiYfkbo4TqBtmvTGe4WJznrDbqW17JoseX+lUv+ov+
         4RRk5GMFWQSvnV+VAsuz7jEylnxUuLvsIQdk21QavdHoMfHcngd/8Pi1fG/BmIuatvth
         0osxOdAEgU0Oa0TSOh9IsPRsItZgReMzh0GNqiqvrVrZUqqQcXPSPtyAE0MPlLBX8iaL
         GWdphmPAcoFfm2rt0mc5m9KuRHAWSZs2WQTWO30WrFFaEUQ6ILjLQRPIZPMTPgMGVvUr
         ZJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742615; x=1759347415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGksrBnhrwp6FwXulyPD+bzAipxEJqKqqJx21DNikWM=;
        b=oYvzjtG+WAjE99iuxUhIydH0Jzi6L/OvtaeosgBkbpgXMjVeh8HKz4+tgXA1NuOjkY
         7fkYxiUAv03g/WSPeUG7rdPERvnqwS2ubMHnCbv+sO/+ZZWkdW9Flz2XosT9gt9NB24r
         b6YV0VuTv8yiisnS+iBejBkmqc0gJyl0jPtY0NH7LbEZXeHhFe28a9XRlhU7+t0j72m7
         d+zRrGMqTlF2SZTrgryZukHM9qRmDe+SJ64n+woXZqmSJU04kXwRbavYpG1s2xFbKaH7
         vRK6DDHfHNP2lX7diV3OrpgtsWHEaJH51rIzx90OB076ZPK6Xjs7hhrru8Hr4tKp4/Vr
         ck3Q==
X-Gm-Message-State: AOJu0Yy8i92hV3itoKaXVz0PmEzcCkRIdoaHF2KmevSzOd92/riGLqSS
	ERY+0Fkg87Wgv2vJrsuaUi6Nj1bfDfdJ53wzDXB7ultT+jpem5nwxZfb
X-Gm-Gg: ASbGncuB8eX5PBm+45HPOecUvXeIBBKwlOBGZsUbLga9WZmOSewbnkpGETfK0NaRExW
	G3Vga7E0Q1oBga2QChzi4Ps5RmwV64SvMVpIWxLy/ueQYeTsYbmni3aqra/Ivt8ooCrTCmU4UJ6
	q2QWuS4QV5QqgkQ0s7Ic26oGv5sUtduiy2FMs8Xb4gkXqgSt1kJ6FZGwGr2FaK24ZP4WzMp9qsl
	eDFO1oH5kNnEXoS5plhegCkp0igLrpMyfV89J657vWZAuG6cmT27Gr0hFPc4a7BFdGcRS/pG3PW
	S9Ots3WrTzTifAiaTxj01un3A0o0YXgmAdTBcbXvSbiAoNyWtreAWfrFIOUnz8Badn4FFdu1/Nz
	Lvbzy9a5AtrMhlgnCKEUs0nAN+Cu7QG2s+FOg5P4c8FTrmO2MvduOq1OY5hWAiRfK+jI8He8ogf
	SfWL7AmmXIgi5hRBkb2rff9LnIHw==
X-Google-Smtp-Source: AGHT+IHj/DitiHlUDZ8amSAXaSBVzNde/WBdb25OsTp+ocWUCZMnYPbmpem0/I2GItxt96tqnRpuwg==
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id d9443c01a7336-27ed49c7763mr8557015ad.12.1758742615280;
        Wed, 24 Sep 2025 12:36:55 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6725bbesm497885ad.60.2025.09.24.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:36:54 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] fs: doc: describe 'pinned' parameter in do_lock_mount()
Date: Wed, 24 Sep 2025 19:36:11 +0000
Message-Id: <20250924193611.673838-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for do_lock_mount() was missing a description
for the 'pinned' parameter:

  Warning: fs/namespace.c:2772 function parameter 'pinned' not described
  in 'do_lock_mount'

This patch adds a short description:

  @pinned: receives the pinned mountpoint

to fix the warning and improve documentation clarity.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 51f77c65c0c6..4de1a33ab516 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2738,6 +2738,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 /**
  * do_lock_mount - lock mount and mountpoint
  * @path:    target path
+ * @pinned:  receives the pinned mountpoint
  * @beneath: whether the intention is to mount beneath @path
  *
  * Follow the mount stack on @path until the top mount @mnt is found. If
-- 
2.34.1


