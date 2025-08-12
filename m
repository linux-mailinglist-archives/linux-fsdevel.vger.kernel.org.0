Return-Path: <linux-fsdevel+bounces-57493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72117B222B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739061885297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F82E92A2;
	Tue, 12 Aug 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGGF1bdP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF42E8DF1;
	Tue, 12 Aug 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990156; cv=none; b=cPQhM7SzUDFBKwT/q3zweC69tgZECS3FoPXEeyC0IZ5Vq8akq/dHrlkL+U/sXQYi9GAR6UdK57LLXX4zwUvuhiHe2IqdfsbI1w5qDs2O2UCMRbvrmbpH/3XhSxd2aLQ3plrWFcN+4Ouy7lgmsMQ6xBsI488414ozGdLFOfcvJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990156; c=relaxed/simple;
	bh=nbmHvENF6wiVd4LFNsW3/Myx/TXvx5lSSh9ejpw6OMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaeniAW3mH8xS2+9I2YvNPK2JwLHuxPZe5VuVntseEXxMdc+SSolQ8H5qWUBoAJR8Vj+DogSQ5W5eTiPPaqm7tWMo6gXO59u2NZdMKT3jY1GiDWWDUadoZ3rt+ZtiGBZpogWIaxa/VwTVNRrwWP9kz062jMJa4R3xx3Guie7G7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGGF1bdP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2405c0c431cso49236845ad.1;
        Tue, 12 Aug 2025 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990154; x=1755594954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=PGGF1bdPOnIvlUxs/qaNXSCDSL+uPzCVLOXezapGuPPX9VLuU4AjYEpElTSA+f1F81
         NI3A6HzHZBbfeYbCXE9+AbM+yi5wER3eGXW15N0WWBge6hpm9Hib4vcJGhUUWvTC+pu3
         EK5efadtaiuYBQeLGXiuefKvbORt6DSHxRhNS3yth2hWzdw8jlIbwiJOlDDzjLUEE/0j
         RDYP3H+DGceZ846/ahugpfXUd9YJxidNQsUl1x7iseCSJv4FKT38YK2w1O/VHlmrg89P
         DlC132f9uPm//IcADJV00zzoMiuinWg68OXyzMloRt1tEyXdl4zmfyeAwqNHQ7NUzTpo
         qE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990154; x=1755594954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP93xN6gwLHr70Ds3prjvKvRcobCNOyB/BNk5HT+4PY=;
        b=tOHjB6DwctL2t7LevjDSC7WhWVBkvKpPrYm0xttoO26uON6Upy8yPIEnEM0AWkq43B
         t11J2xio1Tjyv1TYO4SmgR/nOIMpYPT77eijOgSwZqPjafyOJLh7LbgUB4jUSSOeSww9
         djVNocWgyjVbr4MqvwMVqQNExXbgHUBV28Fgy0+WLOCOOE4ElkoqGPFtErb8uEIaTQQt
         bfqgW9FhyyLrQZox2ZydgY/1vK1bMdoRvWP5iKfBK0MfrOHIMtcB2psEi94oDl8QpGKE
         HlrsU/7Wm1vLXvp7gfOrbNV2LI70jEdCAF5a1y6TnDRP8fkiiw61CqZfsnl3PCEczsKL
         swWw==
X-Forwarded-Encrypted: i=1; AJvYcCXKOz1Ioc95tgpWSGB6xJ8Dwh8enK3W3Sr8ZK0vBOCVRX7V5tSo9U0MLvfvIy280K8fdfQxP7kHaMNTUIKH@vger.kernel.org, AJvYcCXObuh1GiOKlshFlwmenridLwd4m1qo+AZqkkpbA6dQPPBdmdyQTtEnVZscpPzNrRyYe/DPtTa7jyDRyjIG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrfsn7ljYhVZTPDWo5CcjP/za4xg6dNl9SMwv51c1rAUA2jtLu
	pZej8kNcsPUwSO9gKBZZL+e2aGXVcpxCm/Wo5RJqHLGQSdEm2cN3axqJ8OasdncW
X-Gm-Gg: ASbGncuBfT2m6imuwgH7UixJv+RB9m8TCayfj/qzAigswNSpzuwtiURl9Od2Lx9eBAU
	Y7iELdGBEWB+/BtwHzYnwQFu+EAt5YkaqtbliI39ZycSwfJtjrzBjr8BWio/m8gkZb6FGcQGXUe
	QthFLXQYDqAgWKdV/2XL2dHAc9ldRad/6y465mEnSB2ygal9F0ErLDodgDcdpOGamfxIRzDrTnf
	Xm65mQt82+e+wspBg1u+YTV6fzYDTLCodAE8RouzLe10NFiGyS4+XurLtY68hmQA127zFx8LSoz
	5+TwewWZdOcAsGLmeJaNcuX/HNfGEXuqoSCnh5H6kXFOZctPDT1dk0985wmiyJvkWrt0XA4lc3A
	zgP/d3iZ+TlTYxIU/B3GPMKlac36swC40qgY=
X-Google-Smtp-Source: AGHT+IEPQ+MKj6cZsUrHYGttStupeCXS5R6YtXNdkNDqh1mPp1qU+hlOHYrAr4LCph2p99TUoFrk9A==
X-Received: by 2002:a17:903:2342:b0:242:b03f:8b24 with SMTP id d9443c01a7336-242fc1fcfc8mr44592995ad.2.1754990154380;
        Tue, 12 Aug 2025 02:15:54 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm291670665ad.69.2025.08.12.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:15:54 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Tue, 12 Aug 2025 17:15:35 +0800
Message-ID: <20250812091538.2004295-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
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
index fd827398afd2..0c38333933c6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	WARN_ON(*pos & (block_size - 1));
+	WARN_ON(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


