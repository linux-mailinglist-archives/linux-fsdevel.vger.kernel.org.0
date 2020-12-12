Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2312D8870
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405820AbgLLQvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404701AbgLLQvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:51:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9867C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2so9182301pfq.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKvQUhgLuCcONr6n9QV9n5RP5TlhqkWsY4ki/TEfKRY=;
        b=YuI5LuKYXdzNJYM8CmvPx9Z9JOosuVixtHoOJhrFIZxcvckr2dI0lmHiPIZ5Rl5qe8
         +iuaC9FJjVNAyXTVe7pptU9+dXrKPSY+gnzU9PbbroCz/+WGhSMu1Klbtte9T3hjbzih
         QDqrUkulARLQsQkmuyYe/TVnmV4sF3JVzNDVUWshk4tobtA2mF6EW204VLBhaDYOKoOq
         fSNtVNQjA+K/BuIfgeg0seIsIl67kWtPGzUdGQEmOeV6JfGvcBYs8DUuvkVoZinLsmmJ
         CpRWC7N5eAL/u0sokaJkNQBeu/YltnJd5c2gME2k/32KNBdLbgNTausc3VQZGlrK8gUs
         mGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKvQUhgLuCcONr6n9QV9n5RP5TlhqkWsY4ki/TEfKRY=;
        b=Gt03VP3zxTl8UCNpzYbTFKKUBq6EClCmiW08ukwr37EbbkjSM4cOTj2s3Y45GAE5fy
         0kHGEBq4q23ZF9eMKDF8cP5DGlsxftcY3aA1oWPPMvIcirteg2NabntC/G7GYfUfnFIz
         OEvReGTEotUrFlZ0mYSkvkX9xLxvkdnTWNr7HA/VhlZJVFpCT2hVFOytDAhw5z0DUqzS
         JNYzrvKtLXun/UCVFEWAmkV0KNPs1qvhhY5ZW4jY94LdxNHaA0cfQXat3PwYBzE0FADa
         FvIiWjwJdC3dPSs1PXmytBSibPTaOdLapaaUTV4uQBdMrSV322L7XQq5VQWDc8a+SR7A
         ZgQw==
X-Gm-Message-State: AOAM530IzNuHQyglFweCfMmbJxEdUqLBMk6MQzwt/9qzmroPVmwWRD22
        1Hg/RSXGFeiPjRqTyokLFof/s9BMY+2j5w==
X-Google-Smtp-Source: ABdhPJyuTVZ3eJoD7+2nrllGjVVfFuhMzAB/3kMRR4LAQRGZvmXcSMUPY64/2CGIPJBjkiOwWHs2sA==
X-Received: by 2002:aa7:8ac1:0:b029:19d:beff:4e0f with SMTP id b1-20020aa78ac10000b029019dbeff4e0fmr16805684pfd.0.1607791872944;
        Sat, 12 Dec 2020 08:51:12 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET RFC v2 0/5] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK
Date:   Sat, 12 Dec 2020 09:51:00 -0700
Message-Id: <20201212165105.902688-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

After the discussion yesterday, I reworked some of the bits since the v1
posting:

- Improved the 1/5 cleanup patch, based on Al's feedback.

- 2/5 is much cleaner now, also based on Al's feedback. For later
  patches, we also need the same LOOKUP_NONBLOCK failure case in
  unlazy_child(), so I added that. Also fixed the LOOKUP_NONBLOCK
  check in path_init().

- Add mnt_want_write_trylock(). Since we already have
  sb_start_write_trylock(), this is pretty trivial.

- Add 4/5 which handles LOOKUP_NONBLOCK for open_last_lookups(),
  do_open(), and do_tmpfile(). O_TRUNC is expressly not allowed
  with LOOKUP_NONBLOCK/RESOLVE_NONBLOCK, so I didn't want to
  attempt to wire up nonblocking semantics there.

- Fixed comment in 5/5, and added the O_TRUNC check there too. No
  further changes there. I'll commit to writing the change for the
  openat2(2) man page as well, as well as some test cases, once we make
  some more progress on the kernel side.

Ran this through some basic testing with both io_uring (that patch
I left out of this series) and openat2(), and works for me...

-- 
Jens Axboe


