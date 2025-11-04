Return-Path: <linux-fsdevel+bounces-66995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97584C32F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5763A26E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC42EFD8F;
	Tue,  4 Nov 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq+L4wZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75627E056
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289510; cv=none; b=sa6OMirSpy0WaL/9kuZmjMAQdICz5fx+0yFZiwNI+/kosU8qDbkGRsVrS8YvFThcVZNlsZAETLfuUzlogW5QAUdgChWn2NzF3MJY1JbaZHB7JjyDIjafud0OsiJSAlreCsOu9CQOO4YJ/rKwo830BD2EpGUDeoxOg+61SUoCRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289510; c=relaxed/simple;
	bh=gt4OMfqdv46tI8YREgs9KmEGRTFgK90Jdvjvw+m/re8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUrRg0i77NxHf65ajy92VT9zXteEGPxHPqf5B5Dw7YzWLk6IrbGlD88J3hZVCYBJqj1g6EHbS/j+Q/jf1gB7d2yfRUzyDM9u2Oz/RswJGmxnyHmY+YIFmJJQK2Mbr90c2TkqGsuebsRnx6qss1AqrGRcxSLe9eIbopp8gpTVKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq+L4wZ/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34003f73a05so289753a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289508; x=1762894308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2ce7fLnizLLBFA+6zbLhRcicIu/2hxc5t9BIErUiQo=;
        b=Gq+L4wZ/8lSaNy4IzVfLeORjMZA3sjTHuMN6TajynNhRx2v4ltKSCvRM+rfn4EUNWL
         broTrDLPpR9a80jGAXNezihHPvZZLXTKK0xuJ4I7auVi+0ccTPIlqSO5OG5Q97wgDa57
         RompywpupOmhSKkQlGE2msa9iQcwEmzOF+RMwfHjitgN1Wxeg+vUoC760zcyOXAztI2S
         yKOL5rKYOF5WaVny3EsmzijM2ML0sKSaaIUlFpeOAdXP6PdEO27A14ZEJD5/7SG11TYK
         QOOFXjy+ch0hEasxlDTC9lUe8VMFIzdbUvzFb2fks89Kv8ZAsPOJRXP57hl7oRFBzLXK
         QhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289508; x=1762894308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2ce7fLnizLLBFA+6zbLhRcicIu/2hxc5t9BIErUiQo=;
        b=QJWX38OIuFC/yDCnRvinP957hVrIMJsf2+vVuNFBuyNoGBbFw2rq7GXSJvSw49k0fa
         ei85BaO8LP4HluHqh76nUcDYa0kywXvrZ2srQ2bJwhx8kM/cLTt2KOuF9/rH9BajfUfn
         B5P/GIFbkEF59DStBDzFvniac67s9ErakpleyfHXAIrKMZkXZe7ZDbSDDmGtYGSjvvjt
         xzqU8AGlIUbAvmWFRCY/kWKzgs7m1ZfThItgjTi8bX++47bFQJFriGvTkeFR3cl+ki/V
         Or6iUg5baHwrqkGCrn2lXEP3xmmdSuduRqZrkELKggdVlK4ZHg2feMpeWd1bjZcQUq/j
         Z+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmveMjVENiK9QKfclXe8n0NukLzTQ5MjF3uALs0NEhYYQredf+Bs4FVzfClHwgFvatiIBsZ++42uk6DJ1v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MvfodBznZWDVhq6Q2uo3X8Bk7coBlARs89e43WpT+rsoTmpM
	4JOmxbnt0VmoeMf1Shy+rs3aixrzwbdbiSFptRxO6PZ3QBDMjCvmO6K4
X-Gm-Gg: ASbGncsGnyuO92quNbOvBqBoo3D5V8GlcL3WBRGkLGwQupSkoR7Chw3NcXRLoQ6J0o0
	jWt04Od425OMYnFJvJ1bf1pXzPHVaf6y42lPjpw5Up2ZemnJ8d8eJ7joEFxWZSBPI7DYj0S5CWI
	u1Fe8yfESuZNEXsWQAV9pI/FXeaWW++N9+3NuueYh4cRrNaE/80J2HefmCIzzU+p6wz0J5TEPLg
	GyRFQ5EFHO0sF6m9WnLnw67QbBuJPHEO3ceIlZdp7pmmK1nXWKLEyaFmLvna0Nscxj/is3Nv9R9
	9/wt7t09NxvIe0I+s/bIJiEBKKTH/5d37jF6vv/Lt+5gTZFnKwy6K7OoSRbDy+zkVnXfEv+ZE/g
	+mxjLPpbqKIpvOwPqZQ8sdNTC41cbIP9Sl2gyfH861kLQUZrvbjF71SL6L34aCnuxLfqhHOo1xG
	OTf7IIzUtmP6705GIYvMR8vA2zeq6PhHfoM3MEmg==
X-Google-Smtp-Source: AGHT+IHGIy9Ug65RdeA8sPfd+AEtjQ6FxW9fRoOekzjhlrRuDeC4YEFVzusvShzvEJADf5/MSDClWw==
X-Received: by 2002:a17:90b:1c07:b0:33b:dff1:5f44 with SMTP id 98e67ed59e1d1-3417186b032mr5084597a91.6.1762289508445;
        Tue, 04 Nov 2025 12:51:48 -0800 (PST)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a689ad7fsm470541a91.2.2025.11.04.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 5/8] iomap: simplify when reads can be skipped for writes
Date: Tue,  4 Nov 2025 12:51:16 -0800
Message-ID: <20251104205119.1600045-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
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
index 0f14d2a91f49..c02d33bff3d0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -752,9 +752,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
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


