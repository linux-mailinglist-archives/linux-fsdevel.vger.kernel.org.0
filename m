Return-Path: <linux-fsdevel+bounces-71712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45FCCE780
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 05:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6866300EFD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 04:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F92848A2;
	Fri, 19 Dec 2025 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhp0VkKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51B221FDA
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766119228; cv=none; b=DHbzbEnwHj0hUL2mA5FONeE+wls96bRoFpVZuaXrwLeJmgn/FehvF0Z0JwT9wEH1L4HkYc0YCWfSCtXLLyforolEUURHj13F495wRXhpVI6bq1IScuoYxsgCMOSw9Wc5cZgSE15DLdpJSbk9P+zh15mszg+316xU1OLPKEEOv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766119228; c=relaxed/simple;
	bh=8u9pDZ2Kt0Xu9tvZ0dKgyiEhx6iHj4yWIq0k99Kapx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjB0wMivxWJZpe3tq6pFQrP7sf31thSYNBS9wxQ/DMaxQZrQbcJvQlogUUsVoJvRXdQp7k6877c9r/KV+S0UFhcT00nVJdDyLyH5ZsfBrvnMgZJbh9ZkeNJeSszuaHgH2HI8M+NrlxK6G18CyoN6JK/xk76y42QnO7JQDVPg1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhp0VkKM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so1145316a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 20:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766119227; x=1766724027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MvSjlvxPTvLZlxzW5nlJgiRQaGZslKwQs9e+mnP29c=;
        b=lhp0VkKM374crliRhGYvpbNfLfG2ILJyR8aGuH/Q9MHpvZpTTowvBLWi3p0bunhn1z
         HDykekIYTSJqu7/3EEIj+H78+BZdds+g1dzMzb93k6sWa8uKkUjgviR23ePQvXBKRfla
         TcWTYHweNS8bn0g+q8eovDTRTiGO596SRXJFVskfH5t0RKQr1PldAKJHkIBJKuPUv5yV
         KOPQjLPg6mQ6b79u7DbPPmsqqMiwEqmzPpndXhU7fDvvwm23fKzxnF8D+LQbPzw4Lfr1
         t21zewmkhISAd86//RVW9ntiZCLLVg39Tj7eCxKHsMrGTwM10s4zv7F+S2Xbl4NRbNC0
         xh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766119227; x=1766724027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MvSjlvxPTvLZlxzW5nlJgiRQaGZslKwQs9e+mnP29c=;
        b=i1T+T5ThUlQUPlMfWVTONTtFAXsmLEc6ToasLyskHOHbM9yJFnbzGNCvoUooD0Fd5v
         dE9LjjJsWcSGem9q+OK65epBSMX2OLXDPb79Uybab+mO6kL8zc9V1x6KyjfEEMkOPmi5
         p6OyINj13hf+fO5f0USQg74WDDXhNY6zFAEZ1ADRvRVA8FKVBsGaKM8jS3lD3jcbyU7R
         sFzJ4pVZEViTSyeggih9sMyvhSjD55a2ggfCzJpjL3mrIYv36SRbGhNzurJ0RCgZBWfx
         kYxUNmGOX4WMPvDchxqch+5jRpVrrbi+1Qbr3TknCoRxj0GhvawbAnVCm39Rwtou85Ls
         9Jyw==
X-Forwarded-Encrypted: i=1; AJvYcCVSunTDihtJBU/ELhBEKZpfdw+pm8QN3N1Bowx473l6CtgykN6gaZfDVNedo5lqFDYD7E0zlKDeDpsKAiej@vger.kernel.org
X-Gm-Message-State: AOJu0YxafmqV/GF9f5tegd+xUznfRFNzZMn6xDVL2IkBsC/UN435qV6Z
	/pi7nSdWU2QDGsWb4177SR5wzr9v3FFgW5m0yTqrLsTmLIVBaXFo6Kf2wos689TA
X-Gm-Gg: AY/fxX73g4iY+0AvKyEmEOhhO0HThdhXv63ozz55Ac+XwcEGSeHVdjZno34UJDvc57H
	dcch6hXzg1mFPl9De4WwDJOohiw57VeIYG8eHxwynyzNHnV5phC2izYhHQ4lnu+8LhmBk8GcYpj
	XzZWZqAjDKoO0DYi31vqUXM/ShF8gTOlisTb5B7vt5fZWJHShMbRobAxU+UdtAun/AhdXo9HfOe
	bSU1v8Rp5DpmXG7pU9CftiCrkQ0ydex00FhK6cfp/CZTsEVk65T5rAlniZ1i54/UJOneTrplUJx
	PAYKJn7RcsUbTSNvKuBbSFBxSzowns2q+QMHi4c63SF58M6qsad6gaB0l8gCwZT506Fabo/jRCQ
	X2mcUi+19hIhByqAYBtPayQoddqlL10NfX9JeGfJ0he7Av0AmUTG43f/tdoOA0U1KI/HQxX4Dqp
	N5S33E0M4m1Ns=
X-Google-Smtp-Source: AGHT+IHbYgonJVHNaYEC3zqBGg9Dfi9S9PcwRNrhR7Czp1czKGBrj0QLhz4l7qjuhFVsfrt0iRLSOQ==
X-Received: by 2002:a17:903:2ac6:b0:29f:5f5:fa91 with SMTP id d9443c01a7336-2a2f242d7e6mr13081255ad.27.1766112388700;
        Thu, 18 Dec 2025 18:46:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d869sm6131245ad.53.2025.12.18.18.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 18:46:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 4DDAE420A9C8; Fri, 19 Dec 2025 09:46:26 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] vfs kernel-doc fixes for 6.19
Date: Fri, 19 Dec 2025 09:46:18 +0700
Message-ID: <20251219024620.22880-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=603; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=8u9pDZ2Kt0Xu9tvZ0dKgyiEhx6iHj4yWIq0k99Kapx8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkuu3/ttY05/OyyRdsJ7d9CliLvXs51v+tpH106v8Dhk 1lj3sxHHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI+kWMDBu+vo5xz5jtyNi/ 7/CRtghPybwXB8+Hui4p3Xmp00/zAlDFq89//f0zmMKEOcwSeBb+Olj8I/FXt2umduJhof0eyyw 4AQ==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are kernel-doc fixes for vfs subsystem targetting 6.19. This small
series is split from much larger kernel-doc fixes series I posted a while
ago [1].

Enjoy!

[1]: https://lore.kernel.org/linux-fsdevel/20251215113903.46555-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  fs: Describe @isnew parameter in ilookup5_nowait()
  VFS: fix __start_dirop() kernel-doc warnings

 fs/inode.c | 3 +++
 fs/namei.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 24835a96f21ebb295d24e265b5466d9e40f12cbd
-- 
An old man doll... just what I always wanted! - Clara


