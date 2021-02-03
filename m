Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2671630D5EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhBCJKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhBCJI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:08:29 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433FC0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 01:07:49 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a18so4373094pjs.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 01:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sVf7O3WLOu6dhuTCecFldXIW4PzO5RIlEM8KMgTZtuE=;
        b=k9rT4tPGoNn+chkAvyxonhEGVZrgZH/l4ElwINC05PI1JlY6fwWfUBfSH1PVrwolT8
         v2uxaD0ZexjF4hULvEIAS4Kqzpz6+HJFdxTg0znW++pMx9pTy4voqfJPgwtcklUXk0pc
         ChT8/m22vNB5J2C7daqMYjtun7fcZ22RS9ZL3066n43JhYu0mSb3k+6eSH4UG4edtPf5
         GTyWNJvY/mvbhqSJN1aYJnPtzm8qh7Twe5P2bUw5k/ZhRbFozYQVCotb5vlRm/qePdzO
         zxilmgEWAjoAYBIzhRE0kjoFdGPFwELXLYUwfyZhDaf/XrLAzNzeSPfSdBStYMupA7hF
         72mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sVf7O3WLOu6dhuTCecFldXIW4PzO5RIlEM8KMgTZtuE=;
        b=FsbJcH7mqa2MAEGvI7/2/cO9xrxfD+X2f/J0mh+V6pTXldGKMCX2zbEFUgte5Q+lqD
         FFpSWegK7zKoJOTJl333eH2NZEYUz4CKCLg6ty6erpAaBQEqi5ZhO6tkJ24etFZTA9Br
         9rI1nA/fS0lhQsoMFsqHvU9BuJwxssKJBKQBaXlsz5Y1TXFiklx3j/AsuCc+XkZauYuR
         mo+6Mzy01excd6UewTprm6qotDIcYx3Pu/YGp1nAd0Bg7RWx+wdj6Gogj6LoqxwEiaup
         cNC3KlzvKYvKmE0g5h5fwtdb/ykoRFUhdv3g7mmHjWXD/e1CQxDtnKj5/Y64Jvjj4ej6
         dS6Q==
X-Gm-Message-State: AOAM532znTU9cEyWn9vR2SHDr77FdFYGac1lGgufLI77KRV8j7h5edLQ
        2c63xZdKsw/cedUFLyJjlMaLVL4SxwI=
X-Google-Smtp-Source: ABdhPJx7NJUAkcuwh363+5Hq9XXaxc6cA9F+B8VY/3yeXsi5IFRlD4N/OPeo71uDmDTMFTyS3MeoZscuvwk=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:90a:d0c4:: with SMTP id
 y4mr2260364pjw.212.1612343268852; Wed, 03 Feb 2021 01:07:48 -0800 (PST)
Date:   Wed,  3 Feb 2021 09:07:43 +0000
Message-Id: <20210203090745.4103054-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 0/2] Reconcile Encryption and Casefolding in Ext4
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches add support for ext4 encryption and casefolding at the same time.
Since the hash for encrypted casefolded directory names cannot be computed
without the key, we need to store the hash on disk. We only do so for encrypted
and casefolded directories to avoid on disk format changes.

e2fsprogs has already been updated with support for casefolding and encryption.

Daniel Rosenberg (2):
  ext4: Handle casefolding with encryption
  ext4: Optimize match for casefolded encrypted dirs

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/ext4/dir.c                                |  46 ++-
 fs/ext4/ext4.h                               |  79 +++--
 fs/ext4/hash.c                               |  25 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 +--
 fs/ext4/namei.c                              | 323 +++++++++++++------
 fs/ext4/super.c                              |   6 -
 8 files changed, 391 insertions(+), 161 deletions(-)


base-commit: e9f53353e166a67dfe4f8295100f8ac39d6cf10b
-- 
2.30.0.365.g02bc693789-goog

