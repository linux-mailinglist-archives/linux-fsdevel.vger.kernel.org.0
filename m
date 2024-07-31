Return-Path: <linux-fsdevel+bounces-24675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089C942CEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61236B22A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66F1B0116;
	Wed, 31 Jul 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INt33WfV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9881AE871
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424122; cv=none; b=O3yoiZ49oLa8uZqTYo+uTzDZtuBoLdHf3rbKO/JMV4350HTFMINOIu0y+KZEuwNi15L3kGHBqfwfKsI6W4cq5M42HMpQPECyMjLiAviPoFYkaNVMUNzIhxnR93hqkBEJ/qaCvPtGHEWLCpdHgOoRytzRTTpFXT5XotpHwSuqD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424122; c=relaxed/simple;
	bh=bHcIp/RWXMZulfuXjX1cIB7FcxFbBj96swtDAL2L0FU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s4baDUwiq6/GPnYGmoD3Q1pjcjOFbYel7SYWkDVFG+PamXe0hOXph6tNocGR6KbIxNWo95A+oPXkVDq1Eoe2hyEaeqvNhU1vJoXyreC6xaQWqg9kLuq35lNn3x3GNZOWKcJTgcdtGllYtBn1rcrkrGQwU170ogn8VM71ZrRCQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INt33WfV; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7a8281dba5so441630266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722424119; x=1723028919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfLQlsHgObJ3zjZ94VMUpiBu/ZKf1Bowg3k2SwDzaks=;
        b=INt33WfVmQst2waCqSv5NygRSuh5whyE8ywl1bcVIqmZMF6vTyi1Ui3kmlZ5P7Asms
         /KUv52Pbp5vvnbNyD4CaLYk96Z0Fn45CA+PmCTHnhutt3XCgym5d6WC3Uyen985mzjki
         sk8Z4SkTjCU9t3deKamPTVIYInTIZ0fPXZj4U5AZlSUlB6lyIZUWe0FdIJNQvT5I9Nfr
         AxM7JUKRj9EoezK0vqK9hldH1i63evIhYEQ9c5bJ/BKTySK5W5x9qwi2M/hHRvH69FGv
         rlSTNYZQny04KpEqJk1B+NBYv3VqHS3Flw9h9PiuyCwsf5GCPz/WlICGdf79RPTR+vbG
         mCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424119; x=1723028919;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfLQlsHgObJ3zjZ94VMUpiBu/ZKf1Bowg3k2SwDzaks=;
        b=p8AG8XKaH7adxtAJY59J7eq2MUrVZdQzCkuZ7aXQ0il2OFhdgJ9zJijjGtKyQM8120
         qG9Ozd9eqY0PzfyH+vhkkI12DRP1v6cl6aYmPq6ZpCi9WNj5xyodhujpLIEzUcYaC9KV
         HaeTdfc05aSSQPtnKfPOd2V+vPeKqKkSedNarxMmt/F4fc3w/UfzMosGHwZIKboxq/4G
         PG3ruyK3v58cdwivYrkTrUwM4/mSzKFZqtXfN/xWoy6u0jAwkIN959oTiuj5MbGn1LC/
         3fiJ8fxYuFWbOKDmcmY7OyYRrodOdb62dD1D86D6ihlAsy5dSfBvGvZoqwk4k697hsYo
         G9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8rxJH615WJrJ7dMBC0oJXKgb8o2FpiIzTal/JuHsI31CfSo+hXdpPS2zneW9FTIsXPl+iJwYdYtyPqfTpNLunL9lwNJ7GsarCUU72g==
X-Gm-Message-State: AOJu0Yw1q747eVDA8em8eC/dBfmXh5/s0PVwexAtfhZ3YbCu8JMFu8WL
	707/seCgjMUQvjf6BEsuMaKiZDjjY28DRgzbyBDyrz7keCKc/QSByGkfE6Dk1+tLuMXEo5VO16h
	+bh2cKXqI05EPZiZBZzmrkWceRE1azA==
X-Google-Smtp-Source: AGHT+IEM1M+K8r/qQKjGewx/AmQ6X+wh5vqszxa61hdrMv2xQNIKs/CYfNL8FNbj8LmCKQ64nCQNxa3OReYaSg4vR94i
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:28da:b0:a7a:b423:47b9 with
 SMTP id a640c23a62f3a-a7d400e537dmr1079266b.8.1722424119031; Wed, 31 Jul 2024
 04:08:39 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:08:30 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731110833.1834742-1-mattbobrowski@google.com>
Subject: [PATCH v4 bpf-next 0/3] bpf: introduce new VFS based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

G'day!

A respin based off v3, which can be found here [0]. Original
motivations for introducing this suite of BPF kfuncs can be found here
[1].

The primary difference in this version of the patch series is that the
suite of VFS related BPF kfuncs added can be used from both sleepable
and non-sleepable BPF LSM program types. IOW, the KF_SLEEPABLE
annotation has been removed from all of them.

Changes sinve v3:

* KF_SLEEPABLE annotation has been dropped from all newly introduced
  VFS related BPF kfuncs. This includes bpf_get_task_exe_file(),
  bpf_put_file(), and bpf_path_d_path(). Both negative and positive
  selftests backing these new BPF kfuncs have also been updated
  accordingly.

* buf__sz conditional in bpf_path_d_path() has been updated from
  buf__sz <= 0, to !buf__sz.

* Syntax issues as reported so here [2] have been corrected.

[0] https://lore.kernel.org/bpf/20240726085604.2369469-1-mattbobrowski@google.com/
[1] https://lore.kernel.org/bpf/cover.1708377880.git.mattbobrowski@google.com/#t
[2] https://netdev.bots.linux.dev/static/nipa/874023/13742510/checkpatch/stdout

Matt Bobrowski (3):
  bpf: introduce new VFS based BPF kfuncs
  selftests/bpf: add negative tests for new VFS based BPF kfuncs
  selftests/bpf: add positive tests for new VFS based BPF kfuncs

 fs/Makefile                                   |   1 +
 fs/bpf_fs_kfuncs.c                            | 127 ++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/verifier_vfs_accept.c |  85 +++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 161 ++++++++++++++++++
 6 files changed, 404 insertions(+)
 create mode 100644 fs/bpf_fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

-- 
2.46.0.rc2.264.g509ed76dc8-goog


