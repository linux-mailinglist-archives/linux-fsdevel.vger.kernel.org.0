Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2A3E3B5C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhHHQZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhHHQZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCC4E60F92;
        Sun,  8 Aug 2021 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439915;
        bh=Ohc/3heuGxLg0kv3NvHFDAfCusqeQ5RY2plc5dtqdq8=;
        h=From:To:Subject:Date:From;
        b=V5RCkUgAyQb6xImM0cY+ybB7FN3DiId8+ohpzyIXCEEfeCYrqQn8hQSslrzTF992u
         TFOFnDIF3jgzPACAo8vwqW4yK+3X/jQ3p1T/kvV1JGW4SCH1UB3BRojP1vxUfCvdQH
         NtsuTK4hEF5BxKfRYPwLZ86ncby4i5qz1bALQajKRRUh1N4Tu8lUDdZLrg8pWnLqp7
         E1XdIyl1CWlMENfcuLmedfbTMjOZg62oY5c4t9Ykd7sUOTspJKM5LaVTW53CtJEBCO
         PKvNxS7W63zN90tWf2HRXuOz/6gAhXS0kW7/Mlg0mB/IQnMyX0MTBcrvZCX2SA0MAy
         uuW28QvKI2mYQ==
Received: by pali.im (Postfix)
        id 6166413DC; Sun,  8 Aug 2021 18:25:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 00/20] fs: Remove usage of broken nls_utf8 and drop it
Date:   Sun,  8 Aug 2021 18:24:33 +0200
Message-Id: <20210808162453.1653-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Module nls_utf8 is broken in several ways. It does not support (full)
UTF-8, despite its name. It cannot handle 4-byte UTF-8 sequences and
tolower/toupper table is not implemented at all. Which means that it is
not suitable for usage in case-insensitive filesystems or UTF-16
filesystems (because of e.g. missing UTF-16 surrogate pairs processing).

This is RFC patch series which unify and fix iocharset=utf8 mount
option in all fs drivers and converts all remaining fs drivers to use
utf8s_to_utf16s(), utf16s_to_utf8s(), utf8_to_utf32(), utf32_to_utf8
functions for implementing UTF-8 support instead of nls_utf8.

So at the end it allows to completely drop this broken nls_utf8 module.

For more details look at email thread where was discussed fs unification:
https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/t/#u

This patch series is mostly untested and presented as RFC. Please let me
know what do you think about it and if is the correct way how to fix
broken UTF-8 support in fs drivers. As explained in above email thread I
think it does not make sense to try fixing whole NLS framework and it is
easier to just drop this nls_utf8 module.

Note: this patch series does not address UTF-8 fat case-sensitivity issue:
https://lore.kernel.org/linux-fsdevel/20200119221455.bac7dc55g56q2l4r@pali/

Pali Rohár (20):
  fat: Fix iocharset=utf8 mount option
  hfsplus: Add iocharset= mount option as alias for nls=
  udf: Fix iocharset=utf8 mount option
  isofs: joliet: Fix iocharset=utf8 mount option
  ntfs: Undeprecate iocharset= mount option
  ntfs: Fix error processing when load_nls() fails
  befs: Fix printing iocharset= mount option
  befs: Rename enum value Opt_charset to Opt_iocharset to match mount
    option
  befs: Fix error processing when load_nls() fails
  befs: Allow to use native UTF-8 mode
  hfs: Explicitly set hsb->nls_disk when hsb->nls_io is set
  hfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
  hfsplus: Do not use broken utf8 NLS table for iocharset=utf8 mount
    option
  jfs: Remove custom iso8859-1 implementation
  jfs: Fix buffer overflow in jfs_strfromUCS_le() function
  jfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
  ntfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
  cifs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
  cifs: Remove usage of load_nls_default() calls
  nls: Drop broken nls_utf8 module

 fs/befs/linuxvfs.c          |  22 ++++---
 fs/cifs/cifs_unicode.c      | 128 +++++++++++++++++++++++-------------
 fs/cifs/cifs_unicode.h      |   2 +-
 fs/cifs/cifsfs.c            |   2 +
 fs/cifs/cifssmb.c           |   8 +--
 fs/cifs/connect.c           |   8 ++-
 fs/cifs/dfs_cache.c         |  24 +++----
 fs/cifs/dir.c               |  28 ++++++--
 fs/cifs/smb2pdu.c           |  17 ++---
 fs/cifs/winucase.c          |  14 ++--
 fs/fat/Kconfig              |  15 -----
 fs/fat/dir.c                |  17 ++---
 fs/fat/fat.h                |  22 +++++++
 fs/fat/inode.c              |  28 ++++----
 fs/fat/namei_vfat.c         |  26 ++++++--
 fs/hfs/super.c              |  62 ++++++++++++++---
 fs/hfs/trans.c              |  62 +++++++++--------
 fs/hfsplus/dir.c            |   6 +-
 fs/hfsplus/options.c        |  39 ++++++-----
 fs/hfsplus/super.c          |   7 +-
 fs/hfsplus/unicode.c        |  31 ++++++++-
 fs/hfsplus/xattr.c          |  14 ++--
 fs/hfsplus/xattr_security.c |   3 +-
 fs/isofs/inode.c            |  27 ++++----
 fs/isofs/isofs.h            |   1 -
 fs/isofs/joliet.c           |   4 +-
 fs/jfs/jfs_dtree.c          |  13 +++-
 fs/jfs/jfs_unicode.c        |  35 +++++-----
 fs/jfs/jfs_unicode.h        |   2 +-
 fs/jfs/super.c              |  29 ++++++--
 fs/nls/Kconfig              |   9 ---
 fs/nls/Makefile             |   1 -
 fs/nls/nls_utf8.c           |  67 -------------------
 fs/ntfs/dir.c               |   6 +-
 fs/ntfs/inode.c             |   5 +-
 fs/ntfs/super.c             |  60 ++++++++---------
 fs/ntfs/unistr.c            |  28 +++++++-
 fs/udf/super.c              |  50 ++++++--------
 fs/udf/udf_sb.h             |   2 -
 fs/udf/unicode.c            |   4 +-
 40 files changed, 510 insertions(+), 418 deletions(-)
 delete mode 100644 fs/nls/nls_utf8.c

-- 
2.20.1

