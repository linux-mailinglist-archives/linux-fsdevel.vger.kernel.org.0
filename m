Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E1227304
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGTXhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTXhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:37:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E833C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d6so5170102qkg.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oKlpB9JflgOJW0lsaq+hMYnQNitRzPyz15HBElBY3z8=;
        b=i17qPxIQ+FYgs3/oOkOTA5egde4Z8SYqICXc/pdjW+3WlCsYt5Ni8BXkdy6av3PK9M
         q10Dc6or8ugIU4p7j4z+lX1BMSKSUBjbUKPTbnQ2pj4kjL4yUWDHbPar9ysEPBmCd00E
         RtQLja8gf0x2Lyf2Urkel1+HH1DQoGfS8C86KzqnVbhAGPkdYqrCpEGINpz0h8/oI5SU
         IR0EaVXQIAeQZ4yNPLmyksD9kfZmAsxiWyKNilqbtimuctJbIkWpZEkyK24hZ3d+tcAb
         1bw3VNgz1m7X133cTcDXWo2m3DeD+0yX7sg26+tp3PzZZXsaJjovcak1mqDzUPd0b2pl
         xGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oKlpB9JflgOJW0lsaq+hMYnQNitRzPyz15HBElBY3z8=;
        b=MitDHaXOQKou2OJs64Bn8wyrsn4t3q3coGo22qBKPSrBLKYP1lFiZiNLAIcvBFKMel
         zoOPNQgcKCDgzLG699gCQuh+M8doGN1NHR1r+CGmmOfK6Xe77GBraRBi6YzdUCJ8D/au
         WejY+f2Y0+1MBX7dAU9O8UMKdIXbaAPkr+oH0PUJzQTtR5+4a9yAkqR+YJPBi69REyaG
         Xy87ra5fbUcC0uL/lzf7Irc7Qv2Rl7SRhXYTYABOh3WjoVAcX8r8ID/Mu/hPILroJAJq
         Nh2zFo4NEZECI4lhPoQLR6orPlHks44jHKe/qI/32NOzQBJiHh1PhVq0wHSEQKXNZGIa
         myKQ==
X-Gm-Message-State: AOAM532a3rcVfkhVxRl3kHsGpj/UTofX5tdQddDXuaV1eDEQbTVtHZjf
        TRS1RJFQg1p2au8mRzady6RImsjV62w=
X-Google-Smtp-Source: ABdhPJyBkI/ohJhicP2uZzD/rrAaWCmvyhCaVPrvr7OjYU3dPRB2s26/Urv6XxL5AogW5RzjOXaC57U0VCg=
X-Received: by 2002:a0c:e308:: with SMTP id s8mr24750179qvl.127.1595288262100;
 Mon, 20 Jul 2020 16:37:42 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:37:32 +0000
Message-Id: <20200720233739.824943-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v4 0/7] add support for direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds support for direct I/O with fscrypt using
blk-crypto. It has been rebased on fscrypt/master.

Patch 1 adds two functions to fscrypt that need to be called to determine
if direct I/O is supported for a request.

Patches 2 and 3 wire up direct-io and iomap respectively with the functions
introduced in Patch 1 and set bio crypt contexts on bios when appropriate
by calling into fscrypt.

Patches 4 and 5 allow ext4 and f2fs direct I/O to support fscrypt without
falling back to buffered I/O.

Patches 6 and 7 update the fscrypt documentation for inline encryption
support and direct I/O. The documentation now notes the required conditions
for inline encryption and direct I/O on encrypted files.

This patch series was tested by running xfstests with test_dummy_encryption
with and without the 'inlinecrypt' mount option, and there were no
meaningful regressions. One regression was for generic/587 on ext4,
but that test isn't compatible with test_dummy_encryption in the first
place, and the test "incorrectly" passes without the 'inlinecrypt' mount
option - a patch will be sent out to exclude that test when
test_dummy_encryption is turned on with ext4 (like the other quota related
tests that use user visible quota files). The other regression was for
generic/252 on ext4, which does direct I/O with a buffer aligned to the
block device's blocksize, but not necessarily aligned to the filesystem's
block size, which direct I/O with fscrypt requires.

Changes v3 => v4:
 - Fix bug in iomap_dio_bio_actor() where fscrypt_limit_io_pages() was
   being called too early (thanks Eric!)
 - Improve comments and fix formatting in documentation
 - iomap_dio_zero() is only called to zero out partial blocks, but
   direct I/O is only supported on encrypted files when I/O is
   blocksize aligned, so it doesn't need to set encryption contexts on
   bios. Replace setting the encryption context with a WARN_ON(). (Eric)

Changes v2 => v3:
 - add changelog to coverletter

Changes v1 => v2:
 - Fix bug in f2fs caused by replacing f2fs_post_read_required() with
   !fscrypt_dio_supported() since the latter doesn't check for
   compressed inodes unlike the former.
 - Add patches 6 and 7 for fscrypt documentation
 - cleanups and comments

Eric Biggers (5):
  fscrypt: Add functions for direct I/O support
  direct-io: add support for fscrypt using blk-crypto
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto

Satya Tangirala (2):
  fscrypt: document inline encryption support
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 36 +++++++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 82 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 ++++-
 fs/ext4/file.c                        | 10 ++--
 fs/f2fs/f2fs.h                        |  6 +-
 fs/iomap/direct-io.c                  | 12 +++-
 include/linux/fscrypt.h               | 19 +++++++
 8 files changed, 178 insertions(+), 10 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

