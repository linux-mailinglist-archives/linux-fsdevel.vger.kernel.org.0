Return-Path: <linux-fsdevel+bounces-74942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ANJN9dpcWmaGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:05:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F95FCB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CF93363D15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211E126F0A;
	Thu, 22 Jan 2026 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIVDjrt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C55477E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040326; cv=none; b=e9iN5gzosBRatPD4LJNFJMpNIUG0Dk84Xly2myLZ/uv221CR1IxT5RJm8m1Yibt3HTj47TuxvGZjuytHTylTVfjCy+/1tfePvRWud5pa/6qgBzzlzeP0AS11MPnrU758mRU+3E6ND8MZ/TrqUO2SXlXmtLce4P+rVEkon17YBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040326; c=relaxed/simple;
	bh=ZbUZB1ogPVw9gjpt+c9O76DxT1EELZCu7huPHQfRrGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opPL1CyFVAddbaS/POUsDMtfAzVupKzA6Wq358tJ+WwJp6RKhThaTg5PIyCndLDUh1Chy1/bVJ2WGL6RnDi9BYYF1QDL960XJjQ/FoAF89VDGg/a1QLsGPJcBAEP+aePtiOhZn9jbaDe7gSprNvZxuUQOS5uk1EVlJ89tnANLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIVDjrt5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146fcf927so15595001cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040320; x=1769645120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3RYdvqlKAuG/CfRii9sLaEP6zoDVwJWmRzC2pyderY=;
        b=mIVDjrt5nwkrAPW6GhH7zttRSivXq+CY7ekN/W1daoo8iKIBhpTZAji6sE+QcXLK1/
         BxfSM+JneQhBSsiL3JV8jFchryhSP0APuFfYbuCbNheurMPZ8cEqIduCTUJcpa5rwtAB
         dmKw0MZsPiVRZUPV7sGb/X8ZKYH4ytTsotekh1iaZrN7nAG3csUBg1jcSU2I8g0DUGu8
         3lvNET9CohBDWY7vcM338FeYV7xinbgIc1/OnCt9xspVxp22k3gXVGYy52aTFQxHzI+8
         HVkzXcOffPEo5M1ufwMmijV4Ya94RsTBLuFwya8JBtehCT36mH22zUvvm3w9IDc9pUz+
         GE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040320; x=1769645120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3RYdvqlKAuG/CfRii9sLaEP6zoDVwJWmRzC2pyderY=;
        b=BqEoQ77pWzB7urAX93WtX+qjOBIP0XsZ50N0WG/OjCuYWBJ70bsCAISpHbFrvULz0U
         25dVBLu6D2Uv1rXfSUqLbjT3h2vvOb4ACcf9ZJkz97FjNliKyuHkXAIiyQQ6G1lt3D2E
         AzYejfF8swxqm9/V+rgp2KgVUyx9BGZ3Os2JjtpPLd/22/tPUTkJgK4MGJRmWvA1nN7/
         DkrXvSjcyWEk/BjGu3a6BfLYlWTPxO7heJ3TAfFeyRZXj8bb2y7k/iAFdEiroTB0XyBN
         0qr7YuYk/obxak0dEnXXqUUairpjKLaN3xsvuAax/vRS+Nq5Z8l8Ahc413m3k1pYiqDB
         aLig==
X-Forwarded-Encrypted: i=1; AJvYcCXO5Vd1Zz9qK8uBDkkbLjr5UGWKZ6ZJaI3F8g0mRSnvV0YiDpUjmoM9oompA70AgKz80Qmg+T0zMyS4UTaR@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKhqM8g9TVagIHCPnocc99Le/yoG8OM+/J9ZpMTvi/FwFYG7n
	Lp5QZXqWuHG189UZMCOqbLAsJ9HtC5WxybbyEG+Z7Lhsdsj/tbEXtx/f
X-Gm-Gg: AZuq6aJ1sMyTcgYBMvu9KL6K6zPrXadYp4X8lkYOaicVm6SjI8dfk+/UwncaPTzSRE0
	VCWASqni7vv8x2mNDTk3LFO1KNhTDFZGBl2/4eGeJ9fAXM2giIwOsWKEHtHs9HMM5K10f4okTSY
	jt0JBpWAt9tJvZUAqyU8xDp6wRYDGMPKtlJW+USe2FBRA9y5fs6rZAGLPA9YC0Lt2Ac8vxFVVx7
	5PviDYM/ES0On87uQuXJyeS8ECPsOFzsiQkmz+Q5knP4ORL4zQPVOwV3VFtoA4LL4l5QtvyeRew
	6ih+f45vBl0Kd0zTN0Q353CZ+h2UzaBSOzqzio+DT5OCaevkCwIaEakZ1mGFbmY/USJyU9pl3Ls
	+gNauELdrzr/rQtNuwjosq47zMg2CyXF6twWHu5CImgEGi0T2wnP6Xvzb5kJRLMOFtjACS9k/z3
	zYDzSyMEZSSM2a2ELCGEzuCw==
X-Received: by 2002:ac8:5751:0:b0:501:47c4:ac8b with SMTP id d75a77b69052e-502eb58f9e9mr17132691cf.25.1769040319806;
        Wed, 21 Jan 2026 16:05:19 -0800 (PST)
Received: from localhost ([198.1.209.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f480sm122298971cf.13.2026.01.21.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:05:18 -0800 (PST)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH 2/2] exfat: add blank line after declarations
Date: Wed, 21 Jan 2026 19:04:34 -0500
Message-ID: <20260122000451.160907-2-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122000451.160907-1-william.hansen.baird@gmail.com>
References: <20260122000451.160907-1-william.hansen.baird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74942-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B06F95FCB5
X-Rspamd-Action: no action

Add a blank line after variable declarations in fatent.c and file.c.
This improves readability and makes code style more consistent
across the exfat subsystem.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 fs/exfat/fatent.c | 1 +
 fs/exfat/file.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index c9c5f2e3a05e..543ce7e8d367 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -192,6 +192,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
 		int err;
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
+
 		do {
 			bool sync = false;
 
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c1..c7cfa28a3e11 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -682,6 +682,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iocb->ki_pos > pos) {
 		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
+
 		if (err < 0)
 			return err;
 	}
-- 
2.52.0


