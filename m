Return-Path: <linux-fsdevel+bounces-73751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54764D1F8FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995AE302E06C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D530C37B;
	Wed, 14 Jan 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZCkbl+7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7tG72KS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D3238D42
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402431; cv=none; b=BGoQx/Si83z6h5LfqvFTwweyilwAxu6maYPJfWhPTzTgUbJOFvKRIt38hXy1m56YmqRtFUigHG2VCfr/GZmIzN9+hQ44VSXfLvHkjkkbsabTbdIT3hBx+ipSGc0ASYrHPS9ZWpUYRw8RkS/Tjy8X+UUFCmY0UEvI0GD20am96E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402431; c=relaxed/simple;
	bh=wp+PsH0UB1MjwYRfcdp6HdV6Sk9LdvrI3EmO43MUesw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWCYwfC2DtC9vld5XEGHd624vtPKLP7AIQHtMBNoPXVpLUt3E1avamo5STDg98/1BiLy8LMO/sYo2jVij+capVvDTZC/1Lmj0+H+6kPbpwS+Rfb0+0O5g1AK4EGRFfBUppEdATjfc9svhtoQYviw9LMah5Iz2XDVyEvlB9fjlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZCkbl+7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7tG72KS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vs+isBp9RPsPc+5rMsn92hn06p3CWCqMw2jOHDFkIvA=;
	b=CZCkbl+7yGNqlIn8Y8uboQ/nd25AS5oAagWUmXQuzK76OsJYm2ajjwnT2bBeMLE2WQc4Y5
	Iqypx7QkR6l4JDIB6y4dSu+5Lh57c0GrGzNGVsglkqPYBfqDG5LXA8iLxivijASn1ze7HQ
	LW3kSTgADl1NOPQ7YLEnxyYJgV16zxk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-rcw_ka5AMfmCz8hVXCVHfw-1; Wed, 14 Jan 2026 09:53:48 -0500
X-MC-Unique: rcw_ka5AMfmCz8hVXCVHfw-1
X-Mimecast-MFC-AGG-ID: rcw_ka5AMfmCz8hVXCVHfw_1768402427
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64d53a7817eso12013448a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402427; x=1769007227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vs+isBp9RPsPc+5rMsn92hn06p3CWCqMw2jOHDFkIvA=;
        b=f7tG72KSHMrqdL0+xEFXqX3eFKS6fzOvolFCg7jeO7gpGxJ877em1qQmOmarchCWU1
         BV0PT0rpHbmNIit3THTnjiC5rCCvtIJwtAdvrVfo8CbtRSnQVvNolUVpbLzVxXXR10D/
         hqTHn2zqaCt0GtyC+CqwaMmvCSAusiDVeH1j7VR5NCBA9qrvlU8OTWWIPMkShtdQMo49
         nji+VUz1VLUF89F0qQ44IcgTHdA61N4Yrwt5PD5TR5+kSPnpn7CN0Pht2LIB+8psMRo3
         vZByMWA4A5wTq+CmX/+Ro0tN3/ZJ4c37gs1Cyg3STBb/lT9oaxvnwzPnD/FjMdY5z1Yg
         gDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402427; x=1769007227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs+isBp9RPsPc+5rMsn92hn06p3CWCqMw2jOHDFkIvA=;
        b=mQy789LxR8o21PsUxE4ksZnRKL1w2gGqeQ07GNTRTvTYUnIkXoMgQe3LPE55etX/cm
         hxshTsVCVP4LOYpWoSbVxvvS41Tgx9OjbXBDahp/mrQHAhqA/8z3dYEmJb+fsl2A+EFN
         +q7ki5ANLdpdBqQfmPcAceYUId7PqRYkgM2aLRQI3hZOBbzkUb8YmLVG8njYa29Yxkna
         YIN/1YEgjWaclFI03K2iOU9s0MW1l3al8OJel3p4OZYrzhi5VN1rjTP5hBiMsvIhShTF
         aSXE5CovZ0jsiuXQBWmtkgGhOiBcCYxphugVFOeZm19HqqLAQWjOQVa1+7aLbQWa3osi
         H2tg==
X-Gm-Message-State: AOJu0YwW6qr333DewVXNonslhatka3gUNDBCswiOu1eqoi0X65Zc2HYB
	s7qxYhFeNQawcYDQfykJ8hmAamr41UI2w1Po5qHrHOk/jEYGvukssJn0+TvDLiLn9l8ey8zErLp
	6/+N8Ah6Z22C2gpDKu8mREbcNSpH1JugnnUwbYgUxpkbSSNbfkmghPr/PMhBl8LdiYJY1d7YcVO
	96l8I0W0KteYD41Y0VcEgQW2GRbSSvn3sHs9RJOGPh5h4g6NY9aMY=
X-Gm-Gg: AY/fxX6ZzkvF3RIfnoUogGknFq1y46J3Htzh5e8VwIk/XUgnLt2I32/Rwc5cILxdsUx
	cL7vkSZlUR5rHPD2za5tveEr4Zfd0bRJadT4ICmsEvzWxxoU7v3M7MFi/1C/4qA4jGSix5U5Pv6
	3HLUoroEosx4XXvKQsLEZYprF1O3L1uMP2wrFHq4mKN13S/H50BQouNyE67Nl7vKQFimR7NN7pn
	K2jojVP3Mu28YK+P67loouCFA1wHX8OLmwAB9ng0Sarf4QP6g1u2NKx9IBrXlgyNzmg0SK5rOvz
	RPMkGRj/rk0uztzK7BkBeZgaw6AWIxvGiac7UbthsOnXtUeda5+NH0JsdhVvC46d5Y1CW8xGWAX
	ewy3+kDCpccO0o20f31gs7VAAxlm+1GkGJ2+2fT3s5ofxkr8WhUgm7oFOpeNUhuKZ
X-Received: by 2002:a05:6402:1473:b0:640:96fe:c7bb with SMTP id 4fb4d7f45d1cf-653ee2ac9b6mr1961555a12.28.1768402426871;
        Wed, 14 Jan 2026 06:53:46 -0800 (PST)
X-Received: by 2002:a05:6402:1473:b0:640:96fe:c7bb with SMTP id 4fb4d7f45d1cf-653ee2ac9b6mr1961536a12.28.1768402426467;
        Wed, 14 Jan 2026 06:53:46 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:46 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/6] fuse: fixes and cleanups for expired dentry eviction
Date: Wed, 14 Jan 2026 15:53:37 +0100
Message-ID: <20260114145344.468856-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mini series fixes issues with the stale dentry cleanup patches added
in this cycle.  In particular commit ab84ad597386 ("fuse: new work queue to
periodically invalidate expired dentries") allowed a race resulting in UAF.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

Miklos Szeredi (6):
  fuse: fix race when disposing stale dentries
  fuse: make sure dentry is evicted if stale
  fuse: add need_resched() before unlocking bucket
  fuse: clean up fuse_dentry_tree_work()
  fuse: shrink once after all buckets have been scanned
  vfs: document d_dispose_if_unused()

 fs/dcache.c   | 10 ++++++++++
 fs/fuse/dir.c | 29 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.52.0


