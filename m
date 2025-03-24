Return-Path: <linux-fsdevel+bounces-44854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C1A6D473
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF91891723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AF198833;
	Mon, 24 Mar 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bferOem4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09448204C29
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799215; cv=none; b=pfBF015h73rxn7Px07AQPnmqYQOkLiUxxEaJPalKScyiUKFvlDqlrs8sZJhFc2+J4LMiQoNYkKgOgLRTSohNaPuxjRQyUID/LImazQycFXvz2CEuTGwpT6/3F9XluHql300Be2su4quzB1VIQxXmpFWnt91CfeKbUIltoXi2bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799215; c=relaxed/simple;
	bh=BBod9XlyyDQ8D6adGtugfu8HDKv7/m/WFoETZ5Ucj84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uA3s52YksRz+akzpRJgphelLlnG2ar0Pp7ZP4RRP95DK5Wkim9NfdR6ulTiXTahU/VDLV2+z/O+ufzwYVmab4O2r2TMLP7GOTaX3I6ZSbA26lRM+l8Uy1PIwqe0O7K1ym4EIP6Nd2mZgR4iRFU2Yw0Igiq1TMTvTprpNBJMiah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bferOem4; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5fe8759156aso2972573eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799211; x=1743404011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ij8NrI5xZ43JBAGEthvNKWDZxxjZlhI2ViPlC5qM+Ac=;
        b=bferOem4Kmpd73E/n6xq19KUOfp97nSAZkcPz7DO4yw3lssi+zAGYriQuKYIQES1/a
         RO/v5grBrWbnyOpuY6NDWG9WXM2bUqhOt0MnEL181/o1X85rVcIElbeoXUQ6m8eg3nlC
         pDa80t0NC5atHl8/YQICgZ+UP8LVhtRtLfaZtJ3O14j1+mlaYzojfLcK7Fp7sJpXo8eK
         kCKoiKXHnQMctne3QVxZjxUYBMXs4UASBABuLMiF7s5kKzKG6UE3uHpFKmxdx00NMCFh
         9xRVKbwFmOnwyLVIDw/JBU9TH9QZ8uH/HvB4LkNh1l/QgwiAt+SwqzeVXk34I5tpgRMe
         47Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799211; x=1743404011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij8NrI5xZ43JBAGEthvNKWDZxxjZlhI2ViPlC5qM+Ac=;
        b=KOgmdwD9n7FLzgRGe2GMI0+5abawFFs9QeLhLshMGUHsKM+JNN9vcOnENEzxVCL+Xg
         0m0raAfdIlWgDG2SLQp9BHNv/Qnnsf1bEOQWsLz+Pc/vtwd2l4KHWRnwQEOCktAmKrUx
         rYFuV6Nj8CVwmPwnMn3joSFWGOZ96pq/IMoNFsVEvBxd1L968HX9bP3I3/QCMPpKvCGp
         c0FLQmJMbSa08sPWyOM3RSg21/yCulb5atyCCrlyuxc6KnsK/EuS1ppWg6xvP8SNhx8t
         O5WWm5NNp6bxFHICRyg+vrsEgBWjJP26yceE7m5RfYCMCDsMi02Q3q+e7CC6isHQLD3V
         gf7g==
X-Forwarded-Encrypted: i=1; AJvYcCWo2s6DQCb6kSfuSux9Pkz56/r33rXUdC2mj3ChMjRdmshxv5A0Zs19Z4UipPPkyKpnMMMu224r7HrGUros@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGebd0aFhJBzEsKgQ7Oza9WF5zUL0WX7ZPZu+MYRFCX0GVb7Q
	9F3j/Y+eEnA/NPuG1SIIf+JZcMX+p0fr6ume/xY7Y/DsvMHBX834wKkCi4w35KH6Acp89hB2gyy
	ETQ==
X-Google-Smtp-Source: AGHT+IHpdLVbnzsd3cNvYjM2o8eY6lwTbr3KBAgc79gozX2wYwWUwNW68nIoXf4IdVkTdg+SlaMY46oDTYQ=
X-Received: from oacpc8.prod.google.com ([2002:a05:6871:7a08:b0:2b8:faad:4f1d])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:8901:b0:2c2:57a9:79c4
 with SMTP id 586e51a60fabf-2c7805045acmr8278062fac.32.1742799211140; Sun, 23
 Mar 2025 23:53:31 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-1-avagin@google.com>
Subject: [PATCH 0/3 v2] fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
information about guard regions. This allows userspace tools, such as
CRIU, to detect and handle guard regions.

Currently, CRIU utilizes PAGEMAP_SCAN as a more efficient alternative to
parsing /proc/pid/pagemap. Without this change, guard regions are
incorrectly reported as swap-anon regions, leading CRIU to attempt
dumping them and subsequently failing.

This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
add guard region bit to pagemap":
https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/

The series includes updates to the documentation and selftests to
reflect the new functionality.

v2:
- sync linux/fs.h with the kernel sources
- address comments from Lorenzo and David.

Andrei Vagin (3):
  fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
  tools headers UAPI: Sync linux/fs.h with the kernel sources
  selftests/mm: add PAGEMAP_SCAN guard region test

 Documentation/admin-guide/mm/pagemap.rst   |  1 +
 fs/proc/task_mmu.c                         | 17 ++++---
 include/uapi/linux/fs.h                    |  1 +
 tools/include/uapi/linux/fs.h              | 19 +++++++-
 tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
 5 files changed, 87 insertions(+), 8 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


