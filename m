Return-Path: <linux-fsdevel+bounces-30677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713398D334
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EDAB2456C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688E1D0E1A;
	Wed,  2 Oct 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TaO/hpKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA71D0788
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871865; cv=none; b=NpS0o1qAVEz7wD7nH1LhL0rgZ3FBdIE9EjgdS+sXzPipjRxU9Y3D/Ay7g9J6emMrXosybiPcJPbiUtOPoIxKcFSr/nrUq2JnbzH0vA9LVbhroSJSrLaNThMpfistUCq0WKU6JtgbGDeHthtKEemoE7OPkgT9o++X3iyWjykEZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871865; c=relaxed/simple;
	bh=NeAb70ID8j42G87nUgP8vvtPg9itQ0xe55AFpbyVkkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5LDu9+Qehahgmtp4u/vKAFr2wKotHA0l0nMXCt2B+h7d4O49iEjIpL32Jsj6KW7hD/fntIDBreZm7X2DXm8MUopQZsNdH3GVNLQ2qtRCAiCn1mHdSTGQ71iBS9ng0sA6L2racVKyGnUiqz8Gd2+GAkYbBfJyHW98x/dssg8eAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TaO/hpKj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b58f2e1f4so28686525ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1727871862; x=1728476662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9jxj/j9nw6e8DwJ91on41pytWzp7KvscJb32q/qPAQ=;
        b=TaO/hpKjtqjz2/05Gh/g3dKJT/ukpVoOu5IgJ35lvMzEaK4vbdsA3vvW84pth2rWii
         +fURrrJbb2kMD9uUhJnCQ3YGC8UfLhedx73w69uy5AEyRnx5pDCzYAyyPo+Uwsb7zH4T
         VwE0JEufv34Nc753TgeeH5CjkCACD2xrIN4bdg6i4g5BIUN+04wWNZQ06403eLdwDiUY
         bmjeFxd/XJVkfGS2PDcDHAXMxupnsPU/S15NC3MDWBwJnkYQ0Vbso4YpkLw1twAk98KM
         hYdU5gN1OD+5axTGbmMSL0WhZrc/JhoPOpDRwXzgUWKlwzv5fh6mhu/BAQh9dcPRpHKV
         u88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871862; x=1728476662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9jxj/j9nw6e8DwJ91on41pytWzp7KvscJb32q/qPAQ=;
        b=KZiDF5HGUgeKhFo2klzvPnDC91m/wXxC4V2ZzNNXDB1GwJ8Xi0ucxXGMMOTtrfp+dR
         znA/h7hOwwVVjPs2TjWEW4ntPZZULJsGV4NS66y33DhIeXrmjczDbJ6l4Es8z2d0yXZb
         ZhY8736LPwPAeTixi9C2zkYXoBAOODNgUDEb+zcQZA+F1y7ol/Vwo0sqSabBsYZbwFEO
         UWVe+tPs8rwWFokaOJ6RS5AAXKho9ap1mPaxZgMY1PFr8UW68ihsTdB3jbNZOaaVFigB
         WJIaamZFUTYHlyS4KMUdZuiAp4myUrS1BCrRPm8nzN5gO1AArBSz5ayzRXsq09m3J1pO
         h6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX3baDrjWqZMMImmbG4sNkxA/OgKaUeY85PoOx0rclBYqZ4Lq05z0+pYiO43RcgW0WM2FmWaATCcOCFs6rD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/LZYUPli60uyRIme4kby0a78dODsTTLqEYL6TKg0Wt3AVKCC
	KudKdaNTBlLwpSik8Hh4gqSJr0ABrxpqwCLUFqcQmgmIaP5GoerU7eSiNtTnbc0=
X-Google-Smtp-Source: AGHT+IFXFlvM15oq56YUiyDf4u3yzUYz4CacAXGpKSzhgTP9fni+duAM0RvW9k0i+kMeuFGumcgwKA==
X-Received: by 2002:a17:902:f548:b0:20b:7210:5859 with SMTP id d9443c01a7336-20bc5a5d3bbmr44457335ad.38.1727871862407;
        Wed, 02 Oct 2024 05:24:22 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e33852sm83508625ad.199.2024.10.02.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:24:21 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 3/3] xfs: Fix comment of xfs_buffered_write_iomap_begin()
Date: Wed,  2 Oct 2024 21:00:04 +0800
Message-Id: <20241002130004.69010-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002130004.69010-1-yizhou.tang@shopee.com>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Since macro MAX_WRITEBACK_PAGES has been removed from the writeback
path, change MAX_WRITEBACK_PAGES to the actual value of 1024.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 fs/xfs/xfs_iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1e11f48814c0..bb4018395b6e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1097,7 +1097,7 @@ xfs_buffered_write_iomap_begin(
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 	} else {
 		/*
-		 * We cap the maximum length we map here to MAX_WRITEBACK_PAGES
+		 * We cap the maximum length we map here to 1024
 		 * pages to keep the chunks of work done where somewhat
 		 * symmetric with the work writeback does.  This is a completely
 		 * arbitrary number pulled out of thin air.
-- 
2.25.1


