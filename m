Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F863B8C88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 05:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhGADKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbhGADKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:10:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3DC061756;
        Wed, 30 Jun 2021 20:08:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kt19so3398284pjb.2;
        Wed, 30 Jun 2021 20:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dC2tDQKb0XkHAVvgr1NTYrtv5/+PY16weB+Ng/scnVw=;
        b=HZ8eWzaGzEC5xyge8WQAPfBbE8YLqNbU8hXsDuHwYOyo+QiLk1EWJHvP3PG9j+UC5Y
         s8SoU2IEoewFrV+gdUCnIcQ26vO/kA9tIVj/0e+151uurqW2FNrUkKlB2pWOyLlN25p2
         wWkY8jFVMWREbSD/hgrylDIs/kno0Q4z2W7Yvs4T5D2dEQnXsBOqBVwhgkf/lqFI2RIj
         Hq42PByuM/K1GToODNlaXxjT8Ey+4o86x1QUT1EzF4wXVZl/ljWbkYrZhqEgF7XJKm/E
         r4b6v300ZJxUsMnyIZ38cc808AZqL89n+21PHnR0dbirU4ZeEeEnZhKnqebe/soEjoCW
         f+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dC2tDQKb0XkHAVvgr1NTYrtv5/+PY16weB+Ng/scnVw=;
        b=bhCfLmBbpSjS9QNZ2Lproz+O2Ag7Esao0hK5zYwB2sRon0QUUcskPQWHCGr8lNuMWc
         hC5dzkZZKgPM9DE+WEhDnzREHKfadFaahbVHMqzxPGF3EGnna58zzdgfBQgUTub0u0e3
         sGy5quiFkpS4o8dmn/AsG46FqlgGU3gPA0HmBHi2P1Z7vz90JMn4TTzEJeaD1nVfaBEp
         binL2B7PjE8DRdY/rQrDOvGBGRNbczHO5YmQg1YFrEg/IkpK3LguUHuQDd7qT73ZZf3H
         os/W3B1t5rpwEgS1i9vbo47T3M6ZhTopoWvS6NyOR85IzE6px5aZaHUbAQ8wzOgEoz7k
         wr1g==
X-Gm-Message-State: AOAM5334Cp0zSezS/zlTxu7jOZ8OYmmtNaEkgovaoHSrYBSsvb9WhxMU
        BXbZwHlQCOQmzbqj9Crn2xM=
X-Google-Smtp-Source: ABdhPJy4YYFXgECHmGNmhLJ/wD9ZBzYDQelLtBdBYJIjzp/yVE6wiqvZxqz3mCwwYl+eN4aMrAew3w==
X-Received: by 2002:a17:90b:3655:: with SMTP id nh21mr7713862pjb.105.1625108904489;
        Wed, 30 Jun 2021 20:08:24 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id g10sm4568568pjv.46.2021.06.30.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:08:23 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/3] hfs: fix various errors
Date:   Thu,  1 Jul 2021 11:07:53 +0800
Message-Id: <20210701030756.58760-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series ultimately aims to address a lockdep warning in hfs_find_init reported by Syzbot:
https://syzkaller.appspot.com/bug?id=f007ef1d7a31a469e3be7aeb0fde0769b18585db

The work done for this led to the discovery of another bug, and the Syzkaller repro test also reveals an invalid memory access error after clearing the lockdep warning. Hence, this series is broken up into three patches:

1. Add a missing call to hfs_find_exit for an error path in hfs_fill_super

2. Fix memory mapping in hfs_bnode_read by fixing calls to kmap

3. Add lock nesting notation to tell lockdep that the observed locking hierarchy is safe

v1 -> v2:
Patch 1: Consolidated calls to hfs_find_exit on error paths in hfs_fill_super, as suggested by Viacheslav Dubeyko.
Patch 2: Added safety checks, clarified code, and switched from kmap/kunmap to kmap_atomic/kunmap_atomic, as suggested by Viacheslav Dubeyko.

Desmond Cheong Zhi Xi (3):
  hfs: add missing clean-up in hfs_fill_super
  hfs: fix high memory mapping in hfs_bnode_read
  hfs: add lock nesting notation to hfs_find_init

 fs/hfs/bfind.c | 14 +++++++++++++-
 fs/hfs/bnode.c | 25 ++++++++++++++++++++-----
 fs/hfs/btree.h |  7 +++++++
 fs/hfs/super.c | 10 +++++-----
 4 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.25.1

