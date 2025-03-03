Return-Path: <linux-fsdevel+bounces-43010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E874CA4CF08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 00:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430C0189299E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B01D2356DD;
	Mon,  3 Mar 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWAefU4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D241EEA2A;
	Mon,  3 Mar 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043067; cv=none; b=XOdueCCgFVacnN4rzVHclYZRm9QHwpo3ahvXKyV0AQtKQWA/Okj3NPCRQ2l/AE3VoPGMwZ7mycrXbjDK4LCjThX+S62o+BSzyUtcyJW7MSRxNt3hTxg+VN6eh6DxC46AXplq0o4GMfv7e01yygWjLdkZz+JOxInoFLjP+1T9b5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043067; c=relaxed/simple;
	bh=1dga3ZyGa56Srd27YrzgJM4YBMG+svOtEN9xbmvulUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzCz50quY2Vd4HQzbiaggnjz4Yr0qu69N/dWstx2EXqsjhZQxyaOl1WSUiu8z4or9TnJ1ZnBtiu4RHng8YlX5MEK3IVBUDirp8aBMYmxX+aD/BEWIRIEbGX2laR+lR/HjlsusjIgU1aLbRQmibSfZXZZRm9bHaBw3MwfAie1Lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWAefU4H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so31498985e9.1;
        Mon, 03 Mar 2025 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741043064; x=1741647864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPrC46dARN0LjaxKxSWkkaHdPArQam0Dkp/wu01ntBs=;
        b=WWAefU4HxUUndEwiNbpaT2jiZF+jY/j+hcn3uUbflte/eRQPmI5/ZV5FHIs2pr0iH1
         6aF4iM2HHydvT0Bz2VNbWdR8jIEKbT4wdzh99FTIRmfQZJK+BSsPMwuBd+EJRa/9mQLI
         Q7VnC6tSyFJFp5NUUWtGwyI7ha5GmGXRmnq/iUYX5mtM60Reoyc5PxFNZ+4xL2VuhelT
         W7lqIZcrj3w3i+AVzRU0rWq5vUfpadGexyklfJE1mMBaWyJ+T2Vf8l0KRdgmSQdf5dnG
         mdhkkcDEb3lyFMDc/a65by8dcYGVQGUtGr5wEC9EN4sK0LA9cp2VtLXRNcczcnsD9bKk
         y/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741043064; x=1741647864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPrC46dARN0LjaxKxSWkkaHdPArQam0Dkp/wu01ntBs=;
        b=O6oq2vjlz9h5LxhrrMFElTeqUwqZW7bDSjxlk0/uDnuWKrKq9J6vmgbBhN+3EOGQum
         DKEaHr1KRTDyXGi7tW4h+A4Ze2jFptL5mkQdlqnpe1YeYxHeSmC56IP00FCcCduO/CEu
         aoHBA6KSDPbbZ57UCiouHbzVOFQUctkRxaxINHWr1sZIWZ1gFuBUTSsCHKjB+CmEk72u
         scyva41gmPlg+tItJsKiA8AY1fxkKz0bMjTbAoGUJ3/pDfXOUMjd6guUoiCrwuoxv7Jc
         Vlyz5ea6gHeuT/4jlo53PZejLE9n816AeAWes/gdA1z4SqndkTpHdcfZAa1Dfi6Jo/FU
         0TYA==
X-Forwarded-Encrypted: i=1; AJvYcCUiRHInI4gzax0byXNHUEWOpO3tAaoCSZEX0rvEv2S/jnrc4mWUNQOLVd/G4RJNVyYxCLPOo4obWt1YCDD3@vger.kernel.org, AJvYcCXimrRYyf4P+JI9XHtQ2aSPwRSQLVuugEdyWkn29NF2+c9UCHylgsedco8FsYZ0bDMKurj2vLmppA33N3Pt@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7Cfu6WDy34jizTwOXGmyMoEHG5YRv+wY7ExTpMp5jVrhj71M
	TA+r2OIn6sQaZLU0ysVry7lWo5PMzUmtkYNmJIXgFLMc25ai6cx4
X-Gm-Gg: ASbGncuFH7ZoYH/rMkEBEQZlLmli0JrWQvYkDjesGPClhsjJIyXgEMWjWvjzQOa8jPA
	4I2yewDqLNTYQlHeDHj6NWdzfm9JsgHeF15Ud42KBcXwmwxOd+3i8v1NSOkEqPB89XtrDWjxBcc
	v9paxVIBUEj7Pr3fhXnhCWhJQpx3cI/44RXnxDL1+TuvVXowKHhLStGLKSb7gaTkVnjvdGwIXMy
	zwPykobjAPdgF/A/PZwlbNwdi3gzjqBIBpOSkz5L/JsCtHH6KHTsJmViCYJro4jBExUvusj2NY9
	sP2M4cqrzEhKRH1yL9lfIanhPLLiqDh4bLgXBFMiwfxcDJJYHRd9e49xz5Eu
X-Google-Smtp-Source: AGHT+IGOBC6hxzmLOdi3PDf1ZBbud9og/t0k9D2kRRsbPqkFlx3ttchAE9Qq0/Z35uubnFaAHwXeMA==
X-Received: by 2002:a05:600c:5252:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43bcb03c512mr7222235e9.12.1741043063825;
        Mon, 03 Mar 2025 15:04:23 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm37679255e9.31.2025.03.03.15.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 15:04:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	brauner@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/3] some pipe + wait stuff
Date: Tue,  4 Mar 2025 00:04:06 +0100
Message-ID: <20250303230409.452687-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a side effect of looking at the pipe hang I came up with 3 changes to
consider for -next.

The first one is a trivial clean up which I wont mind if it merely gets
folded into someone else's change for pipes.

The second one reduces page alloc/free calls for the backing area (60%
less during a kernel build in my testing). I already posted this, but
the cc list was not proper.

The last one concerns the wait/wakeup mechanism and drops one lock trip
in the common case after waking up. That too was posted some days ago,
but nobody was biting. Perhaps you will be interested (but again, maybe
I got the wrong people from get_maintainer.pl).

Mateusz Guzik (3):
  pipe: drop an always true check in anon_pipe_write()
  pipe: cache 2 pages instead of 1
  wait: avoid spurious calls to prepare_to_wait_event() in
    ___wait_event()

 fs/pipe.c                 | 63 +++++++++++++++++++++++++--------------
 include/linux/pipe_fs_i.h |  2 +-
 include/linux/wait.h      |  3 ++
 3 files changed, 45 insertions(+), 23 deletions(-)

-- 
2.43.0


