Return-Path: <linux-fsdevel+bounces-13685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC6872FD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3E31F21522
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DA5C90C;
	Wed,  6 Mar 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbN1VIbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B252F6B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710764; cv=none; b=WK9s8xa2FG1o5dnGmERbPHX1WKecJScVUlBudv47nfkmnFJ4ij9oECJPnM+5jvZQLRTWTWham8Vo1wkeS4Hijd23FSau6i+261M4NKKFPSRcLU5A68Ela8sEI6R5Lcs25fNozLTjwLC6cpsxmcUY5VzQEsZc6cfbZmOAs5nOob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710764; c=relaxed/simple;
	bh=3zLyHQYTk50JqHGT0H8b7TxvnP4JF7JAmJRGihoWBck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C2BO+6iF4KqsqBVpLMFXZZN+bTkMjhrrZXVjX+DtTW2cHua101WYbHhmZZXib3clD70OV7yYpnVVMebVth+ZI5bwtpkBh5KMbpK2G4e+n+fubJLKDT2MyXTHotiqaltcT24lHaEMLNJpz+ErqU1bPYeVcRfL4Ev93RQ7muI6UYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbN1VIbx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so23095666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 23:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710761; x=1710315561; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iK81biHTtD/Y+vOFBIjWOtHY+5xsEtWIIh90hV3rhZA=;
        b=lbN1VIbxl5krAWpiIEzlRMVEfDx35YP9OXarEQSQVu3s6YPf6iusYXn5zEeItDhnU7
         VY0C0zYWVS77MxqULXv5rKAE9f+sCes56QabDmub79AYl/ACzgdA0RKWbf/W/4Mw95QC
         qBuKOGBuSc1DLKgZVqvmawHRMrW5ogBwbMoHqa/EYYDSVDCgxMSiEmijzz34hjnqS3uh
         XyNVS+igJH2F80kX8FBY/i/6SGfhA77H1xOKxAm0c5yH/F8znrJZSFIpqGhr0Q3bfy/7
         to/SWXD775ZVnDTpwUu/UNCMVm8dvPq6KFof8ZO0G1YqCtJV1mWj7oOBvRNafOEpBFS3
         WEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710761; x=1710315561;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iK81biHTtD/Y+vOFBIjWOtHY+5xsEtWIIh90hV3rhZA=;
        b=aM/qx9C5Pq6ZJULPTpmvQ3XOJCDGu8HJaAvq3YTOKWtvaZA+n4CBH/iSDVbZMLlETb
         V3EL5CX93MR5oJR/b6jKPRcJUuh1Hc5iIBWJpuBYF6FjSEDKFGXpm/fVvmdfFbTD+d+I
         qfez2yAYUzuAyFozKmZgKJCuWaRKM1Y7K+vu2dPfZi52oFSlJtBUNcRfbtiA9Bf9GAsf
         tc1VHIH5ddCR5pEX/vvd/mfL+Q3IEfgmXhz4mix/mXwyItDQqzQxApQQ2qZNAGaRAlcB
         0PoKYYKjnlJqDp7ubl7FDghC4SIdqlJlMTynXFiLsWWUsIDHwaJzgdDvIjv8eXWUTXIo
         p9/A==
X-Forwarded-Encrypted: i=1; AJvYcCVCcPnH8Loz6/nhH+x0TePINEBgBNY/bE97ZA2KDBtllzYHeLqKpW4vxRHy2WIUH/zlzzidH1bQfQIiaNzYCx6U6FSVLGQejnHubVY0Zw==
X-Gm-Message-State: AOJu0YzOg+IRNDrq97gxPzu2KkdvmaPy4X0Sc1lAs6qqAzok4jSUbV63
	igcpEFGrDFqEQRkQsxA7Awpu4mSwZAmSJxxc5ZWlvhemb9p6e0ziYfnanZxT1Q==
X-Google-Smtp-Source: AGHT+IEAo/YHXhUCVcmg42ky0a9z+nrVmwu+zvZWzJ+uai0a1ygawoh3yDL8xN6bZ+CGtHjLKyyvTg==
X-Received: by 2002:a17:907:11d9:b0:a44:1893:437d with SMTP id va25-20020a17090711d900b00a441893437dmr10155440ejb.7.1709710760964;
        Tue, 05 Mar 2024 23:39:20 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm3833592ejb.14.2024.03.05.23.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:39:20 -0800 (PST)
