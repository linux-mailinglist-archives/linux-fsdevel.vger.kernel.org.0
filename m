Return-Path: <linux-fsdevel+bounces-39320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21345A12AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752927A23D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61F1D6DBF;
	Wed, 15 Jan 2025 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijdcS7UF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3E161321;
	Wed, 15 Jan 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965878; cv=none; b=qybYuaGcDe8RdqW+4J3i1Smxce+3u7FnGWDtJl6Q8GegPrZK6S9U6MmD0qaTRZyeSRvDtuBKKbXztS9KlLm0MuFZe5GIA0XqTaiHv7I5XwLBNglpvEkdPvIQm9c1/93qD0ck+TxIYBCg7y5qhk4oYvUCGBNXQYCgFF01WrEI6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965878; c=relaxed/simple;
	bh=p66+xoFqtiaP5WRWiHaD5dq5b0ILcnKOcqP3vpIIUmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVM0CFpEUYWsKHO/SiHgNmQRasoeP9CFVIMc7YpKfZMZNzZPTAYO0XYeYWSytss6AoOrA18r0iWCog2BVw0sqlDuOW8/JCh2rqFf8KwkfXoN4nDrPjXlKo0y5gep8FZPqXvkIBw4pH4elOx0wy6YKu3cT3oWM5heebjZocERUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijdcS7UF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so101705276.3;
        Wed, 15 Jan 2025 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965876; x=1737570676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J95qe0eySXc4QyNapBJVgpR+GaycqECOjClMEXpboYo=;
        b=ijdcS7UFpBTvCZvaixo1yYkyIQyz6DrTsZIvtxsiPJCW7CxAddz8yB32f5HiKC4n1U
         Fpzao3QaR3No4etIjJE89gvP2sN5kIwrvyJkWffNTCgGYtN5T0PMm40kprQgikZnkAxE
         zTkqUNkDNIP7cEtRk29qgXbJ9HGb/QZynm6EpqF4qohdk7hX7OIFWSQlrWVMSlEgBjET
         4B2IFMq9s3Zw8dVDflZqY5ebCM8MIHSxqA5nmDo1UoZezczbVxv9//kA4flwxvF+PGwc
         mBxXD9/QmLlUMLrDtwXuEa8iB6SlZ5QvycGrDDtSpY2AKqS01+ZAkXacNBy8dV+xFA4o
         2TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965876; x=1737570676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J95qe0eySXc4QyNapBJVgpR+GaycqECOjClMEXpboYo=;
        b=qiPhqa1k2Iow+u9f6L69pkeFF1nPzHurJMEjs6a5cSwtl769shgbkQel45N3lLYMzP
         uI2ETQEzNlMiU8pQJeDLHSFkzZshKR1to4+gTsygCtGYiV4bnQjMzwvHLBxrEnU3cfSG
         D8FMmXcqklt3jUuUPEZh4uD4lKI62c+B5HHZ0IqnvV05ZnvmE1kk5kiNYsLwjGM1gW44
         M93yxa9wc4Cv39sMldPHhii6s+HxH1zHOOHitM118/TdAfjRtoePNVQbeFAGxMTi7EEr
         Mp9IXpX4RN8KSKT4N1iLEf8J06535Vm5zN6Msa0qvwl9I44M31ljNcugampNnqs4/KII
         +jqg==
X-Gm-Message-State: AOJu0YxJIWM7LPR4IKthvzJ0y4W8hHLZcFnAye4apNmrNwKRVSIDFkIx
	EvMZ7jLGWg1kyav+nm7ChI7/ZfaobdqVvZIKmhdcZI7wCIc+MDWLZ+VwFQ==
X-Gm-Gg: ASbGnct56CnnKcYiVnUpH3H4Ogf9bXGQ3f45Kf4wvcaZXTAgcjEMGjSIeBkPbYM2B0+
	K1AG0+deTun4PtOOt8dJNPNhIsBZ/mjl9se/R6cz+1wWQsK/f66k8ziqzK2CPZGEV1W85sIspaJ
	P7Ey2lMM5xHcGlNgc/mYaEIIfuK510SN3RhN2yUdI4ZFgNcJkCxPnId+nFfWN252cwWoDvxV595
	dZMV3Yajx0OcV3FquVIQsEGq2uMseex1zwEBIHt5uP5j2YnoyCjkw==
X-Google-Smtp-Source: AGHT+IGzmaNiGh3g7bVji9qbZacNLv/Y7vP/z7cAun5lpLRAAZo+LO3DLHch9JC6brdea/uWqcYGuw==
X-Received: by 2002:a05:690c:610f:b0:6ef:5688:f966 with SMTP id 00721157ae682-6f531311b4bmr259890237b3.37.1736965876229;
        Wed, 15 Jan 2025 10:31:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd7074sm26150697b3.80.2025.01.15.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:31:15 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 0/2] fstests: test reads/writes from hugepages-backed buffers
Date: Wed, 15 Jan 2025 10:31:05 -0800
Message-ID: <20250115183107.3124743-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a recent bug in rc1 [1] that was due to faulty handling for
userspace buffers backed by hugepages.

This patchset adds generic tests for reads/writes from buffers backed by
hugepages.

[1] https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw/

Changelog:
v2: https://lore.kernel.org/linux-fsdevel/20241227193311.1799626-1-joannelkoong@gmail.com/
- Gate -h and MADV_COLLAPSE usage to get it compatible on old systems (Zorro)
- Use calloc instead of malloc/memset (Nirjhar)
- Update exit codes in 1st patch
- Add Brian's reviewed-bys

v1: https://lore.kernel.org/linux-fsdevel/20241218210122.3809198-1-joannelkoong@gmail.com/
- Refactor out buffer initialization (Brian)
- Update commit messages of 1st patch (Brian)
- Use << 10 instead of * 1024 (Nirjhar)
- Replace CONFIG_TRANSPARENT_HUGEPAGE check with checking
  'sys/kernel/mm/transparent_hugepage/' (Darrick)
- Integrate readbdy and writebdy options 
- Update options of generic/759 to include psize/bsize

Joanne Koong (2):
  fsx: support reads/writes from buffers backed by hugepages
  generic: add tests for read/writes from hugepages-backed buffers

 common/rc             |  13 +++++
 ltp/fsx.c             | 119 ++++++++++++++++++++++++++++++++++++++----
 tests/generic/758     |  22 ++++++++
 tests/generic/758.out |   4 ++
 tests/generic/759     |  26 +++++++++
 tests/generic/759.out |   4 ++
 6 files changed, 177 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

-- 
2.47.1


