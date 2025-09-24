Return-Path: <linux-fsdevel+bounces-62677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F59B9C882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B3B3AC292
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021A927E1AC;
	Wed, 24 Sep 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI5ip1wo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856517B418
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756285; cv=none; b=OJ+u1MDoPQAk+NdLSKbTAKSfjFo2uLlpDnnFxyp2ymtOV6stP4LzAVxawqnv8WtUd5+d+kkRvLHe9VzqC7rylFocFv2IwEvXIGTyBwG+gJHKWBZhkixcA9NHzAWTHq0ehdt5toql19Bdi2jIRoNF0jzqGi3WrbN10idUEvvoYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756285; c=relaxed/simple;
	bh=FiLnThxMs4BOcdUqPEc8D33b/fb2FF065NKUAnk8CBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWLeqC/ynpsSx867K6GFEkDfa8gEk5/O7Qa+cX+EkHKGroLa8fapirjcGPLELRM57tipAqAokjug7OE5Jf/EHIc0t6nI0CzJ3Wm3HyUHpPvzLVjKGesqTlgDVKXeQBUorSjt6QF//YU457FsQ5sv3c7tEbacX9WWPTnJsdp5SLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI5ip1wo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-855d525cd00so53495685a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756282; x=1759361082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UoLlcTd1hoHH3r6rgciBaUkpzNe4wynZ4hF7JH3a08=;
        b=BI5ip1wop3yQ7v6x9S58SnrjLj//gdqBRopJ9QDOUINxnHqAYQ99zbAHHZWjrEeDQH
         9RQcviiZgckf5IzRhv3XWhXSxOx92+LRbLvR5Q47V7fjHMAkhGYlhKD8P7oWUSk/IBUi
         iZF9j4YjXJAibtNsREl8s4KbrWMMc6aXoKB3bdyKbd2fElKF8GqSsHFEvIfUZ1Es0HG8
         5G+CbVEzACqi1Vp8LDZaPE5p2KKnINdkj7gtbwWIdYK7PFOBbrKr1mNflLv2OJsJEmID
         U9iQsHbfvtDRrOZb878/0RiEobcuWGTSH3ag0aajj378VFidV1k6fK1KHxufi2gBxNpC
         Fu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756282; x=1759361082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UoLlcTd1hoHH3r6rgciBaUkpzNe4wynZ4hF7JH3a08=;
        b=RT5yGFEGNyXJWno+7hg5hKRbYCk8E757ge4yZXoVLRrmdn4MXheyNZ8vf6mSpnZ3sl
         Mw5M35Ngp9PU5IDfHefaUNZErxEqMEZGfIUxISYJqgP0k5OnGbLMI+/osBY4dXOOvrNj
         1CvF3eo2/uAwatRdtFhO4eoO4x/PM4QG/XnUtg01WgvmNor8RhgXLB6aoyFvYcpp2EIS
         WOFLYQirtjvv8zGQHwV2oJXDb9rng+mYYABUAHqSxrMo74V4Bw4Vlc4MnT8jYqmtpQxU
         zbcotsfduWSN9hQqJHPcYX/+mUriIUpt41rrkRZSy6H+4HXeCZ4ssBOsZUqJkC0vWNDG
         KaIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZHeQkN/Ob0gryxS3E3A7HenfPDfnhQ9gQnSpHXsnI9Uza8hiXCCpu0Koweo8dd4Tln5+ERhUXUe1JxE4r@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXmmVlNlbfDhVPY9S630nDu8KAL2PQU6DW9rycPwf29kuQ0Yu
	jEB99ym+aezBxF+j5xoPdzAUpxpoCWjzLiCtAuAEV2O9k1uYSsQnwfFl
X-Gm-Gg: ASbGncst+vbYoOuz+OaL+0hl7B6gxfZVR70JYfmdy3U30XIlhaDkvO3/xbHVGRa5gHt
	TTkjhMslJFU1VM7gb0BNDHPZLCg3j8poq0g8w2iraCbhlVWYH///DrHonpgT9N2XH4eNGCqpXE2
	ruXzCj3y6zfXwsfmzaJB/do4iXrwJcEAQLisDfol/1sWDxo32GIh4XfwNXh12E7sUqEN0rAZW4N
	v1hzZyQFVLpuBDg7TX2GA+06lsFFWGT1BZvd9IT+LMp/I7YxwC/OFPxxNJWA/dvx3j9f/hZ8593
	1qeLKlRoSQjtvqbsXudKCNLRWQUa6c/ejZTawvZaHhrypsrogdqToimZechasGmkW6NtHztIYkq
	p0sH8o4pcR09127BhzRWTvsPN6LMu3PUZfozoxt3AVyZIQUJ1M/dSPwjjfMe9EnthXC0cNpgssL
	6m/UhFzWNu5sf76oVcrbtOTM6Bm0Q=
X-Google-Smtp-Source: AGHT+IEh2WK1CW/L2asuS8yp94SE5XwXCeR7aL8+Sl9V6cpyivYHK6qCXM1mb9eOF3B32UHraCkYFw==
X-Received: by 2002:a05:620a:4010:b0:855:62d3:8d4e with SMTP id af79cd13be357-85ae5c45a5bmr220060885a.20.1758756282462;
        Wed, 24 Sep 2025 16:24:42 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c336ad64bsm14213285a.59.2025.09.24.16.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dwindsor@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Add more dentry kfuncs for BPF LSM programs
Date: Wed, 24 Sep 2025 19:24:32 -0400
Message-ID: <20250924232434.74761-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF LSM programs often need to perform path-based access control and
security monitoring that requires walking filesystem structures. Currently,
BPF programs can access basic file information but lack the ability to
safely navigate dentry relationships or perform reference-counted
operations on filesystem objects.

This series extends the existing collection of filesystem kfuncs by adding
dentry-specific operations that enable BPF LSM programs to:

1. Safely acquire and release dentry references (bpf_dget/bpf_dput)
2. Navigate parent-child relationships (bpf_dget_parent)
3. Find dentry aliases for inodes (bpf_d_find_alias)
4. Access trusted dentry/vfsmount pointers from files
   (bpf_file_dentry/bpf_file_vfsmount)

David Windsor (2):
  bpf: Add dentry kfuncs for BPF LSM programs
  selftests/bpf: Add tests for dentry kfuncs

 fs/bpf_fs_kfuncs.c                            | 104 ++++++++++++++++++
 .../selftests/bpf/prog_tests/dentry_lsm.c     |  48 ++++++++
 .../testing/selftests/bpf/progs/dentry_lsm.c  |  51 +++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dentry_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/dentry_lsm.c

-- 
2.43.0


