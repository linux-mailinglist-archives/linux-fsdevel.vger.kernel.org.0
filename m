Return-Path: <linux-fsdevel+bounces-71743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9ECCFE5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E5AC300F305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62032D877A;
	Fri, 19 Dec 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuKJ0f9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FD259CB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148785; cv=none; b=dqieUdAUaoeoD4bHfIbLIx2Scr4hiVAXznVWim7mFiGn6TYkH5QhW/Lfsn7KJYQTeQpbgoJC4Ra1AraYHcUJxp6LNqIDMpS8Vit/MD1v7gdUPg9NSGiyFSvkhSLVYPwpSqChya7xxspZCc2Zx0zywJHQzHkHQJBEo4syR5QJMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148785; c=relaxed/simple;
	bh=ArrP/S3Oms93UlPGryLQzcoM430v0Q75MneOqIi7T0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNoU/9eOgChNtPTEgEhprc1wWZsqCJPIaAan/w4mP/meqVgogRlhk3vrhc68V0JzljDbsYuSHluPtNWNhBA8fEIh6ly9cCaLrefk+VWe0StSVJkyo4RzyKJVxZ6g3Keu3WQF8+vpRVXIEI9qtpxBtFieJ19n7jnn2nMbgAYJk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuKJ0f9V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so11300225e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766148782; x=1766753582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/uDBFn1BbWxFA1t/QqkhUGtx2KQ66w7VcfAqzK8Kwrc=;
        b=UuKJ0f9Vcv5a94nKCbExMypTzWlDacz/v/05we06XXADq/3+XKKQ8HDrxnw1SiXiw9
         edjFS0EJzcl8bZx3ATYHTbON+4UCSquDT3pBb41YTTTwbIaJdVwKJInNy8svaWEesSrZ
         3faPUOAeW9SAewHO3Q71ZSIWa42z3vtrfXRb2pS2N5X/io85xmTPHr2ftBs61rIic4yS
         0OZaFpZzi4D0V8qm81vD1yv0ywT+6FXJ+zjtHG91Sgpqja3iYNSNM0xfAG7s+Ehb7kJu
         nK+IyilAUfxMOFzi3iDkoLofGuZoQAYHYK0uu2OCFx0owNO11rNi54Iv2vjoZY4ElfQ6
         AtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766148782; x=1766753582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uDBFn1BbWxFA1t/QqkhUGtx2KQ66w7VcfAqzK8Kwrc=;
        b=dg6xN0cqV2e/Ad78xBVZ8GOK+nLmCtZA96E23UphAXsgTSlr/pU5kY0Ug5cM9YNJAb
         3Lw/kk22iDnIOP0Y6NthYBovHBy+TUcWh+V34ddWuV7milpFhUl2pwgOk64e1GqCAr60
         Iect2ss4reMduczpI6KGAoomDbXvG4AexhP0B6Dp+lX5T2vS34h1n3+UxSAeKMjYsneo
         vDyEMx02iP6eWhDvmhFxMT2XvY5FNAuWDCutGGGGUNePvY7xP5/FvAb9MbnDqaNJwbQo
         3/jG+nxpP6bVoVVuq/CJ2FfFH9ZuMPQskdxU0HLeLRV5tKG56KLEdszayr/qoc4iNeRx
         M37Q==
X-Gm-Message-State: AOJu0Yy/TkoMowLAjthidrw34NRelKEypyCYLL3ZgkdishzmoB4CBqbh
	CQNE5MlHsg+o0AsAMg24Y/z5ff9ctg0/P1PHCGGWRovKvX/xw5Lcdr6qhHlaUPiIRs0=
X-Gm-Gg: AY/fxX4sBLna619p3jHyeej0LrBaSnZ3qOU2MkRmefJ3Wv/1vD54C4gCIiM+3tdltaw
	X7t2JiXn5XPzdVloZMitS5jAgqVUDHi4RexExvbehul76pr8m86lZkV0pQilNTFprTmivfZJ/oA
	t6p5LTbJzsLc/SssqDITjOJGZ1d+VNZvi03gesljd1xbYVeBh7BMlfNbFZx3ATHzYsc+exdYBuH
	vpFIRfLgJUjoJ+rZ2Oc6aBIa8bjRt0lKT6idh9Jd+zsw0oPs11Q4WUxqKAgGP/KuyUCEQA4p2gw
	98ug4HxIh2uEkKegHoHcaEQolB1TYYK1MiEnh+8Mz31OcK4lLVcAAVN6PgXvXk3iTG/mAH4xFxe
	yf/EeyWuB3RcG7FAvEOUuQ9lwfCcx3aSxO4i09Uu64WsOwfoNWXxmpDVbkhTvWXDoY5WDv3hNMD
	Maz1WBrRMdiniXnFWD1HMkoNY5xlh+MsKpTUEYyIEEK0t+XLLbEiEP6h8=
X-Google-Smtp-Source: AGHT+IG/4WVYby91raQvULeU5UVy8iqdXsRNTHT250TgwsK/dFi0hoh2g04FAfwf+LZSN1X5mfA6TA==
X-Received: by 2002:a05:600c:540e:b0:47a:7fd0:9f01 with SMTP id 5b1f17b1804b1-47d195522f7mr26651655e9.16.1766148781700;
        Fri, 19 Dec 2025 04:53:01 -0800 (PST)
Received: from turbo.teknoraver.net (net-37-182-2-9.cust.vodafonedsl.it. [37.182.2.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d5372sm45509385e9.14.2025.12.19.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:53:00 -0800 (PST)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix overflow check in rw_verify_area()
Date: Fri, 19 Dec 2025 13:52:50 +0100
Message-ID: <20251219125250.65245-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow check in rw_verify_area() can itself overflow when
pos + count > LLONG_MAX, causing the sum to wrap to a negative value
and incorrectly return -EINVAL.

This can be reproduced easily by creating a 20 MB file and reading it
via splice() and a size of 0x7FFFFFFFFF000000. The syscall fails
when the file pos reaches 16 MB.

splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
splice(3, NULL, 6, NULL, 9223372036837998592, 0) = -1 EINVAL (Invalid argument)

This can probably be triggered in other ways given that coreutils often
uses SSIZE_MAX as size argument[1][2]

[1] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/cat.c?h=v9.9#n505
[2] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/copy-file-data.c?h=v9.9#n130
---
 fs/read_write.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..8cb4f5bba592 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -464,9 +464,13 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 				return -EINVAL;
 			if (count >= -pos) /* both values are in 0..LLONG_MAX */
 				return -EOVERFLOW;
-		} else if (unlikely((loff_t) (pos + count) < 0)) {
-			if (!unsigned_offsets(file))
-				return -EINVAL;
+		} else {
+			/* Clamp count to MAX_RW_COUNT for overflow check. */
+			loff_t end = min_t(loff_t, count, MAX_RW_COUNT);
+			if (unlikely(end > LLONG_MAX - pos)) {
+				if (!unsigned_offsets(file))
+					return -EINVAL;
+			}
 		}
 	}
 
-- 
2.52.0


