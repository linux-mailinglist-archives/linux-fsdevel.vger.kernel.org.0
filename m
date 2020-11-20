Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413E12BA6B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKTJ4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgKTJ4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5EC0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so7882110wmd.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65HrmNqKftUnE1asqIayt2cnQblLlYt2XJU4abNkW2c=;
        b=cIig+mZbWoziis9QAEDrcbFB/GOPYHBGkq8UJPfrMuHlRHA1uJlZUg8f7WhD8KenMR
         81/gLvFGeeEBXJjDhsMMENeHrnWQTkCblsMZLAlIKI8XYReN/YfTx4TFLK4x62j8vMcv
         NMAQZYA3LmtaSpp4bf8bDO41FIZ2kz913tElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65HrmNqKftUnE1asqIayt2cnQblLlYt2XJU4abNkW2c=;
        b=ZCTtBca70+VlTk5rZEtTMDu7iZ94A5MYLVLXmo20v4fPdrEsfVgoLG0E/4lCYVLJxE
         EtF5NHWVE3Uyf6HG81irUc4aWu1IGnjBefU0RE7nF5IYpx6BWuN8ach4cfOk/F1LJBbm
         hScSxjXTe6igB/S/9KmfcCJ6hTs9cs+ODcBO8bHSU4bqbWsTT3YrFUTyi3stlZsr4/Zo
         TE8mHsG29E4cz5jnz9PGK0bil5SpbtIcQYZ6AQaWKW2QEOxioAYt/FgtlvERujmhntG3
         lHSbM/FgoHDdaZ2SOv6kHbL6G/UKayqu0ep86aCpZn8YJaH++z/svjKzvzIMZPVrzrj9
         /47w==
X-Gm-Message-State: AOAM531OI1XajPK7M6NYg6nXPFuvpZ+bJy1lGhgqBdtlR16Djg4IpKOb
        wRs4XDX7xuPuYIZWiG+yZYHIew==
X-Google-Smtp-Source: ABdhPJyxRsNqKBpDLy2jcbxhd6SI4PAi8++rl2ervW+Oj/NwJ6Q8RtMk6ldX7hjCBVGGsevXbc8h9w==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr9460582wmk.185.1605866170156;
        Fri, 20 Nov 2020 01:56:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9sm4500208wrr.49.2020.11.20.01.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:56:09 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/3] mmu_notifier fs fs_reclaim lockdep annotations
Date:   Fri, 20 Nov 2020 10:54:41 +0100
Message-Id: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I've finally gotten around to polish of my lockdep anntotation patches
from a while ago:

https://lore.kernel.org/dri-devel/20200610194101.1668038-1-daniel.vetter@ffwll.ch/

That patch has been in -mm for a few days already, but it immediately hit
some issues with xfs.

Changes since v2:
- Now hopefully the bug that bombed xfs fixed.
- With unit-tests (that's the part I really wanted and never got to)
- might_alloc() helper thrown in for good.

The unit test stuff was the major drag until I figured out how to make
this very easy with the locking selftests.

Comments, review, testing all very much welcome.

Cheers, Daniel

Daniel Vetter (3):
  mm: Track mmu notifiers in fs_reclaim_acquire/release
  mm: Extract might_alloc() debug check
  locking/selftests: Add testcases for fs_reclaim

 include/linux/sched/mm.h | 16 ++++++++++++++
 lib/locking-selftest.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c        |  7 ------
 mm/page_alloc.c          | 31 ++++++++++++++++----------
 mm/slab.h                |  5 +----
 mm/slob.c                |  6 ++---
 6 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.29.2

