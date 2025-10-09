Return-Path: <linux-fsdevel+bounces-63693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C01BCB27F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A3C4E7258
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1B253356;
	Thu,  9 Oct 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgzPSdqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B69286D7B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050667; cv=none; b=HFFussfPkz95VMR2GjW+SvOtMdJSh0YM5gEUb0T9kxh04LUhmWsSC69rlE6EBBgdQkag2FrMwPA7xmZf6YXJmHUETMJcqUm9rdUIfAAvyobu57rbv9ANQ+iGqSLd3QnaUEXLtgMxTpfsQ+G10fFCtiVxo7G/oODoT1c5XlI1GvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050667; c=relaxed/simple;
	bh=/PvOPPUDbN1UNVps4CBLHSCEA9h/hCpaFU6uoYMnHxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4bbdzb081HnyJctZ5ld5PgZx0o3XPLvKobrIQQc2ZTG+5VaeNiedgC8yNHA4/YuCkE7SlZvOYu1fHWHRq4wK31PNmz/CS3eW3NWcyQE8+iTm1017N+x+1DOvEJaLvvSldXx1UFM+d8SZlBsBnQFGoNGBp+zuia1R8sqtc5yT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgzPSdqB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78118e163e5so1938472b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050665; x=1760655465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y5ztGWr1mZEoFY4LY860Dvh8itLzE5u9hYi3dyUKfQ=;
        b=OgzPSdqBx0PBwqdE/mqS8SGCuNe4/35cf+Z5qokXpadh862CoGxGgTCV4mAGS5kAF3
         xvx5cU2bBp303J3cv+7h3cS0nsExfNhTUNM/lx4f0aNikDLjLM06sf8W5agEqflxbKDs
         Jtz0b9Tj7z8QhE6PWzz4vrEUGHBe5bkLjrSJGcr3Z7XptYuCAroi9BvsbcxtkULtbDlB
         fJFDGzshLO/oLyPD7nUPqE3/K9796wdH5zDdMu03k9E/AfXW3CpyXhX7dhFSZKEa73le
         jIhQcHeEUufXAJH1TY6qnWfbzLoKhrMlGE1xLr17xmH7Rd+n3zaOx2yAA7iKho+fkQEq
         TqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050665; x=1760655465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y5ztGWr1mZEoFY4LY860Dvh8itLzE5u9hYi3dyUKfQ=;
        b=RM0ykrvvw7qWhSpgIhZAuUihD59p0MEuIu13LX15DLTy4Jxw96lAADJV3DyTC6P17/
         FP0fjTZNVWruL99NUQpOm0TdfGwJVpn3bNdtlU3wg3JOdq+SyZ80oXTgPIC+oEA6gPiy
         yX96QI2tYeWIU8axC+I90MlAkIWj66D8hlrDgrn7Gos4tHeTX0x2EF9uLLvnIXhAlADC
         HAqlIMytL33TfkSWyMg44nUXR67jAII2BihrkD6df8wc35ejyRzV2NeBLzJ0prO+S1R3
         GAkBlKaiRnsEpsyYa/8+usFz0yNuzUE81Pi5AGJxE9gSIKzpfUFflKtrgwRxAsgnf5yV
         Ik/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhf01MwlDx8lAmn1uxQVehD1VLV68bw6M1qcd0TMw9QS5nN76Ughe8LFP7i7qQBayE8/WFMo3xr5+MSSIr@vger.kernel.org
X-Gm-Message-State: AOJu0YyVk2RP3jo3CFQXzOucu+WqbpVBH8NIc/qixp+RMFPUViy0ZM+h
	dLP1GctmFlvAnNG/+rzMS9OEUV2hpFCRX4nMK1Gh2lnP73jOoEv96sQ7
X-Gm-Gg: ASbGnctMNDdhXwQYZ8s2gvm4L5ia1tbssrmE/m+5sgG/XX8qfB2OMiqFoQtr6I50EtK
	ue65zmCAKiXbz1OYgnFfV2Rwvx5pFxOtsq9Q5Xrg+wPNfSLz/3EgM6U6ySU/eCwA41PjqeaGaZJ
	lgN8Ba6PYh7UPmQ6BGXr/pRgt7CMxD3LpCVZ3z6Gsf1UNfFDaRar6mqF2gqLe8r8oF8lCxvMsNA
	iP5h8k1e5LkXzGo9+4jKe+yWU07OrG0nhT2adGuF1qt8O2K6igX6ePOREokcsnAKF94U6S7mDVq
	Bg5Qb1eyPUD1IQ18XUKF8GKwFcClsd13EcZjzRGijO2UhRx0yaWslS1q+15XOW/OM4gnkB/rROE
	gjc0nQNFruB7H1zzVz45t5rST2qprdFWTXOUKKerzFoKTDx7UaMcVnCyKWq2qMrHYpnDhm84tjA
	==
X-Google-Smtp-Source: AGHT+IHK4O97Rx6YxhmkNDzY+Oqou1vFMCNo1CvFlT6ZvRRQb1itNjZZEmH5p0XrEA3vspY1/o6Yhg==
X-Received: by 2002:a05:6a21:6d9d:b0:263:616e:b61d with SMTP id adf61e73a8af0-32d96e9c0ccmr18083834637.23.1760050665345;
        Thu, 09 Oct 2025 15:57:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df740bbsm644434a12.39.2025.10.09.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 5/9] iomap: simplify when reads can be skipped for writes
Date: Thu,  9 Oct 2025 15:56:07 -0700
Message-ID: <20251009225611.3744728-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the logic for skipping the read range for a write is

if (!(iter->flags & IOMAP_UNSHARE) &&
    (from <= poff || from >= poff + plen) &&
    (to <= poff || to >= poff + plen))

which breaks down to skipping the read if any of these are true:
a) from <= poff && to <= poff
b) from <= poff && to >= poff + plen
c) from >= poff + plen && to <= poff
d) from >= poff + plen && to >= poff + plen

This can be simplified to
if (!(iter->flags & IOMAP_UNSHARE) &&
    (from <= poff && to >= poff + plen))

from the following reasoning:

a) from <= poff && to <= poff
This reduces to 'to <= poff' since it is guaranteed that 'from <= to'
(since to = from + len). It is not possible for 'from <= to' to be true
here because we only reach here if plen > 0 (thanks to the preceding 'if
(plen == 0)' check that would break us out of the loop). If 'to <=
poff', plen would have to be 0 since poff and plen get adjusted in
lockstep for uptodate blocks. This means we can eliminate this check.

c) from >= poff + plen && to <= poff
This is not possible since 'from <= to' and 'plen > 0'. We can eliminate
this check.

d) from >= poff + plen && to >= poff + plen
This reduces to 'from >= poff + plen' since 'from <= to'.
It is not possible for 'from >= poff + plen' to be true here. We only
reach here if plen > 0 and for writes, poff and plen will always be
block-aligned, which means poff <= from < poff + plen. We can eliminate
this check.

The only valid check is b) from <= poff && to >= poff + plen.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dc05ed647ba5..0ad8c8a218f3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -714,9 +714,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 		if (plen == 0)
 			break;
 
+		/*
+		 * If the read range will be entirely overwritten by the write,
+		 * we can skip having to zero/read it in.
+		 */
 		if (!(iter->flags & IOMAP_UNSHARE) &&
-		    (from <= poff || from >= poff + plen) &&
-		    (to <= poff || to >= poff + plen))
+		    (from <= poff && to >= poff + plen))
 			continue;
 
 		if (iomap_block_needs_zeroing(iter, block_start)) {
-- 
2.47.3


