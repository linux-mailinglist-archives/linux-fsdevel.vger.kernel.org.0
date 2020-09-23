Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2256B274E2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIWBJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgIWBJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:09:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCBC0613D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f199so8021232yba.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gd9BXK6Qogm8GWzcEx/RRuoN03o4stNhU2BMPs3db+g=;
        b=VzYml5mRARymBMqJuBNvlalVRmIpcIRL7rCYhdalEJ6bKiRq37APrmAer+cndQz7ow
         HDgQ8sObYp4idOZvJsIB8XMBdAbJDoPCXf8RcjD8zqSkhEpxPKkDqW19XQG4XFjZvJaz
         8jEIjxaKoJcRnQ8fhGfMGPAbu8NwMdXX1LmNNI+9aYl3v1FIDXUdjNESPhuk/al8UMRu
         iwH+o2SnESdtrDrKMurtAfxp8eGbb3YAnwpecd7/CBg1WdTaJUzuh/5gxIJHiCHdeBs/
         OuNNmgOyE5L/7V98+v4aCcawDaDAqbTrPsoF6o6qWk/oSi7nQACkmrj0atUkhEeP/rkK
         mCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gd9BXK6Qogm8GWzcEx/RRuoN03o4stNhU2BMPs3db+g=;
        b=UK633auWCe7NuC3mfje3JShGaSWjqejtIRi0sbeKHzMoyncohFm1vi+dZUXI3yNSe2
         QcJ78x9tNGmV6JQL2FYw51wnX3O82etolm/mMIM2MRnynEp9Wr7PEwtsWNQ1Yrx1sxal
         aDAkBClirfXhftGVr/XqwiZsPwlUXpuocebBIKTyotd6We/7zUiBWZJ6/7iJ5Qqu5oAR
         s01hUUtKlwJUMUypzLnbRVXZV1wt3ON4C2hWvsNa4CAANlWqSSpCaqtl4BuL0UsR1fIG
         hcNYVL8HEermlwIjIWK8JXvnMtJKeegFekWmt6+kXPYL9p8O6n5wLBiVZ4ojOZkA6aTV
         +2NQ==
X-Gm-Message-State: AOAM530dlGL5J1aQd9NJqS1hgFKlP6m2EVM8gtHmONfZDCrXRYaUenbh
        aZvpBJdE7gdEpb1adwuiiygrUrOCfwU=
X-Google-Smtp-Source: ABdhPJw5IYwBppbdbWip5F74kDHHvTSDqolnxLv2PtjxebJu9eXnJbODevPPAagFkTBzSK+vbQomxUmmEHU=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:6dc6:: with SMTP id i189mr10208913ybc.355.1600823358686;
 Tue, 22 Sep 2020 18:09:18 -0700 (PDT)
Date:   Wed, 23 Sep 2020 01:01:46 +0000
Message-Id: <20200923010151.69506-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 0/5] Add support for Encryption and Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are on top of the f2fs dev branch

F2FS currently supports casefolding and encryption, but not at
the same time. These patches aim to rectify that. In a later follow up,
this will be added for Ext4 as well. I've included one ext4 patch from
the previous set since it isn't in the f2fs branch, but is needed for the
fscrypt changes.

The f2fs-tools changes have already been applied.

Since both fscrypt and casefolding require their own dentry operations,
I've moved the responsibility of setting the dentry operations from fscrypt
to the filesystems and provided helper functions that should work for most
cases.

These are a follow-up to the previously sent patch set
"[PATCH v12 0/4] Prepare for upcoming Casefolding/Encryption patches"

Daniel Rosenberg (5):
  ext4: Use generic casefolding support
  fscrypt: Export fscrypt_d_revalidate
  libfs: Add generic function for setting dentry_ops
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption

 fs/crypto/fname.c       |  7 ++---
 fs/crypto/hooks.c       |  1 -
 fs/ext4/dir.c           | 67 -----------------------------------------
 fs/ext4/ext4.h          | 16 ----------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 21 ++++++-------
 fs/ext4/super.c         | 15 +++------
 fs/f2fs/dir.c           | 64 ++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h          | 11 +++----
 fs/f2fs/hash.c          | 11 ++++++-
 fs/f2fs/namei.c         |  1 +
 fs/f2fs/recovery.c      | 12 +++++++-
 fs/f2fs/super.c         |  7 -----
 fs/libfs.c              | 49 ++++++++++++++++++++++++++++++
 fs/ubifs/dir.c          |  1 +
 include/linux/fs.h      |  1 +
 include/linux/fscrypt.h |  6 ++--
 17 files changed, 148 insertions(+), 144 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

