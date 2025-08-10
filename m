Return-Path: <linux-fsdevel+bounces-57225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4BB1F992
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05651898ECF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8037F248F47;
	Sun, 10 Aug 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDyIV9Bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98480246795;
	Sun, 10 Aug 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820962; cv=none; b=B7zpEWZBK8beXwbNoZgQbMeV/Rr70b8MX+awxA0xRzPyQ8JmwgwXVs2UIsIZHHucs0PUF/xldxAMJe6mCo77614S0n4dTte6J6tIP+YKwjYSh46HcFubXwj8qsHcnDJC3z/TFa5cr5haA+v8nIKKl9/GiNPtmRbmLpCsVEPziPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820962; c=relaxed/simple;
	bh=cB6DVaTT+s01L6C+876Rd99+8HN+C74X/wlCK0guPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXBRb+D95FENRkiciJqwKu5DWNcEIwSkswxFszpJcOcKShxJ4PhFBMUmRUJfURMr1UKJpoKmPPMmXS6pOIDxQDKA53X/nssNv4cMoeDhPzKgbCX+BBTU2860kX3KDFVP96JdK1LDUXjgBZxrdXoEr9PfVY02aqwN5Taz+2vgH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDyIV9Bq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b429abd429aso1733894a12.1;
        Sun, 10 Aug 2025 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820960; x=1755425760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqyEjaGkOre4w9EHd3uKzVy/NASFwfYu/ST40fxNR2A=;
        b=EDyIV9Bqg5q0jDjUtm1U4v/JrWL9jEqgXemjNPXVqH7P76GxtSYC+eod0+0bXKYFnz
         2kgkxSmd2NmjX+yzAQ5SEZC84Yiy/hT3CjsCMnqnc9lBeOM8/uq/SKd5IIUfEbugeYMW
         eqjS6sUgMktseV8pRGV6SpFb27o2zhzc9/bGFQofxJxnm9jI4fYvO1eW0qP2/IgP6Gp+
         vhjdPqtOI13fu4Q5kk4ov4eDC2C+thadc7bY6iDRgsNKVzHBtHwhrwmlJtgdHRK8hX5a
         ITaceYEbaFekx3DHtpZl8vk6MNO4WJvfxAtiHd4TGOJqOxnQe5cLohG4XCfPtYe1cp5z
         nayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820960; x=1755425760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqyEjaGkOre4w9EHd3uKzVy/NASFwfYu/ST40fxNR2A=;
        b=XJVQUkC6GM/xhWQ5+ws2Z5AuPu9p5ATOnwIfVJu+V3hF61jqLJfZM7Km94x1wFEoLX
         Sa1Zi3y0WyIoWaMXovny+lSvBCJS24rd1bdtZtMhoMJ04JyW6UVPCSH/w8pZUF0P4kE5
         DYe0uljTR11ktFjMBzgkYgIHNyALv5zDm4030LldP6KvtUgsSiXNwAbEtwNfQwXlY2gz
         mstd2h2OnwQPwkE0Zq3y0JGacfYeBuz5Z/aXJXyFVSj5FnltHDdKAdXYXUVv8fbnU4Yl
         yL1fMzEynBuPINEbLjbSDja0ga//SW+McRrr3cK32RYoxMkMoVpygIdChlCitRd/kwt1
         cBXA==
X-Forwarded-Encrypted: i=1; AJvYcCWA75475q2gTQ3o4WYrsN9PMT+Pfpgxud2r64JgUJAnyBY5ix4GoyFHIYwo6grCdjHrqkHLNll8M+De0/Cp@vger.kernel.org, AJvYcCXXcbvEipwgh60ay1w4VMPBQMkY1foqiqnPBojiWWBEKCyxelNiS4jQ6hKiAuLcLcPkB680Ws+cnpuEaZzg@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJnLjErYbZA/zhVFuRNOnsthvD4FDGf6SBmQLlN6up+DNXO8n
	/8I54M4UvomdvIrntZsaoyfj8UJ0binU0t6j7wj6aB+hnBqbKhO9s5Av
X-Gm-Gg: ASbGncuFxvRNqP3/OqtRNuox0QDJ9DUHOfQbunX8+I/K1VUF/n+pmgIBmwzKXr7pXkR
	E2OCbxa1CB/N5Ijrg2573z3IYODNqpSEOfmlenxAs31Yd94mXvlA75l9wGcQIM3HhN/shKZCVv6
	f9oVBFpiUeELD202bhkVlB+qvU4QA+szEiSAXITrhjE4SlhROwU82nGYCLMsaEG6+FrWyTqDB9E
	mt9XvH85fWbUhTcJI5bC6+6vG1a6JHkT4DTOO/l6cs164gXVEi9bTxK9dkqW7DyLU9m9eiL+kPv
	NDKNEejlSyX1SUVgwH1SaqVm0yL6wyxvjhHvKt08pNAZtNace79hL5iGkbTA+jkOuFWoBaE7zCh
	PEyJiw/S1f7pFrepIBvc2so/zK6gYxL6II9g=
X-Google-Smtp-Source: AGHT+IGGAYloXbgajoQ/MCYTDAiP+di0jEwd1KkKWrn28Oe8VknTP82jlNHQBOyggGg3giV0hMQ1ug==
X-Received: by 2002:a17:90b:4c07:b0:31f:10e:2c01 with SMTP id 98e67ed59e1d1-321839e313emr13194991a91.8.1754820959798;
        Sun, 10 Aug 2025 03:15:59 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259329sm11923432a91.17.2025.08.10.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 03:15:59 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Sun, 10 Aug 2025 18:15:51 +0800
Message-ID: <20250810101554.257060-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810101554.257060-1-alexjlzheng@tencent.com>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..934458850ddb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	BUG_ON(*pos & (block_size - 1));
+	BUG_ON(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


