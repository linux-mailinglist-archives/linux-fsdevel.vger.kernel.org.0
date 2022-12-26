Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1B65630B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiLZOWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLZOWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D57DDD;
        Mon, 26 Dec 2022 06:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B856360EA0;
        Mon, 26 Dec 2022 14:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB62C433D2;
        Mon, 26 Dec 2022 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064523;
        bh=RE53Fciq2nRixBCsoy3+egocitH34STsez30iGbOyhc=;
        h=From:To:Subject:Date:From;
        b=HhvlJSnhDxEB2hW0pKagPKBpltkDOgH34p8DXvkq2ap8tamup3CfInSKrYghK+89Z
         FVh7d9NiilF5DA0ewfpzdBT67ag9zu0mwMy5tkrvWuPKKisesjm5cwDxpA23QrAAp+
         Un2hAExH3isoqv+J76Hnbt40z2gzMqyoePufWK8kqLUG10O1Lv5PXjDW/y/51Ml8CK
         kmDrSN/W8NbIbn7u8MfWpooCPgTDAPJat6mQ1FEWOCW/uTBHpAOoEsxXE2c1ENuTFI
         gY1UBZu2Vxj3Bo+eUbpOX1Tuv0lx9fSTXmu2hTUiGzHfI+zI1zboiY+b8DPNz4LbD5
         qfKHRgFB8GSQA==
Received: by pali.im (Postfix)
        id 03B949D7; Mon, 26 Dec 2022 15:21:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 00/18] fs: Remove usage of broken nls_utf8 and drop it
Date:   Mon, 26 Dec 2022 15:21:32 +0100
Message-Id: <20221226142150.13324-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Module nls_utf8 is broken in several ways. It does not support (full)
UTF-8, despite its name. It cannot handle 4-byte UTF-8 sequences and
tolower/toupper table is not implemented at all. Which means that it is
not suitable for usage in case-insensitive filesystems or UTF-16
filesystems (because of e.g. missing UTF-16 surrogate pairs processing).

This is RFC v2 patch series which unify and fix iocharset=utf8 mount
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

Changes since RFC v1:
* Dropped already merged udf and isofs patches
* Addressed review comments:
  - updated documentation
  - usage of seq_puts
  - some code moved to local variables
  - usage of true/false instead of 1/0
  - rebased on top of master branch

Link to RFC v1:
https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/

Pali Rohár (18):
  fat: Fix iocharset=utf8 mount option
  hfsplus: Add iocharset= mount option as alias for nls=
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

 Documentation/filesystems/hfsplus.rst |   3 +
 Documentation/filesystems/ntfs.rst    |   5 +-
 Documentation/filesystems/vfat.rst    |  13 +--
 fs/befs/linuxvfs.c                    |  24 +++--
 fs/cifs/cifs_unicode.c                | 128 +++++++++++++++++---------
 fs/cifs/cifs_unicode.h                |   2 +-
 fs/cifs/cifsfs.c                      |   2 +
 fs/cifs/cifssmb.c                     |   8 +-
 fs/cifs/connect.c                     |   8 +-
 fs/cifs/dfs_cache.c                   |  24 ++---
 fs/cifs/dir.c                         |  28 ++++--
 fs/cifs/smb2pdu.c                     |  18 +---
 fs/cifs/winucase.c                    |  14 ++-
 fs/fat/Kconfig                        |  19 +---
 fs/fat/dir.c                          |  17 ++--
 fs/fat/fat.h                          |  22 +++++
 fs/fat/inode.c                        |  28 +++---
 fs/fat/namei_vfat.c                   |  26 ++++--
 fs/hfs/super.c                        |  62 +++++++++++--
 fs/hfs/trans.c                        |  62 +++++++------
 fs/hfsplus/dir.c                      |   7 +-
 fs/hfsplus/options.c                  |  39 +++++---
 fs/hfsplus/super.c                    |   7 +-
 fs/hfsplus/unicode.c                  |  31 ++++++-
 fs/hfsplus/xattr.c                    |  20 ++--
 fs/hfsplus/xattr_security.c           |   6 +-
 fs/jfs/jfs_dtree.c                    |  13 ++-
 fs/jfs/jfs_unicode.c                  |  35 +++----
 fs/jfs/jfs_unicode.h                  |   2 +-
 fs/jfs/super.c                        |  29 ++++--
 fs/nls/Kconfig                        |   9 --
 fs/nls/Makefile                       |   1 -
 fs/nls/nls_utf8.c                     |  67 --------------
 fs/ntfs/dir.c                         |   6 +-
 fs/ntfs/inode.c                       |   5 +-
 fs/ntfs/super.c                       |  60 ++++++------
 fs/ntfs/unistr.c                      |  29 +++++-
 37 files changed, 493 insertions(+), 386 deletions(-)
 delete mode 100644 fs/nls/nls_utf8.c

-- 
2.20.1

