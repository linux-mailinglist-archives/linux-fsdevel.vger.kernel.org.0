Return-Path: <linux-fsdevel+bounces-63688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F778BCB26E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90D974E8607
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA3286D5D;
	Thu,  9 Oct 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXlOuE0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522E72625
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050658; cv=none; b=K9eVaVfCdR0Dtg8ZDpMvYoIJGKhkQJ2K5UhlvOPr0a0TiD/u/tpInMk3+UyB6/zSZZZAIVJXJPJQb91O074iKiSSKJnqvxA9OmG3h0T+pt0c0gX9+Pvq5t8B1hLH4KljIMwcDXnSJ5jWmLOldw5t5T5bH5N1Skwakt36C4+PUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050658; c=relaxed/simple;
	bh=Rm6UKOyZD1B0hxs26TrDBYbCDDGwsYmL0HSe87oBa58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDGadgZuOXFWSdPbvVx1heab8cBAYE9GFZH7DlYHwU3yI1GbEi5tRYYJUADYSWvn7H/8xU87LdvZKx/3Oec29K6rBAj0+g6obowIFBndO77GQ0zanse/Zqid0/1IhXZV3W6VcpMH4Q037T4S/8hTzTRg5VXkVaPeI2vXzoW6Cqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXlOuE0Z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f1f29a551so2024115b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050657; x=1760655457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65o5Z1x/fVFiBDK8ikLe5TwPRmZaCWScJw2OpTZzS1c=;
        b=AXlOuE0ZiZBl+eFUCjLr6+g8BH8J7/ez6XW/XGKmhzBjEUAMDpSsOXa09Jp1PxqxZr
         lj3Rlm4euLkhbo77mTX0MMB0eEKSSJqodFTzmTSiiDPEAy3WPfUEu5dmvsztt5MKfaWF
         /EXakmpouK4vERxLKJJJQAoMJSQIMQ4z6psBMr/lV1P1Zk7DZpvF2fiCiP/MPRSF1zC0
         WAqmloqHC29UH9b9osnIiTrKPL7x1gW8fJ/hysEzhkQ48QFQkQITrulTVW4+px+w/8QB
         /KFongVzRPMFkV1XkCkCkPFRdqbSwUZ+D6etgcEyU/hjaDrDpCq/Uy4uPjo/OQM8M3Q3
         ylzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050657; x=1760655457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65o5Z1x/fVFiBDK8ikLe5TwPRmZaCWScJw2OpTZzS1c=;
        b=clhAre5HFziPoAZCkVq2UMdgU9qS50ZoTSMZ6L+0R/giGrH13N0ymaZ+yPR8ew8xr8
         lbajhByNn2ZFNrinrVaug2F97XLEMVwLHBvMY5Y+fz3IxWmu4kODuAQ4V8MugZgQRGTf
         QRPhXsEACFnj5cG6Eoy2GI2fCwHNu0AVYNXClECrHS/Q7i9IpnanG3svaGclLf7d35OB
         1/tEgAKOacyVR+TFtMFdUzxmkRcPhww6bGRhOygCqM039KgkRkUx2Z30JqGRa16J4PR7
         juJXH3tG9PQFg0rfAXlCPO4m8MbrR7BuAyrc059emSkBly7p3s2awlpiv92ORezM8jWm
         IJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCW7CgCVO8MpJPRFQ4BLhOn19vbZUrpbTjsKxnqfNkfSKO8XOXsSu4cOgS47loKmDmty2ueaFYyWY3Mgy9bN@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGM4f1W7+odcEki8FizIBsFfWCYr1MDfZamN1lHHnb8oY9iAt
	YW10vmz/9+Pod7p9FgSBosWK0DrLvbJ8Xux4GG67cXAow+BjkNwZhw2ewoBwKw==
X-Gm-Gg: ASbGncv1DnNtMvPM583ImE0qxzV/TbSStAbtSXsrU3z89YcuEHkxfkxECJCKgv7pof/
	BJDYPvjWTixWQAuLPNVv2Ipj7zTnsUY5VGgiIkQ1X91O5UvpRcvCRLo5SPwFkMu7ORjujJVjC9J
	6Y1TzCiulJpHXiqqX2fuOH54nQ9Fk3OgFCqifcih12DSvmXzL9ndfwLSeSspkU7mu9C2xRcQy5+
	EakhboIO36y2iAHvlWqwj5XX78nG5jiLYt4sf96LTl3Y8t9hyH3urwBSTiM172dG3yXG5/IG04/
	Qtn9S7G3Qa1KkywdCvE4FRW0FiDQt/plo3iQUfn5kK3kMZ3oooMgeGfY6Mg0PpNXGwjlMbIhGg/
	SuZgm0FAWHJC86VtgbPqe/efHNftDuGniqXMk9nJaph1718OXiczVpZeRhi59gRDy2JDjZULeEv
	p+N03RdE7I
X-Google-Smtp-Source: AGHT+IFg26yiEl/GYM/lpIwuNcJES0dJnjnpg4NYTTU1hKW+ZDqBFuBQkuUIfo8IvTzeEWNQputlmw==
X-Received: by 2002:a05:6a00:2302:b0:781:2177:1c9b with SMTP id d2e1a72fcca58-7938723c480mr13491121b3a.17.1760050656512;
        Thu, 09 Oct 2025 15:57:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b820asm808888b3a.67.2025.10.09.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 0/9] iomap: buffered io changes
Date: Thu,  9 Oct 2025 15:56:02 -0700
Message-ID: <20251009225611.3744728-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is on top of commit 267652e9d474 ("Merge branch 'vfs-6.18.async'
into vfs.all") and patches [1][2][3] in Christian's vfs.all tree.

Patches 8 and 9 (using find_next_bit() for bitmap scanning) were pulled from
another patchset [4]. Patch 8 includes Darrick's nifty
'for_each_clean_block()' macro suggestion and includes expliciting handling
the "if (start_blk == end_blk)" case in ifs_find_dirty_range() to make it less
confusing, per Brian's feedback.

This series was run through fstests on fuse passthrough_hp as a sanity-check.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250919214250.4144807-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/
[4] https://lore.kernel.org/linux-fsdevel/20250829233942.3607248-1-joannelkoong@gmail.com/


Joanne Koong (9):
  iomap: account for unaligned end offsets when truncating read range
  docs: document iomap writeback's iomap_finish_folio_write()
    requirement
  iomap: optimize pending async writeback accounting
  iomap: simplify ->read_folio_range() error handling for reads
  iomap: simplify when reads can be skipped for writes
  iomap: optimize reads for non-block-aligned writes
  iomap: use loff_t for file positions and offsets in writeback code
  iomap: use find_next_bit() for dirty bitmap scanning
  iomap: use find_next_bit() for uptodate bitmap scanning

 .../filesystems/iomap/operations.rst          |  10 +-
 fs/fuse/file.c                                |  18 +-
 fs/iomap/buffered-io.c                        | 281 ++++++++++++------
 fs/iomap/ioend.c                              |   2 -
 fs/xfs/xfs_aops.c                             |   8 +-
 include/linux/iomap.h                         |  15 +-
 6 files changed, 208 insertions(+), 126 deletions(-)

-- 
2.47.3


