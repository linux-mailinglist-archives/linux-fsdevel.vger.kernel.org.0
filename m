Return-Path: <linux-fsdevel+bounces-69112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE3C6F7A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E34F7D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134B364E89;
	Wed, 19 Nov 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCe3tRgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC885342C8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563781; cv=none; b=OcjXG9Xl/kGcqgIQm9HD5PwpICmln/uJqyKyRfqabhd9/3PM3o0T9N7IDnQDrdVYnQPBmL+DNqekWiiFB3X6d64CQUVQYtaClcl4FCy/6A6HbQBnODnlU7R1ht+xAbaYbQolW+wYy7ixE1DT+s7cQzF5PVaLu6E9ZpiJaG9Gayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563781; c=relaxed/simple;
	bh=3oYyxo/eiHHMiZgQI94sg65seo7XfkQSAjlKIt7w93g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+vYnMNndMayzajQmk/ntvvMa8dAceh/q2BXEeMhIOPokGFL+XNv7/81xYDA7iL/+fndnFX5wtLAdgpWxXpNe98R5CL6ViDm5RU8nZTeGJdDORsK3nJwisYs/vW/y7uOBxGalCfOGmLFXkImMYMtXYE+Sndkp3pgGSb71qDi1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCe3tRgu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3c965df5so3969456f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 06:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763563778; x=1764168578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ysI+6IOL7sqeQ8on1/EuP2SEU7hi9xtgLviKdqSFWY=;
        b=gCe3tRguWCAS094e8Li4y5yUlrV+Z3sQ6sp2LN7TQtRfuy0xX+NRzu9pnTa8s2uWJ6
         T94N++pUI8C2cxfrdaNfUAeCi3oSAkCHS2AUj5G8mxnfJ8GyMzYAB31smrtEjcpYVxRz
         mAqbYc35guvfRxLmoVeHB2q75gzoF8T/dChpQIfJKkl0+vUgGbODCy4OVOxmNLv1wBXc
         M6FdurEfO3QG2Ijrwhg5VIv9n+r5mGB2Li5kPZQ5W3o5jpHUh/dOWwMJUxnt1aQvdGgN
         OOxCyEoGIk3xrdqAiwcdUxfT//46TAKzGXaGMHxnxgYSHwVW+IhAFSa8OtxNwX2A0Vsc
         VKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563778; x=1764168578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ysI+6IOL7sqeQ8on1/EuP2SEU7hi9xtgLviKdqSFWY=;
        b=UvQAUWF/4Tkp408AqPWIVKibjwD4Gr8NoBqy2AM+NShBF1PRcJGJccJ5f6v+AG5xAA
         oDJwjmcuKvCoLkaDjL/nZZDosr9xqBV+ADW6sKE7YpdNJRasrsxRdmELynUghtS6PLLp
         xfwRTnwPmNlnkPooYht1sHhusrk3FYr3qbqfdZYp+dklChD6h8PVMofpAnGyve3+LLq6
         +k1i10VbY8gngt9I48Sv5ZfbID8XSDNdpbo9Srvdm/7W2GIdyZLex/pfvVCrVDwppxmr
         jBmSTIO6Sg00wYvuUgq51x5dwD4iEv/2N1CKtjHTsl0CSBFmX16ajNtdoZFcUT90cx1f
         zWYw==
X-Forwarded-Encrypted: i=1; AJvYcCUwdzTChoS8ZRGfZ5fW31ve9BppX1ZqxFjm51WFaPwxNojyPTnUdR2gmbKaYC2g8Gnl/fqujj1PJFFbg38s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LRAj/WXOLs2+id/ZVeQ/cLI7RKpA8aQwZ+l4BzHHYr5oIVJh
	ASCCh0t3jFQHiX4jAkpZ1obXNAkyvQN6AyGOZcH5mXoLHuvkwzZvAdCE
X-Gm-Gg: ASbGncsidoEy3aY8ZCK6IF/ZsgKanxnjw4S1z4dK1BIrVPeJYSs3QjF1L0Oi/UblfL4
	o6Meh24OC+NlR9UO1Y1Jb+XoCeMXxclD3mnMp8NmmBvF3rI+J3TwWcFuIo4WOgYd+0FdsR1TPHS
	MwxrdqoqCebUoryoH53cs6bjAnLzcSRQIidbe+cwR2NZSyi7DtI4xr2c2e9i8sCvWFEgoxC981D
	HmhQ7//FVVvU/aBD1ojLuou4qyo1U622W/c+tPE2uRxbqHwHx3TSC+7CBgbSF5SFxxie8SWfCzo
	F0jYMgKq/5Q16TsSj8qBSphRuwRyItMrY0uDrZAePVL+10QZ5MUaD5sz6sDMjIGoEmLCeByWvJf
	jQeFVO66pJDsICL7U06QZF8sJjMlAe5eBi+atWqabD6AY4unWLggV3SkOYp9u6cYXD6uWgjt0M+
	O2Vmuq22Cl8xS1JWPIA+kowCBCTp18a6cylmmoMnc0Xnl3hF5c9Y/O9wvEYPs=
X-Google-Smtp-Source: AGHT+IFyDFdHzHB9hzSqqAYdxi42ocjcvoYYE9cbVjQE3BDzr31CF+y74/qmoYF7TkWC7LWPSHx5Rg==
X-Received: by 2002:a05:6000:4020:b0:42b:3ee9:4771 with SMTP id ffacd0b85a97d-42b593503ffmr20237249f8f.23.1763563777835;
        Wed, 19 Nov 2025 06:49:37 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm39590390f8f.17.2025.11.19.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:49:36 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: mark lookup_slow() as noinline
Date: Wed, 19 Nov 2025 15:49:30 +0100
Message-ID: <20251119144930.2911698-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise it gets inlined notably in walk_component(), which convinces
the compiler to push/pop additional registers in the fast path to
accomodate existence of the inlined version.

Shortens the fast path of that routine from 87 to 71 bytes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

The intent is to get to a point where I can inline walk_component and
step_into. This is probably the last patch of the sort before I write a
patchset + provide bench results.

 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 11295fcf877c..667360deef48 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1863,7 +1863,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	return dentry;
 }
 
-static struct dentry *lookup_slow(const struct qstr *name,
+static noinline struct dentry *lookup_slow(const struct qstr *name,
 				  struct dentry *dir,
 				  unsigned int flags)
 {
-- 
2.48.1


