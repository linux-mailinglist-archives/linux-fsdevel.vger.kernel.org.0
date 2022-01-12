Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992E748BCC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiALB7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 20:59:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348072AbiALB7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:59:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 41AB61F44896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641952739;
        bh=PF3ZlHbSf6Aq8JxiqzqbyxWalp7fsDDicZK8qmN8P8E=;
        h=From:To:Cc:Subject:Date:From;
        b=bxtPlOI2O8fiNwobm6Uw7SqhUN3uGufkvzXzy81i/UbTq1R2/nodo9PX3bv/5U8+7
         2JdK2yFLRe2ipy10Yw3D+T4yAWedzWKfV8naSEf5qE1L3ysgyinRE1ZBp3gG6HQU9H
         woJX0h4r7gH+vd89YietJNlCoBRB6VX1wLwOtpQLjezlcWj53N8NXjmtebQ8Uq1T+5
         Mwoq8hTmaKHGAdMCg7C1yWZjCuybzHtiQBKjuOO/pgvwcg7rtUUA/F3BYRaPsIy5XZ
         ojgCvyfy2vG68u6HJ6LpzVYNmiutgVbWj/sJOdFb5aRzLTnQwmquFHqu67SInN681V
         mkcEfTH4A/tOQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     hch@lst.de, chao@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] unicode patches for 5.17
Date:   Tue, 11 Jan 2022 20:58:54 -0500
Message-ID: <87a6g11zq9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17

for you to fetch changes up to e2a58d2d3416aceeae63dfc7bf680dd390ff331d:

  unicode: only export internal symbols for the selftests (2021-10-12 11:41:39 -0300)

----------------------------------------------------------------
This branch has patches from Christoph Hellwig to split the large data
tables of the unicode subsystem into a loadable module, which allow
users to not have them around if case-insensitive filesystems are not to
be used.  It also includes minor code fixes to unicode and its users,
from the same author.

There is a trivial conflict in the function encoding_show in
fs/f2fs/sysfs.c reported by linux-next between commit

84eab2a899f2 ("f2fs: replace snprintf in show functions with sysfs_emit")

and commit a440943e68cd ("unicode: remove the charset field from struct
unicode_map") from my tree.

I left an example of how I would solve it on the branch
unicode-f2fs-mergeconflict of my tree.

All the patches here have been on linux-next releases for the past
months.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

----------------------------------------------------------------
Christoph Hellwig (11):
      ext4: simplify ext4_sb_read_encoding
      f2fs: simplify f2fs_sb_read_encoding
      unicode: remove the charset field from struct unicode_map
      unicode: mark the version field in struct unicode_map unsigned
      unicode: pass a UNICODE_AGE() tripple to utf8_load
      unicode: remove the unused utf8{,n}age{min,max} functions
      unicode: simplify utf8len
      unicode: move utf8cursor to utf8-selftest.c
      unicode: cache the normalization tables in struct unicode_map
      unicode: Add utf8-data module
      unicode: only export internal symbols for the selftests

 fs/ext4/super.c                                    |  39 ++-
 fs/f2fs/super.c                                    |  38 +--
 fs/f2fs/sysfs.c                                    |   3 +-
 fs/unicode/Kconfig                                 |  13 +-
 fs/unicode/Makefile                                |  13 +-
 fs/unicode/mkutf8data.c                            |  24 +-
 fs/unicode/utf8-core.c                             | 109 ++++-----
 fs/unicode/utf8-norm.c                             | 262 +++------------------
 fs/unicode/utf8-selftest.c                         |  94 ++++----
 .../{utf8data.h_shipped => utf8data.c_shipped}     |  22 +-
 fs/unicode/utf8n.h                                 |  81 +++----
 include/linux/unicode.h                            |  49 +++-
 12 files changed, 291 insertions(+), 456 deletions(-)
 rename fs/unicode/{utf8data.h_shipped => utf8data.c_shipped} (99%)

