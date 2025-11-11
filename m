Return-Path: <linux-fsdevel+bounces-67979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB62C4F9DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9EB189CCE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58233329E45;
	Tue, 11 Nov 2025 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huo/j9eI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F2329C61
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889921; cv=none; b=qr8hryveBmzIIdzMvSb6sY+MPLTuSDh3QSP/VmZac8h3ViIf22czVSG9fMVRZRvnPnB3aRzf/h//uzQseVmJoszIwXBgSLmpEzXLnIJGhGurobv18IFxUEim/Z+iR4ROa7Tuo4ZI42/KFyGO59aYD7/rDruPX0Ou5FOqU8OfFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889921; c=relaxed/simple;
	bh=Htryp07lTEmEhqm/7A4OtLieDpZEOxkf9yIMDRmKRrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjKcbrGaK7R9FwPjf7VeEh6kHKUAf6W6SohuXUWgFjl0eQGo7dqTiiS4u1Ukaw8AsBh8lZKhngiwi86YQ/J+uaqw2UYJdbAD3zaa3sCo7es4bwshsE3wSXguBJx6cwctyHPK4Bg7SPr4WGCN4vFprYWubabYcN+Xl3JnonmZp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Huo/j9eI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso57338b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889920; x=1763494720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8dZ//QkmBnAh/Z3dSksU8cUM5lbNTbKVhdPBKsTkeA=;
        b=Huo/j9eI3JTztHQgj0MWYOKmc3HLpKSwMEiIWmwqN+E25OVKNBOgY9BJldu8DnOvl4
         +6JteY0iw+mP/+cVPckRScIiX7Rp0QukFkyI42nWh/2roH8FvfDudZPAgPkeEc3p+WOF
         v+2qQ6Qc92mtHeF7L5iVUEHIxjAYahp5zNcHA9Hs9U+yuF7g2+jUX3bqECrSA9yJ6yzL
         MgZw2VSZPrN3IXEz7raQBN/DIzzOz3lAgxnCyOfdIjdNnoHPjWuXojaIcu/VGWVMXau8
         0I6cWyCEBrSFoasMCVLQRS7plZnypv3taXEpC6sgVnN0HGotRU8iFM9uHbyx3QoDcq/3
         g/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889920; x=1763494720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8dZ//QkmBnAh/Z3dSksU8cUM5lbNTbKVhdPBKsTkeA=;
        b=Ngz3pXgIi5t6K+hG30f0+bpeo6DRMwVjDFXiBpwlVelMYuhQZlHYvJwWD9txv/RD/P
         GKj6c36XlfgI1EutfiYBX5HjNJIeF7hi9NGmAvSH/btav1GJoVmnrzsiXl9wAkOjk6FM
         QLHcnY23/3DqO6PqP/2V7KqFkBfJEL0Kh44TdvRIxmAC1wFgeShLf+Ak5ymx3L1mrPQx
         oadJHmoLugzv3u3iRbuCOXk1C3NuDXs/hndyaAJu7OWHjVXzvbpKu/wD9h9F8CoCvCzg
         Mh6evq92WH8bh6h/HtZf+sJ0m5G2tNk3+kEe869AOQrd/s0T8qKhZOZnG/AJZ+All69j
         xPhA==
X-Forwarded-Encrypted: i=1; AJvYcCWGo2Hu9Q2wB0VvzipeeQ8NivDU1I68LZv+s+2GNt3Gd1DAuhtCBMqxPXoEnHFSvo9ExAxaf4VUPQmbSAR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VXwQDZNg/GwmKTZIAPC5qP1PfGy2/k+ItZX5Ah9cw5OFH78N
	2zPiXEGBKqbJrS38BHW7Yidbun9CWAY6SV1fBRYVUwTFkLoAZ5VJD4Uo
X-Gm-Gg: ASbGnctmwSn7AuxJYJjg18jIgaJrpjBnu65KL9yA4jGOGi5g40MXb9iDgiv4EYW0//e
	8y6gEGJ4cwaos2sOVMD9U0vhlKKvqX1WtsDnoN7wxveoKCQSupe5SDF8uIjWtNddq6irShlwFjw
	0YONV0a6z3CcOGAQ1xe9hlec9yqF2jPqlrZ4AZg9XzcShK+7rnpRr73wOfob2//K1iDqdmJ6QH6
	PplcYlBp+Zk7TYMnIDoIk0k1R7GD3JaIMB2ih2pCOHjR9uuV+shlavbDysW0uwhsAE4kKSw9OiT
	ZgoFsYl/QziiLwCPr03VN6n3DPlEuLeZq2ryD7Smgfad54j7zQsIXCee7hhVXCX7H+y34byuPiR
	HQOIucr8m+LvqvqxBoW01bQP2c8IcmEzepyU8b9d2viyePMfBVrgZHau3Nrg++uKVzi8uPBcqsp
	cphowe9Bho5aCe/QrRomBAE4YGjhI=
X-Google-Smtp-Source: AGHT+IGnvqfKuUAJKZa4XcbYvUk5/FX4fIk1Tjw9EiLPR9x5rlP8UiArfRVdkLg/99H5gcZdZBoZRg==
X-Received: by 2002:a05:6a20:5493:b0:352:213a:a22c with SMTP id adf61e73a8af0-3590b02ac3fmr390157637.32.1762889919610;
        Tue, 11 Nov 2025 11:38:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm380477a12.38.2025.11.11.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 0/9] iomap: buffered io changes
Date: Tue, 11 Nov 2025 11:36:49 -0800
Message-ID: <20251111193658.3495942-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is on top of the vfs-6.19.iomap branch (head commit ca3557a68684)
in Christian's vfs tree.

Thanks,
Joanne

Changelog
---------

v3: https://lore.kernel.org/linux-fsdevel/20251104205119.1600045-1-joannelkoong@gmail.com/
v3 -> v4:
* Add patch 1 for renaming bytes_pending/bytes_accounted
* Fix bug in patch 5 to account for the case where the folio has an ifs but
  iomap_read_init() was never called.
* Add Darrick's Reviewed-bys
* Rebase

v2: https://lore.kernel.org/linux-fsdevel/20251021164353.3854086-1-joannelkoong@gmail.com/
v2 -> v3:
* Fix race when writing back all bytes of a folio (patch 3)
* Rename from bytes_pending to bytes_submitted (patch 3)
* Add more comments about logic (patch 3)
* Change bytes_submitted from unsigned to size_t (patch 3) (Matthew)

v1: https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-1-joannelkoong@gmail.com/
v1 -> v2:
* Incorporate Christoph's feedback (drop non-block-aligned writes patch, fix
  bitmap scanning function comments, use more concise variable name, etc)
* For loff_t patch, fix up .writeback_range() callback for zonefs, gfs2, and
  block 

Joanne Koong (9):
  iomap: rename bytes_pending/bytes_accounted to
    bytes_submitted/bytes_not_submitted
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
 fs/iomap/buffered-io.c                        | 307 +++++++++++-------
 fs/iomap/ioend.c                              |   2 -
 fs/xfs/xfs_aops.c                             |   8 +-
 fs/zonefs/file.c                              |   3 +-
 include/linux/iomap.h                         |  15 +-
 9 files changed, 219 insertions(+), 150 deletions(-)

-- 
2.47.3


