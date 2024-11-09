Return-Path: <linux-fsdevel+bounces-34127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11B9C291E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F15B22979
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D492209B;
	Sat,  9 Nov 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="WGY/IeQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53611802B
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115737; cv=none; b=r569f6fbjsEheX7Q1G3vtMCC+zTMfCpF+P9Sy4Lkn6+lb5aSvo+sSIW6ywT2UckmI+pVJwoGgBPb5yL9ByO9u2Hp+k2fyztAz5erd5NeA/uzJhfLe3v8CbC3jalSutslc22RqE4dbA/ZLLWIGoLBm0iKsaNoECCyN0tIf4mGyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115737; c=relaxed/simple;
	bh=S7l/q9ce6B70UtagH9ZI/CwZva41DnVk8Rgp0ZOvS9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQQALM65xUjEHu6w/7/+2KPkCROiaFI+4tUT99p9p8RPTpC/X/mmb6ijzu98IPE8M6o1AY5+yx+kCKDnkWCXto+R7I53gM91pgtgsAojqv5GHEr11UJH07BX+5VJNy1pUWX7vt9KUtJpsX2JVs0g0PYqUXwmza1dZWR84Uj2D6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=WGY/IeQd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cafd36ed0so5615ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115734; x=1731720534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwEl8GsKdt5LD7sdpCLGjkpMXEHijXkBuIdcnGAtpRU=;
        b=WGY/IeQd1p8jhWTaa3gd8fiBC/damkck9AV4h98cY5ySLTHVI9IastDfB4L3VChwCK
         nUEIqgUIEvFN00DUvdXZN+3OJz6sCEsW3ZHgBHozF3V40ZJ2oOmmmwPTUTBnGvu0j5rh
         YqlxZQv5OkfRGOXn5jj+18X0K3KdcAi9DrpUc+7v/xcwXeFUUJUwKjN/CPiK6to4gLjl
         d7e8pNlLeX074HT/SJEHLgTq6lFsI/j6L8JCj3F7r3eH/pwo3N4sK0Ev+Kt/nBGuMSjc
         zmsptodlhVyJU1/dFtSnJQtWFmpGwh/FA4nO6mib0wWedtCBUV3ndPovN5ldZ9BSQaYB
         rfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115734; x=1731720534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwEl8GsKdt5LD7sdpCLGjkpMXEHijXkBuIdcnGAtpRU=;
        b=kaqo74E3Ar/9+g8Y2DFww+bqVrF46t8zRg5aTsfEF34gXd9meGdGcWWyJEypj+/vaj
         AzleLo/FPjF7r7ZPVhNz3k4wGDRf4riMVtFeJUtgFVzIOtS66kXBHR8eq84LDy1fFPOH
         c/oo8fyppead4CAkeS2d3MGHvn6G+UTrCTKuKh72qkFXVMxJEW5+hkJc5M8lwGEc4TOU
         0u98kb+gXdXjzfOtbUTLBieMaz5re0NUGbO4d4oZcOWFnaC1pxgiRv6eYPsHXaugD/L1
         1y++wsXn34I++YGWuZd6cwHmJIsCCzBTtJsoittfKTKU+I0P58dFXkiAPdVbCi9vr3F+
         jgVw==
X-Gm-Message-State: AOJu0YyIDuOUPUE8st7DupxKUbO2dYuLZ5Bqmw08FUGiKWBUf3fxNK2H
	40Rbe0fJCLzksIKm1QDsuOYDoBQAtZmHj4PLf3/bdeFGLXZL/VweHva1/RVJQWfZEeAZt/FaF6C
	k
X-Google-Smtp-Source: AGHT+IH1C6F18P5gAn7O7mTkZhrmkAbwdmt7AndSjK8MgbU5UzBqmqb9BAA1tfKRisdS+woxT304OQ==
X-Received: by 2002:a17:902:ecd0:b0:20c:ee32:7595 with SMTP id d9443c01a7336-211834de6d9mr27902895ad.2.1731115734503;
        Fri, 08 Nov 2024 17:28:54 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:53 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] proc/kcore: performance optimizations
Date: Fri,  8 Nov 2024 17:28:38 -0800
Message-ID: <cover.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Hi,

The performance of /proc/kcore reads has been showing up as a bottleneck
for drgn. drgn scripts often spend ~25% of their time in the kernel
reading from /proc/kcore.

A lot of this overhead comes from silly inefficiencies. This patch
series fixes the low-hanging fruit. The fixes are all fairly small and
straightforward. The result is a 25% improvement in read latency in
micro-benchmarks (from ~235 nanoseconds to ~175) and a 15% improvement
in execution time for real-world drgn scripts.

Since I have a stake in /proc/kcore and have modified it several times,
the final patch volunteers me to maintain it.

Thanks,
Omar

Omar Sandoval (4):
  proc/kcore: mark proc entry as permanent
  proc/kcore: don't walk list on every read
  proc/kcore: use percpu_rw_semaphore for kclist_lock
  MAINTAINERS: add me as /proc/kcore maintainer

 MAINTAINERS     |  7 +++++
 fs/proc/kcore.c | 81 +++++++++++++++++++++++++------------------------
 2 files changed, 48 insertions(+), 40 deletions(-)

-- 
2.47.0


