Return-Path: <linux-fsdevel+bounces-54398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13AAFF474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FB7AD9EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913B24DCE1;
	Wed,  9 Jul 2025 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE7PSHPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD62246795
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099066; cv=none; b=QZbyRgfI6uzSXGL4ax2q9q+jbhExTSgfvkopyXMw8yArq38W7vUUvu/q4Nyh/Lt9kGE/ViLIv2l9K9h2avUFjAjIFCuSbw9HN5xF3bdMULpdYn89cIGdwR6i+di5Hkf1rryQXFbnPVX1Ey/HWj1H7ArEVzatdTg3HJqZG3gY4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099066; c=relaxed/simple;
	bh=yPETnJGbukTef9wflLNDOM57rZMQUJAuFa14kYG+G54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1cP7h1wDbQpeLOT4BZUGcIQUqd69jc+DRCMCqXabzeJxquN4xbfhPT8VvDrTl6kiR32ZNpqvqcA4zpZqHzL34zLgOn+Tq/hYULZRD3KBMDlBEimVdra5wrNxsuibiUsg9OuWCeEqChMZFCz/Ka9kEdGZHmI7YXj39PVx6AHh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE7PSHPt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234f17910d8so4524095ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099064; x=1752703864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZfBYH8AR0Xi68AxcA0kAZ8EHPlNJCHYU+NFUTl0Fuk=;
        b=LE7PSHPtznn/Vle4h+YeLFDhFnKD6DFfOff58jBYxTLQQbqPmnejOgYJF3rD8q53V/
         966T+TZKk/vY7jVFzv1carGRa5JD93yL5F+8NzkJDGKS5aC9EmkXgNkd7jWDcpBiRzE2
         atH1mJRoph+wxKr9ltNreEv5UapmVaD3ykFTrE8mCku1u6CNlcidl2U60I4gWXwAPuN0
         X/l0PMHeAAprXgPHWIrltiXpoiMqQ8THntv0lFmuRx/dzKRy3ZPxwyCeD6rKuuyNiZQ0
         YslGhny9BR159glfTxXrU9BzTrUD3bpwU03o77+2glWudJ25CDiZfgkQmZ2zZrrinx5E
         x2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099064; x=1752703864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZfBYH8AR0Xi68AxcA0kAZ8EHPlNJCHYU+NFUTl0Fuk=;
        b=gkPuDTRZwk+netxG33suRddCS/2MRYqHyh74oBWh2jHQC7k4RAMNBvDWEtHhLId88D
         kZWjDh8kLHLoZvcOlHZoBMRzJyChrPrTeBXN8OiRy2mynSvjNMJaDyq5uYIPZt83e2xI
         XVgG7jly6lbIk70sIp3nAfe4FCZSDxWeLTKUGx7DfxvfG5RCNKB6McN5C34UbPz5P2J6
         T3JgDJkEcpR96+t3O2vMhKbjky1vUJqwQQ3JYYbaGR+jNDUO7CCH96k2+JJ4mSrmaaBz
         +RfJ4H8Ehmbyxx2Ap7Egp24RMhI2lfpHNZTd2LoJhr5tVJbF3jYq7kf7ESd901SOODcn
         Wkpw==
X-Gm-Message-State: AOJu0Yy/KXv2JY4ZTt5aq6kY6JWe/WJfNpdShOzvPbogPxjl9dyil5rz
	mVBTO0+ktkqgSTzCZINIJcOvFHT12XdJTdMgZzcZnA9V20ZXn9Igj41TOQzc1g==
X-Gm-Gg: ASbGncuDU+9k5Kuksyn15sC2SCbA7KK8ARhSg95ZFmS7D4HVNmXdfIcfJ5kYpDFYBOI
	YQWIuJTdRcUNf2xOzY9AovW7WrDyX4NTZp6fNSgnvPEh778O8WMF+ByxLOF6lHSNNRHxWlgk4/u
	kxNvwMIswAe/6fKMzFIQuqOPP6enRLfytOXLTk50FVHNA5jeufqMl4eL4+ioRsKSI4zTY9gumc1
	o3dl78poNtmq2xlKXfXBbdBIZHrBOhVQC03y3WyPDoqBKj5hvn1jfSFh0a8DImTeSqWdN0HWF2e
	tjuIj7+JtTXKMb7Dg2pVDHrijU9Y5Shqn3Q1zf/+X0unVftVGQFs7QvN
X-Google-Smtp-Source: AGHT+IHapHu7kmawzfb1A2AuLqrZbj+If/qEotpU0AfHmjOl+4qMlS8/HBEsSEsIDMk28mhmRYOwnA==
X-Received: by 2002:a17:903:b90:b0:235:f45f:ed2b with SMTP id d9443c01a7336-23de24331ccmr22478745ad.1.1752099064311;
        Wed, 09 Jul 2025 15:11:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322890sm1996015ad.136.2025.07.09.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:11:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 4/5] fuse: hook into iomap for invalidating and checking partial uptodateness
Date: Wed,  9 Jul 2025 15:10:22 -0700
Message-ID: <20250709221023.2252033-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709221023.2252033-1-joannelkoong@gmail.com>
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook into iomap_invalidate_folio() so that if the entire folio is being
invalidated during truncation, the dirty state is cleared and the folio
doesn't get written back. As well the folio's corresponding ifs struct
will get freed.

Hook into iomap_is_partially_uptodate() since iomap tracks uptodateness
granularly when it does buffered writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d7ee03fdccee..669789043a8e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3103,6 +3103,8 @@ static const struct address_space_operations fuse_file_aops  = {
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.47.1


