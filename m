Return-Path: <linux-fsdevel+bounces-37332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9639F1193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9C4165E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFE1E885C;
	Fri, 13 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AAeHJeZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7B1E47D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105372; cv=none; b=N3YYNEmJGBou60++uw+vb+JIp38+hXIMsK7Ksl+GGtGHG4IuF3Yi0ZmmoY6cnle5WJDPcghctr8Z9WJmCKS/hsfo2OXOSm5hOzYpCWexrzSXA0M9uHuzBv2Ya7s5H28fJTanP/QJ0U/QoY0XDdEgo8AsIB9naZll+ijod9kkDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105372; c=relaxed/simple;
	bh=SKl6hxJdy3uyJbhZpOOdAiYhB+0FB2yQzq5XqnnCoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBEOr0Lo3w4tqdw8NjL9VL6O6K7TQQrHb4r5skCYyDZwGiZVj9g19r23iqIhhvud56wa8gVuUrmTKGKnboQILDcL2X2/OwaJFBNBVfpZB6C86aiZ1AR1TZxaW82ToWfy5o1IM+FNG+ER9h1tYeU3f5AoVyDicAb9Pq1RKulNVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AAeHJeZd; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-84435dbda4bso104648539f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105370; x=1734710170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz0Pdg9jqnEJMYLqH2tprv5bkemx7uetlhB6shaJiPY=;
        b=AAeHJeZdtfP/2H1iy+ldIoEDGS54o7//Dw0LyEhQdwB2FK9yFFGFcrabdhflnp0wSE
         r4/OU71VRA2b2GHywltcJnJlEL1ybczlTCu7MiRyPZL4gHKbl9uq8e/I+jYAtiAR0p8b
         /HSiDCDdIwWN2KJ1ZA7CVvimVvrQK8YBnpEeKzchSpnBKlVDSH4xXiwlMNSs+rj7CWQn
         /ZPx9n6tpXNmdHn+5S2uFX+cZJDFowx0rXuu50y3DH2XqOyofqO4v32vjRTUT1OuleQG
         PEMbCUTiTt15tdYbNozMlbAvfmBcw+52Y+IVA1bOp+woVNHYK3HQ5w9p/BDSOI1UnKxN
         QM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105370; x=1734710170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz0Pdg9jqnEJMYLqH2tprv5bkemx7uetlhB6shaJiPY=;
        b=ZanIzqQ11t3Rk7HcpOKrA36zoTVlI72XFfzrhN9YStaTThta6pL647SauhwxOid8fY
         uiz2LBfS2AtruDoTTVIan+Ly1gmyJmCXjyjRJ3S3GrkHNzGueqklH2Jw9NsVAPqR2o73
         O5q+XFCYRHrWdE/BI64BptDwcrAkgg15D6pkkdYU52PBvFJnx8OjRiDTvdp7Gbw0aM8k
         SWQVyUB5eZV7iRoRjZi7TsqPZQEZr5JevxhZSHv91oi97BAG3JLLb86gK+aoQJH1NUX3
         +5j7daDjmZ12V3J2nbo20p30iDBQ/ZdFgn1vGVyXCcKXhRACGpvHGFa7CxqzTJE2QMKP
         eeUA==
X-Forwarded-Encrypted: i=1; AJvYcCVLAcd269dBn3NwWVMR+KkotEp6IlgYWB+hG+5p3Zi1FgJ1F6mW/lh6hg3lkspH0NiCLcvW6sVKdnD9Bu7L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FqwSYfQPNKt6YYVdO/OS/3B3URYv35SLV4UmnqZimuXZxyA6
	Ikj7mCDu9yLLta8ts09yO2B921kyLGEqNtr8s94xOVQCHpVT9gJrEBdaO2aq6Os=
X-Gm-Gg: ASbGncvafu1Tispm5/bNgZt+fGvefMdGSHmhtXL99cPKweRDj9iDEoSSLUt8cy/nmOR
	04QYIvpAT8ucNR62pwlzpn/nsXCAAVGbDzKlDdiEnokw0FXyYfeTEz+QiDirBtQRegX4O8o0c1a
	HK44ZRrTNwq53JMYyVVgavc4XcHepArtVplznQaKl7wCaRIKk+KB2QoljKK+z0xFXgfAc2D/Lbx
	sRzcDsTU3xU+kT4DW02fEg0hCWXkncAr3R0OzrwXvrxfgF0YI3tQ501zaHZ
X-Google-Smtp-Source: AGHT+IHcUplw3Q6ECt5DnQxOZIMw6sSCxN/kZ+qm1VNkzK8N15/r675oe1NRLkEoEeFprb07mxKCyg==
X-Received: by 2002:a92:d10c:0:b0:3a8:13d5:bd2c with SMTP id e9e14a558f8ab-3ae61f23bb3mr46583235ab.2.1734105370422;
        Fri, 13 Dec 2024 07:56:10 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] mm/readahead: add readahead_control->dropbehind member
Date: Fri, 13 Dec 2024 08:55:19 -0700
Message-ID: <20241213155557.105419-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->dropbehind is set to true, then folios created are marked as
dropbehind as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..5da4b6d42fae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1353,6 +1353,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool dropbehind;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 8a62ad4106ff..c0a6dc5d5686 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->dropbehind)
+		__folio_set_dropbehind(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


