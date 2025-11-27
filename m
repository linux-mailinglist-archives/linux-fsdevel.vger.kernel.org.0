Return-Path: <linux-fsdevel+bounces-70011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC3C8E3CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C154E5C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4332FA11;
	Thu, 27 Nov 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkBzWEwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD02BDC3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246261; cv=none; b=NAORhpunHfx/og3IENxv2d4YF8A8ki7RoQrZAPXx87QNznNZmOp9pgEqVdlalMqggWpT6WzyUxzp3R3ApWddcBPvoDUZ4lNLQeGRXIbq4ucfBI9QXecr98UHtKs+pbeUeY8xpXX4teVPq7jwyTyuj5QavDeuXlV4N2/rwXT3FgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246261; c=relaxed/simple;
	bh=zo+ckksolR/h7SHC1fTJKe5lqK6+ZbJ4OuTN0WYLUXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUww9Rw0mLdTcQgiCDEDEKQwo83BWxQwf+Dqdc4iz7l94KdmXBhWd+nGG0gUdqu3P7lJ1By/yzbUHxhOv5WjSMBsZBm85/KlWyoHtz9ByZUSzYfvRklW7r5Ah/rC27oRrmIj5B5Rx5rfcVilPT0YLd24g0FKaYET5JAYedKevsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkBzWEwi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1352734a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246258; x=1764851058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gb8zqqjCqjnCPTBpSCwzYqt6s/4iTJBtQ9HY3ruGO8c=;
        b=QkBzWEwi8KC/tJv2W+uawof4YQtQ8e1shlzNWJPag1IBk/UXyZ4cnfBe/mjp8u/5I0
         wk3p+rOC29vTTHwVyUuJSxULDD2W3ghINu6txOTRzc5XpdLfqH0LQ2kcutfDvCSr3L2R
         S6q0Pjq8U4900ePVEaDkUqR7k+S4G4j+Z5nteiSJONYD8Jvs0iZdi+AvjavLdjAoeAKP
         R+T847Fj0hS1mEpkoFoBFobH4WSoTb0wFh97Pigs4MJ3bJeQ/3rfrQgyY5CNdEyDWSfY
         y1gXDuCDgND4htCm5WjgElgO1EouASdQE6QpeD6U7slSle232aKST1N0QNicnYrmZzK0
         bT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246258; x=1764851058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb8zqqjCqjnCPTBpSCwzYqt6s/4iTJBtQ9HY3ruGO8c=;
        b=SgQhmCCUIkBKXkr0YOc5Ur+1xC9vtJuNZF4kK3eVnDd8RAYC1A8k6p4chXielEkgyt
         JfQyUFGyd6aY0SukBwDIZUEt8vuDRehpEBJANUe0vCpd/zhpvY31T9lhYuLoy932aNDU
         ZwcyV2TwWHRC+ZpWRHWr+NIZtEjxQiQuYK0+iPxaO7z6x9/QI14+oaR7CjlguA3Y7T/i
         MGWd7mXLwyk11jkf72+sWuUjTMT3rO9cYydZ5Mo7uTZS4JI6pAm0R8ST8dh8JBy4u4p4
         9FP1L1zGBVChp2pt5XgZ7XDlc7gzEwhJWtOlyCs2dUCEgQvdbou+ecVxlT7T1MWx0E3M
         sgKg==
X-Forwarded-Encrypted: i=1; AJvYcCVQo7SovhXng6NSFhS9wKVlOE+aF1NXhStuGHjQyOPXQS3YbYAqElFZhNnjC1z7V2LxH/GhzFS0cXHaxH22@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8T8NZgoQnwXyVPAgy7gAYxUbqCc9GP34IdMfRr4J039dACEX
	CqmUjGnX6BKNGN2q7PhMZ3J+7wBcfxRRFjfskS96kZSeOfLHaDcMES71
X-Gm-Gg: ASbGncsIZad9SeZIn4YRb9dRppwWW3IAFwFgufYl/JtZ5z3z4lWwvaKONKz3yEdzE2h
	OlRfeNgkM/6oJX36fGy6lqCOs4KUeS04Nwj0i06F1Dshv9bA0DLo41gPMXt4XVW16LCT5YYz2Qk
	REVTNbRH+4/dlluZHe0OPk23TldfsTeMiAjrqI9wlh56CKp1y/zIyRTTBPzAyLcxw9r79G932zo
	i7ZIGGvD7D2OaXXGDHbCb0gSre3f+k7z5Ivz4IwIKbQ4aboHJ0KD4rIC/zmgxMOiTlMVRRzz5gE
	0h3aQTOE8mZ1g1eWSnmyaCn13A0ETZKqDCB+TdjOfTv8RW2UYzlqw5f8dzoxifqdFQI8fk1GnjA
	yOwHuLj03684ppyRA1s1XEcealmnFgBJX8t9nuXvyLRfO8pwY6Ky+1ES6QSG0Olg5sZz00tqdXZ
	JWKJMCPZnDHwEMN7XBsF8XNJaH82wUtbmbIc9oowniz1pt6cmQ1blEBhbbvlc=
X-Google-Smtp-Source: AGHT+IFoyNxCsdxk2DV+CcdzsOg1WTBusWzZWpn0HqAyCUGIfXuzp9JtdiDmPOtrMRI189/JfOmbAg==
X-Received: by 2002:a17:907:6095:b0:b6d:6c1a:319b with SMTP id a640c23a62f3a-b7671549cd3mr2597924866b.5.1764246257790;
        Thu, 27 Nov 2025 04:24:17 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59e8612sm142586066b.52.2025.11.27.04.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:24:16 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] dcache: predict the name matches if parent and length also match
Date: Thu, 27 Nov 2025 13:24:12 +0100
Message-ID: <20251127122412.4131818-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dentry_cmp() has predicts inside, but they were not enough to convince
the compiler.

As for difference in asm, some of the code is reshuffled and there is
one less unconditional jump to get there.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

i know it's late, but given the non-semantic-modifying nature of the
change, i think it can still make it for 6.19

 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 23d1752c29e6..bc84f89156fa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2346,7 +2346,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 			continue;
 		if (dentry->d_name.hash_len != hashlen)
 			continue;
-		if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
+		if (unlikely(dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0))
 			continue;
 		*seqp = seq;
 		return dentry;
-- 
2.34.1


