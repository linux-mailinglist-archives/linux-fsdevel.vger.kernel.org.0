Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9D2F2405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhALAbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhALAbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:02 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADABC061786;
        Mon, 11 Jan 2021 16:30:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id q5so1190251ilc.10;
        Mon, 11 Jan 2021 16:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf06j2J/xJh26sKzEszG7v2rTNz0GvOcw7vpmSGZN3s=;
        b=frEA0QGaVQjMOSDlhANo4VdHIniY5MeLxw169jZsJEOnj7C/xPE5zzdg5KQ8RDEIST
         rtnNBlqnNnKvFJl2CNZ+aUWGr/7bkvyb2eaDt2FtK4Rh1Hxy77t5Ruq0p7qaES2iAnSm
         X+fp+qqtWo4XqmMjR6n3FNLhZmpV2IgyssKbNPoA5bTl7604TyRmqhjme1iX8crWBAs3
         KHTHFyiTJzTSQiOhX530j0TvFeAsj+DpmWj8EqmI64X6ClkbfRBGMioNM1jL3RnOoUwm
         +mjgvgXepCuImPC/HqdYCcConUsxxRMxgWhZ/1i9cBIFUF9u+Chyy8NE3tlSQJHwJ/g3
         FMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf06j2J/xJh26sKzEszG7v2rTNz0GvOcw7vpmSGZN3s=;
        b=RQwRE6EK03JSi4kF1berkzybxrpdDSm92NesBicmm4065+diY9NVlKKqNvADHDjOOY
         SqPCySsaL15CxpydCgsgdmDlTFu2hE3pKWeWYWAWgpDUcQW8DtwhfC5UFpV/04MAqged
         1NqHnRtjDG5Qp9iNKuyR3v1B89lDMRN3TCjj/eL0dzsCQ2qt8UsRL4ZsuMK01IW4Jv9o
         LwEkqFxyuYHRY8FYsGmIqOBQ9zS8W77Cqm2NoDGPaz6C6hy1kvbPoC10eT9XVZ9/m5A/
         NjNgU9+aBi5977ZPTEkOniam0fHMaZ71v1I2iIRSWLJG+PyH66jWlKPkl1j4I072BqGE
         1c9A==
X-Gm-Message-State: AOAM531RI3bb/TDQv96Mut46E+sXc3zW7WqtozXxQ5atQKHL7D4Gk8j9
        oB/roL0SJWqaCMFXwRTazh7GA7ek+2o=
X-Google-Smtp-Source: ABdhPJxyyXgdQDAValuaJq15oR8PpAGE27m5DoHUX8KazuC48SG0kxxgzH42O+mP85yif7oeT593jQ==
X-Received: by 2002:a05:6e02:118b:: with SMTP id y11mr1512996ili.45.1610411421360;
        Mon, 11 Jan 2021 16:30:21 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:20 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 0/6] fs: deduplicate compat logic
Date:   Mon, 11 Jan 2021 19:30:11 -0500
Message-Id: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Use in_compat_syscall() to differentiate compat handling exactly
where needed, including in nested function calls. Then remove
duplicated code in callers.

Changes
  RFC[1]->v1
  - remove kselftest dependency on variant support in teardown
    (patch is out for review, not available in linux-next/akpm yet)
  - add patch 5: deduplicate set_user_sigmask compat handling
  - add patch 6: deduplicate io_pgetevents sigmask compat handling

[1] RFC: https://github.com/wdebruij/linux-next-mirror/tree/select-compat-1

Willem de Bruijn (6):
  selftests/filesystems: add initial select and poll selftest
  select: deduplicate compat logic
  ppoll: deduplicate compat logic
  epoll: deduplicate compat logic
  compat: add set_maybe_compat_user_sigmask helper
  io_pgetevents: deduplicate compat logic

 fs/aio.c                                      |  94 ++---
 fs/eventpoll.c                                |  35 +-
 fs/io_uring.c                                 |   9 +-
 fs/select.c                                   | 339 +++++-------------
 include/linux/compat.h                        |  10 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../selftests/filesystems/selectpoll.c        | 207 +++++++++++
 8 files changed, 344 insertions(+), 353 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/selectpoll.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

