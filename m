Return-Path: <linux-fsdevel+bounces-37963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3D9F95D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2554B16FCE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C721E0BB;
	Fri, 20 Dec 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XpNPsYgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F321B199
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709732; cv=none; b=HAGn/ou5IsrgH0EySg/PfpgNc83H98k09RI5cSsK1KvsktUkUvooSj4IGI+oKF2RltbkEo3fBMKiu72fK4E8PDVY30aI10LK+Gbm3oB7t5dqJCYN9cVPdGP8R9ZuUzrzOdb5ezjWx6NYLMtB8WZ6J15JDbaKo2dUJyZAXSHkHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709732; c=relaxed/simple;
	bh=zE0xjm5rhzd2cUhrSxtogiQia/migrwaLvBNVMhxtxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyY0YIZgq04nRsDSrkK2XWbAJ+Hskb18qNWLulJw01bxUPgZ99Wb0KjAHbc0w70gm62itnLZIEEUO3oNqOLGfy/+hmrcgJwTRpC+/HblUaPleorS/uUqVJBQedhbubLxr6Yrq6+MnGUgiWoS4alfgoJ43Hp9pQ3F2u4fMNTIN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XpNPsYgT; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9cb80dbfdso14303875ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709730; x=1735314530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol/7y93UZDywrWGNYi5AP2kj1AIRWUpJ2p+2aggyqzo=;
        b=XpNPsYgTpipkSpVs7LrbeF1UL0my+iixYP3Cr4OQkBjATc8tdVJhLIT476q7wihOZV
         BkB5ehPy16t6rAFUTluHuYjes5Gaf51+jjOZiXYKMf6qtE5GjeUIijoOA/ODjm8NdrLn
         0XZ8WETcvLRc+t5zb707wNiMIptKwv6c0v2+0NfazgNqK9co/x4RAnB4QT+wpvvb6GmZ
         5Xmm3bZIPMrEsJLXaN8u6rDnXrVegjcLy1lcYFDlE0OsZzbhB7rYdv49n1kpQ6M7o3D6
         I9fNEVK3Mz1L9I6osQSY4N8BMInx4CeTCYQySqVBUI3Ntk5Ho718230kzdmgVMGjbNjS
         JvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709730; x=1735314530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol/7y93UZDywrWGNYi5AP2kj1AIRWUpJ2p+2aggyqzo=;
        b=Ch3mweB8GIShpZUN/l2FDy0OHdTyaS3zZn08/oyuHTXpkbdHrX68FzMcX9zuEssYOu
         q4QRKYbh7CnOyCZECfaHuMVTXubHKdSny2A5TIR37ys1CCCwrwQsQe0koeTigyGRtLuR
         zXjSNgsa1KTaInu8DzpUTcZIVwgAVHDMuUZ4b96zvaMCLTk7jIjrSiSdejmtuFOJMC8p
         AmogsTPBJ5H3ZUhAY2EE6chiGvRwFMOIlF5TXnCBX44gfnnqmDgvoBLWadMneohF+gVo
         aJ3I7hqFiILAY4qWC6LOJ8tJ0sYGvBcC85CBUBQNwHUiGOw0Zm4ns7zM/XzULWQgpSx2
         DGCw==
X-Forwarded-Encrypted: i=1; AJvYcCXmquuT5c+MYz8PNSYfOOkZ8wirX22NGWzdPiHRzi8hTuNBGXk2NSE3XcGfNZ+UF2LzyiFXPGeuD9CTJcVX@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAYhFHajTGFj8OHJ2StO5AEVE8UyYc8+7BDYdvj4Jo+XiOlOo
	DZB5PFfvd+T/J9+EyFx5iIP7ct+m9XgbWrQ4cP7tZX60Sb2x55E3ux1kqJQNQPo=
X-Gm-Gg: ASbGncsCkEclB9b6kgLnKApaB3t3A+KCWHeP1xaHyYfftgNeHbFC6bFJ3otoiDMwOTy
	TSH1+8v86xO1iGh+gZNmNl8QSy1iW+zgUthPDWIT0hEkU0H7orvSrcd+TwezSbZYsDsOx4dhL0L
	nyx3FukykiM66luKJbC9l2K/WQA38WZ+FJVC8E6kPckUo1yAtXsa2tm03NNE9EyZdR2Q+6VJNRU
	M4cBe0uIXg+I8OvfRminOwikJ4ZcBGsj/aBIeVx8zvnpubSon4P7oal9fAU
X-Google-Smtp-Source: AGHT+IHBkJtXw0hIyGWIXWPfQ49T4FfZrn/htFVCpySmbejAxdhZ6x6C0BhRXfs8Jh6Ol55mQ+pxBw==
X-Received: by 2002:a05:6e02:17cf:b0:3a7:70a4:6872 with SMTP id e9e14a558f8ab-3c2d257934dmr36428035ab.9.1734709729627;
        Fri, 20 Dec 2024 07:48:49 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:48 -0800 (PST)
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
Subject: [PATCH 11/12] mm: call filemap_fdatawrite_range_kick() after IOCB_DONTCACHE issue
Date: Fri, 20 Dec 2024 08:47:49 -0700
Message-ID: <20241220154831.1086649-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a buffered write submitted with IOCB_DONTCACHE has been successfully
submitted, call filemap_fdatawrite_range_kick() to kick off the IO.
File systems call generic_write_sync() for any successful buffered write
submission, hence add the logic here rather than needing to modify the
file system.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 653b5efa3d3f..58a618853574 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2912,6 +2912,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
 		if (ret)
 			return ret;
+	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
+					      iocb->ki_pos + count);
 	}
 
 	return count;
-- 
2.45.2


