Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBFD2E9D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfE3AxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 20:53:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40800 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3AxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 20:53:08 -0400
Received: by mail-yw1-f73.google.com with SMTP id k134so3878449ywe.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=p0enTo1paGhtTCzKrRxNViLV0NJbbGkfixUzKcvFAIM=;
        b=fbbGY86HQAvMyuGABmIV5PWAqyAjKpNYQPTVcYsDDwLMglTCo/RHkGXEHGjlPQlO1i
         1maBy1XlB8ZPwQF1a4O65dbNcWKaebodjcj8l91tKo7tj7lfzms/LmWum3fYAkSCF9+a
         1MduZ6NgfZ4J4RsrcjHMnjmUA/OLn/1xplY3+eg6JF39R9cjdd0UM4lb5tbyKLyN2Flw
         Imwh+pgUv75Np9AyNwYEWKPBO/FRJRrzAlqLSYPGQ2W1XvDlp+vOaZzMVcUBsMuVa0aF
         UhUtZx1Rwvk2/6sFkV3HlEKjNDlqDECo3ImPqfc4klHFAG5mtBhfs4Gt4xbiOYfl1x3s
         9mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=p0enTo1paGhtTCzKrRxNViLV0NJbbGkfixUzKcvFAIM=;
        b=WvX/r44MbGUJP3nN0MNSNKGG52MKlzFebwavZDUaeHu+CLzarOY9bdoV61HILNHkMA
         4PY6gTeM9aSqjr+9zl5JQ4+xtuQu6ZlO/fL+PXHGxAsp+wmQ2Qls9OaTH2PeaW2ifKj4
         FAuHtdi95wtlBRz1Pm1lFc9Xy6cpL+utt4XwbKZFKx0mgVssxIMa75d9vb55Bp1EMUUQ
         epxTQTmlQldv+uoGn/jjOQTYxs8Q1L9AVmxG2jYiUAuJmXNP4IsKoPYKsCwUAjYsDrJA
         X7FQqNVSviiz6rmycnAbOr7kntJX/txn4bOgTJuk7unP9jQ+mnlwYl0BaTIoXfNtgP1V
         nvkQ==
X-Gm-Message-State: APjAAAVJnQiBArO9OGH8rA18D+Kj6Pqqr9QwowgU2WJrbHlCvf6HF4hr
        L5DxDami7yxw/tkilk6iCPL8I1JuK3o=
X-Google-Smtp-Source: APXvYqzWm35RV29MwLeQluK9gcDBYwAUwpZj3MTGP+M+S2CQ5CrRwwOROjnO+bcTCPD25gcsaXKtfsvXOEM=
X-Received: by 2002:a25:4050:: with SMTP id n77mr310800yba.77.1559177587174;
 Wed, 29 May 2019 17:53:07 -0700 (PDT)
Date:   Wed, 29 May 2019 17:49:02 -0700
Message-Id: <20190530004906.261170-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 0/4] F2FS Checkpointing without GC, related fixes
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch adjusts the default allowable holes for checkpointing, and
the next two patches fix underflow issues related to inc_valid_block_count
and inc_valid_node_count. The final one adds a new feature for
checkpointing where the user can specify an acceptable amount of space to
lose access to up front in checkpointing=disable mode instead of requiring
garbage collection.

There is still a question around what to do when the current reserved
space is less than reserved. As it stands, when a block is deleted, if it
was an old block, the space is not actually given back, and is marked as
unusable. But current reserve may still rise towards reserve, which would
make freeing one block result in a net loss of one block, as opposed to no
change. Reserved and unusable serve the same function, so it may make
sense to just handle it as max(current_reserved, unusable), which
effectively removes the double counting. I'm leaving that until later.

Changes from v2:
Adjust threshold for initial unusable blocks
Patches to fix underflows
Added option to set a block limit in addition to a percent for initial
unusable space

Daniel Rosenberg (4):
  f2fs: Lower threshold for disable_cp_again
  f2fs: Fix root reserved on remount
  f2fs: Fix accounting for unusable blocks
  f2fs: Add option to limit required GC for checkpoint=disable

 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++
 Documentation/filesystems/f2fs.txt      | 19 +++++++-
 fs/f2fs/f2fs.h                          | 22 ++++++---
 fs/f2fs/segment.c                       | 21 +++++++--
 fs/f2fs/super.c                         | 62 ++++++++++++++++---------
 fs/f2fs/sysfs.c                         | 16 +++++++
 6 files changed, 115 insertions(+), 33 deletions(-)

-- 
2.22.0.rc1.257.g3120a18244-goog

