Return-Path: <linux-fsdevel+bounces-41331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F8A2E00E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58021884A72
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF5F1E2312;
	Sun,  9 Feb 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFF9Q+4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8F1D47C7;
	Sun,  9 Feb 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127337; cv=none; b=iQ5oBBxF8ikDeXOdX3+ES923jmFrHOVuYzt/tc2BkZj4TNoQbb4fk1/HAzlgNeQQvH3Df2oL2aM62GIyaxsIsrYqtRloUi/YG7+5W+Jrd79KT9QLpsysKBGqvLshRD8LDDtmlE0CP+eX1a1qXpPOch9BfMrrlgJIS58Mfg/6RG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127337; c=relaxed/simple;
	bh=SKfs/wAhs+mKEWUJZVn4JFPLruoQjTvv67ryjPdOJWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJ1s8xSXiZYfEcNE2e+UZlsP9v4mz28Ci6740cw3+4+vhyZRiRWNo4j6ke/+QJasUDZevg30pKUwuqDUpszYNMCKbV9FWR1IuEI8lapH7r+zMYiBEUhQECAVNgIqDgpdrIf5Sv7TZZctYgt2/KUD5PFfHc0A0olRga4MJ+OtWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFF9Q+4V; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so584723666b.1;
        Sun, 09 Feb 2025 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739127334; x=1739732134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHmj2+Im1CcXlK77nnFWhdrR6nUCYh5cEj6EwVR8Zmg=;
        b=HFF9Q+4Vyw8VqSh/1iLJe8nSWZjkaYx1WNfQ0y8FOcuZFwqq5muur4slPt/sAkqZ+S
         tpDjdvhmU313ScZGuyPexwV7PMXTV9+1vYNP2T4H4tCFlGpAbsbJzBtQI3aYqX9iOO7M
         cSF1xo6r1GG7XvBjTx4Cso+2lxsTIM6+UO1ZxHs+2LL2GoGb0Tfc5w1Yy76rt6skq92Y
         3OIrfD/NatTkmBwMG/3UACLYefGdutlrqRGrb1iJUW1g9rs7c8x7jxiyk0FlIeBWEqiR
         GQiXJxQ02K6JKD+83y7xWnenn+MX0EY8e794CiUmbHQAbkwzsgpm9HUiTJNj5KZI/N7N
         U8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127334; x=1739732134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHmj2+Im1CcXlK77nnFWhdrR6nUCYh5cEj6EwVR8Zmg=;
        b=jUDCBNUi3SS9ZgznM+jjqRy6d7I7RIPbH6X1y8XYZqfIcrl4JQ2jG1QFDyKzo6asaZ
         jnb6zgyOupOOBDft0vi/TlRgoakovT/oZcVc9Wl+LTGbkBu0C1S8JXcNNCB8ExsgizpJ
         LRK8W9P3kkfTlEqiRo5EHHvPqwEfZHlImD5WPKow2nnetp5FGDftZ8eN0bIaqqklZV2i
         MRgAln5XYllCOf4UnSR7e4Ab2U6+rO+7KVoMszam4rxhuCfIvffIcYhRzQ6vfFbpJMnU
         TXjwWZxkvvh7h/E3/j4qacO2QpXmZM6yCsVmMcRBTibeBUkFTGH58L8D2J7ib5i0VxA4
         E7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUeb2hsgnsC2LwGSTuUOjN37Myv/vTryOxrlgjRcL4qXkwr2ytehGQw4aZNFAXQwke9jKcJl/D/Zdv16xx/@vger.kernel.org, AJvYcCWjkM+Bhf4EudijlTgoI47efZOIy/sWGZShsqpgZEDZbRT2PEuq3b7wbd935WwPX/eXAMzvgAl4nW1o0YU0@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRuDm+f/VrEq4lSzJR202J6VwwjQAnoMfZujFSXYQIY30Fr77
	dHydKkqN+/BwA7IExZbxSra8nSF0NQpTb5eaC01ehGsyDT0lAFfyNsdaVQ==
X-Gm-Gg: ASbGncuHtpDeuEIJmC3kPVFUVVaT6VCRIcPHaIcbQQBulXY4JWf+P3XgEqa3M7MhcWU
	emtRv3kCL3WwJWNgaEpf1/4VvSFkuLrgMwPs1CP7bW4uxK/OJYdter8l7wFV6uGYpYfmonpfxdQ
	XZDR0iSe/64eX44BYkPdMX4iCAZHM1NlzV+1k1f8WULJxkJ1LkTlsAGmCYE4ejupWkyBs0F+6Qh
	4AAIcmpmXigbkotlMlrp1exL3acEYLw9h6MPFyn5I1D11mfszTXxeyCYwqm1TNITDcctISABKZH
	iGjT1RZDSkc9cI90kbci0niUv6SmoS+G4w==
X-Google-Smtp-Source: AGHT+IGGGMNEsCrKiVhPtWnbJ7/k5DLTxD4z5azU/k/eJeHUjpeq2p5u9UxUWy69/8JHiUICCf6KDA==
X-Received: by 2002:a17:907:d8a:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-ab7897dfdebmr1030036366b.0.1739127333919;
        Sun, 09 Feb 2025 10:55:33 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a82dba37sm318478566b.165.2025.02.09.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:55:32 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 0/3] CONFIG_DEBUG_VFS at last
Date: Sun,  9 Feb 2025 19:55:19 +0100
Message-ID: <20250209185523.745956-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a super basic version just to get the mechanism going, along
with sample usage.

The macro set is incomplete (e.g., lack of locking macros) and
dump_inode routine fails to dump any state yet, to be implemented(tm).

I think despite the primitive state this is complete enough to start
sprinkling asserts as necessary.

v4:
- export dump_inode, fixes building ext4 as a module

v3:
- move dump_inode to fs/inode.c
- s/failed/encountered/
- pr_warn instead of pr_crit, matches dump_mapping

v2:
- correct may_open
- fixed up condition reporting:
before:
VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) ==
sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
*)8))), __builtin_strlen(link), __fortify_strlen(link)) != linklen)
failed for inode ff32f7c350c8aec8
after:
VFS_WARN_ON_INODE(strlen(link) != linklen) failed for inode ff2b81ddca13f338

Mateusz Guzik (3):
  vfs: add initial support for CONFIG_DEBUG_VFS
  vfs: catch invalid modes in may_open()
  vfs: use the new debug macros in inode_set_cached_link()

 fs/inode.c               | 15 ++++++++++++++
 fs/namei.c               |  2 ++
 include/linux/fs.h       | 16 +++-----------
 include/linux/vfsdebug.h | 45 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 5 files changed, 74 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

-- 
2.43.0


