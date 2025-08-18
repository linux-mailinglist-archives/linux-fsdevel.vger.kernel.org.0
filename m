Return-Path: <linux-fsdevel+bounces-58194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA6B2AF4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102785E6DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DC34573F;
	Mon, 18 Aug 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haOCffmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601F271453;
	Mon, 18 Aug 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537770; cv=none; b=l7g8VGiAbMB7fi2/+LcVRATw9eFTMI4Ks7R2zpbqLMh/j6VfQgNu9upbBMqrhjgWzNRuVudECbFdMt9b/9wK1f85xnIRmRWXCR36gQC0iqw9+fNSpekEwnIIPtSoJXY8hpu07VDuXmnGUd6+GT0naKdY2vEQi79Cf6hvJ5vj8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537770; c=relaxed/simple;
	bh=uHAOJ797snaDrkcy+tcW05va71LSdkDm6EybUIj4G2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTl+Nm7FAgDNq35HEdIdJH6bGSjX81fyaR3LB6HjFrYl3KijpM3tlDhZMRbf3ewobKcpR53ac9sQV7Qy9gKC/7DQr8RLcQdzVCPgXRY3s3/X3DqiCiFNm1fFf4SoaE7OB+VRo6sNoO6c+77laSWfedg2GYA2JIVubju5Drt+CfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haOCffmM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so890711b3a.0;
        Mon, 18 Aug 2025 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755537768; x=1756142568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUa68E1nteoaGSXTMTcC9sqWgdV9aURqk+eyEEJTUS4=;
        b=haOCffmMyRtG4y82WsXcbRiP3FEgAt9GeBMdY98EzspHVvzFRuV9EfHYhX4TVXAuxN
         ZAjVOFmnCmo3F/yx446irfUclppMH0N9Bi22kkuArR4KMcf383EbtADHsKXZB4J7I2iU
         6GqhWZV/H9Uf1ePQ5DDQ8WE1Iag7DTsFpfJKoVQOX388KEmx31qsNhLcw+MIQTloA5tj
         +X3NhuYA/cJKaLzKJWKtbGMM/raTOoqpsiJ1HrbrGt07Ukug0pridsXYXNhYmqWT/8Tg
         KSAV7AzV9chpzKSHm0neJ8gajI5OosK1cdeqdjdG93gNLNvY4Hobl4vQPuzcyFQZ34Rn
         7fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537768; x=1756142568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUa68E1nteoaGSXTMTcC9sqWgdV9aURqk+eyEEJTUS4=;
        b=czz/kuZFey5XCzEZ3oRQrQ2FoXqBWXGR/T/2aJ39VOyamByGHFaF612GdV7S5cjCZU
         XNufzF10JQkvfHgk9IctRqAUJNJTzJaxfPgMPkGhMepRshDcEUlAIeE32B6taQ9GEteZ
         xwY3Kyn0dk8DXgF3oSKScBjmCcL7y2qriwsq4/8zvPJq1guYUbJx8/u6Oqo3Vh2XoTNN
         M+jTb2iHUiDtXvsEYFNPp+grR5KDapouGa03gBsl/V5GSI5ig7aJlXZZHT0Ca2ZdzC9G
         iqNuuq5xBuA+/MYxrESMJ++wRpON42lfZ3eNMC0V+LQAdM3CWlys+rzPjdeGswb55Ko1
         IzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgCRhTRTIs3EPheNpjzmw4vMHLMWTzQRwFj29GMp1VrcuJcKXilSQxvJevfJY0WuYSdePjqTa2JaSS0uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDwbOjMAUtQr985YCyAYyWdWxcW9F2kPOmEPuR833pviFjTB6
	8nmosHu69JbfTLXWW4VHlmJOW45io3thfH44yIADFbCAVdjQ//pDyhEn
X-Gm-Gg: ASbGncvy6mJDHccvKF311438hLRUKnAp+KmxkCHCyIX8/pT/NlVT2vr10D+rl4hZ6JQ
	MtAdcOJ9RjE2Xrb6/tvKvW7vYd50kde+HtF7EBra6GsdHsCtRAAPgfEi2sWhzedtwnOdF2BOBey
	9WQS0zksjaBt92ESOcSY+n4vzChAi51HicoRa4w8p1yu9FdSYFgQFEBPA5K1tYhNrFRiN4sb4YR
	icNoIrNH/ibtyRPuUSoM0qF056HAIdlrEyBlF5Tqnho7Vnjbgr0zunjpCpJhwKXhd95JB0juUrn
	3VeO0a6tRZM9QNoIxVAc6X3QfjCY4sPn89R2ElovJ+AnXeGb0gbcl2tre/gVNgj1w2UIXC1CrdW
	TWKmhBJ9vUlAyb0+yr0tuAflc
X-Google-Smtp-Source: AGHT+IFpIFoFxxk/K0di9Ho4RhhPZWQ934ntdvj1PbqjitsJusNWV5Esu4Fkoi7xUxfhnpPn0P+4AA==
X-Received: by 2002:a17:902:e550:b0:242:fb7d:1d57 with SMTP id d9443c01a7336-24478f9e7famr120733685ad.42.1755537768429;
        Mon, 18 Aug 2025 10:22:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:2:f21::2a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5769a9sm85242985ad.151.2025.08.18.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:22:48 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ryan Chung <seokwoo.chung130@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fs/namespace.c: fix mountpath handling in do_lock_mount()
Date: Tue, 19 Aug 2025 02:22:35 +0900
Message-ID: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates documentation for do_lock_mount() in fs/namespace.c
to clarify its parameters and return description to fix
warning reported by syzbot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506301911.uysRaP8b-lkp@intel.com/
Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..577fdff9f1a8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2741,6 +2741,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 /**
  * do_lock_mount - lock mount and mountpoint
  * @path:    target path
+ * @pinned: on success, holds a pin guarding the mountpoint
  * @beneath: whether the intention is to mount beneath @path
  *
  * Follow the mount stack on @path until the top mount @mnt is found. If
@@ -2769,8 +2770,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
  * to @mnt->mnt_mp->m_dentry. But if @mnt has been unmounted it will
  * point to @mnt->mnt_root and @mnt->mnt_mp will be NULL.
  *
- * Return: Either the target mountpoint on the top mount or the top
- *         mount's mountpoint.
+ * Return: On success, 0 is returned. On failure, err is returned.
  */
 static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bool beneath)
 {
-- 
2.43.0


