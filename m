Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1435227F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhDAWNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbhDAWNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A332C06178C
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 15:13:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p12so135762pgj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=cQExDcxo3OoK2mxwYeUFka8uI9xHUTKkU8RyEKfqZ1RZN/sSFJE+2N5pbNgm/YFQ61
         6cj6rbkFPYePaSDv3GdRZpz3odVN2y73i4lw2JOJsdHtIlztHidaHZv+6srccig5fpHH
         4h0d7C3pV7Jy4Hjoc3pPCqU98NbNAjzBuZDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=FTf1+dBL3fdriqkGGLkk4ITsWIff7XX8fkUe9wQsH3U/Rg2naHHg8h4fb0R+uMu2Mz
         8NQcGqVUlq5YqyIMqSPGnhrH/tj8bz7SnhiWYS8kNgF5rtNbRPnlVvBSwIr2x4aubnnh
         TmrC1id7ZEYOM6k97Cuofyv6ycJPWfnf4uLu7gbh3pp5CPeodgjf882kDE8lRyy20Tsn
         8vdF7dgubLZ4Q1YgAvljYBik4+5wJTJhFGFLMcPMfAnGahGD9BbrCH8dfPW6YXgPjo4P
         lgx1E+PxHOXz5p4QmqDqaSzkvtvV/jkljiDKw7GoELmB3JLC1J46bn2CztDLTYXoEFHm
         2JGA==
X-Gm-Message-State: AOAM533J7/2YNUHy/5M6JZr1lg9ktLpdfNdeBPJbEO9ges9b7nm5kG9Z
        cMvtPKSG/v4y9ywDCkkbtM9odw==
X-Google-Smtp-Source: ABdhPJzqcC4ByIZFeQrIwo8KNlFb2Y/g6f2p3afwwogKHitzzyYi+ntwY6nHe5d5rZF1Se1DYCo+pw==
X-Received: by 2002:a65:41c7:: with SMTP id b7mr9147045pgq.237.1617315209553;
        Thu, 01 Apr 2021 15:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm6508328pfb.98.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/3] sysfs: Unconditionally use vmalloc for buffer
Date:   Thu,  1 Apr 2021 15:13:17 -0700
Message-Id: <20210401221320.2717732-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series improves the defensive posture of sysfs's use of seq_file
to gain the vmap guard pages at the end of vmalloc buffers to stop a
class of recurring flaw[1]. The long-term goal is to switch sysfs from
a buffer to using seq_file directly, but this will take time to refactor.

Included is also a Clang fix for NULL arithmetic and an LKDTM test to
validate vmalloc guard pages.

v4:
- fix NULL arithmetic (Arnd)
- add lkdtm test
- reword commit message
v3: https://lore.kernel.org/lkml/20210401022145.2019422-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/

Thanks!

-Kees

Arnd Bergmann (1):
  seq_file: Fix clang warning for NULL pointer arithmetic

Kees Cook (2):
  lkdtm/heap: Add vmalloc linear overflow test
  sysfs: Unconditionally use vmalloc for buffer

 drivers/misc/lkdtm/core.c               |  3 ++-
 drivers/misc/lkdtm/heap.c               | 21 +++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h              |  3 ++-
 fs/kernfs/file.c                        |  9 +++++---
 fs/seq_file.c                           |  5 ++++-
 fs/sysfs/file.c                         | 29 +++++++++++++++++++++++++
 include/linux/seq_file.h                |  6 +++++
 tools/testing/selftests/lkdtm/tests.txt |  3 ++-
 8 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.25.1

