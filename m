Return-Path: <linux-fsdevel+bounces-71603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751FCCA2A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 04:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487B2301FF2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCD2F659F;
	Thu, 18 Dec 2025 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaTA2qCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4922A4E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028216; cv=none; b=FMYloDi4huTza4FXlI3qxI0Y+EORe/Gdssa4EsfNH2xdJfhQsQ1llWAU0BlLGAzlXuAAuyirSigEpXSdmX5pCP/YWUz4oKXQmrNpgXazrIE3N2FHfyVXk73ppkYyDANEEUgXYDUiw+O+GKOk0N6GESOo20xNF/gUnLivuz+Iiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028216; c=relaxed/simple;
	bh=hFFblwx86ZqfGEV3nxo2B7GDHQAhuu5OeGAZxPRChv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7wGUFssWV87yS+enflCqeIbHatx1ITu9Uq8AdDe1eUOWThDUF0rjkkmY+o20DcUm2sGEt4z52lXk1SeBiC8YCnPwh0nLOtl7UlQxld9R3RvkUr0Ia8KzcgcT3ZhWNfUGe7D4yVA/fKocZbHZYOIXYwAkyz26SEaDlEYSBo3zxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaTA2qCQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso183267b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 19:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766028214; x=1766633014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UG7pfV58XRZ1xvXhlyO6OK4zqz4Y181lJscZD1whg/U=;
        b=aaTA2qCQPtiF9SLs+dGvKc8W6z3dGHr3OdEJka2EKWKnaf/8Samx3IGpXUbMXqOX49
         pshFajsx5Y4zE/EyOlB503An+7PJb0Wb/cu5DX5Bp0bWs5UcG/JLL2F8TBOGMebN5Fbc
         LsYoeEIP7QYQ8TTJYQ2lrGeAiofIvdJ4gTXS3opoUV6BZyDVcNUTCkkqB8hn7Ti3P6eL
         aGZPcgQw3TbdAIzQBQYHY1yGejpFtLkCZNIc/qvwoxpMNuiSlE1uvqQVDfhetZOAI3RT
         06kEdy8CQuPAUL3/waPxDsoc1LN/H/gfp/rlQzkJCKlBLirlb3enFiICupq+ckiWmtBU
         wYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766028214; x=1766633014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG7pfV58XRZ1xvXhlyO6OK4zqz4Y181lJscZD1whg/U=;
        b=sUz/NwWyV+CQ9cYP8Gp1X/SzsUxcYcu2RaOqR1YTEKgKqJSo7LL/dn45VlQMZIMlt3
         tm8Gje71v4E5mJ2eq9AoivXdIOC3hDgUFd+j+V/BnYraboNn/EoBsNuuX6C4zhBbUZHg
         98Rbl/SpobrabO3/tFJ0L1JFx/KSkR5W/GgetloI77Pcn6rPdVaCdKBeg0b5hDZkWhBa
         ihwS0Rn0Ih7j83B87tyf58vbSY+yn4uSufVq3EXuuEnyW57xnCw8C5MdVxldeNSHWieL
         IuDusUXaDNmuAyaK7Pco2TOsnwj99Pzvt/MyDQgIkWFV54qYegsUD9wfcNY47V7ow4v7
         jqtg==
X-Forwarded-Encrypted: i=1; AJvYcCUCzPQRdEPkIkallgDmCo9WcW7sgnEMR5zvCykrGeB4yIINesv65lUJdhmuQ5H527dIcp+v5X+wkFQa6ycy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+llK6Fy3uOQXf61YsaTYE4g8KzC9WtN2dQVv6VxCzLwXFrUk
	fcWaLnshr0aSi3GXffyBACwJkaYuZCm62ZcI3a3GU5ubqRQFi6ar7z0P
X-Gm-Gg: AY/fxX71urr35Xa4quPHFOaN6296GmHO/jyZ04t4G89LAKJi8K7TpKH4nS5qi/ieNNz
	8Ghd2vR/vY8lVz4yu8fB/yhmhE+SxWVwGzbEsG+BcEMWFEMJs/SCW+L8a0SqwOsJzGoKk4evmth
	YviQ7aDDgFU6q4RtMjpvCEHUwdPnQAAvPUPSP+rAh+F6IZdkXATjMK0Q6NEXUTECdDylfYYdnYA
	znMiw5UCvLoR/v/1Iilmjqy3inqPyHYfRGxWLFN7lVBBDGTobnQCQ8WTYAKuKw9odVOeflzswek
	bJMP4uSBJEN333BYgWRxcIenwh9aGwNV9+8F5vaDLwl89og0Xd0+JAya1CGX3mBV5eywCUl84sG
	21YT8h5K1pldZ2GZEQPLaTs2QwP0R4tUYPMVJPPeIqU18tpk1WsZw/8zi2f8SEreqyxZbY9FT8G
	YGvbM=
X-Google-Smtp-Source: AGHT+IGQvq/DdZI6Fp9wfMB+YHKDour/ZpI/dwBFNByAuJ3jrP5gtK30k5BaErSIpjYma/as4s6gNg==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr18789906b3a.69.1766028214396;
        Wed, 17 Dec 2025 19:23:34 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12125b0fsm884992b3a.20.2025.12.17.19.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:23:33 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	stable@vger.kernel.org,
	syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Subject: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec fail
Date: Thu, 18 Dec 2025 11:23:23 +0800
Message-ID: <20251218032327.199721-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_mm_cid_after_execve() is called from the failure path
of bprm_execve(). At that point exec has not completed successfully,
so updating the mm CID state is incorrect and can trigger a panic,
as reported by syzbot.

Remove the call from the exec failure path.

Cc: stable@vger.kernel.org
Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9d5ebc9d15b0..9044a75d26ab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1773,7 +1773,6 @@ static int bprm_execve(struct linux_binprm *bprm)
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_fatal_sig(SIGSEGV);
 
-	sched_mm_cid_after_execve(current);
 	rseq_force_update();
 	current->in_execve = 0;
 
-- 
2.43.0


