Return-Path: <linux-fsdevel+bounces-56846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77065B1C976
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0217C3AB7BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F0299A87;
	Wed,  6 Aug 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otZTRT4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03C2951DD
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495953; cv=none; b=lFRyjTfwebFDBbwpAzgoi/CuUISbhGNltVEZi68h6ygOT41sEj/ztI89gmE26WvGTFcpbPFEW4Rqsc0AfZFv3x3rjKA8qvZX5SjKmVvE83Pb/BoIysUDNDLznbTLJdF5dw8aYga4pNfJ7RotlUg00OB3hT0prIABkgtni+wHR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495953; c=relaxed/simple;
	bh=jzjRn/EZFD0qAQ+PJvsX6Uv6SB8tn7O65AU/5V7/ImQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=imCi/4AALRbirZkJebCvPRAuMe7rkIkBR/AOc1+rE1yNqUkwXyexCogUZQhC92eEpxaVAkvUf9YjrDKA4VXwrVXKi9KTfN8MRxB2QucOf0BAmvbO0RWR5Nghtop5cYlxc54SuH+paQkqCcG3ZDIOl0kR2UydQyrW//3TkdR7FD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otZTRT4m; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fe28867b7so73427375ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754495948; x=1755100748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zAHdeKYizePAgk53VMIm61MpWp5aV7NGmFxaAW2qcsU=;
        b=otZTRT4mpSiUBkcg3U2OkNkL+5oTnrbWazEZ1grVG6Zx4eMBGz0x+QriBzxdeOX4sO
         lQghchVPU1rAnvrwZGgvNPxNYzKlDhG0oVKTbOXlLdxuqeGTqH80PreGd1QqmGCHjXEf
         5/uf41EYggwk7oJ4paTDsIN0MbaY2U+oWX/G0n1+bJlX5cBuD+c+l0JIf/I407kgGCfu
         MQWBMbLvarQBspoE9MJe1qWEkvWBIDXFEjdqrGwKWd/0w9DnHRA8tMJ2rawQqi8T68qg
         MJdg5TQ+hQKaAuIIqSr6cAIP5vLoNwqEP00NFCU2mJgQGUk0Jgj5kPl6VdiYjibRaFuP
         e2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495948; x=1755100748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAHdeKYizePAgk53VMIm61MpWp5aV7NGmFxaAW2qcsU=;
        b=rQgZF+7ONgSYSMdnyr97bD57+FVMYOnlaeKQ/h0EpdNfS+p9UljFQAYyN+R/X3vQpK
         ScY7At0Viv1v+GP3XrXNU+vJ1C1L5Eo6KXtkvi84LL9DbfVACA7pvLRNomAdZ1DTOslJ
         oi1OmQftVLqTOTLQD+oSov6L4zDfKLieXCg64sSSSdveyWuK+GkdYnv8Cxen6PvnzLZH
         /uNpk8wyJvvCRpasz1xRSP8Nrfx0uxm4eGbNvWIqfpSHa8amqTPCIdALI8S86uuPZ6QE
         8ssPiRxUZ2NuTIYjmRTRlzJbZ7Z8emeKm6O4rcIYd0EVO6juMbmAh5FXreEFyHyi6TwW
         OCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT63e2uVDIxDGJLmPBTC8acjrYg2p+nff2GVMxb4MP34btK2XkBtsXtJW/mjoNp37ZN9rintWDNlFXeh/i@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEV4Rfx237GyKoZcnH77r7oPPYzqgFQ3kiXFR8B5MrAfZ9XtX
	SOrtb5C/rOe02N6/ZYPCqY2NX9qSijhAKE0EBu3ovw4MEyfAGG5bIjuGW/wMGg8I7PWoXTk4/NA
	qyy4q4g==
X-Google-Smtp-Source: AGHT+IEoRLZr8fswQu/g25yORXPM7roxpFOr4Rm1EYCkeCXzeC1BTvV4Tg3ArHbfD7/3gKCei8+KcI8zLGk=
X-Received: from plbkz11.prod.google.com ([2002:a17:902:f9cb:b0:240:3c17:a5de])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:350b:b0:240:5549:7094
 with SMTP id d9443c01a7336-242a0ac2da9mr39592665ad.18.1754495948156; Wed, 06
 Aug 2025 08:59:08 -0700 (PDT)
Date: Wed,  6 Aug 2025 08:59:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806155905.824388-1-surenb@google.com>
Subject: [PATCH v3 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
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

Changes since v2 [2]
- Added Reviewed-by, per Vlastimil Babka
- Fixed query_vma_find_by_addr() to handle lock_ctx->mmap_locked case,
per Vlastimil Babka

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250804231552.1217132-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 152 ++++++++++++------
 fs/proc/task_nommu.c                          |  14 +-
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 4 files changed, 184 insertions(+), 62 deletions(-)


base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
-- 
2.50.1.565.gc32cd1483b-goog