Date: Wed, 6 Mar 2024 07:39:14 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

G'day All,

The original cover letter providing background context and motivating
factors around the needs for the BPF kfuncs introduced within this
patch series can be found here [0], so please do reference that if
need be.

Notably, one of the main contention points within v1 of this patch
series was that we were effectively leaning on some preexisting
in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
within some of the newly introduced BPF kfuncs. As noted in my
response here [1] though, I struggle to understand the technical
reasoning behind why exposing such in-kernel helpers, specifically
only to BPF LSM program types in the form of BPF kfuncs, is inherently
a terrible idea. So, until someone provides me with a sound technical
explanation as to why this cannot or should not be done, I'll continue
to lean on them. The alternative is to reimplement the necessary
in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO.

Changes since v1:
   * Dropped the probe-read related patches [2, 3], which focused on
     retroactively fixing bpf_d_path() such that it's susceptability
     to memory corruption issues is drastically reduced. Rightfully so
     though, it was deemed that reimplementing a semi-functional
     variant of d_path() that was effectively backed by
     copy_from_kernel_nofault() is suboptimal.

[0] https://lore.kernel.org/bpf/cover.1708377880.git.mattbobrowski@google.com/
[1] https://lore.kernel.org/bpf/ZdX83H7rTEwMYvs2@google.com/
[2] https://lore.kernel.org/bpf/5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com/
[3] https://lore.kernel.org/bpf/18c7b587d43bbc7e80593bf51ea9d3eb99e47bc1.1708377880.git.mattbobrowski@google.com/

Matt Bobrowski (9):
  bpf: rename fs_kfunc_set_ids to lsm_kfunc_set_ids
  bpf: add new acquire/release BPF kfuncs for mm_struct
  bpf/selftests: add selftests for mm_struct acquire/release BPF kfuncs
  bpf: add new acquire/release based BPF kfuncs for exe_file
  bpf/selftests: add selftests for exe_file acquire/release BPF kfuncs
  bpf: add acquire/release based BPF kfuncs for fs_struct's paths
  bpf/selftests: add selftests for root/pwd path based BPF kfuncs
  bpf: add trusted d_path() based BPF kfunc bpf_path_d_path()
  bpf/selftests: adapt selftests test_d_path for BPF kfunc
    bpf_path_d_path()

 kernel/trace/bpf_trace.c                      | 248 +++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/d_path.c |  80 ++++++
 .../selftests/bpf/prog_tests/exe_file_kfunc.c |  49 ++++
 .../selftests/bpf/prog_tests/mm_kfunc.c       |  48 ++++
 .../selftests/bpf/prog_tests/path_kfunc.c     |  48 ++++
 .../selftests/bpf/progs/d_path_common.h       |  35 +++
 .../bpf/progs/d_path_kfunc_failure.c          |  66 +++++
 .../bpf/progs/d_path_kfunc_success.c          |  25 ++
 .../bpf/progs/exe_file_kfunc_common.h         |  23 ++
 .../bpf/progs/exe_file_kfunc_failure.c        | 181 +++++++++++++
 .../bpf/progs/exe_file_kfunc_success.c        |  52 ++++
 .../selftests/bpf/progs/mm_kfunc_common.h     |  19 ++
 .../selftests/bpf/progs/mm_kfunc_failure.c    | 103 ++++++++
 .../selftests/bpf/progs/mm_kfunc_success.c    |  30 +++
 .../selftests/bpf/progs/path_kfunc_common.h   |  20 ++
 .../selftests/bpf/progs/path_kfunc_failure.c  | 114 ++++++++
 .../selftests/bpf/progs/path_kfunc_success.c  |  30 +++
 .../testing/selftests/bpf/progs/test_d_path.c |  20 +-
 .../bpf/progs/test_d_path_check_rdonly_mem.c  |   8 +-
 .../bpf/progs/test_d_path_check_types.c       |   8 +-
 20 files changed, 1160 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_file_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/exe_file_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_kfunc_success.c

-- 
2.44.0.278.ge034bb2e1d-goog

/M

