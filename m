Return-Path: <linux-fsdevel+bounces-43252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A965DA4FEB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DD83AA3F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733FD24502F;
	Wed,  5 Mar 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2SaNC56"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F820551D;
	Wed,  5 Mar 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178214; cv=none; b=oV8k+U5WxLSar3vClWBPe6Wy5YlmFXLE9kn5TqBXde751Gaa65YHKOtko2el5khXjzXUnIjKT0DSqHAaWN9Y3B9zC5kaEtwC7P6tKnPllL5yipkQGIr2g4xEq/D2+E3Dt7QNMCxY4SZoeQy7ET6Ng3nl3Ex890etQsdTuUSvmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178214; c=relaxed/simple;
	bh=gUTjlqhUiVTWDXNXuMMdkyAxQdgHWSMDSEfH0fgqhAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1Mk4dQo+kUsgl3BsAC3sugqqRP2JrArW4cSpEoGeASdIEBtEOoN2fJ1eUKv9z98a2IGeFmzJQl8YvrFTIzwZSn1JtoXnVevue5PfzqmDSHsgxo+Ps28yzNdFXMMC6M7qg33S7PJrPta7mi4MxDriFCMHvSsUF7Iz9WlE9I9yic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2SaNC56; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf538f7be0so712755466b.3;
        Wed, 05 Mar 2025 04:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741178211; x=1741783011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6p8zqSbOavpHNE2rD7qVUlmFIV4Vx8wkpmVjD8ddAxg=;
        b=S2SaNC56zAX3AN8ok2+JzJEkE7jSFIpINVzqGOG3FQnoUJ7l5PWte08XW975h6qSSM
         oUcXvGvf4VHT+uHw8cDTpmX9Qh8snVugP283TcpKr/1N+JXCF+xzxj3ubkmopAF7gBJi
         ca1xQNa4FGjJdypGPU0f3TGQx/1lEk+0YfU3C9Su054JLP9+HitILhZMSXR3RmuHhBmE
         pCVLia87pnLq5eJBTMX56gNn1AZQ0YIWaXVnFJSei/2Y2jiS9QS2uVkgZt7eiEY+/RHu
         p5QHFo/XxPAT3MAp2g2h/kdvgSAsGJurYs81uNvRun5Oz23v2VvUSzkEuTeXXKvwMloM
         tvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178211; x=1741783011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p8zqSbOavpHNE2rD7qVUlmFIV4Vx8wkpmVjD8ddAxg=;
        b=F+4Nw60CRCLaoXYmpl74eqbm6jxYYj6Q30rfGQeAQgnfY1as0ksOhYW0Qkh2uXKWK6
         enX3xJVEIhSYyigCE+FJQH3wr3l13t+T2QRBiw4G9XDNJY61VwHKpDxxLxTtt6C2eRRW
         AnlYNilNks8Q4aYzjb3ybnSYJzBUyJbl0THAu6SyX7hL/VgG4/UZqMLn6ZegeBd4BFOY
         rAfJUrpRLQig00cxfjuFG2Xif0hpdLr+6B9NpiA4WdrTQoG9ya2aF9ynaBLivpP9BKuu
         CofiVKLxU3esGt6ecqhSRQ5hq2MKG9uXTEUKZekbHIcTruAuTdlAjhS7vRsEqHLX2fzh
         UI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/3ZqPm0ZDHU9FM5OSNv7DO2lA9pUYnRgJaDfE/RzZl3hwgFGH4C4UrBXpHPRTWpnnvcem+KlJ25unTHhG@vger.kernel.org, AJvYcCUw92ZDj8TfRdrqFw5xQqygUnyMPeJ0Bp5qzMAJ5Lv0b7/nxp5XTjR9nsAY+8JoS4L7GALG4tE8rmcMOjMl@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdw+ifZeGEURD4QLAhKXCCv+MW7QGFhN2NjBjzcvApVDN5hG0
	uLSTEyd8VQNvhZEbwQB/bkq51ieoEidnhpZerh1RiCfIg76WKMoD
