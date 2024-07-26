Return-Path: <linux-fsdevel+bounces-24301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E193CFF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B539A282D6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A73176FCF;
	Fri, 26 Jul 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTw7AMAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E236D
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984172; cv=none; b=BN8wgCRja0RarHaArUXEs37vjGe6dwaPALgLFvS8t3ccgU3Scwq97UruqDyu9YhBxdyEB/HvXOwPxqPhL+Xlmh2fSGVCuriVwarH5y6BSpycIRDUiSjHGeA9sfeMXnB2AYIVj0516c0T9yi4VzfxO4M0K1w7jEOnjwPeZkHzSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984172; c=relaxed/simple;
	bh=01rTGrhez7nMcipxCbynimMvPgxooqqono4ewDJXnHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TNyfaZuosgNlYCOyyZwBqecFidGwHtAP7zheXgcNhFZBr+0cvWSAmAbYT6Lq/Sk5um781ikwJUYXui8bhwynJFttCnPB9lGTTZu1pDZ6j4uSGU8YmcpZKBMJ2ctTfFaS9NkswgRtJUYvnXn5rAJg4b5dFpLlNpe+x6pAdNnwNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTw7AMAC; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7abee2b4b0so123103766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984169; x=1722588969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzhEE0I2ZSCZWkX/coFdL22YkdHDYtKnmVSDepdfaTc=;
        b=gTw7AMACEUWwvR2fdt/ky39w1blHGLLsivTQYHP3Zr9dg9s5Hf+n4n4ALryLOHIgDP
         TDmS4lv2qgySNnEUJEG22jnWCInyTyUsWAabB2zYz1EG8LpefPlBW7PgP6RvvGwMpBNZ
         Rov9O4mGELwDXiLNCTjwSFKJEh1nt7qK9JUqFujoSyR54+yEM9HckB8Oxt795FoYx+jL
         Lu2/40TG61ZxeyhxMsNoBPOZrKhp28/AxhQD3rRCUH9Ju8dZC4IGsqQH2Kw7K1s7i1Jy
         Frb7LYUogdLLoKFBG96G6Axq7Zqfx/G7EQ3oFXTTdqpxevwV5BBw5d4DNKekEj5PJhhJ
         uysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984169; x=1722588969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzhEE0I2ZSCZWkX/coFdL22YkdHDYtKnmVSDepdfaTc=;
        b=bsK5YOnqntzXCNcycq58SVbP5qjXGkcFDV9lqghqbS2RwcuhVj3laZCds+nKmSejxs
         3Xw49o5WtvidCd1CA9PI0MOuOEbDck/rSSF+nIaltGNf+lJncl2uSFS70r005YTjuwRu
         zbEfqGdcKzDg1yhDnoStt8YwScQOJTCuEwyTE8lNY7uPqoEyRpVD0LKpz0YlaMmuoWnR
         YNtSMyeZV6IXM44g0tu5KvYEvC9fjvFj85NpRQRjSC77aSKjk0JgmrVGCZcY9hiZQaJv
         u8xU9H/MVs4p8IYayv8nMLHExs1x9+2HhSoGfiZlnAXGDy4UL4OWKe4LudBEJ9DqyEa/
         4xSA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDH/yOH4+qVXIsGlFNgEXVXelFgAzcCzPzyHY621XTQr2yCmkrukXBwvbV+njG4j28HTSYRx1eIl2U4pkQUIMiuHwMreP2IwbOj05Eg==
X-Gm-Message-State: AOJu0YxOG8qy4W6bfJXg1b9gB3h4y8Zph3neG3/rUmZbJo/xVVfegfTp
	crMfgj+v55TlmrpsaylcTZk55ADogDi3nNjqNWJGMztGku62VRvfI2hxGG/8E3zfs8uLUUjQbjr
	hEK2cQvF/2qatCaFTUtp/VFCr/H1A/g==
X-Google-Smtp-Source: AGHT+IFyXMf6dwxh4GF7E1byYlwWvvDvyucdwlRGsB9mphq0pjANaGoft3BJpuyuA7elNNZyHVgViHE+Ysmk2o0VGG34
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:c794:b0:a7a:8c65:641d with
 SMTP id a640c23a62f3a-a7acb3793cemr286766b.1.1721984169485; Fri, 26 Jul 2024
 01:56:09 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-1-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

G'day!

The original cover letter providing background context and motivating
factors around the needs for these new VFS related BPF kfuncs
introduced within this patch series can be found here [0]. Please do
reference that if needed.

The changes contained within this version of the patch series mainly
came at the back of discussions held with Christian at LSFMMBPF
recently. In summary, the primary difference within this patch series
when compared to the last [1] is that I've reduced the number of VFS
related BPF kfuncs being introduced, housed them under fs/, and added
more selftests.

Changes since v2 [1]:

* All new VFS related BPF kfuncs now reside in fs/bpf_fs_kfuncs.c
  rather than kernel/trace/bpf_trace.c. This was something that was
  explicitly requested by Christian after discussing these new VFS
  related BPF kfuncs recently at LSFMMBPF.
  
* Dropped other initially proposed VFS related BPF kfuncs, including
  bpf_get_mm_exe_file(), bpf_get_task_fs_root(),
  bpf_get_task_fs_pwd(), and bpf_put_path().

* bpf_path_d_path() now makes use of __sz argument annotations such
  that the BPF verifier can enforce relevant size checks on the
  supplied buf that ends up being passed to d_path(). Relevant
  selftests have been added to assert __sz checking semantics are
  enforced.

[0] https://lore.kernel.org/bpf/cover.1708377880.git.mattbobrowski@google.com/
[1] https://lore.kernel.org/bpf/cover.1709675979.git.mattbobrowski@google.com/

Matt Bobrowski (3):
  bpf: introduce new VFS based BPF kfuncs
  selftests/bpf: add negative tests for new VFS based BPF kfuncs
  selftests/bpf: add positive tests for new VFS based BPF kfuncs

 fs/Makefile                                   |   1 +
 fs/bpf_fs_kfuncs.c                            | 133 ++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/verifier_vfs_accept.c |  71 +++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 196 ++++++++++++++++++
 6 files changed, 431 insertions(+)
 create mode 100644 fs/bpf_fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

-- 
2.46.0.rc1.232.g9752f9e123-goog


