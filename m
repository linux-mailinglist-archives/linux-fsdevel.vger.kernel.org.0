Return-Path: <linux-fsdevel+bounces-56689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640CB1AA4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9B73BAFA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2E23A562;
	Mon,  4 Aug 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diSSailw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0749634
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341846; cv=none; b=PAXrD/Fjc8uL8Jdv9dd0V2p5sz1liHIpepsoa4+Gf4SiMZPIEintTK5z+S22SyPlXHAguisat/6Ftk7E49qFk/w50dhZtSLVc4eWNMfOik9JHKuPuGd+wM/VlUvnEqPoTF0RlSRrjbJQr6KPHDGSFLcTkSQXHmbgj92lvN9GzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341846; c=relaxed/simple;
	bh=/pExkOe15bK6yvkXA1yWSix8S6vCDN0NcnSH1QaaCOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjnuiPbApk9DVzLm3KjQWKEDr5YeAWIQ1iPFxhdpmzyEBIfXbKB4yqOBz7V3EecfpeZAGQgYdemDfpA42YwQKRZ6edCWbd0TWNm8Lpp64MSzEx1cJCKECo6uUo2pLBCe5XkvRlF57ZnGEIukjQ+0Vl0h7PksIC2LtA7/T8uWG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diSSailw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3226307787so2775479a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754341844; x=1754946644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4JFC3nD27BmsrpGkxbwpGIkEQpCa0LYHKn9BqA5a7s=;
        b=diSSailwnHBIFUXw2C52LD1e+u4C8WAao9a76+6MRtN8nFouh8iK6FmjlI3YSpyOo9
         dt+0FTtpoIMt6M2UtlL2/ruI1NVxXyOnSPJiFxznzJBZBKbA7g2Ryy9UQnBkoPVdPDON
         2m/d9sqkepX/t+kGkNEgheunp79OP5zaNJIQnwacZIPZkhcQOfGny17aHntA61KDkU+G
         RcaYc6uVlnMxoNgLuBKuYH8qceEH9qB91vt98mrjTKi/tYe6Ef2hHu2EvUQA8jjIK26F
         i7FvADWElAIlEWgaz1unD9VccCMceNFKPrGH3h4v5B3rwvfYb6UXS8xC3PGZZ7tv9ckm
         UL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754341844; x=1754946644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4JFC3nD27BmsrpGkxbwpGIkEQpCa0LYHKn9BqA5a7s=;
        b=IQR9CrzMH4VT4INd0uCNEYlFgeYkiqLMRfNUeae5tt4eLcpOLxtmRu9i7IpSePI4it
         yDlMbz/ZxTrqjDkhnmtKOG0oaqGDNDZwuEapR/JfpofeMWTYjB5YBMltCxui3S5ot8T1
         +7H+wgfKK4ynJUuDJ9JCzLCxBXmnKkjFmDIzeBkjiEXN4VpThUQCdDwkk+OmEq4f4LNK
         pvoIhh15/NvxZf/HUqvjzO7oo5H3wELYb2E268HvdZ6dRCXPQJDRzAUWQAKM+Kn/tSiP
         QYqhbVUcThjQHyha8x+TZkSlL+12CA1qF4yuOhp21c5LrjVRxDIseovgWfYDjqMIr5Qe
         9kZg==
X-Forwarded-Encrypted: i=1; AJvYcCW89k7cr1oMaxyAfdBsn/1JzAcifNtIwoFrkhewiYomGbyLu6096vq/y1XhD+gzr+xgR/zK3aeQ9eJ5oScl@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXMkLP2Rt4W65xri0Aqb1+dehN1qU4v02eEPQQNIsA/PxSov4
	B6a4qH+CKAz0/o9Lw9qUZdyeAHcEM/BWyZoNx3KzuyZ1XVD8Gwe0He+M
X-Gm-Gg: ASbGncviPeO04xaKHmgINc3pSLAwGwZijcO0wUxK4K7xXRvefFbw7aCUutu6Fkhsml3
	vsp5kVP4IaKTbaQE2WxeDi/kmodGSStwh4VBUVZJJIbLkpEmX/adcCeITPDkpaze6ywPhkMk2/q
	vtS0f+4UgMwuoPR7IiHUUNf23vaZ5vt4DDj8k5UaOH17Vaf1hQvVwJF1oT8bvN8J9ltAa27rLEC
	sQQTGzYVbMviO5OfdtfG0UeYH+1H7VNxYFGwJRQqs70tb9Hm+R7S70Rh80PEQj3vLw42cHy7BR8
	0G6A7Im1aKHovUfICXnKp3pRXTiOgHl4StuSQNMnHv98UrIOa5BxDZTDkOTei6S6tpzSMd+w924
	XTJktTs1111M3jC7S
X-Google-Smtp-Source: AGHT+IHdHAlKGRxPl9vqmiHmBDh8CMdnxrJT57Y5TrN2RFEZwJOiOnBMrAdbgd7hi0AH/zPXkpjW5w==
X-Received: by 2002:a17:90b:1a81:b0:321:4760:c65a with SMTP id 98e67ed59e1d1-3214760c8c6mr3586783a91.27.1754341843890;
        Mon, 04 Aug 2025 14:10:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0b57sm9677455a12.31.2025.08.04.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:10:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 0/2] fuse: disallow dynamic inode blksize changes
Date: Mon,  4 Aug 2025 14:07:41 -0700
Message-ID: <20250804210743.1239373-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fuse now using iomap for writeback handling, inode blocksize changes are
problematic because iomap relies on the inode blocksize value for its internal
bitmap logic.

There are a few options for addressing this, as discussed in [1].
a) add "u8 blkbits" to iomap internals (struct iomap_folio_state) and change
iomap logic to use this static value instead of using inode->i_blkbits
b) remove all folios for the inode from the page cache and synchronize that
with modifying inode->i_blkbits
(unfortunately this does not work, see [1] for more details)
c) disallow the inode blocksize from changing dynamically in fuse

In the discussion in [1], we decided to go with c) given that servers don't
have a good use case for dynamically modifying the blocksize and it doesn't
seem likely that servers use this. If the server wishes to set a constant
blocksize for all inodes, then from patch 2, this can be done at mount time
through the -oblksize= configuration option.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1ZREcrd=FNUYLVWwXUeJ3mJz9J+aqyEvoHkyG3RrJ2QkA@mail.gmail.com/T/#m13c375821fb36c491626a59b552ed0cc5061736a

Joanne Koong (2):
  fuse: disallow dynamic inode blksize changes
  fuse: add blksize configuration at mount for non-fuseblk servers

 fs/fuse/dir.c             |  9 +--------
 fs/fuse/inode.c           | 18 +++++++++---------
 include/uapi/linux/fuse.h |  4 ++--
 3 files changed, 12 insertions(+), 19 deletions(-)

-- 
2.47.3


