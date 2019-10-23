Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03753E1094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 05:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfJWDeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 23:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfJWDeA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:34:00 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D772086D;
        Wed, 23 Oct 2019 03:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571801639;
        bh=y9FaMVUv4Jv0rf2VWZjSHgqxab4WZTGBH8pG0NEsKOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=17HrWhJkFB7DQKPcqr4BIxgLh1dSa1kXZGdFwAXB8Mlg0Mc/uejCJt8ZL0BBpmC2u
         EyZ/H/g36b0keJqoqxBvOv5BJrz3F60PA6I+LX94NBXGqNC+mboTd7Os8cmzvK4CEk
         GZKXDsXB3GWcjLt6NbMxs9gnovfMT3TR4KoFfnmw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH v2 0/2] ext4: support encryption with blocksize != PAGE_SIZE
Date:   Tue, 22 Oct 2019 20:33:10 -0700
Message-Id: <20191023033312.361355-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patchset makes ext4 support encryption on filesystems where the
filesystem block size is not equal to PAGE_SIZE.  This allows e.g.
PowerPC systems to use ext4 encryption.

Most of the work for this was already done in prior kernel releases; now
the only part missing is decryption support in block_read_full_page().
Chandan Rajendra has proposed a patchset "Consolidate FS read I/O
callbacks code" [1] to address this and do various other things like
make ext4 use mpage_readpages() again, and make ext4 and f2fs share more
code.  But it doesn't seem to be going anywhere.

Therefore, I propose we simply add decryption support to
block_read_full_page() for now.  This is a fairly small change, and it
gets ext4 encryption with subpage-sized blocks working.

Note: to keep things simple I'm just allocating the work object from the
bi_end_io function with GFP_ATOMIC.  But if people think it's necessary,
it could be changed to use preallocation like the page-based read path.

Tested with 'gce-xfstests -c ext4/encrypt_1k -g auto', using the new
"encrypt_1k" config I created.  All tests pass except for those that
already fail or are excluded with the encrypt or 1k configs, and 2 tests
that try to create 1023-byte symlinks which fails since encrypted
symlinks are limited to blocksize-3 bytes.  Also ran the dedicated
encryption tests using 'kvm-xfstests -c ext4/1k -g encrypt'; all pass,
including the on-disk ciphertext verification tests.

[1] https://lkml.kernel.org/linux-fsdevel/20190910155115.28550-1-chandan@linux.ibm.com/T/#u

Changed v1 => v2:
  - Added check for S_ISREG() which technically should be there, though
    it happens not to matter currently.

Chandan Rajendra (1):
  ext4: Enable encryption for subpage-sized blocks

Eric Biggers (1):
  fs/buffer.c: support fscrypt in block_read_full_page()

 Documentation/filesystems/fscrypt.rst |  4 +--
 fs/buffer.c                           | 48 ++++++++++++++++++++++++---
 fs/ext4/super.c                       |  7 ----
 3 files changed, 45 insertions(+), 14 deletions(-)

-- 
2.23.0

