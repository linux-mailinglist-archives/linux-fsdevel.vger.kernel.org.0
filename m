Return-Path: <linux-fsdevel+bounces-67985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BA8C4F9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5C189D2C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9932A3CC;
	Tue, 11 Nov 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Biz5iAc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59723329E6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889930; cv=none; b=syv3xdpzLyWaUEZhfkwiTzhXrI4HdoISCd1s09vHf17opw+0uhFy2/g32pG0my/fEaLwSfUDQZ+HHvQSAmYU8MmhHrJ7yixAzvJ1HA9QrkeEe5hmkYRmYfg1E4vEr8Qdf3NZDwl9FAGBjpxaqmC5g5CPAoGLR77lD0F10H3IMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889930; c=relaxed/simple;
	bh=080WzniW579oJXmstJ9YuYh8/JK8IBdT5Yky/VUBuJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLoIvYL4SSN3R1p323KHGLYtqUOALcaKUaff7KDOmsjp9TA90UJKelgqhqvltTLP7779TRITdr56bHnccic68pmgsGwvcQxM3OtDtULf7249k7BiuDTFWC6evKjOMv+aKMvbrXbuaFuYFshvI6ROjMwAY9ztvP7G3zQlweHnNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Biz5iAc4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3434700be69so136876a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889929; x=1763494729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0U9wcpeyoTwrgfCCy5foYmqqdoZu9/+bjoADuIZh7U=;
        b=Biz5iAc42azqUoi+sQWsJ5VvUoQWJfIk4+N5Z57Di/M6fSyDTK0edCeVJAkFFJbw9y
         Q9gegd6eSNFhsoFE8a9ym/pLccnD1vSY9AM0w/kmIKa32qsPtx+rBWABReV8/FhHRepr
         D7UAlYhqlZU/ykLL6TnCV4i2EGH3H8tgZhxIC6EKuRZ+epcceOrzB5JBv+Hx8IXya76E
         b9fxPnDJkjRPMbGFyp4xgzLr7HqeVsMmIjZ1dtVreJShWDTudsKFX3U0//CMV0BG+o4S
         wfvExqeZ2MTiARAY27siCMi94EmAjcAcd/doPXPXnhJ45lapj+Y9YBDzj9FekIOlexoQ
         uxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889929; x=1763494729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0U9wcpeyoTwrgfCCy5foYmqqdoZu9/+bjoADuIZh7U=;
        b=Ref4XnY7CQ7CreZr4QTXhfWiOPi8VBR8b14OafcyoJSz0kKGz8zEBiGGxPLNPx7T9W
         CBJTzBIB/HJHSMaHQoFTU6Pm/M6SJCryJsSqh71eNCr1IlhS6FKI9y4QYcrHNRXkgphg
         bSp3VMZdVKwtZeX6oM75kb3IJ6DlcXFWIyKpuqKQhLQhWO/XpO/GEem0JATAraFuCTX6
         gVDSur07nsNlVilvZ5ehJKUYo9zBiN2Bxf8FyyURqPFqoBb6jOVnbbmOCW8LdQdYKQG0
         v21Q3IHEOHgncWAInAFTwJ6W1h2eu8s7o55AQEKsB8bxVwwfgZWkCcemlhV3qP7Y2lL4
         G+UA==
X-Forwarded-Encrypted: i=1; AJvYcCWlhkIV7ws5X7Rane3Ko4QULHlKOVCGvHcCIKMv521NT/MIf2M1/wzKzOE8yD0EXyAxVGHw7rLEmvU8S36u@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEHPxspBkxQ7xfcMwOww5cxGP6T2z7WanipbjUOX0RFmGjLkl
	JrlMhwcPv6rz+a8GGUPZ8/7KRg1OB4HwFcvnKMU64ynF1InNkB1QbB99CrW5xg==
X-Gm-Gg: ASbGncvTeK8sHLIptzu92VEP8qrV0wd41/IvK7f0t+HFRKtQerio7Zw3QS80fvNftmZ
	LgwtjNQxswajQh4WAAzzXP138z0wYGXvCbkwuFglIfthqQ+TmZGHcu+Dv7UPCrL8xaBDVbo2CJA
	r/gEq81qKolm7m+e1k9czCAsWKCHbMbo7PdWngtuq3dsjXkzn3WHffZDfXK3hMHh1qtY4o5RIBQ
	Rv8sjmxX8jHc1EiSoUyiD2oY32V8wfQ5GSxvcsSNXrUeBjLkx6YGdIHzXUmV0qrnMdWspQUYtlW
	IaICk6wKzxDWGKwEMyKZ9dVszY1Xq6eSq8QF1m7zZWzXtqwR6ei9my+GUIOfv/jdrB5YnfbulEy
	jAeEJb8VMdzzxpv1Bzz5qYRdlufJDlIwkckhCdT1kue4mzFiOH9qnpKoqATYfWdf+vFqi85YLKC
	yw2b0msg5gFM0M19JYfUdGGhMLwloUfyxExA==
X-Google-Smtp-Source: AGHT+IED7oRJXwK9ZEp277UzsQ4FhXym8zSYGUoRpo0+z97OmqcJePNAp+xwlD8r+SKf3NQC9/9bjg==
X-Received: by 2002:a17:90b:4d09:b0:341:133:e13d with SMTP id 98e67ed59e1d1-343dde0e97emr572009a91.5.1762889928700;
        Tue, 11 Nov 2025 11:38:48 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c07a3f46sm1966346a91.2.2025.11.11.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 6/9] iomap: simplify when reads can be skipped for writes
Date: Tue, 11 Nov 2025 11:36:55 -0800
Message-ID: <20251111193658.3495942-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
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
if (!(iter->flags & IOMAP_UNSHARE) && from <= poff && to >= poff + plen)

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c82b5b24d4b3..17449ea13420 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -758,9 +758,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 		if (plen == 0)
 			break;
 
-		if (!(iter->flags & IOMAP_UNSHARE) &&
-		    (from <= poff || from >= poff + plen) &&
-		    (to <= poff || to >= poff + plen))
+		/*
+		 * If the read range will be entirely overwritten by the write,
+		 * we can skip having to zero/read it in.
+		 */
+		if (!(iter->flags & IOMAP_UNSHARE) && from <= poff &&
+		    to >= poff + plen)
 			continue;
 
 		if (iomap_block_needs_zeroing(iter, block_start)) {
-- 
2.47.3


