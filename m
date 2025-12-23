Return-Path: <linux-fsdevel+bounces-71974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04436CD92BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CD4B3021074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A4330D24;
	Tue, 23 Dec 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="giwN4CQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75A2FFFA8
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766491540; cv=none; b=IYdyFHzuzbRhEyzhAQe35/VXdx7hOpbzWX4Rrwxc8VQUxOyW74t5qLLMMAWt0Re7MGEgXpNd2nC6lTesUX1u9CSCzRmEtLDDh2T8qqaY4ThBD0cWeCbhLr+ikcucYcfo9cwkABsLrt+/lCzKPeUBJPj0uyHcYTbAjRHl01+mzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766491540; c=relaxed/simple;
	bh=m3haRJ8pGETAyvNAOZ29rsjg0cyKEKYKC/lZKJ00PvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JJfLNgyGNrQvOOM8C/ClK4h2ZdfDelDp8JmEb5CwHBvBlT6MRtboIfcgc2OHIb5XX3QrdkrgcpXfeoTaRKYe4SDWk6DVBhpVDepqz5q2bD8NwPdkJGDhev0HpdUH51eaKx+DsWG4lUp4UWKgp8PVZwaxRSIb+PQFEFqO7H+ADkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=giwN4CQX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so4385113a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766491537; x=1767096337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftekLSXzXE57OqOuAB8uQD/s+vIY9KY6GMSnZF6FfC0=;
        b=giwN4CQX2dZj/o5QAdKL4ArWH3lq4tcB1mT3/SYdssXjRSLvRyLiEE1urGADH11DoV
         j3ZsG8Q6WXhGDbxYcqi6f5D5Aa1LyOaCG+Jm5R6yI2+wFBl608oYMAZme2psvnC2uOLd
         yuvsdwLgTEkUztSDNkvG8TJdIGmdvrcCFmWkE6BMLyrOMUEd23DaaWJjCQ+ypl7ZYi6+
         4FMWd5AQuw/9+3Bpi6Nd01ssI+rvhrOcyxpLBTcW0qRP8gwjh6QS+k6dQRWVsubV5S9I
         y3uMnmdAHEs+mwzlsOa6oblL25LvcaB67Bn9kug1D+631k4inDFeJGjd2e0rXcAC8NFT
         L07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766491537; x=1767096337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftekLSXzXE57OqOuAB8uQD/s+vIY9KY6GMSnZF6FfC0=;
        b=WSM7OpzzpXdf47xscl/5okJWRH4LbHI37WZGAq4h1b7fx6YQgo9uYI7aMKgwcxTytt
         zQDIevFhPoGbqd6qWEztOi3MRuBrTraIvarYccEJgDLKvXaFwt/u81A/51shqlUSEKwi
         nd/CHXL2bUf3Fglvd2CT9x6dtss3c4Ehw0cSda5jzTm0Mw/tj3l33R/34Sj5ua9M30rZ
         0niPmfMbYZ0QN8xLvdINwOJIFZxZA1AgBy78SK/hOyHuCVFCG0zGsivR+mJ6TzoUijLI
         F+QTAbq5oLwiWrHJPmDDYVe2GF5cAaghgpuXryXsGBsPk/iJvkk5FldduV8lBfj6LiSL
         W65A==
X-Forwarded-Encrypted: i=1; AJvYcCUh7PGLiW5ql3C2n/u2NvnCMvdjezOTTfnFeVrimx/gYZumekY49INW2NodanJ7r2RcCADCOa4SfK6MRBkV@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2WaR/boTrllNbnT5KqtFdsndcVKXGQFVyEkLY+HcLsSwf6dJ
	qENJdTGBvfNwtter65h0uVxBQFfFRAyWj7fh0OcGocQlSXT9/QBmNY0UmknllQ==
X-Gm-Gg: AY/fxX6tH9lJ1aaRgjpX8+kw9C7PuD6+yl9fnsafSPdhQ/5Kqx6TEIWfLJWWG1hw4IJ
	R/+3me9Sg7ajP1zatlZkSPVxmVaAM3EP7fbH2zMEkp3iA7H13+46nOBmW/5KneCrghCU1kg1nbT
	ZPP786yYSAxR3LeanAE9ULNNjeqmRIh5WN8Y/5HpVAAl7vHHMXlvAAXAazi4TCYtrj23XNOPPCz
	pnTCE+NF4H3WM7QyyTYJMTkuaSCsuPRCdB1KYTxAtsgVt1xPrxsxCtrHN2HVe0MLRlFUhZ24z2V
	rHzoxeQeM1YaSw1O3Z1docFdprbtJceUUzVVusY9ziQc9/dwKjtqdZAD70wQMcO2YPi0gWBwc2V
	+YYh/Tr5kCPAf8jcmYYudzkZ+fnMGGggA9ubEFxTY/zqjz/lbioLvH2mXf0D0yzBsJbOO78BySL
	tGEVdbbG9UyJTcXTV3p/NWcoqR1v8lo6+gVRYUHXcGhu7/1ncw
X-Google-Smtp-Source: AGHT+IF5hqunKa9yMBO2eHYm/0kXxlE8e/7e6SNao1I1ieLhYqDDPkhXVu31e8uNu8wodFp0G/XbIA==
X-Received: by 2002:a05:6402:280b:b0:640:a9b1:870b with SMTP id 4fb4d7f45d1cf-64b8e94e16fmr13636049a12.14.1766491537405;
        Tue, 23 Dec 2025 04:05:37 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105655asm13720460a12.9.2025.12.23.04.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:05:37 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH RFC 0/2] fuse: compound commands
Date: Tue, 23 Dec 2025 13:05:28 +0100
Message-Id: <20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiFSmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNj3bTS4lTd5PzcgvzSvJRi3dKC4pKi1MRc3WQL0ySTVGPLJOMUYyW
 g7oKi1LTMCrDJ0UpBbs5KsbW1AKgWOkJuAAAA
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766491536; l=1186;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=m3haRJ8pGETAyvNAOZ29rsjg0cyKEKYKC/lZKJ00PvE=;
 b=d2+6khYeu6riFR5ZWDEyDJUAjYNnP0aB9l1igvC3MYpCv6IwQx/NhgRiMVUoRtiZNgYprksgi
 oVgHrB6zoNcDJp5t5NTWfmbG6ypVwlikalNuHUYwrYqyO3fs34S4bif
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.
    
Here's a propsal for exactly that compound command with an example
(the mentioned open+getattr).
    
[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Horst Birthelmer (2):
      fuse: add compound command to combine multiple requests
      fuse: add an implementation of open+getattr

 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c             |  25 ++++
 fs/fuse/file.c            | 115 +++++++++++++--
 fs/fuse/fuse_i.h          |  20 ++-
 fs/fuse/inode.c           |   6 +
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  37 +++++
 8 files changed, 556 insertions(+), 19 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


