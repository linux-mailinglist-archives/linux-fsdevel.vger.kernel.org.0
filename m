Return-Path: <linux-fsdevel+bounces-30674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E798D32B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761D82856DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CA1D0413;
	Wed,  2 Oct 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="jAkW0I2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5A1CF7CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871854; cv=none; b=Ms58liTo6QALyP8h9rdaPnYQyDGgM5AcYyQOxDpF7SQESLwh3xVmr0Z3U3QOOM6p3KnNqYorunGT8iYfPuCLorON+2uCDOIaCEPSku2VMCWXddm9vLCKJRPKz0RCioAG+gYq5fmNve11IgyZCZTityaFQv5j7Y+gFiErMJZa8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871854; c=relaxed/simple;
	bh=L9+1a4Nvhl4tzEYVdSqhW0osk5/oToIvRvPo4KJU228=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxiMrDq3K9RTCZGqJgSkIyXR6ZlKD/XeIN7MQAcoeR27/S3k1Gmf7GiuKWl65gvcv9wZndRr51oOUkTJOZp3gMsQZAFTtMSma6mL99AQQdOP42ZzYjIjbBLFdp+tnVcKZndLxhyNg3x1UmkqJbpteQRGzRX5EkktqAz2qJntbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=jAkW0I2x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b90ab6c19so31839025ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1727871852; x=1728476652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSRpGgRiOL4V7C0v24EhN3UDSCpKvNuqNV1m3ZjKLE0=;
        b=jAkW0I2xxb4HrDS825RLiYGeHBgKtNd0oncymsY4hnVBOylwrJhCXA2PGUS4E0LiHk
         7QaDW+FBEcCENayIbTW/bHRtKB2BjFjEJd5dqqySf/LeacdQ+jU/tukgkMnHUyUQXckH
         EH9cOU0iIMQAhE5yLLSPOihc5JdZsO+ZtAmZJFoy7aTg42J8Q4GNjyMQsYjnp9lpwL/A
         xsKqGUziwSr3VpwjiwZLwgmaBG5NNnWux/UoPmSq7iH9KuBwqEQwH6v1hr0rot+9vuDJ
         d3dFOci4Qi6xK5EymVKPGSWApbVR3l1g+N9Q3lPXKSbfGiypUn474apwLy3SBYzDNpL5
         TnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871852; x=1728476652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSRpGgRiOL4V7C0v24EhN3UDSCpKvNuqNV1m3ZjKLE0=;
        b=LoqAu4GSuU0AzEV78Bxr0SHfHUTmVk6mV4QcdUY7nB6Z+j0zPIssahlTD1/vmJPYIC
         BILoOaZD3FLlJeMg2c0gdxrZQFvy3Nr4gtfU5kJFqEWGv7IfRC5xLh5MndEsLRmbRzj5
         Xtzx5iwF2ASbYyalpBimoa/bzA1AGM+0+RAKjGDsFX6VZRFPRJYJi8bm1tgRCulCg+Mo
         NRKk4bb5RDYUFIh8Z+CG82IP80icc5KhTglFJGGdvTuSMkoAbmGpjztHsZ15VoWVD6R3
         +yXcJOSEYmbogwYB9UoTAuiWQBCe9ACHxTFVLCMKyy2pskb36vmQTO7GnrhUIEYAxI0h
         7Exg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZkTaayB5MssRywwZWW+DbZGwUGK8DefvWOUXURIbSZ9DqNsGq7hn8uTuZBG8QFxFdlBlInzh/VzjA+DU@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRjbjLPyqa22s3HVDAYTTerRzOF1vxfHxSzGN9MzN0XZH7Vas
	KjJijth7TGHYdJAocL3SLGp8TYjW9kKqw+1sU7Gs9qXiggE4XxbzPQz4MKB40IA=
X-Google-Smtp-Source: AGHT+IEwQwMtyKjJs5mIPiMJsYOnVLsxcA/9aIPnlYTc9sY8VpaQdegvup3iaqWg5jZXNodocqXfoA==
X-Received: by 2002:a17:902:e88f:b0:20b:c258:2a74 with SMTP id d9443c01a7336-20bc5a3d3cemr40438745ad.29.1727871852063;
        Wed, 02 Oct 2024 05:24:12 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e33852sm83508625ad.199.2024.10.02.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:24:11 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 0/3] Cleanup some writeback codes
Date: Wed,  2 Oct 2024 21:00:01 +0800
Message-Id: <20241002130004.69010-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL and update some comments.

Tang Yizhou (3):
  mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL
  mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
  xfs: Fix comment of xfs_buffered_write_iomap_begin()

 fs/xfs/xfs_iomap.c  |  2 +-
 mm/page-writeback.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.25.1


