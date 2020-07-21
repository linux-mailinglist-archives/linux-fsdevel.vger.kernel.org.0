Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A5A228C53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgGUXA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGUXA7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:00:59 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9914E20720;
        Tue, 21 Jul 2020 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372458;
        bh=k3zJtj9swL8Em2zr4t0dgLpBU2miGzB6T+4/DOJqYLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Th1AiTHwrnCJXpn6yM0O2m52c82NWRdDo4e8Gu5vDBZP6ir8te0mn/8JjqHhrhdVf
         aIaZzUV/1HNfA47AFBH80hZIAMlRJmflhQTRo9G6tSyR8+UOFhTUR3olkfGwhTES8x
         ESddhewxSWqEUxj9FMEIvj813sooIehuXr/XKVdU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH 0/5] fscrypt, fs-verity: one-time init fixes
Date:   Tue, 21 Jul 2020 15:59:15 -0700
Message-Id: <20200721225920.114347-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes up some cases in fs/crypto/ and fs/verity/ where
"one-time init" is implemented using READ_ONCE() instead of
smp_load_acquire() but it's not obviously correct.

One case is fixed by using a better approach that removes the need to
initialize anything.  The others are fixed by upgrading READ_ONCE() to
smp_load_acquire().  I've also improved the comments.

This is motivated by the discussions at 
https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
and
https://lkml.kernel.org/linux-fsdevel/20200717044427.68747-1-ebiggers@kernel.org/T/#u

These fixes are improvements over the status quo, so I'd prefer to apply
them now, without waiting for any potential new generic one-time-init
macros (which based on the latest discussion, won't be flexible enough
to handle most of these cases anyway).

Eric Biggers (5):
  fscrypt: switch fscrypt_do_sha256() to use the SHA-256 library
  fscrypt: use smp_load_acquire() for fscrypt_prepared_key
  fscrypt: use smp_load_acquire() for ->s_master_keys
  fscrypt: use smp_load_acquire() for ->i_crypt_info
  fs-verity: use smp_load_acquire() for ->i_verity_info

 fs/crypto/Kconfig           |  2 +-
 fs/crypto/fname.c           | 41 +++++++++----------------------------
 fs/crypto/fscrypt_private.h | 15 ++++++++------
 fs/crypto/inline_crypt.c    |  6 ++++--
 fs/crypto/keyring.c         | 15 +++++++++++---
 fs/crypto/keysetup.c        | 18 +++++++++++++---
 fs/crypto/policy.c          |  4 ++--
 fs/verity/open.c            | 15 +++++++++++---
 include/linux/fscrypt.h     | 29 +++++++++++++++++++++-----
 include/linux/fsverity.h    |  9 ++++++--
 10 files changed, 96 insertions(+), 58 deletions(-)

-- 
2.27.0

