Return-Path: <linux-fsdevel+bounces-58627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C61B300DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97811897B58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F4307AEB;
	Thu, 21 Aug 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXj5nqQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE91DFCE;
	Thu, 21 Aug 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796755; cv=none; b=TQHDlHmcOJd06VOdE/SM25zta25h5vPt2/4tM0hL9zL+UgdXMsmKLv8/+x6W/jIHewTIj2SQwihd8mel5saiJoCK4q0lfJQ5GNP0wW1nVuCsNrEksMirDx1Cw9nwpB/WDe5DBLZQsdYwZy1AE52w9ahDAYTEjYfQgtsUc3sr+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796755; c=relaxed/simple;
	bh=kJOoCHsdPAISSR4HcFlHZ0fIcM/ZbT9tK9WAAjen35Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aElcM0QiErqTIUB0tvLoTfjJqvf9Fmx8Jam2EUql8qHXbSFBtcNU0H/+F6M2MV1y8g6S+iEJAJIvsqbMmgv4SbRyIbjuIzpYKm9mj7x2D16cPHZPcGLEjrbhS0kT2OJmLQId26Zu4Mg/aqIKbQRs3v6InDL+wdFHamaCF1Cy0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXj5nqQD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1223835b3a.1;
        Thu, 21 Aug 2025 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755796753; x=1756401553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcYrZ6OBHDvhQxq+aUNrUDX0E+CGMcdoNU7ZBepwhNQ=;
        b=TXj5nqQDTb/7P/Jvoyh/lYTlAip9VPbLtd0DGpxuYE744oRdPTbA914Sy+9SNVrhLZ
         VVtiBdzfyVVIZKveu55gokdnZyerr4riFL+Q/6Z9y0q3+Hn7OTRmz+SNGQ0VYB3rsh/e
         B3LKjmqt9ah8nMvAkF9s7Ve8fYGakIJwAaX1XR/1mTiOqzwaIBLV0anzJTSI4ViSrC3j
         0Ng9ee0SsVyfv0NeG0FlBqDg5jKwNSRHWDqqNs5WFxwPA/GtEYyESZ6w4CE95wfuaskX
         8LipEgVaQBYAcV7tpkJTY4fJLbL6tgjicvr5Rm7QCaymGWTYUJXkfun8hhwlspBPf66G
         ZcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796754; x=1756401554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcYrZ6OBHDvhQxq+aUNrUDX0E+CGMcdoNU7ZBepwhNQ=;
        b=IhdB+lPLiX2RsnKXIWsAmBgyqEEudEaRB5fFOd2EjxYFgqYxLwubdK6FecG6CYQGSK
         Yh/mi44vB+wKaII9QG1H/HXplsutojRuzGkAdC013bpD5UXNT2xEmqEuxzgvKWCg+TVE
         xXqeB3yWXJ6sl5ChiKv+foZeND2XYCipGe41RkvBIPx8DfN6AXGoQxzAe2w6oMK5liIv
         AbCM4TZtwcb8B/u8/ajPtEfW/8Lsmz3fZhYyH1Rn7C6pcP2wr9l/xMj8c7kfEMqHtACD
         CV2aFHXkXLvk/qW3MDDLSWjftdwGbJwLzV76SEhOBYuCxWfsirIeWsJGOhajJdL44MEf
         r4sg==
X-Forwarded-Encrypted: i=1; AJvYcCXeOOO9Zco1C/eK7W4c1yMxyVYfL3iBZ420l6och5hIoluAWXLG3eOPcfTDW8ZFFB/N3oL++wzogL34M1vk@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEVisma47ZbRa2QLqUNwfl1CY+6wQdfAtXpAxySLfZmUQlJ3p
	iFCmbuvM0RR15g1pvIjtnViqBLfagDj+grseWfRH600D2GZWHE5sKY1h
X-Gm-Gg: ASbGncs070EXOFU5j6Xb8zjCY7/MgSPX7eYa54Ps/7dIOQ7a0FFDl5pOAgAjEFnn2qM
	wpiIV825xUlJMMSqNPxTCJNXlTP4qy1duKYhA/4wgYLZ8puwCu2LjDaIqhGHKoTVNXaEuyEfoJk
	8bM8NjQMi+r1+Qq9d7sVbut8yhhVqYiJCUMA5Og0kZoRzo5tD8lZertWWYQQvDXlWP3KbLcSgVs
	uig3sYyHBcZv3j3/wOwVPUtx8iAr7kUwEIi3SyxZ4LY75tCA21RvGxy8+USXZpb8+Eatnwqxxz+
	mUL8HjQQCFEMaXHEY1juI0WNx8iPVvpM2NBaWqnndOpQ1n07xrLW3aSaVID1WUzkdV0d5VjCe+L
	RNXQ8y+sHMStIArDhkTnUI/j5TX1tug==
X-Google-Smtp-Source: AGHT+IHBucu8OwcgFnbMcDmdfHatcMrjkcrIifXC+JFyAq9nGFkI3xdW1Hyw9uXfRdw3ENPPJJZBMQ==
X-Received: by 2002:a05:6a00:3e01:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-7702fa091a4mr233913b3a.1.1755796753292;
        Thu, 21 Aug 2025 10:19:13 -0700 (PDT)
Received: from archlinux ([205.254.163.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d14e531sm8626591b3a.50.2025.08.21.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:19:12 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] fs/namespace: describe @pinned parameter in do_lock_mount()
Date: Thu, 21 Aug 2025 22:49:05 +0530
Message-ID: <20250821171905.10251-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description for the @pinned parameter in do_lock_mount() to suppress
a compiler warning. No functional changes

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0a5fec7065d7..52394a2ebaf3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2738,6 +2738,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 /**
  * do_lock_mount - lock mount and mountpoint
  * @path:    target path
+ * @pinned:  holds a reference to the mountpoint pinned during the
+ *           mount operation to prevent it from being unmounted or
+ *           moved concurrently
  * @beneath: whether the intention is to mount beneath @path
  *
  * Follow the mount stack on @path until the top mount @mnt is found. If
-- 
2.50.1


