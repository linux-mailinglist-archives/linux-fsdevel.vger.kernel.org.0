Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F973B9C71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhGBG5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 02:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGBG5W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 02:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A7A613F0;
        Fri,  2 Jul 2021 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625208890;
        bh=2YEFNbCIRo9WHTdZ5XW0VKfk2fnVjJ1mVF7axmh20i4=;
        h=From:To:Cc:Subject:Date:From;
        b=hb2Z+thtoOA3Ut1D51UPw7NUY4/SDw+9ssqTVt7RSJrQ+PeUpckBpHqKThBKweN5k
         lbd26NukQBtGrzVQZR0VApGV+hAOe4pbrKCoHqnOFYlvvNHWI6lLZN1slkg9znK7QA
         PBWSIug3OcJx+ZYgHrfHDhJdMgqiEO97WuKXOGiLuCN5iUglvtfoBmTj4ieI5MLW3G
         tp1fPywkkq9ZrOOj+xHVwcAFrOPXsgTGtWc0z7yMxtSeDXSWq4rpTGKc1p0Bg2NawI
         OZWUn6F3LZrJuKBLEGWrDr3IwEyl6nIznqGrYnLPez8t9ykzve/FQxDyZEnZaiODQk
         aT+b5KyTtBu6Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] fscrypt: report correct st_size for encrypted symlinks
Date:   Thu,  1 Jul 2021 23:53:45 -0700
Message-Id: <20210702065350.209646-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series makes the stat() family of syscalls start reporting the
correct size for encrypted symlinks.

See patch 1 for a detailed explanation of the problem and solution.

Patch 1 adds a helper function that computes the correct size for an
encrypted symlink.  Patches 2-4 make the filesystems with fscrypt
support use it, and patch 5 updates the documentation.

This series applies to mainline commit 3dbdb38e2869.

Eric Biggers (5):
  fscrypt: add fscrypt_symlink_getattr() for computing st_size
  ext4: report correct st_size for encrypted symlinks
  f2fs: report correct st_size for encrypted symlinks
  ubifs: report correct st_size for encrypted symlinks
  fscrypt: remove mention of symlink st_size quirk from documentation

 Documentation/filesystems/fscrypt.rst |  5 ---
 fs/crypto/hooks.c                     | 44 +++++++++++++++++++++++++++
 fs/ext4/symlink.c                     | 12 +++++++-
 fs/f2fs/namei.c                       | 12 +++++++-
 fs/ubifs/file.c                       | 13 +++++++-
 include/linux/fscrypt.h               |  7 +++++
 6 files changed, 85 insertions(+), 8 deletions(-)


base-commit: 3dbdb38e286903ec220aaf1fb29a8d94297da246
-- 
2.32.0