X-Gm-Gg: ASbGncvN5XiOaEKJlr6HofxGlCvw2Ptyibu4cTtKzeCsFOKo8q3U75AmYy+J9IBcdTr
	LOo7e9ugOa4dWOW25Ji9Dsk/VTotdRRpIt+aXQXLe1qxqmYP1SWwa7wnWmqwAOAqmNvU7UxYWnZ
	vMplyhaffrSYbaKCG0+H4xf3f6AujqZHifHaprqzFZwMFAyNAJ6Yr+HfpgX0hb9FU7VesGdjZTt
	WBRIUfcsby1eft1IgmBuLLyAjyuwQEqglUSwxqig0GHXuUitPPzv8LEzfoB3AYx8+GuV/cBPM/s
	swLDoPAMuyv61Y+JvA4LMvheEjGxn3AZ5Z8kyxqq2WuYFpxPB4tBQ9C4QPx0
X-Google-Smtp-Source: AGHT+IH8FLt+NeMItLSHqUIubd2OFA6gmGPQFB7jbifELckyXfJrgTFFbMHeh++rXIoAHKGxF/ev4Q==
X-Received: by 2002:a17:907:3d86:b0:ac2:8a4:b9db with SMTP id a640c23a62f3a-ac20d8bcab2mr255600366b.16.1741178211067;
        Wed, 05 Mar 2025 04:36:51 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm9632068a12.18.2025.03.05.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:36:50 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH v3 0/4] avoid the extra atomic on a ref when closing a fd
Date: Wed,  5 Mar 2025 13:36:40 +0100
Message-ID: <20250305123644.554845-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel transitioning the file to no refs held penalizes the
caller with an extra atomic to block any increments.

For cases where the file is highly likely to be going away this is
easily avoidable.

In the open+close case the win is very modest because of the following
problems:
- kmem and memcg having terrible performance
- putname using an atomic (I have a wip to whack that)
- open performing an extra ref/unref on the dentry (there are patches to
  do it, including by Al. I mailed about them in [1])
- creds using atomics (I have a wip to whack that)
- apparmor using atomics (ditto, same mechanism)

On top of that I have a WIP patch to dodge some of the work at lookup
itself.

All in all there is several % avoidably lost here.

stats colected during a kernel build with:
bpftrace -e 'kprobe:filp_close,kprobe:fput,kprobe:fput_close* { @[probe] = hist(((struct file *)arg0)->f_ref.refcnt.counter > 0); }'

@[kprobe:filp_close]:
[0]                32195 |@@@@@@@@@@                                          |
[1]               164567 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:fput]:
[0]               339240 |@@@@@@                                              |
[1]              2888064 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:fput_close]:
[0]              5116767 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]               164544 |@                                                   |

@[kprobe:fput_close_sync]:
[0]              5340660 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]               358943 |@@@                                                 |


0 indicates the last reference, 1 that there is more.

filp_close is largely skewed because of close_on_exec.

vast majority of last fputs are from remove_vma. I think that code wants
to be patched to batch them (as in something like fput_many should be
added -- something for later).

[1] https://lore.kernel.org/linux-fsdevel/20250304165728.491785-1-mjguzik@gmail.com/T/#u

v3:
- inline file_ref_put_close
- unexport the new routines and move their declaration to fs/internal.h
- s/__fput_defer_free/__fput_deferred/

v2:
- patch filp_close
- patch failing open

Mateusz Guzik (4):
  file: add fput and file_ref_put routines optimized for use when
    closing a fd
  fs: use fput_close_sync() in close()
  fs: use fput_close() in filp_close()
  fs: use fput_close() in path_openat()

 fs/file.c                | 41 ++++++++++++-----------
 fs/file_table.c          | 70 ++++++++++++++++++++++++++++------------
 fs/internal.h            |  3 ++
 fs/namei.c               |  2 +-
 fs/open.c                |  4 +--
 include/linux/file_ref.h | 34 +++++++++++++++++++
 6 files changed, 112 insertions(+), 42 deletions(-)

-- 
2.43.0


