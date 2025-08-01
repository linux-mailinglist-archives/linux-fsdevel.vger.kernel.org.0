Return-Path: <linux-fsdevel+bounces-56485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB2B17A94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC61F5467F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DCA95E;
	Fri,  1 Aug 2025 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc5oZ7oK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720411862
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008058; cv=none; b=Pyv3C4r9TcFuzh8aN6JrRWpF9+Q8B7cWIq63czuxENtEOO0lNhosTpKDocZ+DfNqKGfStSPNcZL4WciMy8UtKZAmavlhd72yhVFCR+r+fDhCHwxFFjlx4Lr4XknTZsT0+aOmMCvnZMNMRPtWVMZhzV94bVaCzk/mxSk/gsyc83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008058; c=relaxed/simple;
	bh=dl6odPQmPR/dCZIZa0ckLUbXvm39AYiANSPWBFTRZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ5HEA25O2scqz9ERexn374PlHFWguyhReo6wpigcQ2/DElS37JLonbqc0+Uwp7jf+xkXdOieZSJkqGqKX3Rf2CJDit7XDNnr53hIw0F5KQbwdjMly4ypdurTRr/X6TZyHcxkw/nr40dIvad4Ad2Wvf8Kk95BeT2d7IKseHq0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc5oZ7oK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23fe2be6061so11877145ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008057; x=1754612857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAPMJh4JRf2T8eUTecykcOIk5D+apWsXjMJdfZ5OmLU=;
        b=mc5oZ7oKDLfFUZKl4kb/SJKmHLtcbpuEu/MMWv1jrffFOZM3ACmhX6LKTokHSXohQv
         EAjaNemaptR/SaPs4AzFy7+xrNF50xGFVx83rYzw5iKxhcSgV5cEU/Xii2rkRoUQN8SS
         dcn1Zn2gjPe9vmaj5BlTZz9gcvJeTkCeBHysloKRIiIb/NEv7DFZymWK/gsJSGQc7YOo
         ZnH21R55M0KEMiugWZmxzyp1IqMS65sIKNNasmJjnwG3Sag3C39zu8eLRtiJ1jla1KD+
         +QmxeVeNHrZXemwL/rl1Cy9cVEKD9VFYNtC8/vCW20m+M5sFDhkzXbT63WPbvtYeAI5h
         7Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008057; x=1754612857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAPMJh4JRf2T8eUTecykcOIk5D+apWsXjMJdfZ5OmLU=;
        b=MxpsFQCzKZSNtc85l39JS1ED5FGOm7qU0Mkl42NSqs+2Imwwck9o5ilExyEU3DP+Md
         XoCqq9q8ia13YBG1hH11FtL+n38XTRO6/CH/BBcscWJ3SQEyn5ydC1wxewjAbXyzR+4n
         t+cRELlZ+XveQJ9lEKvZzKJFD7s9OME5H0AMiLbG0xlIdND/32PuQpx/9h2NjK+LmjcE
         ZaU01dy3M2O12AUFo2lXnu7rCAkzeLzBL/WBX/QU1JGWoybBbz1wK2E9qWKOvr2OL9Gi
         Qkte8CRwSS/bJ3F2VZ9sPbD314u2DaqAtOgPHm3t37aPVRwdZIzuswMzsRGSfwavCcm1
         nrfg==
X-Forwarded-Encrypted: i=1; AJvYcCXFXL9omlm89Zpk4ZT1Uc9LVUG8mJUbsZ8L0q9+6Lxgn6HZVLyE6RUoSO1rbnNwoW1IRMlLy0ROcWAiXv/C@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNLt+JpM5AOjppcXVW3z3zI5+Hal3379dZXw6HmIWleozZzD+
	et8PcU8mTDUH9mi3tmHqUaIYrpgvbGcxeoMALsdg4ugofR5jqx6pecqW
