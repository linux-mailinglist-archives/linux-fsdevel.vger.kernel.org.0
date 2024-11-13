Return-Path: <linux-fsdevel+bounces-34670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B809C77DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B001F224A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F71E1037;
	Wed, 13 Nov 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX+d7cie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518A7080E;
	Wed, 13 Nov 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513073; cv=none; b=E9GCofebkHYEQcnVRu8znt/N+uH4gsxWWlB4BE4WnHN8Ia2nW9UnZy10a6vfFqdE8RV7mcZBmt30cvO4WJIOBt67CLIscM3DoWxkCgGJ3AQ6o3a+B5HsCQQUzYZKlD7IZezTZ32x8WZGaNET3zOaUW3FUcOBiIW8xL5RJ8IjGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513073; c=relaxed/simple;
	bh=8MGRA9hYboxLOztL3f5vUvdAhpsnT/UqBLVIl7abfp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBo7+He2rOEmm4zaaAI9JOioHR/Frf6Ahnl1lBrU7jRnLuhG17dVRRn7lyiwX9eI77wVj4jI17VXqc2N5kTRYFY40E1epgdoRH14BtjeUyASJq9vDNEksPuAVIKtoyUonnOY0GuZFywOD+kNcabIXiA+t80WqQTt//R/4DmCiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX+d7cie; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so1573852a12.1;
        Wed, 13 Nov 2024 07:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513070; x=1732117870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fte30riwc6FZQaQYC+IHZsQJ9uRg1npBzhDUb8Cdi9Q=;
        b=kX+d7cieJIdHwXcbZlby6QRLhojQzQKYdqobxmKbB0APFq7tjkOPnQGT1zcPHobXv4
         WcY5IwEcZSWA527J1u4XEVgZ4j7baUS4pB69uyiKIBpg9ITjFY/BI/ckh6pLYN0SsHbz
         2b6OOVjePOach0Fp0uaFXoQaFJE54CoyhSTxjCDF0YawHZQKKgv228KPPMLLakTaVSgb
         2jYy8/ZB4X8Vc6DaxzqCqiKinZEOAe/4PIpjLWl01AVFSH5jYc1gXIVPIgUiO1RYCe8p
         P55Mj+Yxa9tsCEhHwwkLvEh+/3TjVlH+Cg5g2ttt2FrowGt726W7jEAW9xRfusd8vyLr
         t/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513070; x=1732117870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fte30riwc6FZQaQYC+IHZsQJ9uRg1npBzhDUb8Cdi9Q=;
        b=WK1ks4Rq2zDFwBMF7yUWhdrxEDTgxMFMeHA8qDIs8sgUTS6I0mTJ95faSlOUOrw9Ju
         SjCaVnNsX5tq+84Mt9MaU5isZaywsL/XUNUcRenLYsg53ZY+xUQCfMoWZXfOWzJN3uJF
         4UyMCmnrf55cg3IbG6oodSiTxC/GW3NBg2BX0OantjecvEjNYTHKWXyYXnzMXs6x/86p
         poCeYEwQF+GdAueEIVw7n2GmOHszEy9AhqN6du/t5C5diElZ0MWuyrNYBVDY7WEW1/np
         pn/jIhOVFmWFmbTtOOrBxBrMXU8rl/s2t9Hwpmn2hW+M9BvKUKuhdNGe6DvutBuLVeLt
         ZTRw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4cFKXY0LhZSFEQQWcMoYp1aDgCWtOglqlLrk/1LP4iNfj85xr7wGjiNcjnap2IAjijbMaQdYIWup0LJ2@vger.kernel.org, AJvYcCXM9u1mcsX+scTGx7s5btyV23iR00CWQ22Ggo0lDZBo9hDIhUG0HUpH4/+7zQLxSIa6szucnRlZDP8CnglF@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpieUYZpJlc0f2NKhMACYXT+qoB61fUQKa60fr0zu3t5i4cJL
	6kqknB9cxE9MkJmbMYFlX+l/6Px1NvvRg4kLNBtXtOvFTudjWLR5
X-Google-Smtp-Source: AGHT+IGLUsmT8SMc3S6YYRSR3jyq+4a98D/t15JXLYsWaLn4hF2PrHMkm956BrvfHAnLOUQeTa3GhA==
X-Received: by 2002:a17:907:3e88:b0:a9a:662f:ff4a with SMTP id a640c23a62f3a-a9eec5823a8mr2165476466b.0.1731513069797;
        Wed, 13 Nov 2024 07:51:09 -0800 (PST)
Received: from f.. (cst-prg-85-239.cust.vodafone.cz. [46.135.85.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2ec75sm886572866b.188.2024.11.13.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:51:09 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: make evict() use smp_mb__after_spinlock instead of smp_mb
Date: Wed, 13 Nov 2024 16:51:03 +0100
Message-ID: <20241113155103.4194099-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It literally directly follows a spin_lock() call.

This whacks an explicit barrier on x86-64.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This plausibly can go away altogether, but I could not be arsed to
convince myself that's correct. Individuals willing to put in time are
welcome :)

 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index e5a60084a7a9..b3db1234737f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -817,7 +817,7 @@ static void evict(struct inode *inode)
 	 * ___wait_var_event() either sees the bit cleared or
 	 * waitqueue_active() check in wake_up_var() sees the waiter.
 	 */
-	smp_mb();
+	smp_mb__after_spinlock();
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 	spin_unlock(&inode->i_lock);
-- 
2.43.0


