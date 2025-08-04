Return-Path: <linux-fsdevel+bounces-56698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73EB1AB4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBFD1899F4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB1C2900BA;
	Mon,  4 Aug 2025 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUOCTCL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815115E97
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754349357; cv=none; b=N/lcnKTjyp0coR97xV4JmCcvtho9qKL9+zKlHoJYM5wTkQaK2i7T0DgvQj1bZeTUBqxEnOjeQmCynSxRk+P5YlBo3EMzvStBeNNICYMMUFNQkBwfwsswoqr5FbtF6sOGLhZGju034LuE29dBKNyW2UzVhMK754PM2raC+b4yLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754349357; c=relaxed/simple;
	bh=aLD/mc6gQzsIeMbR4/fU38vrGMY6ASni5WoEO50oRKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mso4G4lfYsyHd00VEeZf/1mAQxPdK5MBRSKTElbOpe1G9m6E5rWQyva5owVtGzenilR6cqllJ4j1z47n/NrekyEkw9wGdW+u63u7z//idmieUNg3jJNTqETA32UvSLe87owck9rVcC47cjnUPrD7wYiOKe4CytfGlUxcGwX4+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUOCTCL9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so5196332a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754349356; x=1754954156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8NgMA0HX6GfrkP4AehXbgu9Qzh9g7nw7slgx4SS+9M=;
        b=jUOCTCL9cdlB88x2O5dDxoLZTx9JMu2tQcoRTsm+Z85wtpQoH/5W15Q1dbGrso6RhC
         aH970OhJdlNGCY5gJ3uRCL+iWImyAbs9qkzjerMOldzudBwIh26R3zf0O8vUZq1a7qKW
         D82/OwFCHBhBH2mYUXwUBbDok262nsjEyC3p7nx6bfRBf7kTeDVgfCbT38wt8G9xrc/C
         dq16kv7zNdHDm80y7Fnj7GbzPi1ARnFQSV4/GRxlp1FXPqqwjmWKoaEM+Kx8M818/7SJ
         Ob6rjzz+QxEy+i/f3UhGbd2qqxUYco4Lxd6PGIxNej3s3PeWkFK3pg5jp5c5mFYV7Eom
         ZEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754349356; x=1754954156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8NgMA0HX6GfrkP4AehXbgu9Qzh9g7nw7slgx4SS+9M=;
        b=ir/idh/e0Zybg6+F9XWEYsn3U06wOw5/COnmsyD2SmmlWCq/5Cay2Sbo/2CcQc5u72
         OscdGb7qyZx/exdf8UmiyXTgxFJElcSfYpTSgu19k6wtYJRoLtQFnd8KN9ObIQjRgUq/
         TBg/+j+chqZfT+iMru9UgwxWAd+LlDpH9wQZqiC8DD+3ggmqqdb0enZLhvcCgZdXxH+7
         I9CE2DJaU9F45FPS+BD2KLxwvl4NYzBTf6GThq2F0wFSNpNgmGRND21i65mNkwwD7/tl
         DC4qDMPE48kVdhDjMDEV0bmPlV/vhGydIcOq/xDmouV20M6L45qxNxohtXzlJXNcbhW1
         nHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvN23igcf78ySurRkv+RDdlYi9WDffPj0r0YKrNeWZgkM8SEVQybepE1mpXhL4vOb26lD5FNjFKs0oYWqI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiq7+66rx+QrJ9SrP3OOXd2Jyj4vHwdDmF6j+ajJ9vLbPqqfPZ
	o1NFHDeqNY3RwzNL8TnxdZEYneGRCC1hVcSl33SVcJuJjqt/vyMaPOfGygxFL7GDC04iy4IacX0
	EGvtn1A==
X-Google-Smtp-Source: AGHT+IG2q4Q/icGmfZqa/AQL4Y/7ixWiXboOhyChxpBm5zefJHZYEBLAPMKg6t2vVqdvtV/Sahk/uwOkeqs=
X-Received: from pgan189.prod.google.com ([2002:a63:40c6:0:b0:b42:da4:ef4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9994:b0:23f:fd87:424b
 with SMTP id adf61e73a8af0-23ffd874f47mr10654460637.44.1754349355847; Mon, 04
 Aug 2025 16:15:55 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:15:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804231552.1217132-1-surenb@google.com>
Subject: [PATCH v2 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
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

Changes since v1 [2]
- Added Tested-by and Acked-by, per SeongJae Park
- Fixed NOMMU case, per Vlastimil Babka
- Renamed proc_maps_query_data to proc_maps_locking_ctx,
per Vlastimil Babka

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250731220024.702621-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 149 ++++++++++++------
 fs/proc/task_nommu.c                          |  14 +-
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 4 files changed, 181 insertions(+), 62 deletions(-)


base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.565.gc32cd1483b-goog


