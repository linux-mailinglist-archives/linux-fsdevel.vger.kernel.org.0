Return-Path: <linux-fsdevel+bounces-35644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BC9D6AAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AB3B21612
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D1E146013;
	Sat, 23 Nov 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBxDMkfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553452AE90;
	Sat, 23 Nov 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385351; cv=none; b=YMiOSWCyvLqQHGdi8EKvlzI0oT6erRRZ9zGEZUpmMURUyFS6YjJW/IYbgf2gS07Iu1xznXpl/jbKy39ZdRgrqPDYc+NzULfOwWDwYLYNlcQ7AoisnYklWR6rLaMgMVwzOgvR+RA67X0EHgv50rAym/jzMFdzeSRpuBrxreFHtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385351; c=relaxed/simple;
	bh=6l9s3Ydvl+883iSfMEF6k5y+5gcrrJqW4lK9xyUxr34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCAOF1eZ1i4ZYtJcHJ9iJZ1hTZ/uPaJKI5k5W0z1wz1lMHgS4sx+c/m7Ms6tmd/x04gK6slxAFlygrOR7R8eo8sxmm4ylRfJbkfSqEFQUht9q92GVeo2DiVy1BWz581A1aqC5qYlafkuljWYGgvNkzHZ1YxVdH4PdSsQWoeNSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBxDMkfF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212776d6449so34878065ad.1;
        Sat, 23 Nov 2024 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385350; x=1732990150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70ukTFRg7n6M1zgWJ4AWCRSyP5CAlpK7ZnU0g82lpUE=;
        b=OBxDMkfF7zB0budwXpXToDRKVeRxEzDLpCjLkQ/+9ykqfVYN8xeCp3bZ3OFSD2cl6M
         r5ArWNUma88M9uc+mYVOIRIxLWe9ZK5cNVwJmH1TdBuZCCadxD7qDvRwH8v8/yYqJDpD
         7ebWStGwuKc3seJieDCVfwfGK4Cr3c7HFxbyeXtwIzXgTIUzunFVWmTMI0xAOkk5IWq4
         ozj3n3JNHbmSU1IKHQFC2n4ioaQrU5jOmjWMDrJ9twKJzTimHAQkUZZrb6VTUw+0UcnP
         X/x4/R8+gFuUMRF4d/5ttn/5SHFkxTkgqAIWewMDssx5g69ov5B9bnzLVABCwNB8IMnP
         VSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385350; x=1732990150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70ukTFRg7n6M1zgWJ4AWCRSyP5CAlpK7ZnU0g82lpUE=;
        b=QL8DeKFKsrqUQFatvLYtWzBugvQYOivgvf/m17K55WaZkrxpkuw0qcEMtfVtFhl6ky
         vlfpwu8ciF69+E8qBS21e2NRitvYRIJtYPZskAgW35h5Ng1bbsIlx9YlaDeKmLFEQVV9
         ic8fh+4+zo1GOUTuh+X/kPo7Md6vmziAllSUXoBy90CIVsx/kGSWwei442SP/aIiGBS2
         AwSH/Sw4kXElILapqzIjEo1ZHUcy+cCjYeKhBw7xpqpWTGqQYoUGB+0kdKjYAomKYAv+
         PJDUUgoKLdJ3AB/zosVbO/YXzudENbBbu3dQIuHuGLLrxkbi4HIATtzFayGWRsRXHSO7
         naug==
X-Forwarded-Encrypted: i=1; AJvYcCUlAGNkVqUDo2+31Vp1kFCjU72mkteaivT/xGE4NPxqmJazsnvvybxt0lX3XIWOtXYRm6KP1B7GrJIJUWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7UELlvfbcPbY+aQTsln9IcA6pssoMmS9Oyp5K07judjGOm0W
	spH7CpovgjYffhqDQEAnHEVctxXCDqegI/Y7MOWVXvbc7/daAJgB
X-Gm-Gg: ASbGncukwrIKnBxfP/Qn21Mmt0oTp3ht9EmdQ6jm0+lX4v7RdtVGAL7aXOtN7tpqcFd
	HnDFw65/aMFh6VmwEGTZmjvvxJ/Cq2Z+HTaEMPpiHpoPZOe8pfUxVHnG9E4eqz3wGsDZ+OezMU6
	9EqugPMUGQmrYzjIRio3jC4N5tM1ks8ggYFLEN6r+3BSwRECnkfakzI/HfCTLB9AU/iz+iTjpub
	Lb8dsHlKJkjHhYGVmcfe3TWne5wAhLTlKwSdwkdJCchjkS/9wEm42fUG2Q+EzxebQ==
X-Google-Smtp-Source: AGHT+IE7+W1Fq7uSCQ8ZbRiJFN/jR8TqFwGezrB0SHydUC1bMvjCrf3pdWBBMMyJOJABN0Xxx8OaHg==
X-Received: by 2002:a17:902:ec88:b0:212:530:a65d with SMTP id d9443c01a7336-2129f5e73bemr113795055ad.38.1732385349660;
        Sat, 23 Nov 2024 10:09:09 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc225e45sm3626491a12.42.2024.11.23.10.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:09:09 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	adobriyan@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	flyingpeng@tencent.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 0/6] Maintain the relative size of fs.file-max and fs.nr_open
Date: Sun, 24 Nov 2024 02:08:55 +0800
Message-ID: <20241123180901.181825-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/admin-guide/sysctl/fs.rst, fs.nr_open and
fs.file-max represent the number of file-handles that can be opened
by each process and the entire system, respectively.

Therefore, it's necessary to maintain a relative size between them,
meaning we should ensure that files_stat.max_files is not less than
sysctl_nr_open.

However, this point is overlooked in the current kernel code, and
this patchset aims to rectify this. Additionally, patch 0001 fixes
the type issue with the sysctl_nr_open handler.

Jinliang Zheng (6):
  fs: fix proc_handler for sysctl_nr_open
  fs: make files_stat globally visible
  sysctl: refactor __do_proc_doulongvec_minmax()
  sysctl: ensure files_stat.max_files is not less than sysctl_nr_open
  sysctl: ensure sysctl_nr_open is not greater than files_stat.max_files
  fs: synchronize the access of fs.file-max and fs.nr_open

 fs/file_table.c        | 15 ++++++++---
 include/linux/fs.h     |  2 ++
 include/linux/sysctl.h |  4 +++
 kernel/sysctl.c        | 59 ++++++++++++++++++++++++++++++++++++++----
 4 files changed, 71 insertions(+), 9 deletions(-)

-- 
2.41.1


