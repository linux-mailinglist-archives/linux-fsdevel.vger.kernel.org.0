Return-Path: <linux-fsdevel+bounces-47862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C71AA642F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEDF1B651F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A692288C6;
	Thu,  1 May 2025 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="coR3mkAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361018DB3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128592; cv=none; b=W0TvJUS68C2GN6R+/QjuVc9/jYtY8TyL8jX4QtfafU9cQY0Lzssv3lT0ePnFfj3lOc8mrbtRUrNADHiD+XIU1dK11lf4SrwikaNDO+AMKUxG+TDppGdq7RksxMyhoXX0vTZP3Sy+B79tby1FUZcJVBwATC4ecnpJo8qaeyT/n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128592; c=relaxed/simple;
	bh=2aon5cRP+l1B2JTpKPoPuiku93oRe55ZyVy7IR8uchI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIvsuRvV9xI8TR4KR5EWz2WB0kQqo4JjeuZCfCpxrAa3d2LXMWxsr7wkl4dEGUopNrkw8xiyY+MTI0bj0zykGlNo93fyQshLdxNrMzX+XmBcgNKD9/o4hYj8sduZ+be+i+PmlUx/wRnbJB6KBU2PXqC/agiJ1QNKXx8wdzrkxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=coR3mkAI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2008928b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746128589; x=1746733389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QP6+EvCruX6vsDt1kQkwAU2ri+es0FOsVPQVgd1gBBQ=;
        b=coR3mkAID/oLP3kcoix0ydIF6OhkG9+xmt1EFAlEWWleGTB7xsFZ6PTXlFnEYor6qo
         JJ+WJ19F2TIoml3haczObfen9SCG/zvY43B6m4raNaanTH5cZEbMBw5ZiuGSg9bXxxKm
         su0KLOjCkvzht4Jf2LLn8CAfWJ4KLP1x7EMXgHczAqngLJzk8Jq11HeC7SjRm3pVkt4X
         WqLr1SsBCKMuX4vRB/9x/aH1zmq2xCHyYeY4uexfShv/xxlaWA8RvP3FWrLPv5ydUCzW
         fbkhgxLMF1w+VCW2Zkk2UpfZFfgKz8oqJvqxjLvzygOwvzhj106OIX6gpFpleTi7Obo4
         Ws4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746128589; x=1746733389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QP6+EvCruX6vsDt1kQkwAU2ri+es0FOsVPQVgd1gBBQ=;
        b=FPWGFheBWFTeDyA/mOFqJSTpGUPG9MNUyU8a8lw4zsQBfyXnWEqF20/HE6aGUKTi/F
         j/wGnUB2Wtotr5ifjyfGnYS1DhmkL47UNc6MMgI4ZGG01HKaxnmnJAIQPdgvkWAI2r9p
         prfhQFYFkuJXkgFMIiHHHJve8Xy8p51fw0dQ2z5tSOvIhrYkvGrgrf80a2OO0DBog4Vg
         gBSYJyICoxM3eN+vKesFJcFUg5FR6cVP7zQlOrwvE/CWospEUHqOJAOisaXQ5oNMY94A
         8GMKFrazy40i1OcqQAd3ATcFqyLCS7AGzaCPhcCN+enD10gCmssPqzSihD0pmDkbsK88
         RNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjazx7Z/FxMTof4BNOrMw2LnAqJPLM4JbLhJkpQxK4iPZsPYcfr6Rw+Z3nCnDmEM7JlY5d7f0qDYzqjXq/@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCmRa1MM98Zyc1AVXzZySbH/FmmScSqJZbrOEVecQ73Dvz0S8
	ZL7IKsNJbyAIfavgSiTjj2p/T8jx9HNcF+Fk5WQvQcJeUlkewzeQF8b4WD7si9g=
X-Gm-Gg: ASbGnctHryH1FXTYHe8Retf3uULV0bBw0PaUsmO4Fs7C0dPpr+48igQ0FpIAs8tieOL
	gzaUC8g7ed2tyQQQgnfyEZ78f9KeDT3Td3AY9JOVlZM9PKadcqVK66+Wj8K3MZY07FlKcyvmtw0
	k2wYN8rJ3TDByBjhocgbCQ7q72CS5BqybcDsA1b1qjFJ5SBThvFT7LlOVVX052rtAeGgsgJ3WpX
	vE4WY0icPZHsLoFn8DTjl1xc906PpcrKBmxhh0NllTVcCuwVFqxsW1MeCS5H9EXAq9hFiYhVrh5
	qZ3q3p191YGQvQncD2TEJzS7E8dqSanD952uEYk9MSpxAWsfGLbeORuvQA==
X-Google-Smtp-Source: AGHT+IEW/Lia9WlDQZ0wFSoMPXJ2hOVQ3v13RQyspU7E7JrjsY6BGGMuQkdYDaoFLW1SueBr5DmLXg==
X-Received: by 2002:a05:6a00:448c:b0:736:592e:795f with SMTP id d2e1a72fcca58-74058a20d67mr268114b3a.9.1746128589556;
        Thu, 01 May 2025 12:43:09 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:7a9:d9dd:47b7:3886])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dc45basm50882b3a.69.2025.05.01.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:43:08 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 0/2] ceph: cleanup of hardcoded invalid ID
Date: Thu,  1 May 2025 12:42:46 -0700
Message-ID: <20250501194248.660959-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patchset introduces CEPH_INVALID_CACHE_IDX
instead of hardcoded value. Also, it reworks ceph_readdir()
logic by introducing BUG_ON() for debug case and
introduces WARN_ON() for release case.

Viacheslav Dubeyko (2):
  ceph: introduce CEPH_INVALID_CACHE_IDX
  ceph: exchange BUG_ON on WARN_ON in ceph_readdir()

 fs/ceph/Kconfig | 13 +++++++++++++
 fs/ceph/dir.c   | 33 ++++++++++++++++++++++++---------
 fs/ceph/file.c  |  2 +-
 fs/ceph/super.h |  8 ++++++++
 4 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.48.0


