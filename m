Return-Path: <linux-fsdevel+bounces-64971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7EBF7C2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBD19A7736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6C344D03;
	Tue, 21 Oct 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4ed5KEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0F393DFD
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065112; cv=none; b=q4uh0xVHd3h1bd5KmSrnySK192595AwtWGXQZtOOElTHVa3Y20u54ehlng6ddPnahA7CzUbz/eNvmmQvmNIDiNsXi6ih10+Uh3O4YWMnSFUG5hyyJ2VB713i1tmVOXrKQ0PhLtkTvLggGca44m5KK+IJ8KgBgbQqlsTOzeoQzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065112; c=relaxed/simple;
	bh=hFDpTAYP58lld6xJbLW6TPWHCu+EQbzN6eiEiWotam0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8a53ZpE4Z0RDTR3Ielu5UTyZLC8dmGIsnJAhTGKSG613dDH6fUZ8E9ruSam+fPW6a3IuOxaUSC6Cu60gPhOt+9LoTua3LQBLNC3UIVcUi2D6gnRgTFc7QTwchDp0L/K8T/v0x+oeHQvcQx0e0vyC87rMKNjZO+gjL0FhtXhmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4ed5KEq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782023ca359so5773340b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065108; x=1761669908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoZSQSz1H3s86vZOeAByJWWxtt06IbzM3led2CL2lTI=;
        b=R4ed5KEqVpBC+IjF12ELrUtdtN8bkPzg7hBjmucdQtXMS3P/WCRuVUyjHYRSKjz89m
         5wn5UVYL9kIZO0ZfCHzUSRiAnJscOSupgtzlDx2zVFlFMiwet9YJRBnn4Sf+pu8DuGBu
         wniedXpNjUBR7iqQ5dnkYF8pHZu0hxJXDsnTkyID5l/3QaJubUeOeafgNj5BiQ4xwirI
         RM2nLlOGMtl2BIWNaofUOw67accm6Pnq23aOA4WMDW0+dEkHCn8aPoJyJWljGI2tzN9A
         4eDigKDX2MAknpcp90QgxWMZjGYpBOsVWnVJDQtMT0wdXGVIYLoZ/xsrfYTJidHOfzse
         hA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065108; x=1761669908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoZSQSz1H3s86vZOeAByJWWxtt06IbzM3led2CL2lTI=;
        b=aNSFd6FP8bIv+rmqzbmFZ6n/cd2IJXtju+2zgKyOlBKDH+Ua3QaYhfKOU5YoEKlNYP
         Sm6UGC9frqSZx/YPVbUyY6KtcR6lZNH2iETpTwHjcB2PZQnD5hLFp2LOMEJnmA1LzfYq
         t2WBTRIaUaXkq/3oVV3DLFpT0H2NanMMpZMJHuqI76jZHZdHWWPg8nuz2s0UhP67F3e4
         odzYH7/8F3usLdiw2jFGp8j/8jg9ASYvqwpuIGOlG/s9gA0E7i3H4W8yKEtW1m4/M3Aq
         9QXA8U36ISHnUXz8lIP+puNOuiTNiVQaKTnJEsfYvLzoxWj2xOECoo9ZLfJ4ISP8v9PY
         Hw9g==
X-Forwarded-Encrypted: i=1; AJvYcCWyv4RCYifdKLSqcnAqtBVz5UQIOfgkB+X+ni2ghSQkVzUHakLm+fEAhMf9PQhpQpmzADbfYVAsTajc6rAk@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9mS4vTQVAe7BtKi7aP7B1szuY3+iO+rKEwF6QlwEAC+WGgUT
	L+tSnKZpjMI1jj0Kx6xj0Br1EfvFujLQVledDW8KTjLBpDr593jBgBqA
X-Gm-Gg: ASbGnct7AhbFSjqD6YD4FBxKrwkcGHDBbc1f66dSkz7JR7OImgrCTe0TYxHoTKTKhq0
	YDqCnJflVJHvYYMB7cOdH1PrJLW68+sqx9ZMAxZkhX7u2E9HgyrLrB77coOSw0RlGPLFTExeYSf
	oD8EmMzFm2gogLeAW1UW+q5hJqKrYBl0sQEHzWiqAEC8z1EBzD8xVm1o/KdbK5Vyl0gBQwOzjBD
	rRFRpY/JUCWkjFSloqiUTva9Kcer7bUfdnGd5IofhDgkRAbnjJge2Nl5aBQ2YBfjVGWatmv7Yc0
	Cpu3EBl8vKB/C5/e3OChKqfY2WcST1RnAgKJC3t/MDw04Sl6cgBD0m/AhxGGZIWbkGg+m/pBmI4
	T0RQ/L93L0SFITbbR78+mGAOrWVwRuJgwSD1P5PZ0BUQobyzIDi2gJQHF03xGAsYz10jU+zAsLv
	fOWJSGeBNJb5B28S9zhThLxtmufA==
X-Google-Smtp-Source: AGHT+IG0mGsRpRplzhPHRgeROoxE2shxla56yExU7I8mPlfwpvMaAOuTVZtgjfNSdz5HEC3j5sZ98A==
X-Received: by 2002:a62:ed17:0:b0:7a2:6485:f32f with SMTP id d2e1a72fcca58-7a26485fb6cmr297939b3a.32.1761065108034;
        Tue, 21 Oct 2025 09:45:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff35a59sm11728552b3a.25.2025.10.21.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:45:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/8] iomap: buffered io changes
Date: Tue, 21 Oct 2025 09:43:44 -0700
Message-ID: <20251021164353.3854086-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-1-joannelkoong@gmail.com/
v1 -> v2:
* Incorporate Christoph's feedback (drop non-block-aligned writes patch, fix
  bitmap scanning function comments, use more concise variable name, etc)
* For loff_t patch, fix up .writeback_range() callback for zonefs, gfs2, and
  block 

Joanne Koong (8):
  iomap: account for unaligned end offsets when truncating read range
  docs: document iomap writeback's iomap_finish_folio_write()
    requirement
  iomap: optimize pending async writeback accounting
  iomap: simplify ->read_folio_range() error handling for reads
  iomap: simplify when reads can be skipped for writes
  iomap: use loff_t for file positions and offsets in writeback code
  iomap: use find_next_bit() for dirty bitmap scanning
  iomap: use find_next_bit() for uptodate bitmap scanning

 .../filesystems/iomap/operations.rst          |  10 +-
 block/fops.c                                  |   3 +-
 fs/fuse/file.c                                |  18 +-
 fs/gfs2/bmap.c                                |   3 +-
 fs/iomap/buffered-io.c                        | 229 +++++++++++-------
 fs/iomap/ioend.c                              |   2 -
 fs/xfs/xfs_aops.c                             |   8 +-
 fs/zonefs/file.c                              |   3 +-
 include/linux/iomap.h                         |  15 +-
 9 files changed, 167 insertions(+), 124 deletions(-)

-- 
2.47.3


