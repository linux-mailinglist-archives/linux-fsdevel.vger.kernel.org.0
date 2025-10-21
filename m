Return-Path: <linux-fsdevel+bounces-64975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75575BF7C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664CA54386F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFB347402;
	Tue, 21 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyGuO5pH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B13473FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065119; cv=none; b=tkgry5nMWXNVxreh8zXNZoRN7P+el48Ic/xDh797B5Lf5yKYonlnjrxtm2NNCFozN/a5w3eU/8n6j/WwCMl/QODWR8lVfesGeQMzhTemBIJEy9K+9OXgV48GmOlJYPvRKVOH1j1HHCIPVgv0pUpOqVP/3KWRj3Tb86Osy66mxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065119; c=relaxed/simple;
	bh=Zf3CjzHUds8gVKJ/gkkb5KVePkkMbS8egpxe/GGsNKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVsKm8w86a2k1u1io/yj7We21Cq8YCp57i4G50FcSAR8zRkD4uMHkBKAEPB0zQm+aCsPL6n4c+5BPsuRJUBnnn6xRo3ILRu5YwWl3L44ZoIQHoiE5oAxVFYqDhv+iKk+C9voDJ3t6mTk17cASeCDNdUAL1UD7AYP+MvhVdYYF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyGuO5pH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781001e3846so5371357b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065116; x=1761669916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1j2/3P5HAdkMMWM/6sCR856GbpnVup2iXR6423G4Kc=;
        b=cyGuO5pHcD8gI2xQB3SlGZ0L2lT/huODfVTQcE5DAI+JFijYbrT06ZSZMHcRgMtF1F
         Qjgrk1lIWkOXlaKIwPmAMNNUAT7qjhMbBaF/3acn48vOQ5yrEfomEskXIbe/klv9rCGF
         k6ZW05ulwvxlxhPmbYY8qpD9zLdv7Z2nFHpMMjJfAUd8bje39GNaMAgff6kq9y90vHza
         WtbOoev/Uu5ZosE/rk5TeUqCEUCPzv/sON3GmL2nlKJ6xGvASULc3jDLdzHDITcJd3Uu
         JyTVa8hS6qHREBJIdIWSjClVsGpnLK0DFbRLoDLbijSs1thNUubIfMwqP77aj4qw49ZC
         5o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065116; x=1761669916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1j2/3P5HAdkMMWM/6sCR856GbpnVup2iXR6423G4Kc=;
        b=nt2yKWwKUAKTZRTknu59+a3ghE8o2XgYygZItHayDphUkf/Y9NU2JFNqtWCfe4itw+
         BsD9P9EwyxPFi5o4yytyPm1LSicZ+/HlJwHu4DRfvM82maMLej5xdXDhgfitBL58UMNJ
         //pnC9qLzot8ijGclhxRRFd1b+Ns7JEb0CVjaHbrik50M93DbnOSKHDSBbGAiSeeDroO
         zHkClShemIs3pcJAcJ5QNhsGMmajZxDMo5wv3A3jY7VwA2/2VoFJryFMAY2kJ1NFLEB5
         mEyp/TiMA1F9E2tz1cYC6LnvUP0ua1XT+kStfSoBqwWCbbbja0T94/MfmFTt8RtNSE/Z
         zfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVIzhgM3MgD5fot6alO9N21QDWj1HNfnZ7MCFHgk/WHVLgRsyNyu65jzMssxj8zUCKJS5vGDwRlP4T7nZ4g@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43k7s6hgMgLPL26ttkUIZVAVDBdY+6Ob6PlO3l0SKUee4s5+f
	VL0OW2K51Uou1eRMm/MWJ5AxObxnL6km+ONPBken+yAyyWKqWTDFFcj0
X-Gm-Gg: ASbGncvkSjwqyCwsRaswbxnXLBX8kXB7PbYtac0f0RBGyNM9AhQDxUV3dPEAuLCPYMh
	MQilsAPgB1QWfAhyqxGIVYwlCc72/Kjhe94LewIZiSuSNlIMGPPpSmCB83zQfOqARHLw6amDC27
	afNki0FTeIwOtHuYoUOszO9jRjBOmF56F3nTbbMTTDoXoCMCXYNmnUZdehIpiHJC3yt+h1pjVhU
	EtzTPMGE4PYbiJQsMCGsy9zYXPyFXaOYO5wKqjDroMr2tt25KZsGHvoIqjxrCatBVvePPYESJEP
	bP2p09QtAnlqTVdZp4Ojo46fY4zcFVmwEVd48nRrkCg70IIW+gQmMJW7hNfajKoeSCri8T2BuEP
	dZoRxn7T+6nW2IwmUXkHTni3gwhl4YQDycR8s9rOLCFL/uzCdrQQzVcW2QMUTfQi2PZlWcKXDbc
	8LwgkLepIB7RK0Jq1HxoFCW8FO/f4vlMnvwE7AhA==
X-Google-Smtp-Source: AGHT+IFtUFSbGA0N3Vw8iYtTgCsKyTiNbw8fO9bDKkTe6eoY/oQpsEZPQGeM+Gzd+Y64ASgQyPys0w==
X-Received: by 2002:a05:6a20:1611:b0:334:9f00:3aeb with SMTP id adf61e73a8af0-334a8565af8mr22087270637.23.1761065115747;
        Tue, 21 Oct 2025 09:45:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff4f779sm11817958b3a.32.2025.10.21.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:15 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 5/8] iomap: simplify when reads can be skipped for writes
Date: Tue, 21 Oct 2025 09:43:49 -0700
Message-ID: <20251021164353.3854086-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021164353.3854086-1-joannelkoong@gmail.com>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
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
---
 fs/iomap/buffered-io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 82ebfa07735f..9f1bc191beca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -714,9 +714,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
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


