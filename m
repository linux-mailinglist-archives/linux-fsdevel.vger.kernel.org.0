Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77F2B58A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 05:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKQEDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 23:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKQEDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:03:20 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5BC0617A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 20:03:19 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id bl3so4594484qvb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 20:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yi0JUluZtuNsiNBZqteV14yq9mKWglSiwibM+BbEW8s=;
        b=vUa28QYkFc2WUUIbgYO3nv/X2d3Z3MKwmP9a9NdvQ+iXI9eRQSpwcbM1zweGD+PWjQ
         QyO7PKMH7hALyP5kVRRUUEQhNUMyGcGxycU5hh15BIlDdMDVNFeomDPWZtAiNxYcDVgI
         O9N7Q8fQK6FCCYWzN4zAysq4VjpXkGWFoHwSAyIgOdZ3JdTXsHSQxt7A535mEFe6mbCI
         xRcdwurKrJjRS3x/Wy7Owt+nUhBzzoZd59OpZAMSSLJwMwiWNfuJ57bdm6HBz3MYe3jz
         CDHDezcGavS4VIbNKWOomIriqHoANjpxWR1mF8/FtsvNrR1jmsH9N2dG7lDQUsqelH/h
         IREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yi0JUluZtuNsiNBZqteV14yq9mKWglSiwibM+BbEW8s=;
        b=TBHLzm33f4Ghj9cv6qBfWW2iPd0HwoZfoD36TCNSFxKJedyuXVCelJr2mqsELCdxYY
         4nj9kyRHHZNAajP3AWP20TxbAfIZ+Lb9l8FIopMlo2QCtCb1KOiCYJLFWM/TD+52tEWQ
         XGpFR9mVU+i2VrHl+edHds7ITBMvuVuOSwdcCMWMOGruvv3JqHD9NqPNcZuGI1/WqGWm
         SjdUIU5zlthwEASzVvclUbX1QsrnYoeoEuT8ZCaIWWr5YbWTY+2Dj7Tk+UVo7hIUwMwN
         2x9+NB3MNt+eJ0UYPUYSeUMcMAQ7dCMJtVdS3zyhhxNNE512jXzq9bsJnlJBvJfDWjZ2
         xlEQ==
X-Gm-Message-State: AOAM532WbSLTSqRXP/ZUT3BGYB5L0dL/PKioK8ALWc23sVBK9oailX9H
        yd04essP2sx9kcF5kAfFyWCpWMJu5lo=
X-Google-Smtp-Source: ABdhPJwVaMNu6pc/HpSWjKyc3VedMIrzCM6dHWWO+chOqAq4rf69TQRjG2u+LrpdtRlwfoNUezY7MZGkC5A=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a05:6214:12ed:: with SMTP id
 w13mr18440880qvv.23.1605585798591; Mon, 16 Nov 2020 20:03:18 -0800 (PST)
Date:   Tue, 17 Nov 2020 04:03:12 +0000
Message-Id: <20201117040315.28548-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 0/3] Add support for Encryption and Casefolding in F2FS
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

These patches are on top of the torvalds tree.

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

v2:
Simplified generic dentry_op function
Passed through errors in f2fs_match_ci_name

Daniel Rosenberg (3):
  libfs: Add generic function for setting dentry_ops
  fscrypt: Have filesystems handle their d_ops
  f2fs: Handle casefolding with Encryption

 fs/crypto/fname.c       |  4 --
 fs/crypto/hooks.c       |  1 -
 fs/ext4/dir.c           |  7 ---
 fs/ext4/ext4.h          |  4 --
 fs/ext4/namei.c         |  1 +
 fs/ext4/super.c         |  5 ---
 fs/f2fs/dir.c           | 96 +++++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h          | 11 +++--
 fs/f2fs/hash.c          | 11 ++++-
 fs/f2fs/inline.c        |  4 ++
 fs/f2fs/namei.c         |  1 +
 fs/f2fs/recovery.c      | 12 +++++-
 fs/f2fs/super.c         |  7 ---
 fs/libfs.c              | 60 ++++++++++++++++++++++++++
 fs/ubifs/dir.c          |  1 +
 include/linux/fs.h      |  1 +
 include/linux/fscrypt.h |  5 ++-
 17 files changed, 170 insertions(+), 61 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