X-Gm-Gg: ASbGncvllBHNJ65YE/W9eLRQc8PUxT+JZl2coXRFPSsVqZ1sLwnO7pGCTqDO3jdWQEh
	EWT9pTrE7M9iWz6nvF/IyfevdOePUf+5+GhAVwoQ+kY8BsGil8rZTYczjL/pjSDlM+QdiQL+ki2
	FN8yTk7coECF6DfHEm1tjosqeYKCwbc4MdIzpA4S7/nG2AdNGiaA9jmeEd/OG+OYvZyfHN9qj17
	uf+JJaXI/Sa1KzZfyvm3QNE/aA2mHHX8FhNLLLwzEwxHI+Ckw3/GMrtrqNjyh99MUKayqcV4AjP
	Evkbo9fz+UQJyitQDH9l9acfKm38f094VS4hs5t6rdiAf3RuREkpaqjjpQ5kiD1IIEqAlxs0ul4
	8h0/mtuNg7wtzdMSNeg==
X-Google-Smtp-Source: AGHT+IHzWNsW+PHX0gfTZBUsIf6NcpFKKaHSrqNk3KKofuw5NyOdzVyboY88paNtVEDHWR8z0e1cxQ==
X-Received: by 2002:a17:902:e543:b0:240:b884:2fa0 with SMTP id d9443c01a7336-24200d9a8a8mr61414635ad.26.1754008056541;
        Thu, 31 Jul 2025 17:27:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67cfsm28592975ad.2.2025.07.31.17.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 00/10] mm/iomap: add granular dirty and writeback accounting
Date: Thu, 31 Jul 2025 17:21:21 -0700
Message-ID: <20250801002131.255068-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is a stab at adding granular dirty and writeback stats
accounting for large folios.

The dirty page balancing logic uses these stats to determine things like
whether the ratelimit has been exceeded, the frequency with which pages need
to be written back, if dirtying should be throttled, etc. Currently for large
folios, if any byte in the folio is dirtied or written back, all the bytes in
the folio are accounted as such.

In particular, there are four places where dirty and writeback stats get
incremented and decremented as pages get dirtied and written back:
a) folio dirtying (filemap_dirty_folio() -> ... -> folio_account_dirtied())
   - increments NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE,
     current->nr_dirtied

b) writing back a mapping (writeback_iter() -> ... ->
folio_clear_dirty_for_io())
   - decrements NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE

c) starting writeback on a folio (folio_start_writeback())
   - increments WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING

d) ending writeback on a folio (folio_end_writeback())
   - decrements WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING

Patches 1 to 9 adds support for the 4 cases above to take in the number of
pages to be accounted, instead of accounting for the entire folio.

Patch 10 adds the iomap changes that uses these new APIs. This relies on the
iomap folio state bitmap to track which pages are dirty (so that we avoid
any double-counting). As such we can only do granular accounting if the
block size >= PAGE_SIZE.

This patchset was run through xfstests using fuse passthrough hp (with an
out-of-tree kernel patch enabling fuse large folios).

This is on top of commit d5212d81 ("Merge patch series "fuse: use iomap..."")
in Christian's vfs iomap tree, and on top of the patchset that removes
BDI_CAP_WRITEBACK_ACCT [1].

Benchmarks using a contrived test program that writes 2 GB in 128 MB chunks to
a fuse mount (with out-of-tree kernel patch that enables fuse large folios) and
then does 50k 50-byte random writes showed roughly a 10% performance improvement 
(0.625 seconds -> 0.547 seconds for the random writes).


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250707234606.2300149-1-joannelkoong@gmail.com/


Joanne Koong (10):
  mm: pass number of pages to __folio_start_writeback()
  mm: pass number of pages to __folio_end_writeback()
  mm: add folio_end_writeback_pages() helper
  mm: pass number of pages dirtied to __folio_mark_dirty()
  mm: add filemap_dirty_folio_pages() helper
  mm: add __folio_clear_dirty_for_io() helper
  mm: add no_stats_accounting bitfield to wbc
  mm: refactor clearing dirty stats into helper function
  mm: add clear_dirty_for_io_stats() helper
  iomap: add granular dirty and writeback accounting

 fs/buffer.c                |   6 +-
 fs/ext4/page-io.c          |   2 +-
 fs/iomap/buffered-io.c     | 136 ++++++++++++++++++++++++++++++++++---
 include/linux/page-flags.h |   6 +-
 include/linux/pagemap.h    |   4 +-
 include/linux/writeback.h  |   6 ++
 mm/filemap.c               |  25 ++++---
 mm/internal.h              |   2 +-
 mm/page-writeback.c        | 127 ++++++++++++++++++++++------------
 9 files changed, 246 insertions(+), 68 deletions(-)

-- 
2.47.3


