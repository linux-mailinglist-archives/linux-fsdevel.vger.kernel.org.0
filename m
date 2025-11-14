Return-Path: <linux-fsdevel+bounces-68542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB4C5F109
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 348BE4E1A88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF6324B1F;
	Fri, 14 Nov 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="gB/m9qsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1322DCBF3
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149068; cv=none; b=rnUBB7qQtsB51XHhduNUq5q6W+w1KDV9u5/Q/gRxM7yta8C/yQF2lkb0Xw98DgHkP0kGJh1C6D5iuR/C1Q6BDQaQARYSDcE5eqRrCkV3/3/N5XUjfBVcU9xfz7Jy6UFlh+FjQ5godELVk+MxleP1sXEtG8iZ8u6gic5Y6nCN5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149068; c=relaxed/simple;
	bh=w8x1vgY5Ytuh+8oAzT9I6DYuO6E1SOohSBxub76r0Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQEkY2s7wkXAb3PzIRYmFrZUVJkqzOVmMfnXhcsypEwEbEBNucArZ2UPursiY8aSbUwGH8r3jDiGO2B6d0JIokqy7RALK3Tv7SkKO3EWAEGzlRgafTBjn1R1fmXhwEj5ahNZ/TI4ptDH9/6As34EXKI8bw6KkblS74eUQuJlsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=gB/m9qsl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aad4823079so2162593b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763149065; x=1763753865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XU8vU/KjPE99lkBMAKIxdrPamg7+p9OoEjvmjp1kXQ0=;
        b=gB/m9qslmSjHwisTXE47sBgVjnU7/AQn8tPivcaH8mZxuduYsz5HbloRU+NMlal7DH
         7KmZEDBrWEuIvS/9L5bBjxUMiRY3J9ChalJHBI9q0jwelORF7fVM6siArnFqOnammBKA
         o/b+82QVEQRa/Laq/Ew+b4Ov8ix11AOpiJxNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763149065; x=1763753865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU8vU/KjPE99lkBMAKIxdrPamg7+p9OoEjvmjp1kXQ0=;
        b=pPeFEi5OtgkAt6BO5gdnG/nRoXHUPREOkP+l+OpmdQ1bcAnj3HDdD3ncEPhXFNeSb+
         Ibe2dx/8AxfVlCYpY3qhIG/HSIEkVjEF0Qw9Izpcd1av/YWA0lEwvxFG1FcjkLy5S5Ca
         IUTaGckZGR7STtPKRA0REnrLdFfOOcYarXtMiHJwbb0jaPJ1InLyRu1ozR2JUIDEzLU0
         r+UodvYrAKBlHyHAbq8zq+f21i8t4MrJfY8qq8logr2MjJBw85ejALM5VvwJhrWBU/Oc
         crQrqNCrOoSa/xz123j2UQCJmOwQHxg12TdlbCCbWcQ39ANyCqM4+jCM8im57kJCOXT8
         9DYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtNGrPtoHlwjOQDLoz6cfFikM2FGZsZqNm7pNycbKR57Y8vklQ725KU6Lies+7k/eVja45yM0pfoQ1HAiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTccXdwn/PU9VOIruyiGO8DG91w7M2S4yK+zKZzVeQDi++YmSF
	4kh+YlGvmGG0FOPeDSub36tY1w3cx4g9RX9AZOgYVPbOPxcPEsDbVuWIgwbTdlTvHdtV17cVm3u
	jkL7sPeg=
X-Gm-Gg: ASbGncuMTFs1SFYMdtnzzGVKH3PVwouXT7xDm7dUQE7v7Q3fEBZm32LhH27cydCmSt5
	QvoeaNqXpPmFlqFmjaZIuTLqXYAFgbjNy4BoNQOH8gaMq6mv0nsLKSCnc/s5AxOAUbAEjCXUZlz
	rg22vgwenmOAKJ00uL9WkvbEu4OpAoEYTRdHO8cdH782IZwQKkhJbfUOswGRH/XBvLR7d9syqfa
	sYW3miPGx81qheNLfXQTzxf4CSiBdOV9+pWk3ZFwWfjpK5EfK04oFDoT1ChnNE6GN5xwKt0pfiT
	/DCr1CfIOiKlxj6sZDPPtJbKJMX8kYz3GmMRIG+LPUS//TEyfutbKRhDYnk8jmNdNoLhzmDEk1s
	kl6XaTJVCQ+XJ+ocXPajuGuJABuZNr+7aoW4TRRNNqFuf2OIBI42HnAXfiyfk9TIzAgSaBZGqQN
	CZ2H+NUoasVNPSICQlQs360yiWKzfrz9KKvfvGMYJU0ttaYx/1XV+w2FsX
X-Google-Smtp-Source: AGHT+IE+LbpWEktarCB2Dnrv1yWZrNsnZpDCOeAp7apnz9uVsWtNi+RAN9rwFssQKUSctcc6Q3Qc9w==
X-Received: by 2002:a05:6a00:2e8f:b0:7b9:7349:4f0f with SMTP id d2e1a72fcca58-7ba3799f055mr4742484b3a.0.1763149064968;
        Fri, 14 Nov 2025 11:37:44 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:6873:3448:fe16:68a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cd5f6sm5941807b3a.16.2025.11.14.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:37:44 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	shakeel.butt@linux.dev,
	eddyz87@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
Date: Sat, 15 Nov 2025 01:07:29 +0530
Message-Id: <20251114193729.251892-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

When read_cache_folio() is called with a NULL filler function on a
mapping that does not implement read_folio, a NULL pointer
dereference occurs in filemap_read_folio().

The crash occurs when:

build_id_parse() is called on a VMA backed by a file from a
filesystem that does not implement ->read_folio() (e.g. procfs,
sysfs, or other virtual filesystems).

read_cache_folio() is called with filler = NULL.

do_read_cache_folio() assigns filler = mapping->a_ops->read_folio,
which is still NULL.

filemap_read_folio() calls filler(), causing a NULL pointer
dereference.

The fix is to add a NULL check after the fallback assignment and return
-EIO. Callers handle this error safely.

Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..f700fe931d61 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3980,6 +3980,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
+	if (!filler)
+		return ERR_PTR(-EIO);
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-- 
2.34.1


