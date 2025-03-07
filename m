Return-Path: <linux-fsdevel+bounces-43486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CDEA574DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636E71896556
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A425744A;
	Fri,  7 Mar 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VOBt5Vhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BA241673
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386320; cv=none; b=SsN1HybLE2HOZiJHCWhXpAvJ0CO0KSzYNTUG9spFvA3SIE7BNgofF7T3x0gbntXMkPE5L6krOeACzFQuZDF3KD0f9HQxqlJ0/uAkoCQmjjUZ7zwz/I/QZ9tthrbLlVRdBBgHE5G48sNqx2lATLjpfXC/rnYPSyaKj64ffOBKtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386320; c=relaxed/simple;
	bh=Tefjw0Zt4cnyZO02FKhjkwBKwBWG4UZLtaZPQIzucR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R39bSblh6HSPJh84AbLLVXj/exHV3wVY04+bPiXv0aY11yoQAioWa9RPBeN1KwMDVvia/i+9TxAB1JEVEmRnpnr5VopzyqBdPpYeE0Dto4G7r0avaV146f7/E4366RRwthaHPUc8kb0jjAC3zRwTCjXqFSgSZZoqYptoHTaB2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=VOBt5Vhb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso477812166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1741386316; x=1741991116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7bxGM8ehnB0CKiiNXfobN0duR+gRIWC930Rlv14dlw=;
        b=VOBt5VhbTOia0Al5PKYxai4X+deB6jaRpfsUq7LHAjRR3qtE58dZazkmVMzcVQ/nh2
         xlOg7a2SL44mIW2FFujDKocMJ0Q+ImKdDgX10VpDgYcOHtLNDJVdPMWx4J6ilCiqIgdA
         QbiibculboRuexNoF2QGzv4YRvQSlo4KGVP/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741386316; x=1741991116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7bxGM8ehnB0CKiiNXfobN0duR+gRIWC930Rlv14dlw=;
        b=w7dp9P/uCzF0WGX6kDOZ3YrGlDS9vOQf7woJyvmgFEdgRuDGht+rpyjwuZ9A5uLC91
         a/bfyhrIo1aX5ODRc6OQmhWc3OtNrCiWnIb0ABX5KQukk6T/D5yoZuoddQkqvbIoz5J6
         L6cb78Da5okm9lJiU2VTwJmMHSa77JWjhk6iuvZ873UY+WeemgGsuoZ52jQ9COv8GtoE
         vImS6giS+wR3CSQJJAO4aGYCa+cAtf8Joo6tMZ0BHK875l53zmXtoHzf8ty4f5hKHGf0
         XagEJYCujXhabGL7Q4AtLGfZK7v0VYBdVIZKs78RIcSStjPs6bhwchastGmCyF3zqyZW
         Nhiw==
X-Forwarded-Encrypted: i=1; AJvYcCXocbaHDMJ0h9x59uCsfqpOKXgQFKx0zh5+W2nM9vuN4+JkUfXIjcb7qoH3/r4Cq2wy7riRV/DUy5CJyq+W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Oiq9PAaUORD5GS+sq8OeqAHrysj4q8RQwEnsmCfJPFU9Yk77
	OC3Z1PlFIe8WzZU3DEnEUwrPYT917BY8ft06MCgo1kaPtPweHXbDBB8dPB8xALY=
X-Gm-Gg: ASbGncudMdKR8XnHrI+/Yf5jt0yW/ssL9Mrhtp5gKgCRWcnhtI7CHjN3iLMqjf1HNSZ
	Y8vdrRW7AvaIfZs+tmczErHt5NuOS8uPcVLNL+ZA4LB+4wOKYc8oFpCf0azSlHu+XgN8ldP66y9
	tf3txCUBiX2ZPgMUUAWGYwHXtm7JfIQaMHj5fmQ47VfsHxh6GFKi+Dap1Fhlf3ffO/MkJkkbhTj
	7U3QOB7IaiNgnOXNJlr8FkjvDykLaf9A+uuQJf8O+x8eWPFyJNIASC0RVrHrlwoniCm42ITlh4j
	GOfUseOn2378Y1p3g3cMJTzPEcVfhvq2gajHrMken5PibtXfp5pTxitKsq3QWxULGkXWM896wa9
	VCJ0=
X-Google-Smtp-Source: AGHT+IGTO+rlQYp8L/Ng/3pTy8WwsLZtG1hOzMYWfjy73pYnHQygx5aMKEaDNsFM6tybUcd4gs8WgA==
X-Received: by 2002:a17:906:794f:b0:abf:6b14:6cfb with SMTP id a640c23a62f3a-ac2525e314cmr594597266b.5.1741386315785;
        Fri, 07 Mar 2025 14:25:15 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239438f9bsm339136066b.11.2025.03.07.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:25:15 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/pipe.c: merge if statements with identical conditions
Date: Fri,  7 Mar 2025 23:25:00 +0100
Message-ID: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As 'head' is not updated after head+1 is assigned to pipe->head, the
condition being tested here is exactly the same as in the big if
statement just above. Merge the two bodies.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/pipe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 097400cce241..27385e3e5417 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
-
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
-- 
2.48.1


