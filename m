Return-Path: <linux-fsdevel+bounces-20718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A658D7314
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E4D1F2165E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C46FCC;
	Sun,  2 Jun 2024 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1vggi3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539B3207;
	Sun,  2 Jun 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295893; cv=none; b=Na5a8Vq5EwtqhBJypvV1NQaspCtJLJRjQDa2DvXTxE1GV6fxr3mzjvqfZ8dQmnP3xCSuPoAQztsdyyNpUbfmVQUTLo+EGZWc/ytkbg3tY5Y/yXmYLdaDg6BD28EtmDql5Cg64meiwLia89XC4NMhfd9CO7IorIMf8M9lsxGIfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295893; c=relaxed/simple;
	bh=BEvwO8ns12UnOClFh9ECeKgBnQu5E6KcClV2OXro1mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pcZ6jkfrfnly8Uzw3pxhuSpTjw3evADZmYBo846QWfNFuMYCqQCFaEimVgz3xBeRGz45tL8RhcSzx973h1JWyNJeahKpjCKHDiua+ByfpxjuNaMSIVcOywpxZaZquOlhsyeDacpf7AwUxh1u8dxpANmEe+t7YrC2KMU2ix7P8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1vggi3U; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-681ad081695so2304546a12.3;
        Sat, 01 Jun 2024 19:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295891; x=1717900691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5jw3U32WVQ2mu7sEVPOQe4LCfxoKjEQKNWxX7qFcmg=;
        b=g1vggi3UCHP5mOpiDKjlM+nToPv54f/ZfS4mNKMIoz/5BISLSP6Vnku/ihWx+jrSku
         q/0r95CJ+l29QhuBtzsQ3z4/el6/ggYt2ongLLr08Yz5jFt8OHxjppOQJmhJWP5pSa6M
         WZCWMHBdpZoAmvpqTGYBKYtUc9LZwtfQmKso8FsryoSslwkzLCuxhM2KM5sX49kOxcj6
         9VQmR1FJQvBSuBhWQAxp7/mkntQrsY1v/zxWHMM+5MpVSnkVpgbBIXmIzcjawJKZMqLq
         AGa69Qk8KlT8OzCTFXpj3mzebBb6OI8w4mQ1FWkuLmykwNJVd+6MQMvAiL1gKiuwTy8O
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295891; x=1717900691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5jw3U32WVQ2mu7sEVPOQe4LCfxoKjEQKNWxX7qFcmg=;
        b=GjqJyjj0HLtsS8iRRyVg97Wy9LWaf0OF97W3NeUX1gOq46hqZyr9mngB+Ektw6Kdfc
         H5/R1l8VZX1oqJjTSye4MOCWjgFcw8z+ieiCIIOGxT9zFddeR1utkMtceAIOMWihSaXE
         pdVec7WgrTQrDhGzE2/bjig5iqFd6SD4EsSE0vBFUphut/8mHGExZT+Hj/pCJ4uWMlyH
         FITNhK1n5P998CC/KtE4fFL/Bizvf1MDdo8kxdHYPdeP2mGU3AKPF5ErF54iLAS02ARM
         PPASwKmQQrQFDGs5YATxElfOG1QbYbOrE18xuVVHCqtpSVR5fPn/ApvulWGVla8dYpRo
         AXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVGV6t+kJXVnJA5MH6TrEf7Z9BcFwKBK/WL7fhHYc9JIi8c2gstWP2Qc+mdFtvG4GPIGf0lgBtkn6QNMVlllm0F2cw9i+NqKwt9MleQ9ZpPVSR7kIaw9NdKsbJA5Wd4Otd9W5LiIWNe/3A3Xt3Jmx12WGdbcXhI9OFlBQxFQ5EgOBXTR8Fit+zXiO+W00bBzDZ+Y8AGgG50z7GtCDuh4SkZAIH/hpM4HazDYpG51dHD74/Q7UirVA+igSgPnzDcftLY5BEAeBpKRMTo0Ol9MIDbygBS3R/WD1mGP5mdeQ==
X-Gm-Message-State: AOJu0YwkQNkcVysxk+34KGEQJ7P7XPVMoZiO51ZQbu7d9IZpopa4Y/60
	vIXNgM+NsG+6Gw1KgH+htK9IAtLFhkeojAnTS6Lar2+2Sbber+dgb6fWxkmH
X-Google-Smtp-Source: AGHT+IGo/wVjyO4OICpJZDZTH4jheRMtb0X7t2+mNawRoMfV8Qr8nCyFpN9Zm95vvFymEE9SACUejg==
X-Received: by 2002:a05:6a20:9788:b0:1b2:66b6:3848 with SMTP id adf61e73a8af0-1b26f296b46mr5019662637.55.1717295891380;
        Sat, 01 Jun 2024 19:38:11 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/6] kernel: Avoid memcpy of task comm
Date: Sun,  2 Jun 2024 10:37:48 +0800
Message-Id: <20240602023754.25443-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using memcpy to copy the task comm relies on the length of task comm.
Changes in the task comm could result in a destination string that is not
NUL-terminated. Therefore, we should explicitly ensure the destination
string is always NUL-terminated, regardless of the task comm. This approach
will facilitate future extensions to the task comm.

As suggested by Linus [0], we can identify all relevant code with the
following git grep command:

  git grep 'memcpy.*->comm\>'

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Yafang Shao (6):
  fs/exec: Drop task_lock() inside __get_task_comm()
  tracing: Replace memcpy() with __get_task_comm()
  auditsc: Replace memcpy() with __get_task_comm()
  security: Replace memcpy() with __get_task_comm()
  bpftool: Make task comm always be NUL-terminated
  selftests/bpf: Replace memcpy() with __get_task_comm()

 fs/exec.c                                     |  7 +++--
 include/linux/sched.h                         |  2 +-
 include/linux/tracepoint.h                    |  4 +--
 include/trace/events/block.h                  | 10 +++----
 include/trace/events/oom.h                    |  2 +-
 include/trace/events/osnoise.h                |  2 +-
 include/trace/events/sched.h                  | 27 ++++++++++---------
 include/trace/events/signal.h                 |  2 +-
 include/trace/events/task.h                   |  4 +--
 kernel/auditsc.c                              |  6 ++---
 security/lsm_audit.c                          |  4 +--
 security/selinux/selinuxfs.c                  |  2 +-
 tools/bpf/bpftool/pids.c                      |  2 ++
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  2 +-
 14 files changed, 41 insertions(+), 35 deletions(-)

-- 
2.39.1


