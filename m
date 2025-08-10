Return-Path: <linux-fsdevel+bounces-57224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5237B1F98F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEE41898E21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AFC24633C;
	Sun, 10 Aug 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbIdr4aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57673B663;
	Sun, 10 Aug 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820959; cv=none; b=byFKpX0xgektEG7NZsrQXicxSkhIBlR4C9B1RLD1mAVth/mqYqrAVL4F1zU5tZHo8gE2gTcCaIHculy2RBUjbRNFFC5/2OnDewidYHOuOGxkwXd5I7ZZBYLAhSDtt+aD9aiyEWxmhhnaYqsuH0N8lac3lFXkU82fN+RiPNaKKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820959; c=relaxed/simple;
	bh=9+AOdJ565H9RJbq/+XSIWKdBgMLgcHyOQ9W7Rf0CE7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2+tbwryugkHPQ+EmpIQ9rNFdeSnY4hTA9pg7/TvuIGo/WIyzE76guOGeFlExjoZtWN4QkmtFVBheylleITkg7lReow/bO1oRpk79Td8lIuBcWNo7iftvyfiXhXB9gZ2JTSg3J0O4s3f9/OWsC1dsfVfXT8/htdHFbm8Mf5KAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbIdr4aa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fd3fe0d81so32853445ad.3;
        Sun, 10 Aug 2025 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820957; x=1755425757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz1Yg5vkrZt6kI6nly4GxO0yxN39fm0sZgL6hsPRIGE=;
        b=MbIdr4aabJTUXcYVjYjmP0dCcjSa76ik+xKIlM9uicJ/Lhvuw4gHWUEZixhZypZDoP
         FcCITNHG6qpBHMkC0tMxqtPHNaFwiHaRxdVw+CamQ0QbHvih4jRa8ilXY46vLQpyul+6
         sln4LR/LQkupBMHehnYbRSbqDf/DfbyJ9+QDoBOUcyL7yCLweusbKcHN4ROKnzxnZBz3
         hiQexSF/0GnXE+M8dBh5UGPP46jtvVZeliupZvd7qtcuxgC3AhFknCNc+o0EcTtkQvsg
         3ODAbXYn7xKy6llhzmdZ7zH5wuv0tkycnUJ5EM7Bv1aicUhFPXzb/cqS5YnxOBl1jDQ2
         eMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820957; x=1755425757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz1Yg5vkrZt6kI6nly4GxO0yxN39fm0sZgL6hsPRIGE=;
        b=ZxKhAlJ/01yrFsDptBNhcwknfIAoymKW5r8acaQVYLMLqDke8mULidmi6WtuGeIN9i
         ASKQC6nc72cVdP4/VcRBC2ndXrx9evokTswG+rQrAQt6qt4HtSiS67FsH5/6dpSg67Ev
         6smD9rbjhKoj+ROxLhvgPBOb2hxq0qNX+lygBc6Ioo9jRcg+UZbMTs00lT2hNJqCDFyB
         M8lbbYoZ7IFcYpNkgObLjvN7S+cUF2kVpXhUqCYciwPYqsvclxCHVMcbBGPQoO/nQdh1
         IhvDvvtqMi5KUFW+36pL/a6ujxwftl3E+OoXKhE4+02LChnZC5+YIyMvl2skfxrupp7K
         sSmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1neoyHO6MZHTEnI4rPasHj7jNUJfVPltZaFGFG9/gaU00AavYWvFBg37qeOOwXsgAlr+G+pyu995lFzfQ@vger.kernel.org, AJvYcCWOoBk0SWW0ra0nOJnnCebNyM5NpS6CqNWcd2ivW0ZUaHMb9DXKIKoHhbP3NPpw4CY1i7TeyJ99CHygX/kd@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCSLXqSdvUfXAJ5XHWgbPhee3qhjlhi8KXuH2zK6hx2MKRgii
	tXllJ5Uz271S1j+zTtO3YlXRnItCF+TiV9I0rmdGRxjb9rtZsVYyRKox4eanA/iw
X-Gm-Gg: ASbGnctjK1MW2Q8c5z1vKlrAlZOLaFvyAc6cGkFwYdwRqlzn/fMrOYgNBzVSGX+sJkr
	wD0X8fCNKsw0Ml3bo1qHY0Aqnklflwx9g2pMRFwIT7LcJL74XqToOM85M+X+274Aof8basA554B
	kCbmvlxk0BpFmDQdjxf5uSmcYGEdldZa2dB8WwKSZJqPJGRfXM3dODyoJKWCor25aTLDCdBIZbS
	JP4X0U7jsq6LAN9gao4a06Tbnysy5iX91x0DdRkzQ0u362hxG93+LYnsRr91GwB7ZgN81B7gVWQ
	YvDfTTtmY2ANR2NOfXI0KdXOzQZ7h6IZ+1/8gcCQHl+5Y+8fWvSfaPePytG8RemgYfSK6mvoY8c
	2eEhsNTtPBLqhAxKfLsV5Qeh+urUBkwpbMsw=
X-Google-Smtp-Source: AGHT+IHJ5hjkyPeucXSQhM7+0h7BBFuYI2L5ciJAvQ1XVg8HLMMu2QhFTRkR7XCDqQuMZkCUj54R8Q==
X-Received: by 2002:a17:903:1105:b0:240:4fbf:cd29 with SMTP id d9443c01a7336-242c20aafe4mr133512465ad.18.1754820957477;
        Sun, 10 Aug 2025 03:15:57 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259329sm11923432a91.17.2025.08.10.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 03:15:57 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 0/4] iomap: allow partial folio write with iomap_folio_state
Date: Sun, 10 Aug 2025 18:15:50 +0800
Message-ID: <20250810101554.257060-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

This patchset has been tested by xfstests' generic and xfs group, and
there's no new failed cases compared to the lastest upstream version kernel.

Changelog:

V2: use & instead of % for 64 bit variable on m68k/xtensa, try to make them happy:
       m68k-linux-ld: fs/iomap/buffered-io.o: in function `iomap_adjust_read_range':
    >> buffered-io.c:(.text+0xa8a): undefined reference to `__moddi3'
    >> m68k-linux-ld: buffered-io.c:(.text+0xaa8): undefined reference to `__moddi3'

V1: https://lore.kernel.org/linux-fsdevel/20250810044806.3433783-1-alexjlzheng@tencent.com/

Jinliang Zheng (4):
  iomap: make sure iomap_adjust_read_range() are aligned with block_size
  iomap: move iter revert case out of the unwritten branch
  iomap: make iomap_write_end() return the number of written length again
  iomap: don't abandon the whole thing with iomap_folio_state

 fs/iomap/buffered-io.c | 68 +++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 21 deletions(-)

-- 
2.49.0


