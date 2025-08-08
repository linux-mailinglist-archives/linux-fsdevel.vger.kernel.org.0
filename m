Return-Path: <linux-fsdevel+bounces-57104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DCB1EC18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F75216E363
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CA7283FC8;
	Fri,  8 Aug 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNOw/ZP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D76283CA7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666935; cv=none; b=oS9Us4y9qADgraVKfzkYQPD1kRhgnFMRnELTzdrYevJf+2NxNO5/+hcyQWMn8ija/1OZwILpFaMC5GOi70RixTwoKW+Ni59Johdojk1HwfeZs/m+0ldNa8Dr0FpwyXtXg4OixHsbCXqx+Fbqmj70nAyU8RZPD5guB4whAVBEFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666935; c=relaxed/simple;
	bh=jfENedvJWAaa9lz9FaLsPj5cXBxGw5o61onXRpt9eos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hgFJEnpRRFxD0ZwXUnukfdACDAFRgIafLCJLfMwjp2HAU8b88q3oSuQyFzLPoB3jv7+U56V9rYibUzwNuwPeKimXfj+LzQZn4JkoKxLk73d7JvzeMnkMzMiyHltlMHgI99gZmJkGuESfIUkYC9rAGQ3VrjGtBHOIYXDBRkj/AzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNOw/ZP2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38ec062983so1804583a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754666933; x=1755271733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZGoPBcCcngLqfzu/WDHEZzT30X9O02KREgicG74Nsi0=;
        b=uNOw/ZP2WzLm88wz+2lwUiIlD/LJhzUZg6varaYCrQZjLa9OAkBehRIrYmtnQS1/Wk
         3fZ+YfWM9r/Mog1xgqxERKja0F+FAh+xNNnKco0LiqWlURMUTQL8Be+dwKP7uQWTvm/L
         xtZffwhZt71VGUfz+lOFsVMW17/iVbrDKJYb7vPdvjzONgBTctFRLH+/ZiFMfYAsQW+f
         Y5ma2bwFDeWvqkk+ZBiUkXAbsfWAFSYQCmt9+z78hQmt2wMPZmwE20W04nG4vFnmniaB
         DkGuZek5nTMxj0k6qkuMLzoeHti9RyapddHB7qzm7r7BRZyotp/T4Ha31xkGR92oRhXQ
         omuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666933; x=1755271733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGoPBcCcngLqfzu/WDHEZzT30X9O02KREgicG74Nsi0=;
        b=bwsih5UsjfBInxqRT1htY+d1qLyN+gHG3ZhnEFvT6OBqLgMVlbqRfCM3mGPy3ZkhVu
         /6xfyoX8BqfNWrKj9DFIJyUPJR1xVgaZxyIuKOTb1H7y0LZ0QGp33mwy5DSQPQunZ5LR
         fdYJqULUmovtd6yyTV367fn97gE719hnwe+P1BV1jutbZnvrGhvw3jErtDvoMQw0zqXF
         F3jcOxxb4+0f77TsyxOHEvTXqBgsdF4prviwCX658rTjdod99LGO+HUuIOgJQDhcwptt
         sSk0vkakOx81XZThF3sHj34Uv0hYs2oFE5xUgfBZqlYN8DCoV6PP6xgDjObWcxNoMI8L
         X/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVd37iooB9W+SHUCDTFdjtbO5x3DKkPMCrF2PscP9AUEC7hYXUsBEaYjay6MV3glYdOBX7n0S2+yhTv9Bnl@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQvtlTw4Zc1A/RWQPQwVvT+yRF7PciU9frApgPF9/+NihrQ9Y
	WnCXbeUoPqzN/ed8PC5DKxVQ/FGM847uKBj9RdHKu1XclXbIo9rQgiCi3gQ+e4j+1iC0UtKpFza
	WzXiyxg==
X-Google-Smtp-Source: AGHT+IELDzzPgMm+39UaZJjm8Tn8NXpoMJEAAaRaanTag6m6o3qi4t1yNnmGCams/nVAxvB7CcmtNDxM1x4=
X-Received: from plbm13.prod.google.com ([2002:a17:902:d18d:b0:234:b2bd:b68f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bd0:b0:240:66ff:b253
 with SMTP id d9443c01a7336-242c222c21bmr56641595ad.46.1754666933115; Fri, 08
 Aug 2025 08:28:53 -0700 (PDT)
Date: Fri,  8 Aug 2025 08:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808152850.2580887-1-surenb@google.com>
Subject: [PATCH v4 0/3]  execute PROCMAP_QUERY ioctl under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With /proc/pid/maps now being read under per-vma lock protection we can
reuse parts of that code to execute PROCMAP_QUERY ioctl also without
taking mmap_lock. The change is designed to reduce mmap_lock contention
and prevent PROCMAP_QUERY ioctl calls from blocking address space updates.

This patchset was split out of the original patchset [1] that introduced
per-vma lock usage for /proc/pid/maps reading. It contains PROCMAP_QUERY
tests, code refactoring patch to simplify the main change and the actual
transition to per-vma lock.

Changes since v3 [2]
- change lock_vma_range()/unlock_vma_range() parameters,
per Lorenzo Stoakes
- minimize priv->lock_ctx dereferences by storing it in a local variable,
per Lorenzo Stoakes
- rename unlock_vma to unlock_ctx_vma, per Lorenzo Stoakes
- factored out reset_lock_ctx(), per Lorenzo Stoakes
- reset lock_ctx->mmap_locked inside query_vma_teardown(),
per Lorenzo Stoakes
- add clarifying comments in query_vma_find_by_addr() and
procfs_procmap_ioctl(), per Lorenzo Stoakes
- refactored error handling code inside query_vma_find_by_addr(),
per Lorenzo Stoakes
- add Acked-by as changes were cosmetic, per SeongJae Park

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250806155905.824388-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 184 ++++++++++++------
 fs/proc/task_nommu.c                          |  14 +-
 tools/testing/selftests/proc/proc-maps-race.c |  65 +++++++
 4 files changed, 210 insertions(+), 68 deletions(-)


base-commit: c2144e09b922d422346a44d72b674bf61dbd84c0
-- 
2.50.1.703.g449372360f-goog


