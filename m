Return-Path: <linux-fsdevel+bounces-43155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA30A4EC2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2737E1884A53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901327932E;
	Tue,  4 Mar 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr4gssoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7726036C;
	Tue,  4 Mar 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113326; cv=none; b=NBBUlmqVrJbZaUTW7zzTnydxNr489rZgvFTQq1y//VhTcla1+k6anm9nXTofHeoRs8Z5NwORfcxEsxxctoojHmk8HscLL/efBkltM0xuyKhuTacwuTP/O8bICP1I+VvgqXCZ19TPFGwlEULeBoyVNYHLEUHGypoarm0pMCasTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113326; c=relaxed/simple;
	bh=Tj/MdgPZ5cCJuJyqipEsMQgzBXtGY6F6q4iEUHpndOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGqI5ysmhr36adBOKxEum4StMAjEC0n1e0nSlM6DEL0DcT2MSTaplsJ03tpo5mL3lWOIgacoWMq38XPmzaYI5iJoEaCdoTnSvtCpARlrX4tmiSWq01oxBdOpOfIeDpzTihcVq23bLtfCVSDT9el7k5iGeRihEezF1glDQwWDkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr4gssoa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so11116391a12.0;
        Tue, 04 Mar 2025 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113323; x=1741718123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyDsNpX9HcSDC6V6t1dVpjf3NEtUKhWlmeySG+ENdu8=;
        b=Qr4gssoazn91fkGY8RdhAuvgWyxQ/Ln19ABxayBzgErbDAvEQT8S6CPEwEGShakG4X
         HCfO+Z1KWv+5CmG4Dp8ViNLMXcbt6g2I4NFPJfmnhrscjpBc1N+pd0gW89IdnXaT6umv
         NSfqW8kyw5gX+B5x2w+BRaqUGy1cPWTdL49DFbt4wc3KAhfAVFaK/XxG4V2EBgo1NCb/
         vaKsE1dw87GEtA2DvZK10fmgz8BuyCkY+8O1aYSbjAArnx8j1+aZ+o63dj2Ku03A1Anr
         YiF8w2VwfI4BYMzv1UpHRObwvO5Gh7Wl3EdE+azcA8j4Ak36H4PnIe42rAtOuYscE4Tn
         niCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113323; x=1741718123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyDsNpX9HcSDC6V6t1dVpjf3NEtUKhWlmeySG+ENdu8=;
        b=YLTrDP9rVYZDg6Uu3CXT3mNJ19OtKD6qteuoBukYu2F7E50fGE3yNnSDOz3sgotcV3
         51SAFnKeUH5y4dJD6RtFVs3tSJ2+S+47cHvC02w6dpJO2lkkq35Ajzalf5bWHnmJMpai
         9XhF1ePXxXb/3+rsyTV9RJwiBOS/n3ZzVjB6YfJVDsaSA1iDagiUaSS1rDaZtVoBQBw/
         S6k2AAQeAjuqexu2GfjkbYZ6ho0ssVl0u7m1HgaM71NBVfeuPvcrvdA/kk4bUHzXP0qV
         SX8Z45hIF2TQpovpJ5pn2FuBlsJng+FIt9Uik4TxnUGTJp0mUNO6IXA5VUnngh0FC3Kk
         08jg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDSBN+MPOBy6Ve8rKeSos7PhCjGziNuRJTgmAWcE03DTXfKgvri7ipUlSjSFGDTRj242oqf9X1+sZAaC/@vger.kernel.org, AJvYcCWN+zxWBrjXH9aj2AE6JU4OP7ELqJc0v/5kM0PLqxmqxv/vVFRby23qZ04bKDthSIgVbkDCZKIBRTMnRH+r@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyH63spthe4jIcqIfzE5FXa1EjGscrVjw5Mw2sY0U4ysnUzaG
	t6P51FGaG+50grULd/CAS/aVJq++5S7k0mu/GWKnflMi3feooY7C
X-Gm-Gg: ASbGncscjxLUqtXORW/tDnsrcC/zO4EGEvXKRGyvc3azFa0nCJiIxAXMvPEMKZjQrxo
	MbbUHX14a08QU47t99PZZ+mtZCsYKFd93ydrFm5h8xp59SmV+QiwcirmoNhN2lPu604+OYr6IGP
	lcXGUblQhnZdPjbEn7h4fusFau34cgW/dgP9cdpnM2i91u6jNAm0RrMeaU60GB0V/Yb0q2krC+d
	BYgKtFitQDPfWZJnWhMy5ARX10upSvZIVRzzvWoyeioECkMpBFQ7wM6l8VkQK7C/mT1ux4+fa2H
	ozkQ8oHB/mb9uxNLEANtFPMc845jpncf4GKCwocLONmOmuGpVaH040NjiXXO
X-Google-Smtp-Source: AGHT+IGABG5ux5DyBs31vWizjFg2g8zC/4PRf2kiX5akS7Vj2GWs4WMJ+xD9KZXiN3kx391JN33YOQ==
X-Received: by 2002:a05:6402:274e:b0:5d9:a62:32b with SMTP id 4fb4d7f45d1cf-5e59f363d52mr148506a12.7.1741113322607;
        Tue, 04 Mar 2025 10:35:22 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm8691328a12.42.2025.03.04.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:35:21 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/4] fs: use fput_close() in filp_close()
Date: Tue,  4 Mar 2025 19:35:05 +0100
Message-ID: <20250304183506.498724-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>
References: <20250304183506.498724-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing a kernel build over refcounts seen this is a wash:
@[kprobe:filp_close]:
[0]                32195 |@@@@@@@@@@                                          |
[1]               164567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

I verified vast majority of the skew comes from do_close_on_exec() which
could be changed to use a different variant instead.

Even without changing that, the 19.5% of calls which got here still can
save the extra atomic. Calls here are borderline non-existent compared
to fput (over 3.2 mln!), so they should not negatively affect
scalability.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index fc1c6118eb30..ffb7e2e5e1ef 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1589,7 +1589,7 @@ int filp_close(struct file *filp, fl_owner_t id)
 	int retval;
 
 	retval = filp_flush(filp, id);
-	fput(filp);
+	fput_close(filp);
 
 	return retval;
 }
-- 
2.43.0


