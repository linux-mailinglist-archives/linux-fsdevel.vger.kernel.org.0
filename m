Return-Path: <linux-fsdevel+bounces-56450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030CB178BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C263BED62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22EE2676DF;
	Thu, 31 Jul 2025 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDqPysBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0612550CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999229; cv=none; b=og6sPNTN0czDnEpxFCGC4/dOFCe5xonjS0174JfoJecGxFZUPzpovmqXFV/7K3gC2gcWxm35UCH87/IE8Cx0A4BEozZA6zMlLRiMV1qUJbOZ0ADmH3IeJt9cD3uxyDMsoix83hssU4atOo0HCmnJNeTBTvCsfnlJXKOaJaq7Ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999229; c=relaxed/simple;
	bh=x/5qNHQp3hm0H146d+Dqg3WjLwLMsNAApyRZw+PjJcU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nJSEjLNRpKvybVsucFvoffOIec+JVPjVTpdox+k4sYBkOhM76oygYzABKd77sb9wmKGTDYfWQD21tbI3YHrDUkv9LNYaSu02wYuNbpD1uUKkZLjs2v8qW6wYeAjMkBVnyqdQVr0Mu/cnGHJXxHt40rPXVwr8QhmpARue9Eh3sqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDqPysBy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2420cfdafcaso2377035ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999227; x=1754604027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cCSvQKtWkk35NnkkH+OyPH5z8EOYlo24FiwE70HiXFE=;
        b=mDqPysByUqxBbzoCvBYDb+iKPn5EwtNDU7IoHsFuu98vSFg9SgiXXDILxOJZQczo1S
         Ae++vOyHsX7ly6gqghu0UJiUiBLun4t6RL6sfjHhRqSoPMpDfVDBVxlfmTHuBaSickKM
         K5AFpkrxng2GjM8fB8uH8YgGnLX0GoBFQqRGRGEBEjcj6wKttGgC8qBPiJDOwAZJVrkn
         HAUO0dT505m/58DwEtW0Oy68V+2OvkugXo53W18tzm68f0n8zTtwIhBzQCl+qu819Fjo
         mUuVwS0C5kXaHwrc6JNZqJyQyhxmUljqxNij8R2jtnMvRifsVowIYj187MJjAiO5JMcx
         w2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999227; x=1754604027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCSvQKtWkk35NnkkH+OyPH5z8EOYlo24FiwE70HiXFE=;
        b=H2sHEenqVnDF4PV8XTHxth0JNh747EmzGkAAtu4ri+skdEK6sa+9UC5OoT2DUkO6Yh
         gvEQHi73c/Emt0k9kRSAzjF2LHpxxdPOGfe9QFa2vVBb3Oy+5L4QiObcGe4ZG2xwB2OS
         zSacNPSUnERTeUPF1rS9meAp0cyw+OL0pBhlOaQyYTBZ4KLQmSBtgMz2JgJbBLs3Zhvg
         9FA2lvEqN2qEHXTMYhIZXUw1kGi3OjTYlPa2o4lbNuKvDNV97e8UsTN/0TaLLKhgrv9W
         TitAdz8+V3X2QDO0LPxFdpOEzOvMK64e1wOlLDKMLgXHAfnxJHE0jvRAn1wjKmMdzx1Z
         FY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpSo5nbzl/EcL7MEe5En2v/qQv3jb3qIi4proDWcern8cski25idoBecCwhGUV/Nym7mKVlc4BqJKBUojb@vger.kernel.org
X-Gm-Message-State: AOJu0YyES1Mx+aEcTyqx0Mz5gy9c7NdKe2sKGWgZcjQug9CApy1gSXey
	Mdb0BhuxZTu0Z7qo6nuVfFO3ub4khPKGT36mOROJy8Et7i5Y4qQ02Is1Pj5nFhE5pIYY78DZTPL
	NrARdJA==
X-Google-Smtp-Source: AGHT+IGtegZ8YgQm2ROATdnX6in35bV2Ie8nf5pnKlyAF9NAZgIOc92HgxdoMwUjsjKWnQz4jS6av6uz+y0=
X-Received: from plkl11.prod.google.com ([2002:a17:902:d34b:b0:240:11bf:3c68])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acc:b0:240:3e40:43b0
 with SMTP id d9443c01a7336-24096be1970mr126184995ad.43.1753999227429; Thu, 31
 Jul 2025 15:00:27 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:00:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731220024.702621-1-surenb@google.com>
Subject: [PATCH 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
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

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 149 ++++++++++++------
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 3 files changed, 174 insertions(+), 55 deletions(-)


base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.565.gc32cd1483b-goog


